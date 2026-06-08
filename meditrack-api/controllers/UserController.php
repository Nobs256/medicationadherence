<?php
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Response.php';
require_once __DIR__ . '/../core/Request.php';
require_once __DIR__ . '/../core/Helpers.php';
require_once __DIR__ . '/../core/Upload.php';

class UserController {
    private ?array $auth;

    public function __construct(?array $auth) {
        $this->auth = $auth;
    }

    // GET /users?role=doctor&hospital_id=X&page=1
    public function index(): void {
        try {
        $db         = Database::getInstance();
        $role       = sanitize(Request::get('role', ''));
        $hospitalId = (int)Request::get('hospital_id', $this->auth['hid'] ?? 0);
        $doctorId   = Request::get('doctor_id');
        $page       = max(1, (int)Request::get('page', 1));
        $perPage    = 20;
        $offset     = paginationOffset($page, $perPage);

        $conditions = ['u.is_active = 1'];
        $params     = [];

        if ($this->auth['role'] !== 'super_admin') {
            $conditions[] = 'u.hospital_id = ?';
            $params[]     = $this->auth['hid'];
        } elseif ($hospitalId) {
            $conditions[] = 'u.hospital_id = ?';
            $params[]     = $hospitalId;
        }

        if ($role) { $conditions[] = 'r.name = ?'; $params[] = $role; }

        if ($doctorId === 'me' || ($doctorId && $this->auth['role'] === 'doctor')) {
            $conditions[] = 'EXISTS (SELECT 1 FROM doctor_patient_assignments dpa WHERE dpa.patient_id = u.id AND dpa.doctor_id = ? AND dpa.is_active = 1)';
            $params[]     = $this->auth['uid'];
        }

        $where = 'WHERE ' . implode(' AND ', $conditions);

        $total = $db->prepare("SELECT COUNT(*) FROM users u JOIN roles r ON r.id = u.role_id $where");
        $total->execute($params);
        $count = (int)$total->fetchColumn();

        $stmt = $db->prepare("
            SELECT u.id, u.full_name, u.email, u.phone, u.avatar_url, u.is_active,
                   u.date_of_birth, u.diagnosis, u.emergency_contact, u.created_at,
                   r.name AS role_name, h.name AS hospital_name
            FROM users u
            JOIN roles r ON r.id = u.role_id
            LEFT JOIN hospitals h ON h.id = u.hospital_id
            $where ORDER BY u.full_name ASC LIMIT ? OFFSET ?
        ");
        $params[] = $perPage;
        $params[] = $offset;
        $stmt->execute($params);

        Response::paginated($stmt->fetchAll(), $count, $page, $perPage);
        } catch (Throwable $e) {
            Response::error('Failed to fetch users: ' . $e->getMessage(), 500);
        }
    }

    public function store(): void {
        $db   = Database::getInstance();
        $body = Request::json();

        $missing = validateRequired($body, ['full_name', 'email', 'role']);
        if ($missing) Response::error('Missing fields: ' . implode(', ', $missing), 422);

        $allowedRoles = [];
        switch ($this->auth['role']) {
            case 'super_admin':
                $allowedRoles = ['hospital_admin', 'doctor', 'patient'];
                break;
            case 'hospital_admin':
                $allowedRoles = ['doctor', 'patient'];
                break;
            default:
                $allowedRoles = [];
        }
        if (!in_array($body['role'], $allowedRoles))
            Response::error('You cannot create a user with that role', 403);

        $hospitalId = ($this->auth['role'] === 'super_admin') ? ($body['hospital_id'] ?? null) : $this->auth['hid'];

        $exists = $db->prepare("SELECT id FROM users WHERE email = ?");
        $exists->execute([sanitize($body['email'])]);
        if ($exists->fetch()) Response::error('Email already registered', 409);

        $roleRow = $db->prepare("SELECT id FROM roles WHERE name = ?");
        $roleRow->execute([$body['role']]);
        $roleId  = $roleRow->fetchColumn();
        if (!$roleId) Response::error('Invalid role', 422);

        $password = $body['password'] ?? randomPassword();

        $db->prepare("
            INSERT INTO users (role_id, hospital_id, full_name, email, password, phone,
                               date_of_birth, gender, emergency_contact, diagnosis)
            VALUES (?,?,?,?,?,?,?,?,?,?)
        ")->execute([
            $roleId, $hospitalId,
            sanitize($body['full_name']),
            sanitize($body['email']),
            hashPassword($password),
            sanitize($body['phone'] ?? ''),
            $body['date_of_birth'] ?? null,
            $body['gender'] ?? null,
            sanitize($body['emergency_contact'] ?? ''),
            sanitize($body['diagnosis'] ?? ''),
        ]);

        Response::json(['id' => $db->lastInsertId(), 'temporary_password' => $password], 201);
    }

