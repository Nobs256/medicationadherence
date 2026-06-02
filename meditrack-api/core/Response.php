<?php
class Response {
    public static function json($data, int $code = 200) {
        http_response_code($code);
        header('Content-Type: application/json');
        echo json_encode(['success' => true, 'data' => $data]);
        exit;
    }

    public static function error(string $message, int $code = 400) {
        http_response_code($code);
        header('Content-Type: application/json');
        echo json_encode(['success' => false, 'message' => $message]);
        exit;
    }

    public static function paginated(array $data, int $total, int $page, int $perPage) {
        http_response_code(200);
        header('Content-Type: application/json');
        echo json_encode([
            'success' => true,
            'data'    => $data,
            'meta'    => [
                'total' => $total, 'page' => $page, 'per_page' => $perPage, 
                'last_page' => ceil($total / $perPage)
            ]
        ]);
        exit;
    }
}