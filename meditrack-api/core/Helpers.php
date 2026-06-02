<?php
function sanitize(string $input): string {
    return htmlspecialchars(strip_tags(trim($input)), ENT_QUOTES, 'UTF-8');
}

function generateCode(PDO $db, string $table, string $column, string $prefix, int $padding = 4): string {
    $stmt = $db->prepare("SELECT $column FROM $table ORDER BY id DESC LIMIT 1");
    $stmt->execute();
    $last = $stmt->fetchColumn();
    $num  = $last ? (int)substr($last, strlen($prefix) + 1) + 1 : 1;
    return $prefix . '-' . str_pad((string)$num, $padding, '0', STR_PAD_LEFT);
}

function insertNotification(PDO $db, array $n): void {
    $db->prepare("
        INSERT INTO notifications
            (recipient_id, sender_id, title, body, type, reference_id, reference_table)
        VALUES (?,?,?,?,?,?,?)
    ")->execute([
        $n['recipient_id'],
        $n['sender_id']        ?? null,
        $n['title'],
        $n['body'],
        $n['type'],
        $n['reference_id']     ?? null,
        $n['reference_table']  ?? null,
    ]);
}

function paginationOffset(int $page, int $perPage = 20): int {
    return max(0, ($page - 1) * $perPage);
}

function validateRequired(array $data, array $fields): array {
    $missing = [];
    foreach ($fields as $f) {
        if (!isset($data[$f]) || trim((string)$data[$f]) === '') {
            $missing[] = $f;
        }
    }
    return $missing;
}

function hashPassword(string $plain): string {
    return password_hash($plain, PASSWORD_BCRYPT, ['cost' => 12]);
}

function randomPassword(int $length = 10): string {
    return substr(str_shuffle('ABCDEFGHJKMNPQRSTUVWXYZabcdefghjkmnpqrstuvwxyz23456789@#$'), 0, $length);
}