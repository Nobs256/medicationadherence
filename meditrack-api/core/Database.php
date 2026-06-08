<?php
class Database {
    private static ?PDO $instance = null;

    public static function getInstance(): PDO {
        if (self::$instance === null) {
            $host = $_SERVER['DB_HOST'] ?? getenv('DB_HOST');
            $db   = $_SERVER['DB_NAME'] ?? getenv('DB_NAME');
            $dsn  = "mysql:host=$host;dbname=$db;charset=utf8mb4";
            self::$instance = new PDO($dsn, $_SERVER['DB_USER'] ?? getenv('DB_USER'), $_SERVER['DB_PASS'] ?? getenv('DB_PASS'), [
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES   => true,
            ]);
        }
        return self::$instance;
    }
}