    public function show(string $id): void {
        try {
        $db   = Database::getInstance();
        $stmt = $db->prepare("
            SELECT u.id, u.full_name, u.email, u.phone, u.avatar_url, u.date_of_birth,
                   u.gender, u.emergency_contact, u.diagnosis, u.is_active, u.last_login, u.created_at,
                   r.name AS role_name, h.name AS hospital_name, h.id AS hospital_id
            FROM users u
            JOIN roles r ON r.id = u.role_id
            LEFT JOIN hospitals h ON h.id = u.hospital_id
            WHERE u.id = ?
        ");
        $stmt->execute([(int)$id]);
        $user = $stmt->fetch();
        if (!$user) Response::error('User not found', 404);

        if ($this->auth['role'] !== 'super_admin' && $user['hospital_id'] != $this->auth['hid'])
            Response::error('Forbidden', 403);

        // If doctor viewing a patient, check assignment
        if ($this->auth['role'] === 'doctor') {
            $check = $db->prepare("SELECT 1 FROM doctor_patient_assignments WHERE doctor_id = ? AND patient_id = ? AND is_active = 1");
            $check->execute([$this->auth['uid'], $id]);
            if (!$check->fetch()) Response::error('Forbidden', 403);
        }

        Response::json($user);
        } catch (Throwable $e) {
            Response::error('User details failed: ' . $e->getMessage(), 500);
        }
    }

    public function update(string $id): void {
        $db   = Database::getInstance();
        $body = Request::json();
        $db->prepare("
            UPDATE users SET full_name = ?, phone = ?, date_of_birth = ?, gender = ?, emergency_contact = ?, diagnosis = ?
            WHERE id = ?
        ")->execute([
            sanitize($body['full_name'] ?? ''), sanitize($body['phone'] ?? ''), $body['date_of_birth'] ?? null,
            $body['gender'] ?? null, sanitize($body['emergency_contact'] ?? ''), sanitize($body['diagnosis'] ?? ''), (int)$id,
        ]);
        Response::json(['updated' => true]);
    }

    public function toggle(string $id): void {
        $db = Database::getInstance();
        $db->prepare("UPDATE users SET is_active = NOT is_active WHERE id = ?")->execute([(int)$id]);
        Response::json(['toggled' => true]);
    }

