<?php
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Response.php';
require_once __DIR__ . '/../core/Request.php';
require_once __DIR__ . '/../core/Helpers.php';
require_once __DIR__ . '/../core/Auth.php';

class AuthController {
    private ?array $auth;

    public function __construct(?array $auth) {
        $this->auth = $auth;
    }

    /**
     * POST /auth/login
     */
    public function login(): void {
        $body  = Request::json();
        $email = sanitize($body['email'] ?? '');
        $pass  = $body['password'] ?? '';

        if (!$email || !$pass) {
            Response::error('Email and password are required', 422);
        }

        $db   = Database::getInstance();
        $stmt = $db->prepare("
            SELECT u.*, r.name AS role_name 
            FROM users u 
            JOIN roles r ON r.id = u.role_id 
            WHERE u.email = ? AND u.is_active = 1
        ");
        $stmt->execute([$email]);
        $user = $stmt->fetch();

        if (!$user || !password_verify($pass, $user['password'])) {
            Response::error('Invalid email or password', 401);
        }

        // Update last login
        $db->prepare("UPDATE users SET last_login = NOW() WHERE id = ?")->execute([$user['id']]);

        // Issue Tokens
        $tokens = Auth::issueTokens($user);
        
        // Clean sensitive data before response
        unset($user['password']);

        Response::json(array_merge($tokens, ['user' => $user]));
    }

    /**
     * POST /auth/refresh
     */
    public function refresh(): void {
        $body = Request::json();
        $refreshToken = $body['refresh_token'] ?? '';
        if (!$refreshToken) Response::error('Refresh token required', 422);

        $db = Database::getInstance();
        $hashedToken = hash('sha256', $refreshToken);
        
        $stmt = $db->prepare("
            SELECT rt.*, u.id, u.hospital_id, r.name AS role_name 
            FROM refresh_tokens rt
            JOIN users u ON u.id = rt.user_id
            JOIN roles r ON r.id = u.role_id
            WHERE rt.token = ? AND rt.revoked = 0 AND rt.expires_at > NOW()
        ");
        $stmt->execute([$hashedToken]);
        $tokenData = $stmt->fetch();

        if (!$tokenData) Response::error('Invalid or expired refresh token', 401);

        // Revoke old token
        $db->prepare("UPDATE refresh_tokens SET revoked = 1 WHERE id = ?")->execute([$tokenData['id']]);

        // Issue new tokens
        $user = ['id' => $tokenData['user_id'], 'role_name' => $tokenData['role_name'], 'hospital_id' => $tokenData['hospital_id']];
        $newTokens = Auth::issueTokens($user);

        Response::json($newTokens);
    }

     /**
     * POST /auth/logout
     */
    public function logout(): void {
        $body = Request::json();
        $refreshToken = $body['refresh_token'] ?? '';
        if ($refreshToken) {
            $db = Database::getInstance();
            $db->prepare("UPDATE refresh_tokens SET revoked = 1 WHERE token = ?")
               ->execute([hash('sha256', $refreshToken)]);
        }
        Response::json(['message' => 'Logged out successfully']);
    }

    /**
     * POST /auth/change-password
     */
    public function changePassword(): void {
        $body = Request::json();
        $oldPass = $body['old_password'] ?? '';
        $newPass = $body['new_password'] ?? '';

        if (!$oldPass || !$newPass) Response::error('Old and new passwords required', 422);

        $db = Database::getInstance();
        $stmt = $db->prepare("SELECT password FROM users WHERE id = ?");
        $stmt->execute([$this->auth['uid']]);
        $user = $stmt->fetch();

        if (!$user || !password_verify($oldPass, $user['password'])) {
            Response::error('Incorrect current password', 401);
        }

        $db->prepare("UPDATE users SET password = ? WHERE id = ?")
           ->execute([hashPassword($newPass), $this->auth['uid']]);

        Response::json(['message' => 'Password updated successfully']);
    }
}