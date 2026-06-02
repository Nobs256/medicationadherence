<?php
class Request {
    public static function json(): array {
        $raw = file_get_contents('php://input');
        $data = json_decode($raw, true);
        return is_array($data) ? $data : [];
    }

    public static function get(string $key, mixed $default = null): mixed {
        return $_GET[$key] ?? $default;
    }

    public static function post(string $key, mixed $default = null): mixed {
        return $_POST[$key] ?? $default;
    }

    public static function bearerToken(): ?string {
        $header = $_SERVER['HTTP_AUTHORIZATION'] ?? $_SERVER['REDIRECT_HTTP_AUTHORIZATION'] ?? '';
        if (preg_match('/Bearer\s+(.+)/i', $header, $m)) return $m[1];
        return null;
    }

    public static function ip(): string {
        return $_SERVER['HTTP_X_FORWARDED_FOR']
            ?? $_SERVER['REMOTE_ADDR']
            ?? '0.0.0.0';
    }
}