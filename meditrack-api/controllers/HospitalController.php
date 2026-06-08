<?php
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Response.php';
require_once __DIR__ . '/../core/Request.php';
require_once __DIR__ . '/../core/Helpers.php';
require_once __DIR__ . '/../core/Upload.php';

class HospitalController {
    private ?array $auth;

    public function __construct(?array $auth) {
        $this->auth = $auth;
    }

    public function index(): void {
        $db   = Database::getInstance();
        $sql = "
            SELECT h.*,
                (SELECT COUNT(*) FROM users u JOIN roles r ON r.id=u.role_id WHERE u.hospital_id=h.id AND r.name='doctor' AND u.is_active=1) AS doctor_count,
                (SELECT COUNT(*) FROM users u JOIN roles r ON r.id=u.role_id WHERE u.hospital_id=h.id AND r.name='patient' AND u.is_active=1) AS patient_count,
                (SELECT ROUND(IFNULL(AVG(al.adherence_percentage), 0), 1) FROM adherence_logs al JOIN users u ON u.id=al.patient_id WHERE u.hospital_id=h.id AND al.log_date >= DATE_SUB(CURDATE(),INTERVAL 30 DAY)) AS avg_adherence
            FROM hospitals h ORDER BY h.name ASC
        ";
        $stmt = $db->prepare($sql);
        $stmt->execute();
        Response::json($stmt->fetchAll(PDO::FETCH_ASSOC));
    }

    public function store(): void {
        $db   = Database::getInstance();
        $body = Request::json();
        $missing = validateRequired($body, ['name']);
        if ($missing) Response::error('name is required', 422);

        $logoUrl = null;
        if (!empty($_FILES['logo'])) {
            try { $logoUrl = uploadImage($_FILES['logo'], 'hospital_logos'); }
            catch (Exception $e) { Response::error($e->getMessage(), 422); }
        }

        $db->prepare("INSERT INTO hospitals (name, address, phone, email, logo_url, created_by) VALUES (?,?,?,?,?,?)")
           ->execute([sanitize($body['name']), sanitize($body['address'] ?? ''), sanitize($body['phone'] ?? ''), sanitize($body['email'] ?? ''), $logoUrl, $this->auth['uid']]);

        Response::json(['hospital_id' => $db->lastInsertId()], 201);
    }

    public function show(string $id): void {
        $db   = Database::getInstance();
        $stmt = $db->prepare("SELECT h.*, u.full_name AS created_by_name FROM hospitals h LEFT JOIN users u ON u.id=h.created_by WHERE h.id=?");
        $stmt->execute([(int)$id]);
        $hospital = $stmt->fetch();
        if (!$hospital) Response::error('Hospital not found', 404);

        // Admins for this hospital
        $admins = $db->prepare("SELECT u.id, u.full_name, u.email, u.phone FROM users u JOIN roles r ON r.id=u.role_id WHERE u.hospital_id=? AND r.name='hospital_admin' AND u.is_active=1");
        $admins->execute([(int)$id]);
        $hospital['admins'] = $admins->fetchAll();

        Response::json($hospital);
    }

    public function update(string $id): void {
        $db   = Database::getInstance();
        $body = Request::json();
        $db->prepare("UPDATE hospitals SET name=?, address=?, phone=?, email=? WHERE id=?")
           ->execute([sanitize($body['name'] ?? ''), sanitize($body['address'] ?? ''), sanitize($body['phone'] ?? ''), sanitize($body['email'] ?? ''), (int)$id]);
        Response::json(['updated' => true]);
    }

    public function toggle(string $id): void {
        $db = Database::getInstance();
        $db->prepare("UPDATE hospitals SET is_active = NOT is_active WHERE id=?")->execute([(int)$id]);
        $hospital = $db->prepare("SELECT is_active FROM hospitals WHERE id=?"); $hospital->execute([(int)$id]);
        $h = $hospital->fetch();
        if (!$h['is_active']) {
            $db->prepare("UPDATE users SET is_active=0 WHERE hospital_id=?")->execute([(int)$id]);
        }
        Response::json(['toggled' => true]);
    }
}