    public function profile(): void {
        $db   = Database::getInstance();
        $stmt = $db->prepare("
            SELECT u.id, u.full_name, u.email, u.phone, u.avatar_url,
                   u.date_of_birth, u.gender, u.emergency_contact, u.diagnosis,
                   r.name AS role_name, h.name AS hospital_name, h.id AS hospital_id,
                   h.logo_url AS hospital_logo
            FROM users u
            JOIN roles r ON r.id = u.role_id
            LEFT JOIN hospitals h ON h.id = u.hospital_id
            WHERE u.id = ?
        ");
        $stmt->execute([$this->auth['uid']]);
        $user = $stmt->fetch();
        if (!$user) Response::error('Profile not found', 404);
        Response::json($user);
    }

    public function updateProfile(): void {
        $db   = Database::getInstance();
        $body = Request::json();
        $db->prepare("UPDATE users SET full_name = ?, phone = ?, gender = ?, emergency_contact = ? WHERE id = ?")
           ->execute([sanitize($body['full_name'] ?? ''), sanitize($body['phone'] ?? ''), $body['gender'] ?? null, sanitize($body['emergency_contact'] ?? ''), $this->auth['uid']]);
        Response::json(['updated' => true]);
    }

    public function uploadAvatar(): void {
        if (empty($_FILES['avatar'])) Response::error('No file uploaded', 422);
        try {
            $url = uploadImage($_FILES['avatar'], 'avatars');
            Database::getInstance()->prepare("UPDATE users SET avatar_url = ? WHERE id = ?")->execute([$url, $this->auth['uid']]);
            Response::json(['avatar_url' => $url]);
        } catch (Exception $e) { Response::error($e->getMessage(), 422); }
    }

    public function assignPatient(string $patientId): void {
        $db   = Database::getInstance();
        $body = Request::json();
        if (empty($body['doctor_id'])) Response::error('doctor_id is required', 422);
        $db->prepare("UPDATE doctor_patient_assignments SET is_active = 0 WHERE patient_id = ? AND hospital_id = ?")->execute([(int)$patientId, $this->auth['hid']]);
        $db->prepare("INSERT INTO doctor_patient_assignments (doctor_id, patient_id, hospital_id) VALUES (?,?,?) ON DUPLICATE KEY UPDATE is_active = 1, assigned_at = NOW()")->execute([(int)$body['doctor_id'], (int)$patientId, $this->auth['hid']]);
        Response::json(['assigned' => true]);
    }

    public function dashboard(): void {
        try {
        $db   = Database::getInstance();
        $role = $this->auth['role'];
        $uid  = $this->auth['uid'];
        $hid  = $this->auth['hid'];

        Response::json($this->getDashboardData($db, $role, $uid, $hid));
        } catch (Throwable $e) {
            Response::error('Dashboard Error: ' . $e->getMessage(), 500);
        }
    }

    private function countUsers(PDO $db, string $role, int $hospitalId): int {
        $stmt = $db->prepare("SELECT COUNT(*) FROM users u JOIN roles r ON r.id=u.role_id WHERE r.name=? AND u.hospital_id=? AND u.is_active=1");
        $stmt->execute([$role, $hospitalId]);
        return (int)$stmt->fetchColumn();
    }

    private function hospitalAdherence(PDO $db, int $hospitalId): float {
        $stmt = $db->prepare("SELECT ROUND(AVG(al.adherence_percentage),1) FROM adherence_logs al JOIN users u ON u.id=al.patient_id WHERE u.hospital_id=? AND al.log_date >= DATE_SUB(CURDATE(),INTERVAL 30 DAY)");
        $stmt->execute([$hospitalId]);
        return (float)($stmt->fetchColumn() ?? 0);
    }

    private function patientTodayStats(PDO $db, int $patientId, string $type): int {
        if ($type === 'total') {
            $stmt = $db->prepare("SELECT COUNT(*) FROM medication_schedules WHERE patient_id=? AND DATE(scheduled_time)=CURDATE()");
        } elseif ($type === 'taken') {
            $stmt = $db->prepare("SELECT COUNT(*) FROM medication_schedules WHERE patient_id=? AND DATE(scheduled_time)=CURDATE() AND status='taken'");
        } else {
            $stmt = $db->prepare("SELECT COUNT(*) FROM medication_schedules WHERE patient_id=? AND DATE(scheduled_time)=CURDATE() AND status='pending'");
        }
        $stmt->execute([$patientId]);
        return (int)$stmt->fetchColumn();
    }

    private function patientWeekAdherence(PDO $db, int $patientId): float {
        $stmt = $db->prepare("SELECT ROUND(AVG(adherence_percentage),1) FROM adherence_logs WHERE patient_id=? AND log_date >= DATE_SUB(CURDATE(),INTERVAL 7 DAY)");
        $stmt->execute([$patientId]);
        return (float)($stmt->fetchColumn() ?? 0);
    }

    private function getDashboardData(PDO $db, string $role, int $uid, ?int $hid): array {
        if ($role === 'super_admin') {
            $hospitals = 0; $users = 0; $prescriptions = 0; $adherence = 0.0;
            
            $s1 = $db->prepare("SELECT COUNT(*) FROM hospitals WHERE is_active=1");
            if ($s1->execute()) $hospitals = (int)$s1->fetchColumn();
            
            $s2 = $db->prepare("SELECT COUNT(*) FROM users WHERE is_active=1");
            if ($s2->execute()) $users = (int)$s2->fetchColumn();
            
            $s3 = $db->prepare("SELECT COUNT(*) FROM prescriptions WHERE is_active=1");
            if ($s3->execute()) $prescriptions = (int)$s3->fetchColumn();
            
            $s4 = $db->prepare("SELECT ROUND(IFNULL(AVG(adherence_percentage), 0), 1) FROM adherence_logs WHERE log_date >= DATE_SUB(CURDATE(),INTERVAL 30 DAY)");
            if ($s4->execute()) $adherence = (float)$s4->fetchColumn();
            
            return ['hospitals' => $hospitals, 'users' => $users, 'prescriptions' => $prescriptions, 'adherence' => $adherence];
        }
        if ($role === 'hospital_admin') {
            return [
                'doctors' => $this->countUsers($db,'doctor',$hid), 
                'patients' => $this->countUsers($db,'patient',$hid), 
                'avg_adherence' => $this->hospitalAdherence($db,$hid)];
        }
        if ($role === 'doctor') {
            $patients = 0; $todayAppts = 0; $prescriptions = 0;
            $s1 = $db->prepare("SELECT COUNT(*) FROM doctor_patient_assignments WHERE doctor_id=? AND is_active=1");
            if ($s1->execute([$uid])) $patients = (int)$s1->fetchColumn();
            $s2 = $db->prepare("SELECT COUNT(*) FROM appointments WHERE doctor_id=? AND DATE(appointment_date)=CURDATE() AND status='scheduled'");
            if ($s2->execute([$uid])) $todayAppts = (int)$s2->fetchColumn();
            $s3 = $db->prepare("SELECT COUNT(*) FROM prescriptions WHERE doctor_id=? AND is_active=1");
            if ($s3->execute([$uid])) $prescriptions = (int)$s3->fetchColumn();
            return ['patients' => $patients, 'todayAppts' => $todayAppts, 'prescriptions' => $prescriptions];
        }
        return [
            'today_total' => $this->patientTodayStats($db, $uid, 'total'),
            'today_taken' => $this->patientTodayStats($db, $uid, 'taken'),
            'today_pending' => $this->patientTodayStats($db, $uid, 'pending'),
            'week_adherence' => $this->patientWeekAdherence($db, $uid)
        ];
    }
}
?>