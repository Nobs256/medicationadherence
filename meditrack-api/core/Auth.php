<?php
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class Auth {
    public static function issueTokens(array $user): array {
        $now = time();
        $accessPayload = [
            'iss'  => APP_URL,
            'iat'  => $now,
            'exp'  => $now + JWT_ACCESS_TTL,
            'uid'  => $user['id'],
            'role' => $user['role_name'],
            'hid'  => $user['hospital_id'],
        ];
        $accessToken  = JWT::encode($accessPayload, JWT_SECRET, 'HS256');
        $refreshToken = bin2hex(random_bytes(64));

        // Store refresh token
        $db = Database::getInstance();
        $db->prepare("INSERT INTO refresh_tokens (user_id, token, expires_at) VALUES (?,?,?)")
           ->execute([$user['id'], hash('sha256', $refreshToken), date('Y-m-d H:i:s', $now + JWT_REFRESH_TTL)]);

        return ['access_token' => $accessToken, 'refresh_token' => $refreshToken, 'expires_in' => JWT_ACCESS_TTL];
    }

    public static function verifyAccessToken(string $token): ?array {
        try {
            $decoded = JWT::decode($token, new Key(JWT_SECRET, 'HS256'));
            return (array)$decoded;
        } catch (Exception $e) {
            return null;
        }
    }

    public static function fromRequest(): ?array {
        $token = Request::bearerToken();
        if (!$token) {
            return null;
        }
        return self::verifyAccessToken($token);
    }
}