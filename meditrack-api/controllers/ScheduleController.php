<?php
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Response.php';
require_once __DIR__ . '/../core/Request.php';
require_once __DIR__ . '/../core/Helpers.php';

class ScheduleController {
    private ?array $auth;

    public function __construct(?array $auth) {
        $this->auth = $auth;
    }

    public function today(): void {
        $db  = Database::getInstance();
        $uid = $this->auth['uid'];

        $stmt = $db->prepare("
            SELECT
                ms.id, ms.scheduled_time, ms.status, ms.confirmed_at, ms.notes,
                pm.dosage, pm.frequency, pm.with_food, pm.with_water, pm.special_instructions,
                m.name AS medication_name, m.image_url,
                p.diagnosis
            FROM medication_schedules ms
            JOIN prescription_medications pm ON pm.id = ms.prescription_medication_id
            JOIN medications m ON m.id = pm.medication_id
            JOIN prescriptions p ON p.id = pm.prescription_id
            WHERE ms.patient_id = ?
              AND DATE(ms.scheduled_time) = CURDATE()
            ORDER BY ms.scheduled_time ASC
        ");
        $stmt->execute([$uid]);
        Response::json($stmt->fetchAll());
    }

    public function index(): void {
        $db        = Database::getInstance();
        $from      = Request::get('from', date('Y-m-d'));
        $to        = Request::get('to', date('Y-m-d'));
        $patientId = (int)Request::get('patient_id', $this->auth['uid']);

        if ($this->auth['role'] === 'doctor') {
            $check = $db->prepare("SELECT 1 FROM doctor_patient_assignments WHERE doctor_id=? AND patient_id=? AND is_active=1");
            $check->execute([$this->auth['uid'], $patientId]);
            if (!$check->fetch()) Response::error('Forbidden', 403);
        }

        $stmt = $db->prepare("
            SELECT ms.id, ms.scheduled_time, ms.status, m.name AS medication_name
            FROM medication_schedules ms
            JOIN prescription_medications pm ON pm.id = ms.prescription_medication_id
            JOIN medications m ON m.id = pm.medication_id
            WHERE ms.patient_id = ?
              AND DATE(ms.scheduled_time) BETWEEN ? AND ?
            ORDER BY ms.scheduled_time ASC
        ");
        $stmt->execute([$patientId, $from, $to]);
        Response::json($stmt->fetchAll());
    }

    public function markTaken(string $id): void {
        $db = Database::getInstance();
        $stmt = $db->prepare("SELECT patient_id FROM medication_schedules WHERE id = ?");
        $stmt->execute([(int)$id]);
        $schedule = $stmt->fetch();

        if (!$schedule || $schedule['patient_id'] != $this->auth['uid']) Response::error('Unauthorized', 403);

        $db->prepare("UPDATE medication_schedules SET status='taken', confirmed_at=NOW() WHERE id=?")->execute([(int)$id]);
        Response::json(['status' => 'taken']);
    }

    public function markSkipped(string $id): void {
        $db   = Database::getInstance();
        $body = Request::json();
        $db->prepare("UPDATE medication_schedules SET status='skipped', confirmed_at=NOW(), notes=? WHERE id=? AND patient_id=?")
           ->execute([sanitize($body['notes'] ?? ''), (int)$id, $this->auth['uid']]);
        Response::json(['status' => 'skipped']);
    }
}