<?php
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Response.php';
require_once __DIR__ . '/../core/Request.php';
require_once __DIR__ . '/../core/Helpers.php';

class PrescriptionController {
    private ?array $auth;

    public function __construct(?array $auth) {
        $this->auth = $auth;
    }

    public function index(): void {
        try {
        $db        = Database::getInstance();
        $patientId = (int)Request::get('patient_id');
        $active    = Request::get('active');

        $conditions = ['p.hospital_id = ?'];
        $params     = [$this->auth['hid']];

        if ($patientId) { $conditions[] = 'p.patient_id = ?'; $params[] = $patientId; }
        if ($this->auth['role'] === 'doctor') { $conditions[] = 'p.doctor_id = ?'; $params[] = $this->auth['uid']; }
        if ($active !== null) { $conditions[] = 'p.is_active = ?'; $params[] = (int)$active; }

        $where = 'WHERE ' . implode(' AND ', $conditions);
        $stmt  = $db->prepare("
            SELECT p.id, p.diagnosis, p.start_date, p.end_date, p.is_active, p.created_at,
                   pat.full_name AS patient_name, pat.avatar_url AS patient_avatar,
                   doc.full_name AS doctor_name,
                   (SELECT COUNT(*) FROM prescription_medications pm WHERE pm.prescription_id=p.id) AS medication_count
            FROM prescriptions p
            JOIN users pat ON pat.id = p.patient_id
            JOIN users doc ON doc.id = p.doctor_id
            $where ORDER BY p.created_at DESC
        ");
        $stmt->execute($params);
        Response::json($stmt->fetchAll());
        } catch (Throwable $e) {
            Response::error('Fetch failed: ' . $e->getMessage(), 500);
        }
    }

    public function store(): void {
        $body = Request::json();
        $db   = Database::getInstance();

        $missing = validateRequired($body, ['patient_id', 'diagnosis', 'start_date', 'medications']);
        if ($missing) Response::error('Missing: ' . implode(', ', $missing), 422);

        // Verify the patient is assigned to this doctor and belongs to the same hospital
        $check = $db->prepare("SELECT 1 FROM doctor_patient_assignments WHERE doctor_id=? AND patient_id=? AND hospital_id=? AND is_active=1");
        $check->execute([$this->auth['uid'], (int)$body['patient_id'], $this->auth['hid']]);
        if (!$check->fetch()) Response::error('Patient not assigned to you or in a different hospital', 403);

        $db->beginTransaction();
        try {
            // 1. Insert prescription
            $stmt = $db->prepare("INSERT INTO prescriptions (patient_id, doctor_id, hospital_id, diagnosis, notes, start_date, end_date) VALUES (?,?,?,?,?,?,?)");
            $stmt->execute([(int)$body['patient_id'], $this->auth['uid'], $this->auth['hid'], sanitize($body['diagnosis']), sanitize($body['notes'] ?? ''), $body['start_date'], $body['end_date'] ?? null]);
            $prescriptionId = $db->lastInsertId();

            // 2. Insert each medication + generate schedules
            foreach ($body['medications'] as $med) {
                if (empty($med['medication_id']) || empty($med['times_of_day'])) continue;

                $stmt = $db->prepare("INSERT INTO prescription_medications (prescription_id, medication_id, dosage, frequency, times_of_day, with_food, with_water, special_instructions, duration_days) VALUES (?,?,?,?,?,?,?,?,?)");
                $stmt->execute([$prescriptionId, (int)$med['medication_id'], sanitize($med['dosage']), sanitize($med['frequency']), json_encode($med['times_of_day']), $med['with_food'] ? 1 : 0, $med['with_water'] ? 1 : 0, sanitize($med['special_instructions'] ?? null), $med['duration_days'] ?? null]);
                $pmId = $db->lastInsertId();

                // Generate medication_schedules
                $startDate  = new DateTime($body['start_date']);
                $durationDays = $med['duration_days'] ?? (isset($body['end_date']) ? (new DateTime($body['start_date']))->diff(new DateTime($body['end_date']))->days + 1 : 30);

                $scheduleInserts = [];
                for ($day = 0; $day < $durationDays; $day++) {
                    $date = clone $startDate;
                    $date->modify("+{$day} days");
                    foreach ($med['times_of_day'] as $time) {
                        [$hour, $minute] = explode(':', $time);
                        $scheduleInserts[] = [$pmId, (int)$body['patient_id'], $date->format('Y-m-d') . " {$hour}:{$minute}:00"];
                    }
                }
                // Batch insert schedules
                if (!empty($scheduleInserts)) {
                    $placeholders = implode(',', array_fill(0, count($scheduleInserts), '(?,?,?)'));
                    $flatValues    = array_merge(...$scheduleInserts);
                    $db->prepare("INSERT INTO medication_schedules (prescription_medication_id, patient_id, scheduled_time) VALUES {$placeholders}")->execute($flatValues);
                }
            }

            // 3. Insert lifestyle advice
            foreach ($body['lifestyle_advice'] ?? [] as $advice) {
                $db->prepare("INSERT INTO lifestyle_advice (prescription_id, advice_type, title, description, frequency, duration_minutes) VALUES (?,?,?,?,?,?)")
                   ->execute([$prescriptionId, $advice['advice_type'], sanitize($advice['title']), sanitize($advice['description']), sanitize($advice['frequency'] ?? null), $advice['duration_minutes'] ?? null]);
            }

            // 4. Send in-app notification to patient
            insertNotification($db, [
                'recipient_id'   => $body['patient_id'],
                'sender_id'      => $this->auth['uid'],
                'title'          => '📋 New Prescription',
                'body'           => "A new prescription has been issued for you. Open the app to view your schedule.",
                'type'           => 'prescription',
                'reference_id'   => $prescriptionId,
                'reference_table'=> 'prescriptions',
            ]);

            $db->commit();
            Response::json(['prescription_id' => $prescriptionId], 201);
        } catch (Exception $e) {
            $db->rollBack();
            Response::error('Failed to create prescription: ' . $e->getMessage(), 500);
        }
    }

    public function show(string $id): void {
        try {
        $db   = Database::getInstance();
        $stmt = $db->prepare("
            SELECT p.*, pat.full_name AS patient_name, pat.date_of_birth, pat.avatar_url AS patient_avatar,
                   doc.full_name AS doctor_name, h.name AS hospital_name
            FROM prescriptions p
            JOIN users pat ON pat.id = p.patient_id
            JOIN users doc ON doc.id = p.doctor_id
            JOIN hospitals h ON h.id = p.hospital_id
            WHERE p.id = ?
        ");
        $stmt->execute([(int)$id]);
        $prescription = $stmt->fetch();
        if (!$prescription) Response::error('Not found', 404);

        // Enforce access control
        if ($this->auth['role'] === 'patient' && $prescription['patient_id'] != $this->auth['uid']) Response::error('Forbidden', 403);
        if ($this->auth['role'] !== 'super_admin' && $prescription['hospital_id'] != $this->auth['hid']) Response::error('Forbidden', 403);

        $meds = $db->prepare("
            SELECT pm.*, m.name AS medication_name, m.generic_name, m.category,
                   m.description AS medication_description, m.image_url
            FROM prescription_medications pm
            JOIN medications m ON m.id = pm.medication_id
            WHERE pm.prescription_id = ?
        ");
        $meds->execute([(int)$id]);
        $medsData = $meds->fetchAll();
        foreach ($medsData as &$med) {
            $med['times_of_day'] = json_decode($med['times_of_day'], true);
            $med['with_food']    = (bool)$med['with_food'];
            $med['with_water']   = (bool)$med['with_water'];
        }

        $advice = $db->prepare("SELECT * FROM lifestyle_advice WHERE prescription_id = ? ORDER BY advice_type ASC");
        $advice->execute([(int)$id]);

        $prescription['medications']     = $medsData;
        $prescription['lifestyle_advice'] = $advice->fetchAll();

        Response::json($prescription);
        } catch (Throwable $e) {
            Response::error('View Error: ' . $e->getMessage(), 500);
        }
    }

    public function myPrescriptions(): void {
        try {
        $db   = Database::getInstance();
        $stmt = $db->prepare("
            SELECT p.id, p.diagnosis, p.start_date, p.end_date, p.is_active, doc.full_name AS doctor_name
            FROM prescriptions p
            JOIN users doc ON doc.id = p.doctor_id
            WHERE p.patient_id = ?
            ORDER BY p.is_active DESC, p.created_at DESC
        ");
        $stmt->execute([$this->auth['uid']]);
        $prescriptions = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $adviceStmt = $db->prepare("SELECT * FROM lifestyle_advice WHERE prescription_id = ? ORDER BY id ASC");

        foreach ($prescriptions as &$p) {
            // Cast types to ensure correct JSON representation
            $p['id'] = (int)$p['id'];
            $p['is_active'] = (bool)$p['is_active'];

            $adviceStmt->execute([$p['id']]);
            $advices = $adviceStmt->fetchAll(PDO::FETCH_ASSOC);

            // Also cast types for advice items
            foreach ($advices as &$a) {
                $a['id'] = (int)$a['id'];
                $a['prescription_id'] = (int)$a['prescription_id'];
                $a['duration_minutes'] = isset($a['duration_minutes']) ? (int)$a['duration_minutes'] : null;
            }
            $p['lifestyle_advice'] = $advices;
        }

        Response::json($prescriptions);
        } catch (Throwable $e) {
            Response::error('Fetch Error: ' . $e->getMessage(), 500);
        }
    }
}