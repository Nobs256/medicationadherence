<?php
require_once __DIR__ . '/../vendor/autoload.php';

$dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . '/..');
$dotenv->safeLoad();

define('APP_URL',           $_ENV['APP_URL'] ?? 'http://localhost');
define('JWT_SECRET',        $_ENV['JWT_SECRET'] ?? '');
define('JWT_ACCESS_TTL',    (int)($_ENV['JWT_ACCESS_TTL'] ?? 900));
define('JWT_REFRESH_TTL',   (int)($_ENV['JWT_REFRESH_TTL'] ?? 2592000));
define('ONESIGNAL_APP_ID',  $_ENV['ONESIGNAL_APP_ID'] ?? '');
define('ONESIGNAL_KEY',     $_ENV['ONESIGNAL_REST_API_KEY'] ?? '');
define('UPLOAD_PATH',       $_ENV['UPLOAD_PATH'] ?? __DIR__ . '/../uploads');
define('UPLOAD_URL',        $_ENV['UPLOAD_URL'] ?? APP_URL . '/uploads');
define('MAX_UPLOAD_BYTES',  (int)($_ENV['MAX_UPLOAD_MB'] ?? 5) * 1024 * 1024);