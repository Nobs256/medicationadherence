<?php
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Response.php';
require_once __DIR__ . '/../core/Request.php';
require_once __DIR__ . '/../core/Helpers.php';

class AppointmentController {
    private ?array $auth;

    public function __construct(?array $auth) {
        $this->auth = $auth;
    }

    /**
     * GET /appointments?status=scheduled&patient_id=X
     * Lists appointments filtered by user role and status.
     */
    public function index(): void {
        $db     = Database::getInstance();
        $status = Request::get('status');
        $uid    = $this->auth['uid'];
        $role   = $this->auth['role'];

        $conditions = [];
        $params     = [];

        if ($role === 'patient') {
            $conditions[] = 'a.patient_id = ?'; $params[] = $uid;
        } elseif ($role === 'doctor') {
            $conditions[] = 'a.doctor_id = ?'; $params[] = $uid;
        } elseif ($role === 'hospital_admin') {
            $conditions[] = 'a.hospital_id = ?'; $params[] = $this->auth['hid'];
        }

        if ($status) { $conditions[] = 'a.status = ?'; $params[] = $status; }

        $where = $conditions ? 'WHERE ' . implode(' AND ', $conditions) : '';
        $stmt  = $db->prepare("
            SELECT a.id, a.appointment_date, a.purpose, a.notes, a.status,
                   p.full_name AS patient_name, p.phone AS patient_phone, p.avatar_url AS patient_avatar,
                   d.full_name AS doctor_name, d.phone AS doctor_phone,
                   h.name AS hospital_name
            FROM appointments a
            JOIN users p ON p.id = a.patient_id
            JOIN users d ON d.id = a.doctor_id
            JOIN hospitals h ON h.id = a.hospital_id
            $where ORDER BY a.appointment_date ASC
        ");
        $stmt->execute($params);
        Response::json($stmt->fetchAll());
    }

    /**
     * POST /appointments
     * Allows a doctor to schedule a new appointment with an assigned patient.
     */
    public function store(): void {
        $db   = Database::getInstance();
        $body = Request::json();

        $missing = validateRequired($body, ['patient_id', 'appointment_date', 'purpose']);
        if ($missing) Response::error('Missing: ' . implode(', ', $missing), 422);

        // Verify the patient is assigned to this doctor
        $check = $db->prepare("SELECT 1 FROM doctor_patient_assignments WHERE doctor_id=? AND patient_id=? AND is_active=1");
        $check->execute([$this->auth['uid'], (int)$body['patient_id']]);
        if (!$check->fetch()) Response::error('Patient not assigned to you', 403);

        $db->prepare("
            INSERT INTO appointments (patient_id, doctor_id, hospital_id, appointment_date, purpose, notes)
            VALUES (?,?,?,?,?,?)
        ")->execute([
            (int)$body['patient_id'],
            $this->auth['uid'],
            $this->auth['hid'],
            sanitize($body['appointment_date']),
            sanitize($body['purpose']),
            sanitize($body['notes'] ?? ''),
        ]);
        $apptId = $db->lastInsertId();

        // Notify patient
        insertNotification($db, [
            'recipient_id'   => (int)$body['patient_id'],
            'sender_id'      => $this->auth['uid'],
            'title'          => '📅 Appointment Scheduled',
            'body'           => "You have an appointment scheduled on " . date('M j, Y g:i A', strtotime($body['appointment_date'])) . ". Purpose: {$body['purpose']}",
            'type'           => 'appointment',
            'reference_id'   => $apptId,
            'reference_table'=> 'appointments',
        ]);

        Response::json(['appointment_id' => $apptId], 201);
    }

    /**
     * PUT /appointments/{id}
     * Allows a doctor to update or cancel their appointments.
     */
    public function update(string $id): void {
        $db   = Database::getInstance();
        $body = Request::json();

        // Verify doctor owns this appointment
        $stmt = $db->prepare("SELECT doctor_id FROM appointments WHERE id=?");
        $stmt->execute([(int)$id]);
        $appt = $stmt->fetch();
        if (!$appt) Response::error('Not found', 404);
        if ($appt['doctor_id'] != $this->auth['uid']) Response::error('Forbidden', 403);

        $db->prepare("
            UPDATE appointments SET
                appointment_date = ?, purpose = ?, notes = ?, status = ?
            WHERE id = ?
        ")->execute([
            sanitize($body['appointment_date'] ?? ''),
            sanitize($body['purpose'] ?? ''),
            sanitize($body['notes'] ?? ''),
            sanitize($body['status'] ?? 'scheduled'),
            (int)$id,
        ]);
        Response::json(['updated' => true]);
    }
}