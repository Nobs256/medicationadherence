<?php
require_once __DIR__ . '/../config/config.php';
require_once __DIR__ . '/../core/Database.php';

$processedCount = 0;
try {
$db  = Database::getInstance();
$now = new DateTime();
$in24h = (clone $now)->modify('+24 hours');

// Fetch pending schedules within next 24h without notifications sent
$stmt = $db->prepare("
    SELECT
        ms.id, ms.scheduled_time, ms.patient_id,
        u.onesignal_player_id, u.full_name,
        pm.dosage, pm.with_food, pm.with_water, pm.special_instructions,
        m.name AS med_name, m.description AS med_desc
    FROM medication_schedules ms
    JOIN users u ON u.id = ms.patient_id
    JOIN prescription_medications pm ON pm.id = ms.prescription_medication_id
    JOIN medications m ON m.id = pm.medication_id
    WHERE ms.status = 'pending'
      AND ms.onesignal_notification_id IS NULL
      AND ms.scheduled_time BETWEEN ? AND ?
      AND u.onesignal_player_id IS NOT NULL
");
$stmt->execute([$now->format('Y-m-d H:i:s'), $in24h->format('Y-m-d H:i:s')]);
$schedules = $stmt->fetchAll();

if (!defined('ONESIGNAL_KEY') || !ONESIGNAL_KEY) return;

foreach ($schedules as $s) {
    try {
    $scheduledTime = new DateTime($s['scheduled_time']);
    $advanceTime   = (clone $scheduledTime)->modify('-2 hours');
    $instructions  = buildInstructions($s);

    // Advance reminder (2 hours before)
    if ($advanceTime > $now) {
        $advId = sendOneSignalNotification(
            $s['onesignal_player_id'],
            "⏰ Upcoming: {$s['med_name']}",
            "You will need to take {$s['med_name']} ({$s['dosage']}) in 2 hours. {$instructions}",
            ['type' => 'advance_reminder', 'schedule_id' => (string)$s['id']],
            $advanceTime->format(DateTime::ATOM)
        );
        $db->prepare("UPDATE medication_schedules SET advance_notification_id = ?, advance_reminder_sent_at = NOW() WHERE id = ?")
           ->execute([$advId, $s['id']]);
    }

    // Due reminder (at scheduled time)
    $dueId = sendOneSignalNotification(
        $s['onesignal_player_id'],
        "💊 Time to take {$s['med_name']}",
        "Take {$s['dosage']} of {$s['med_name']} now. {$instructions}",
        ['type' => 'medication_reminder', 'schedule_id' => (string)$s['id']],
        $scheduledTime->format(DateTime::ATOM)
    );
    $db->prepare("UPDATE medication_schedules SET onesignal_notification_id = ?, reminder_sent_at = NOW() WHERE id = ?")
       ->execute([$dueId, $s['id']]);
    
    $processedCount++;
    } catch (Throwable $e) {
        continue;
    }
}
} catch (Throwable $e) {
    error_log("Medication Reminder Cron Error: " . $e->getMessage());
}

function buildInstructions(array $s): string {
    $parts = [];
    if ($s['with_food'])  $parts[] = 'Take with food';
    if ($s['with_water']) $parts[] = 'Drink plenty of water';
    if ($s['special_instructions']) $parts[] = $s['special_instructions'];
    return implode('. ', $parts);
}

function sendOneSignalNotification(string $playerId, string $title, string $body, array $data = [], ?string $sendAfter = null): ?string {
    $payload = [
        'app_id'             => ONESIGNAL_APP_ID,
        'include_player_ids' => [$playerId],
        'headings'           => ['en' => $title],
        'contents'           => ['en' => $body],
        'data'               => $data,
    ];
    if ($sendAfter) $payload['send_after'] = $sendAfter;

    $ch = curl_init('https://onesignal.com/api/v1/notifications');
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST           => true,
        CURLOPT_HTTPHEADER     => [
            'Content-Type: application/json', 
            'Authorization: Basic ' . ONESIGNAL_KEY
        ],
        CURLOPT_POSTFIELDS     => json_encode($payload),
    ]);
    $rawResponse = curl_exec($ch);
    $result = $rawResponse ? json_decode($rawResponse, true) : null;
    curl_close($ch);
    return (is_array($result) && isset($result['id'])) ? (string)$result['id'] : null;
}

echo "[" . date('Y-m-d H:i:s') . "] Reminders processed: $processedCount\n";
?>