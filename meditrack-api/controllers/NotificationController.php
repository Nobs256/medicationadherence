<?php
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Response.php';
require_once __DIR__ . '/../core/Request.php';
require_once __DIR__ . '/../core/Helpers.php';

class NotificationController {
    private ?array $auth;

    public function __construct(?array $auth) {
        $this->auth = $auth;
    }

    // GET /notifications?page=1
    public function index(): void {
        $db     = Database::getInstance();
        $uid    = $this->auth['uid'];
        $page   = max(1, (int)Request::get('page', 1));
        $perPage = 30;
        $offset  = paginationOffset($page, $perPage);

        $total = $db->prepare("SELECT COUNT(*) FROM notifications WHERE recipient_id=?");
        $total->execute([$uid]);
        $count = (int)$total->fetchColumn();

        $stmt = $db->prepare("
            SELECT n.id, n.title, n.body, n.type, n.reference_id, n.reference_table,
                   n.is_read, n.sent_at, n.read_at,
                   u.full_name AS sender_name
            FROM notifications n
            LEFT JOIN users u ON u.id = n.sender_id
            WHERE n.recipient_id = ?
            ORDER BY n.sent_at DESC
            LIMIT ? OFFSET ?
        ");
        $stmt->execute([$uid, $perPage, $offset]);
        Response::paginated($stmt->fetchAll(), $count, $page, $perPage);
    }

    // POST /notifications/{id}/read
    public function markRead(string $id): void {
        $db = Database::getInstance();
        $db->prepare("UPDATE notifications SET is_read=1, read_at=NOW() WHERE id=? AND recipient_id=?")
           ->execute([(int)$id, $this->auth['uid']]);
        Response::json(['marked_read' => true]);
    }

    // POST /notifications/read-all
    public function markAllRead(): void {
        $db = Database::getInstance();
        $db->prepare("UPDATE notifications SET is_read=1, read_at=NOW() WHERE recipient_id=? AND is_read=0")
           ->execute([$this->auth['uid']]);
        Response::json(['all_marked_read' => true]);
    }

    // GET /notifications/unread-count
    public function unreadCount(): void {
        $db   = Database::getInstance();
        $stmt = $db->prepare("SELECT COUNT(*) FROM notifications WHERE recipient_id=? AND is_read=0");
        $stmt->execute([$this->auth['uid']]);
        Response::json(['count' => (int)$stmt->fetchColumn()]);
    }

    // PUT /users/onesignal-id
    public function updatePlayerId(): void {
        $db   = Database::getInstance();
        $body = Request::json();
        if (empty($body['onesignal_player_id'])) Response::error('onesignal_player_id required', 422);
        $db->prepare("UPDATE users SET onesignal_player_id=? WHERE id=?")
           ->execute([sanitize($body['onesignal_player_id']), $this->auth['uid']]);
        Response::json(['updated' => true]);
    }
}