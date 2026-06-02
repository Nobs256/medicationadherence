<?php
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Response.php';
require_once __DIR__ . '/../core/Request.php';
require_once __DIR__ . '/../core/Helpers.php';
require_once __DIR__ . '/../core/Upload.php';

class MedicationController {
    private ?array $auth;

    public function __construct(?array $auth) {
        $this->auth = $auth;
    }

    public function index(): void {
        $db         = Database::getInstance();
        $hospitalId = (int)Request::get('hospital_id', $this->auth['hid'] ?? 0);
        $search     = sanitize(Request::get('q', ''));

        $params = [$hospitalId];
        $searchSql = '';
        if ($search) {
            $searchSql = 'AND (m.name LIKE ? OR m.generic_name LIKE ? OR m.category LIKE ?)';
            $params = array_merge($params, ["%$search%", "%$search%", "%$search%"]);
        }

        $stmt = $db->prepare("
            SELECT m.*, u.full_name AS created_by_name 
            FROM medications m 
            LEFT JOIN users u ON u.id = m.created_by 
            WHERE m.hospital_id = ? $searchSql 
            ORDER BY m.name ASC
        ");
        $stmt->execute($params);
        Response::json($stmt->fetchAll());
    }

    public function store(): void {
        $db   = Database::getInstance();
        $body = Request::json();
        $missing = validateRequired($body, ['name']);
        if ($missing) Response::error('name is required', 422);

        $imageUrl = null;
        if (!empty($_FILES['image'])) {
            try {
                $imageUrl = uploadImage($_FILES['image'], 'drug_images');
            } catch (Exception $e) {
                Response::error($e->getMessage(), 422);
            }
        }

        $db->prepare("
            INSERT INTO medications (hospital_id, created_by, name, generic_name, description, category, image_url) 
            VALUES (?,?,?,?,?,?,?)
        ")->execute([
            $this->auth['hid'],
            $this->auth['uid'],
            sanitize($body['name']),
            sanitize($body['generic_name'] ?? ''),
            sanitize($body['description'] ?? ''),
            sanitize($body['category'] ?? ''),
            $imageUrl
        ]);

        Response::json(['medication_id' => $db->lastInsertId()], 201);
    }

    public function update(string $id): void {
        $db   = Database::getInstance();
        $body = Request::json();
        $db->prepare("
            UPDATE medications 
            SET name = ?, generic_name = ?, description = ?, category = ? 
            WHERE id = ? AND hospital_id = ?
        ")->execute([
            sanitize($body['name'] ?? ''),
            sanitize($body['generic_name'] ?? ''),
            sanitize($body['description'] ?? ''),
            sanitize($body['category'] ?? ''),
            (int)$id,
            $this->auth['hid']
        ]);
        Response::json(['updated' => true]);
    }
}