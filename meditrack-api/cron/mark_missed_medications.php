<?php
require_once __DIR__ . '/../config/config.php';
require_once __DIR__ . '/../core/Database.php';

$db = Database::getInstance();
// TESTING: Mark as missed if older than 5 minutes (was 1 hour)
$db->prepare("
    UPDATE medication_schedules
    SET status = 'missed'
    WHERE status = 'pending'
      AND scheduled_time < DATE_SUB(NOW(), INTERVAL 5 MINUTE)
")->execute();

echo "[" . date('Y-m-d H:i:s') . "] Missed medications updated.\n";
?>