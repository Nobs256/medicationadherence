<?php
require_once __DIR__ . '/../config/config.php';
require_once __DIR__ . '/../core/Database.php';

$processed = 0;
try {
$db        = Database::getInstance();
$yesterday = date('Y-m-d', strtotime('-1 day'));

$stmt = $db->query("SELECT DISTINCT patient_id FROM medication_schedules WHERE DATE(scheduled_time) = '{$yesterday}'");
$patients = $stmt->fetchAll(PDO::FETCH_COLUMN);

foreach ($patients as $patientId) {
    try {
    $stmtCount = $db->prepare("
        SELECT
            COUNT(*) AS total,
            SUM(status = 'taken')   AS taken,
            SUM(status = 'missed')  AS missed,
            SUM(status = 'skipped') AS skipped
        FROM medication_schedules
        WHERE patient_id = ? AND DATE(scheduled_time) = ?
    ");
    $stmtCount->execute([$patientId, $yesterday]);
    $counts = $stmtCount->fetch();

    if (!$counts) continue;

    $pct = $counts['total'] > 0 ? round(($counts['taken'] / $counts['total']) * 100, 2) : 0;

    $db->prepare("
        INSERT INTO adherence_logs (patient_id, log_date, total_scheduled, total_taken, total_missed, total_skipped, adherence_percentage)
        VALUES (?,?,?,?,?,?,?)
        ON DUPLICATE KEY UPDATE 
            total_scheduled=VALUES(total_scheduled), 
            total_taken=VALUES(total_taken),
            total_missed=VALUES(total_missed), 
            total_skipped=VALUES(total_skipped), 
            adherence_percentage=VALUES(adherence_percentage)
    ")->execute([$patientId, $yesterday, $counts['total'], $counts['taken'], $counts['missed'], $counts['skipped'], $pct]);

    $processed++;
    } catch (Throwable $e) {
        // Skip failed patient record
        continue;
    }
}
} catch (Throwable $e) {
    error_log("Compute Adherence Cron Error: " . $e->getMessage());
}

echo "[" . date('Y-m-d H:i:s') . "] Adherence computed for $processed patients.\n";
?>