<?php
class Response {
    public static function json($data, int $code = 200): void {
        http_response_code($code);
        header('Content-Type: application/json');
        $json = json_encode(['success' => true, 'data' => $data]);
        if ($json === false) {
            self::error('JSON Encoding Error: ' . json_last_error_msg(), 500);
        }
        echo $json;
        if (function_exists('fastcgi_finish_request')) fastcgi_finish_request();
        flush();
        exit;
    }

    public static function error(string $message, int $code = 400): void {
        http_response_code($code);
        header('Content-Type: application/json');
        echo json_encode(['success' => false, 'message' => $message]);
        if (function_exists('fastcgi_finish_request')) fastcgi_finish_request();
        flush();
        exit;
    }

    public static function paginated(array $data, int $total, int $page, int $perPage): void {
        http_response_code(200);
        header('Content-Type: application/json');
        $json = json_encode([
            'success' => true,
            'data'    => $data,
            'meta'    => [
                'total' => $total, 'page' => $page, 'per_page' => $perPage, 
                'last_page' => ceil($total / $perPage)
            ]
        ]);
        if ($json === false) {
            self::error('JSON Encoding Error: ' . json_last_error_msg(), 500);
        }
        echo $json;
        if (function_exists('fastcgi_finish_request')) fastcgi_finish_request();
        flush();
        exit;
    }
}