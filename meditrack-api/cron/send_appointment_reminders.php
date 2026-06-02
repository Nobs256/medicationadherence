<?php
require_once __DIR__ . '/../config/config.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Helpers.php';

$db       = Database::getInstance();
$tomorrow = date('Y-m-d'); // TESTING: Check for today's appointments instead of tomorrow

$stmt = $db->prepare("
    SELECT a.id, a.appointment_date, a.purpose, a.patient_id,
           p.full_name AS patient_name, p.onesignal_player_id,
           d.full_name AS doctor_name
    FROM appointments a
    JOIN users p ON p.id = a.patient_id
    JOIN users d ON d.id = a.doctor_id
    WHERE DATE(a.appointment_date) = ?
      AND a.status = 'scheduled'
      AND a.reminder_sent = 0
      AND p.onesignal_player_id IS NOT NULL
");
$stmt->execute([$tomorrow]);
$appointments = $stmt->fetchAll();

foreach ($appointments as $appt) {
    $time    = date('g:i A', strtotime($appt['appointment_date']));
    $payload = [
        'app_id'             => ONESIGNAL_APP_ID,
        'include_player_ids' => [$appt['onesignal_player_id']],
        'headings'           => ['en' => '📅 Appointment Tomorrow'],
        'contents'           => ['en' => "You have an appointment with Dr. {$appt['doctor_name']} tomorrow at {$time}. Purpose: {$appt['purpose']}"],
        'data'               => ['type' => 'appointment', 'appointment_id' => (string)$appt['id']],
    ];

    $ch = curl_init('https://onesignal.com/api/v1/notifications');
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true, 
        CURLOPT_POST => true, 
        CURLOPT_HTTPHEADER => ['Content-Type: application/json', 'Authorization: Basic ' . ONESIGNAL_KEY], 
        CURLOPT_POSTFIELDS => json_encode($payload)
    ]);
    curl_exec($ch);
    curl_close($ch);

    // Mark as reminded + insert in-app notification
    $db->prepare("UPDATE appointments SET reminder_sent=1 WHERE id=?")->execute([$appt['id']]);
    insertNotification($db, [
        'recipient_id' => $appt['patient_id'],
        'title'        => '📅 Appointment Tomorrow',
        'body'         => "Appointment with Dr. {$appt['doctor_name']} at {$time}",
        'type'         => 'appointment',
        'reference_id' => $appt['id'],
        'reference_table' => 'appointments',
    ]);
}

echo "[" . date('Y-m-d H:i:s') . "] Appointment reminders sent: " . count($appointments) . "\n";
?>