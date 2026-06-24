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
        $appointments = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Manually cast numeric types to ensure correct JSON representation for clients.
        foreach ($appointments as &$appt) {
            $appt['id'] = (int)$appt['id'];
        }
        Response::json($appointments);
    }

    /**
     * POST /appointments
     * Allows a doctor to schedule an appointment OR a patient to request one.
     */
    public function store(): void {
        $db   = Database::getInstance();
        $body = Request::json();
        $role = $this->auth['role'];
        $uid  = $this->auth['uid'];

        if ($role === 'doctor') {
            // Doctor schedules an appointment for a patient
            $missing = validateRequired($body, ['patient_id', 'appointment_date', 'purpose']);
            if ($missing) Response::error('Missing: ' . implode(', ', $missing), 422);

            // Verify the patient is assigned to this doctor
            $check = $db->prepare("SELECT 1 FROM doctor_patient_assignments WHERE doctor_id=? AND patient_id=? AND is_active=1");
            $check->execute([$uid, (int)$body['patient_id']]);
            if (!$check->fetch()) Response::error('Patient not assigned to you', 403);

            $stmt = $db->prepare("
                INSERT INTO appointments (patient_id, doctor_id, hospital_id, appointment_date, purpose, notes, status)
                VALUES (?,?,?,?,?,?,?)
            ");
            $stmt->execute([
                (int)$body['patient_id'],
                $uid,
                $this->auth['hid'],
                sanitize($body['appointment_date']),
                sanitize($body['purpose']),
                sanitize($body['notes'] ?? ''),
                'scheduled' // Doctors directly schedule
            ]);
            $apptId = $db->lastInsertId();

            // Notify patient
            insertNotification($db, [
                'recipient_id'   => (int)$body['patient_id'],
                'sender_id'      => $uid,
                'title'          => '📅 Appointment Scheduled',
                'body'           => "Your doctor scheduled an appointment on " . date('M j, Y g:i A', strtotime($body['appointment_date'])) . ". Purpose: {$body['purpose']}",
                'type'           => 'appointment',
                'reference_id'   => $apptId,
                'reference_table'=> 'appointments',
            ]);

            Response::json(['appointment_id' => $apptId], 201);

        } elseif ($role === 'patient') {
            // Patient requests an appointment with a doctor
            $missing = validateRequired($body, ['doctor_id', 'appointment_date', 'purpose']);
            if ($missing) Response::error('Missing: ' . implode(', ', $missing), 422);

            $stmt = $db->prepare("
                INSERT INTO appointments (patient_id, doctor_id, hospital_id, appointment_date, purpose, notes, status)
                VALUES (?,?,?,?,?,?,?)
            ");
            $stmt->execute([
                $uid,
                (int)$body['doctor_id'],
                $this->auth['hid'],
                sanitize($body['appointment_date']),
                sanitize($body['purpose']),
                sanitize($body['notes'] ?? ''),
                'requested' // Patients request, doctor must approve
            ]);
            $apptId = $db->lastInsertId();

            // Notify Doctor
            insertNotification($db, [
                'recipient_id'   => (int)$body['doctor_id'],
                'sender_id'      => $uid,
                'title'          => '🗓️ Appointment Request',
                'body'           => "You have a new appointment request for " . date('M j, Y g:i A', strtotime($body['appointment_date'])),
                'type'           => 'appointment',
                'reference_id'   => $apptId,
                'reference_table'=> 'appointments',
            ]);

            Response::json(['appointment_id' => $apptId], 201);
        } else {
            Response::error('Forbidden', 403);
        }
    }

    /**
     * PUT /appointments/{id}
     * Allows a doctor to update their appointments (e.g., accept/reject/reschedule).
     * Allows a patient to cancel a requested appointment.
     */
    public function update(string $id): void {
        $db   = Database::getInstance();
        $body = Request::json();
        $role = $this->auth['role'];
        $uid  = $this->auth['uid'];

        $stmt = $db->prepare("SELECT * FROM appointments WHERE id=?");
        $stmt->execute([(int)$id]);
        $appt = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$appt) Response::error('Not found', 404);

        $canUpdate = false;
        if ($role === 'doctor' && $appt['doctor_id'] == $uid) {
            $canUpdate = true;
        } elseif ($role === 'patient' && $appt['patient_id'] == $uid) {
            // Patient can only cancel an appointment they requested that is still pending.
            if ($appt['status'] === 'requested' && isset($body['status']) && $body['status'] === 'cancelled') {
                $canUpdate = true;
            }
        }

        if (!$canUpdate) {
            Response::error('Forbidden: You do not have permission to update this appointment.', 403);
        }

        // Build the update query dynamically
        $fields = [];
        $params = [];
        $allowedFields = ['appointment_date', 'purpose', 'notes', 'status'];

        foreach ($body as $key => $value) {
            if (in_array($key, $allowedFields)) {
                $fields[] = "$key = ?";
                $params[] = sanitize($value);
            }
        }

        if (empty($fields)) {
            Response::json(['message' => 'No fields to update'], 200);
            return;
        }

        $params[] = (int)$id;
        $stmt = $db->prepare("UPDATE appointments SET " . implode(', ', $fields) . " WHERE id = ?");
        $stmt->execute($params);

        // Send notifications on status change
        if (isset($body['status'])) {
            $newStatus = $body['status'];
            $patientId = (int)$appt['patient_id'];
            $doctorId = (int)$appt['doctor_id'];
            $appointmentDate = $body['appointment_date'] ?? $appt['appointment_date'];

            if ((($newStatus === 'scheduled' && $appt['status'] === 'requested') || $newStatus === 'rejected') && $role === 'doctor') {
                // Doctor accepted or rejected the request, notify patient
                $stmt = $db->prepare("SELECT full_name FROM users WHERE id = ?");
                $stmt->execute([$doctorId]);
                $doctorName = $stmt->fetchColumn();
                
                $title = $newStatus === 'scheduled' ? '✅ Appointment Confirmed' : '❌ Appointment Rejected';
                $bodyText = $newStatus === 'scheduled' 
                    ? "Your appointment request for %s has been confirmed by %s."
                    : "Your appointment request for %s has been rejected by %s.";

                insertNotification($db, [
                    'recipient_id'   => $patientId,
                    'sender_id'      => $uid,
                    'title'          => $title,
                    'body'           => sprintf($bodyText, date('M j, Y g:i A', strtotime($appointmentDate)), $doctorName),
                    'type'           => 'appointment',
                    'reference_id'   => (int)$id,
                    'reference_table'=> 'appointments',
                ]);
            } elseif ($newStatus === 'cancelled' && $role === 'patient') {
                // Patient cancelled their request, notify doctor
                $stmt = $db->prepare("SELECT full_name FROM users WHERE id = ?");
                $stmt->execute([$patientId]);
                $patientName = $stmt->fetchColumn();

                insertNotification($db, [
                    'recipient_id'   => $doctorId,
                    'sender_id'      => $uid,
                    'title'          => '🚫 Appointment Cancelled',
                    'body'           => "{$patientName} has cancelled their appointment request for " . date('M j, Y g:i A', strtotime($appointmentDate)) . ".",
                    'type'           => 'appointment',
                    'reference_id'   => (int)$id,
                    'reference_table'=> 'appointments',
                ]);
            }
        }

        Response::json(['updated' => true]);
    }
}
