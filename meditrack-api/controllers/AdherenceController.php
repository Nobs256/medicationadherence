<?php
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Response.php';
require_once __DIR__ . '/../core/Request.php';

class AdherenceController {
    private ?array $auth;

    public function __construct(?array $auth) {
        $this->auth = $auth;
    }

    /**
     * GET /adherence?patient_id=X&from=YYYY-MM-DD&to=YYYY-MM-DD
     * Fetches daily adherence logs for a specific patient.
     */
    public function index(): void {
        $db        = Database::getInstance();
        $patientId = (int)Request::get('patient_id', $this->auth['uid']);
        $from      = Request::get('from', date('Y-m-d', strtotime('-30 days')));
        $to        = Request::get('to', date('Y-m-d'));

        // Enforce role isolation
        if ($this->auth['role'] === 'patient') $patientId = $this->auth['uid'];
        if ($this->auth['role'] === 'doctor') {
            $check = $db->prepare("SELECT 1 FROM doctor_patient_assignments WHERE doctor_id=? AND patient_id=? AND is_active=1");
            $check->execute([$this->auth['uid'], $patientId]);
            if (!$check->fetch()) Response::error('Forbidden', 403);
        }

        $stmt = $db->prepare("
            SELECT log_date, total_scheduled, total_taken, total_missed, total_skipped, adherence_percentage
            FROM adherence_logs
            WHERE patient_id = ? AND log_date BETWEEN ? AND ?
            ORDER BY log_date ASC
        ");
        $stmt->execute([$patientId, $from, $to]);
        Response::json($stmt->fetchAll());
    }

    /**
     * GET /adherence/summary?patient_id=X
     * Provides a statistical summary of adherence (weekly/monthly/streak).
     */
    public function summary(): void {
        $db        = Database::getInstance();
        $patientId = (int)Request::get('patient_id', $this->auth['uid']);
        if ($this->auth['role'] === 'patient') $patientId = $this->auth['uid'];

        // Last 7 days overview
        $week = $db->prepare("
            SELECT
                ROUND(IFNULL(AVG(adherence_percentage), 0), 1) AS weekly_avg,
                IFNULL(SUM(total_taken), 0)                    AS weekly_taken,
                IFNULL(SUM(total_scheduled), 0)                AS weekly_scheduled,
                IFNULL(SUM(total_missed), 0)                   AS weekly_missed
            FROM adherence_logs
            WHERE patient_id = ? AND log_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
        ");
        $week->execute([$patientId]);
        $weekData = $week->fetch();

        // Last 30 days overview
        $month = $db->prepare("
            SELECT
                ROUND(IFNULL(AVG(adherence_percentage), 0), 1) AS monthly_avg,
                IFNULL(SUM(total_taken), 0)                    AS monthly_taken,
                IFNULL(SUM(total_scheduled), 0)                AS monthly_scheduled,
                IFNULL(COUNT(CASE WHEN adherence_percentage >= 80 THEN 1 END), 0) AS good_days
            FROM adherence_logs
            WHERE patient_id = ? AND log_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
        ");
        $month->execute([$patientId]);
        $monthData = $month->fetch();

        // Current adherence streak (days >= 80%)
        $streak = $this->calculateStreak($db, $patientId);

        // Per-medication adherence breakdown for the last 30 days
        $meds = $db->prepare("
            SELECT m.name AS medication_name, pm.dosage,
                   COUNT(*) AS total_doses,
                   SUM(ms.status = 'taken') AS taken,
                   SUM(ms.status = 'missed') AS missed,
                   ROUND(SUM(ms.status='taken') / COUNT(*) * 100, 1) AS adherence_pct
            FROM medication_schedules ms
            JOIN prescription_medications pm ON pm.id = ms.prescription_medication_id
            JOIN medications m ON m.id = pm.medication_id
            WHERE ms.patient_id = ?
              AND ms.scheduled_time >= DATE_SUB(NOW(), INTERVAL 30 DAY)
            GROUP BY pm.id, m.name, pm.dosage
        ");
        $meds->execute([$patientId]);

        Response::json([
            'weekly'           => $weekData,
            'monthly'          => $monthData,
            'best_streak_days' => $streak,
            'per_medication'   => $meds->fetchAll(),
        ]);
    }

    private function calculateStreak(PDO $db, int $patientId): int {
        $stmt = $db->prepare("
            SELECT log_date, adherence_percentage
            FROM adherence_logs
            WHERE patient_id = ?
            ORDER BY log_date DESC
            LIMIT 60
        ");
        $stmt->execute([$patientId]);
        $logs   = $stmt->fetchAll();
        $streak = 0;
        foreach ($logs as $log) {
            if ((float)$log['adherence_percentage'] >= 80) $streak++;
            else break;
        }
        return $streak;
    }
}