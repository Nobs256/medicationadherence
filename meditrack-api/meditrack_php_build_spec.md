# Build Specification: MediTrack — Multi-Hospital Medication Adherence & Chronic Disease Monitoring App
# (Revised: PHP REST API + MySQL Backend)

> **For AI Agent Use:** This document is the single source of truth for building the complete MediTrack application. Read every section before writing any code. Build features in the phase order defined at the end. Never skip ahead. The backend is a PHP REST API. The frontend is Flutter. They communicate exclusively via JSON over HTTP.

---

## 1. Project Overview

**App Name:** MediTrack  
**Mobile Platform:** Flutter (iOS + Android)  
**Backend:** PHP 8.2+ REST API (no framework — pure PHP with PDO)  
**Database:** MySQL 8.0+  
**Push Notifications:** OneSignal (triggered from PHP cron jobs)  
**File Storage:** Local server filesystem (served via PHP)  
**Auth:** JWT (JSON Web Tokens) — issued by PHP, verified on every request  

### Architecture Summary
```
┌─────────────────┐        HTTPS/JSON         ┌──────────────────────┐
│  Flutter App    │ ◄────────────────────────► │  PHP REST API        │
│  (iOS/Android)  │                            │  /api/v1/...         │
└─────────────────┘                            ├──────────────────────┤
                                               │  MySQL 8.0+          │
         OneSignal Push ◄─────────────────────┤  (all data)          │
         Notifications                         ├──────────────────────┤
                                               │  PHP Cron Jobs       │
                                               │  (notification       │
                                               │   scheduler)         │
                                               └──────────────────────┘
```

### Core Value Propositions
- Patients receive timely, rich medication reminders with full drug instructions
- Doctors prescribe medications, exercises, and lifestyle advice digitally
- Hospitals onboard and manage their own isolated data ecosystems
- Admins oversee the entire platform or individual hospital operations

---

## 2. Tech Stack

### PHP Backend
- **PHP:** 8.2+
- **Database:** MySQL 8.0+ via PDO
- **Auth:** JWT — use `firebase/php-jwt` (install via Composer)
- **Notifications:** OneSignal REST API called via PHP `curl`
- **Storage:** Local filesystem (`/uploads/`) served via PHP endpoint
- **Cron:** Linux crontab calling PHP scripts every 5 minutes
- **No framework:** Pure PHP, procedural with helper files

### Flutter Frontend
- **Flutter SDK:** Latest stable (≥ 3.19)
- **State Management:** Riverpod (flutter_riverpod + riverpod_annotation)
- **Navigation:** GoRouter
- **HTTP Client:** Dio (replaces supabase_flutter)
- **Auth storage:** flutter_secure_storage (stores JWT token)
- **Notifications:** onesignal_flutter
- **UI Components:** Custom widget library

### Flutter Packages
```yaml
dependencies:
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5
  go_router: ^13.2.0
  dio: ^5.4.3
  flutter_secure_storage: ^9.0.0
  onesignal_flutter: ^5.1.2
  flutter_local_notifications: ^17.1.2
  intl: ^0.19.0
  image_picker: ^1.0.7
  cached_network_image: ^3.3.1
  fl_chart: ^0.67.0
  shimmer: ^3.0.0
  gap: ^3.0.1
  timeago: ^3.6.1
  logger: ^2.2.0
  freezed_annotation: ^2.4.1
  json_annotation: ^4.9.0

dev_dependencies:
  build_runner: ^2.4.9
  riverpod_generator: ^2.3.11
  freezed: ^2.5.2
  json_serializable: ^6.8.0
  flutter_lints: ^3.0.0
```

### PHP Composer Packages
```json
{
  "require": {
    "firebase/php-jwt": "^6.10",
    "vlucas/phpdotenv": "^5.6"
  }
}
```

---

## 3. PHP Backend — Project Structure

```
meditrack-api/
├── composer.json
├── composer.lock
├── vendor/
├── .env                          # DB creds, JWT secret, OneSignal keys
├── .env.example
├── .htaccess                     # Rewrite all → index.php
├── index.php                     # Router entry point
├── config/
│   └── config.php                # Load .env, DB connection, constants
├── core/
│   ├── Database.php              # PDO singleton
│   ├── Router.php                # Simple URL router
│   ├── Request.php               # Parse JSON body, headers
│   ├── Response.php              # json(), error(), paginated()
│   ├── Auth.php                  # JWT issue, verify, middleware
│   ├── Upload.php                # Image upload handler
│   └── Helpers.php               # sanitize(), generateCode(), hashPassword()
├── controllers/
│   ├── AuthController.php
│   ├── HospitalController.php
│   ├── UserController.php
│   ├── MedicationController.php
│   ├── PrescriptionController.php
│   ├── ScheduleController.php
│   ├── AppointmentController.php
│   ├── NotificationController.php
│   └── AdherenceController.php
├── cron/
│   ├── send_medication_reminders.php   # Run every 5 min
│   ├── send_appointment_reminders.php  # Run every hour
│   ├── mark_missed_medications.php     # Run every 15 min
│   └── compute_adherence.php          # Run daily at midnight
└── uploads/
    ├── avatars/
    ├── hospital_logos/
    └── drug_images/
```

---

## 4. MySQL Database Schema

> Run all SQL in exact order. Use InnoDB engine, utf8mb4 charset.

```sql
CREATE DATABASE IF NOT EXISTS meditrack CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE meditrack;
```

### 4.1 `roles`
```sql
CREATE TABLE roles (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(50) NOT NULL UNIQUE  -- 'super_admin','hospital_admin','doctor','patient'
);

INSERT INTO roles (name) VALUES
  ('super_admin'), ('hospital_admin'), ('doctor'), ('patient');
```

### 4.2 `hospitals`
```sql
CREATE TABLE hospitals (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(200) NOT NULL,
  address     TEXT,
  phone       VARCHAR(30),
  email       VARCHAR(150),
  logo_url    VARCHAR(255),
  is_active   TINYINT(1) DEFAULT 1,
  created_by  INT,
  created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### 4.3 `users`
```sql
CREATE TABLE users (
  id                  INT AUTO_INCREMENT PRIMARY KEY,
  role_id             INT NOT NULL,
  hospital_id         INT,
  full_name           VARCHAR(150) NOT NULL,
  email               VARCHAR(150) NOT NULL UNIQUE,
  password            VARCHAR(255) NOT NULL,
  phone               VARCHAR(30),
  avatar_url          VARCHAR(255),
  onesignal_player_id VARCHAR(255),
  date_of_birth       DATE,
  gender              ENUM('male','female','other'),
  emergency_contact   VARCHAR(200),
  diagnosis           TEXT,              -- for patients: primary diagnosis
  is_active           TINYINT(1) DEFAULT 1,
  last_login          DATETIME,
  created_at          DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at          DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (role_id) REFERENCES roles(id),
  FOREIGN KEY (hospital_id) REFERENCES hospitals(id) ON DELETE SET NULL
);

-- Seed default super admin
INSERT INTO users (role_id, full_name, email, password) VALUES
  (1, 'System Admin', 'admin@meditrack.app', '$2y$12$PLACEHOLDER_HASH');
-- Replace PLACEHOLDER_HASH with password_hash('Admin@1234', PASSWORD_BCRYPT, ['cost'=>12])
```

### 4.4 `doctor_patient_assignments`
```sql
CREATE TABLE doctor_patient_assignments (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  doctor_id   INT NOT NULL,
  patient_id  INT NOT NULL,
  hospital_id INT NOT NULL,
  assigned_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  is_active   TINYINT(1) DEFAULT 1,
  UNIQUE KEY unique_assignment (doctor_id, patient_id),
  FOREIGN KEY (doctor_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (patient_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (hospital_id) REFERENCES hospitals(id)
);
```

### 4.5 `medications`
```sql
CREATE TABLE medications (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  hospital_id INT,
  created_by  INT,
  name        VARCHAR(200) NOT NULL,
  generic_name VARCHAR(200),
  description TEXT,
  category    VARCHAR(100),             -- 'antibiotic','antidiabetic','antihypertensive', etc.
  image_url   VARCHAR(255),
  created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (hospital_id) REFERENCES hospitals(id) ON DELETE SET NULL,
  FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);
```

### 4.6 `prescriptions`
```sql
CREATE TABLE prescriptions (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  patient_id  INT NOT NULL,
  doctor_id   INT NOT NULL,
  hospital_id INT NOT NULL,
  diagnosis   TEXT,
  notes       TEXT,
  is_active   TINYINT(1) DEFAULT 1,
  start_date  DATE NOT NULL,
  end_date    DATE,
  created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (patient_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (doctor_id) REFERENCES users(id),
  FOREIGN KEY (hospital_id) REFERENCES hospitals(id)
);
```

### 4.7 `prescription_medications`
```sql
CREATE TABLE prescription_medications (
  id                  INT AUTO_INCREMENT PRIMARY KEY,
  prescription_id     INT NOT NULL,
  medication_id       INT NOT NULL,
  dosage              VARCHAR(100) NOT NULL,        -- e.g. "500mg"
  frequency           VARCHAR(100) NOT NULL,        -- e.g. "twice daily"
  times_of_day        JSON NOT NULL,               -- ["08:00","20:00"]
  with_food           TINYINT(1) DEFAULT 0,
  with_water          TINYINT(1) DEFAULT 1,
  special_instructions TEXT,
  duration_days       INT,
  created_at          DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (prescription_id) REFERENCES prescriptions(id) ON DELETE CASCADE,
  FOREIGN KEY (medication_id) REFERENCES medications(id)
);
```

### 4.8 `lifestyle_advice`
```sql
CREATE TABLE lifestyle_advice (
  id              INT AUTO_INCREMENT PRIMARY KEY,
  prescription_id INT NOT NULL,
  advice_type     ENUM('exercise','diet','hydration','sleep','general') NOT NULL,
  title           VARCHAR(200) NOT NULL,
  description     TEXT NOT NULL,
  frequency       VARCHAR(100),              -- "Daily", "3 times a week"
  duration_minutes INT,
  created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (prescription_id) REFERENCES prescriptions(id) ON DELETE CASCADE
);
```

### 4.9 `medication_schedules`
```sql
CREATE TABLE medication_schedules (
  id                          INT AUTO_INCREMENT PRIMARY KEY,
  prescription_medication_id  INT NOT NULL,
  patient_id                  INT NOT NULL,
  scheduled_time              DATETIME NOT NULL,
  status                      ENUM('pending','taken','missed','skipped') DEFAULT 'pending',
  confirmed_at                DATETIME,
  onesignal_notification_id   VARCHAR(255),
  advance_notification_id     VARCHAR(255),
  reminder_sent_at            DATETIME,
  advance_reminder_sent_at    DATETIME,
  notes                       TEXT,
  created_at                  DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (prescription_medication_id) REFERENCES prescription_medications(id) ON DELETE CASCADE,
  FOREIGN KEY (patient_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_patient_scheduled (patient_id, scheduled_time),
  INDEX idx_status_scheduled (status, scheduled_time)
);
```

### 4.10 `appointments`
```sql
CREATE TABLE appointments (
  id              INT AUTO_INCREMENT PRIMARY KEY,
  patient_id      INT NOT NULL,
  doctor_id       INT NOT NULL,
  hospital_id     INT NOT NULL,
  appointment_date DATETIME NOT NULL,
  purpose         TEXT,
  notes           TEXT,
  status          ENUM('scheduled','completed','cancelled','rescheduled') DEFAULT 'scheduled',
  reminder_sent   TINYINT(1) DEFAULT 0,
  created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (patient_id) REFERENCES users(id),
  FOREIGN KEY (doctor_id) REFERENCES users(id),
  FOREIGN KEY (hospital_id) REFERENCES hospitals(id)
);
```

### 4.11 `notifications`
```sql
CREATE TABLE notifications (
  id              INT AUTO_INCREMENT PRIMARY KEY,
  recipient_id    INT NOT NULL,
  sender_id       INT,
  title           VARCHAR(255) NOT NULL,
  body            TEXT NOT NULL,
  type            ENUM('medication_reminder','advance_reminder','appointment','prescription','advice','general') NOT NULL,
  reference_id    INT,
  reference_table VARCHAR(100),
  is_read         TINYINT(1) DEFAULT 0,
  sent_at         DATETIME DEFAULT CURRENT_TIMESTAMP,
  read_at         DATETIME,
  FOREIGN KEY (recipient_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE SET NULL,
  INDEX idx_recipient_read (recipient_id, is_read)
);
```

### 4.12 `adherence_logs`
```sql
CREATE TABLE adherence_logs (
  id                      INT AUTO_INCREMENT PRIMARY KEY,
  patient_id              INT NOT NULL,
  log_date                DATE NOT NULL,
  total_scheduled         INT DEFAULT 0,
  total_taken             INT DEFAULT 0,
  total_missed            INT DEFAULT 0,
  total_skipped           INT DEFAULT 0,
  adherence_percentage    DECIMAL(5,2),
  created_at              DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY unique_patient_date (patient_id, log_date),
  FOREIGN KEY (patient_id) REFERENCES users(id) ON DELETE CASCADE
);
```

### 4.13 `refresh_tokens`
```sql
CREATE TABLE refresh_tokens (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  user_id     INT NOT NULL,
  token       VARCHAR(512) NOT NULL UNIQUE,
  expires_at  DATETIME NOT NULL,
  revoked     TINYINT(1) DEFAULT 0,
  created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
```

---

## 5. PHP Backend — Core Files

### 5.1 `.env`
```ini
APP_ENV=production
APP_URL=https://api.yourdomain.com

DB_HOST=localhost
DB_NAME=meditrack
DB_USER=root
DB_PASS=your_password

JWT_SECRET=your_very_long_random_secret_key_min_32_chars
JWT_ACCESS_TTL=900          # 15 minutes (seconds)
JWT_REFRESH_TTL=2592000     # 30 days (seconds)

ONESIGNAL_APP_ID=your_onesignal_app_id
ONESIGNAL_REST_API_KEY=your_onesignal_rest_api_key

UPLOAD_URL=https://api.yourdomain.com/uploads
UPLOAD_PATH=/var/www/meditrack-api/uploads
MAX_UPLOAD_MB=5
```

### 5.2 `config/config.php`
```php
<?php
require_once __DIR__ . '/../vendor/autoload.php';

$dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . '/..');
$dotenv->load();

define('APP_URL',           $_ENV['APP_URL']);
define('JWT_SECRET',        $_ENV['JWT_SECRET']);
define('JWT_ACCESS_TTL',    (int)$_ENV['JWT_ACCESS_TTL']);
define('JWT_REFRESH_TTL',   (int)$_ENV['JWT_REFRESH_TTL']);
define('ONESIGNAL_APP_ID',  $_ENV['ONESIGNAL_APP_ID']);
define('ONESIGNAL_KEY',     $_ENV['ONESIGNAL_REST_API_KEY']);
define('UPLOAD_PATH',       $_ENV['UPLOAD_PATH']);
define('UPLOAD_URL',        $_ENV['UPLOAD_URL']);
define('MAX_UPLOAD_BYTES',  (int)$_ENV['MAX_UPLOAD_MB'] * 1024 * 1024);
```

### 5.3 `core/Database.php`
```php
<?php
class Database {
    private static ?PDO $instance = null;

    public static function getInstance(): PDO {
        if (self::$instance === null) {
            $dsn = "mysql:host={$_ENV['DB_HOST']};dbname={$_ENV['DB_NAME']};charset=utf8mb4";
            self::$instance = new PDO($dsn, $_ENV['DB_USER'], $_ENV['DB_PASS'], [
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES   => false,
            ]);
        }
        return self::$instance;
    }
}
```

### 5.4 `core/Auth.php`
```php
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
            'name' => $user['full_name'],
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
        } catch (Exception) {
            return null;
        }
    }

    public static function fromRequest(): ?array {
        $header = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
        if (!preg_match('/Bearer\s+(.+)/i', $header, $m)) return null;
        return self::verifyAccessToken($m[1]);
    }
}
```

### 5.5 `core/Response.php`
```php
<?php
class Response {
    public static function json(mixed $data, int $code = 200): never {
        http_response_code($code);
        header('Content-Type: application/json');
        echo json_encode(['success' => true, 'data' => $data]);
        exit;
    }

    public static function error(string $message, int $code = 400): never {
        http_response_code($code);
        header('Content-Type: application/json');
        echo json_encode(['success' => false, 'message' => $message]);
        exit;
    }

    public static function paginated(array $data, int $total, int $page, int $perPage): never {
        http_response_code(200);
        header('Content-Type: application/json');
        echo json_encode([
            'success' => true,
            'data'    => $data,
            'meta'    => ['total' => $total, 'page' => $page, 'per_page' => $perPage, 'last_page' => ceil($total / $perPage)]
        ]);
        exit;
    }
}
```

### 5.6 `index.php` (Router)
```php
<?php
require_once 'config/config.php';
require_once 'core/Database.php';
require_once 'core/Auth.php';
require_once 'core/Response.php';
require_once 'core/Request.php';
require_once 'core/Helpers.php';
require_once 'core/Upload.php';

// CORS headers
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(204); exit; }

$uri    = strtok(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), '?');
$uri    = preg_replace('#^/api/v1#', '', $uri);
$method = $_SERVER['REQUEST_METHOD'];

// Route map: [METHOD, pattern, controller, action, [required_roles]]
$routes = [
    // Auth
    ['POST', '/auth/login',           'AuthController',         'login',                []],
    ['POST', '/auth/refresh',         'AuthController',         'refresh',              []],
    ['POST', '/auth/logout',          'AuthController',         'logout',               ['*']],
    ['POST', '/auth/change-password', 'AuthController',         'changePassword',       ['*']],

    // Hospitals (super_admin only)
    ['GET',  '/hospitals',            'HospitalController',     'index',                ['super_admin']],
    ['POST', '/hospitals',            'HospitalController',     'store',                ['super_admin']],
    ['GET',  '/hospitals/{id}',       'HospitalController',     'show',                 ['super_admin']],
    ['PUT',  '/hospitals/{id}',       'HospitalController',     'update',               ['super_admin']],
    ['POST', '/hospitals/{id}/toggle','HospitalController',     'toggle',               ['super_admin']],

    // Users management
    ['GET',  '/users',                'UserController',         'index',                ['super_admin','hospital_admin']],
    ['POST', '/users',                'UserController',         'store',                ['super_admin','hospital_admin']],
    ['GET',  '/users/{id}',           'UserController',         'show',                 ['super_admin','hospital_admin','doctor']],
    ['PUT',  '/users/{id}',           'UserController',         'update',               ['super_admin','hospital_admin']],
    ['POST', '/users/{id}/toggle',    'UserController',         'toggle',               ['super_admin','hospital_admin']],
    ['GET',  '/profile',              'UserController',         'profile',              ['*']],
    ['PUT',  '/profile',              'UserController',         'updateProfile',        ['*']],
    ['POST', '/profile/avatar',       'UserController',         'uploadAvatar',         ['*']],
    ['POST', '/users/{id}/assign',    'UserController',         'assignPatient',        ['hospital_admin']],

    // Medications (library)
    ['GET',  '/medications',          'MedicationController',   'index',                ['super_admin','hospital_admin','doctor']],
    ['POST', '/medications',          'MedicationController',   'store',                ['doctor','hospital_admin']],
    ['PUT',  '/medications/{id}',     'MedicationController',   'update',               ['doctor','hospital_admin']],

    // Prescriptions
    ['GET',  '/prescriptions',        'PrescriptionController', 'index',                ['doctor','hospital_admin']],
    ['POST', '/prescriptions',        'PrescriptionController', 'store',                ['doctor']],
    ['GET',  '/prescriptions/{id}',   'PrescriptionController', 'show',                 ['doctor','hospital_admin','patient']],
    ['PUT',  '/prescriptions/{id}',   'PrescriptionController', 'update',               ['doctor']],
    ['GET',  '/my-prescriptions',     'PrescriptionController', 'myPrescriptions',      ['patient']],

    // Schedules
    ['GET',  '/schedules/today',      'ScheduleController',     'today',                ['patient']],
    ['GET',  '/schedules',            'ScheduleController',     'index',                ['patient','doctor']],
    ['POST', '/schedules/{id}/take',  'ScheduleController',     'markTaken',            ['patient']],
    ['POST', '/schedules/{id}/skip',  'ScheduleController',     'markSkipped',          ['patient']],

    // Appointments
    ['GET',  '/appointments',         'AppointmentController',  'index',                ['doctor','patient','hospital_admin']],
    ['POST', '/appointments',         'AppointmentController',  'store',                ['doctor']],
    ['PUT',  '/appointments/{id}',    'AppointmentController',  'update',               ['doctor']],

    // Notifications
    ['GET',  '/notifications',        'NotificationController', 'index',                ['*']],
    ['POST', '/notifications/{id}/read','NotificationController','markRead',            ['*']],
    ['POST', '/notifications/read-all','NotificationController','markAllRead',          ['*']],
    ['GET',  '/notifications/unread-count','NotificationController','unreadCount',      ['*']],
    ['PUT',  '/users/onesignal-id',   'NotificationController', 'updatePlayerId',       ['*']],

    // Adherence
    ['GET',  '/adherence',            'AdherenceController',    'index',                ['patient','doctor','hospital_admin']],
    ['GET',  '/adherence/summary',    'AdherenceController',    'summary',              ['patient','doctor','hospital_admin']],

    // Dashboard stats
    ['GET',  '/dashboard',            'UserController',         'dashboard',            ['*']],
];

// Route matching & dispatch
foreach ($routes as [$routeMethod, $pattern, $controllerName, $action, $roles]) {
    $regex = preg_replace('#\{[^}]+\}#', '([^/]+)', $pattern);
    if ($method !== $routeMethod || !preg_match("#^{$regex}$#", $uri, $matches)) continue;

    // Auth check
    $tokenData = null;
    if (!empty($roles)) {
        $tokenData = Auth::fromRequest();
        if (!$tokenData) Response::error('Unauthorized', 401);
        if ($roles !== ['*'] && !in_array($tokenData['role'], $roles)) Response::error('Forbidden', 403);
    }

    array_shift($matches); // Remove full match
    require_once "controllers/{$controllerName}.php";
    $controller = new $controllerName($tokenData);
    call_user_func_array([$controller, $action], $matches);
    exit;
}

Response::error('Not Found', 404);
```

### 5.7 `.htaccess`
```apache
Options -Indexes
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^(.*)$ index.php [L,QSA]

# Prevent PHP execution in uploads
<Directory uploads>
  php_flag engine off
</Directory>

Header set Access-Control-Allow-Origin "*"
```

---

## 6. API Endpoints Reference

All endpoints prefixed with `/api/v1`. All responses are JSON.

### Authentication
| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| POST | `/auth/login` | None | Login → returns access_token + refresh_token + user |
| POST | `/auth/refresh` | None | Refresh access_token using refresh_token |
| POST | `/auth/logout` | JWT | Revoke refresh token |
| POST | `/auth/change-password` | JWT | Change own password |

### Hospitals
| Method | Endpoint | Roles | Description |
|--------|----------|-------|-------------|
| GET | `/hospitals` | super_admin | List all hospitals |
| POST | `/hospitals` | super_admin | Create hospital |
| GET | `/hospitals/{id}` | super_admin | Hospital detail + stats |
| PUT | `/hospitals/{id}` | super_admin | Update hospital |
| POST | `/hospitals/{id}/toggle` | super_admin | Activate/deactivate |

### Users
| Method | Endpoint | Roles | Description |
|--------|----------|-------|-------------|
| GET | `/users?role=doctor&hospital_id=X` | admin | List users (filtered) |
| POST | `/users` | admin | Create doctor/patient/admin |
| PUT | `/users/{id}` | admin | Update user |
| POST | `/users/{id}/toggle` | admin | Activate/deactivate |
| POST | `/users/{id}/assign` | hospital_admin | Assign patient to doctor |
| GET | `/profile` | all | Get own profile |
| PUT | `/profile` | all | Update own profile |
| POST | `/profile/avatar` | all | Upload avatar image |
| PUT | `/users/onesignal-id` | all | Update OneSignal player ID |

### Medications
| Method | Endpoint | Roles | Description |
|--------|----------|-------|-------------|
| GET | `/medications?hospital_id=X` | doctor, admin | List medication library |
| POST | `/medications` | doctor, admin | Add medication to library |
| PUT | `/medications/{id}` | doctor, admin | Edit medication |

### Prescriptions
| Method | Endpoint | Roles | Description |
|--------|----------|-------|-------------|
| GET | `/prescriptions?patient_id=X` | doctor, admin | List prescriptions |
| POST | `/prescriptions` | doctor | Create prescription (+ generates schedules) |
| GET | `/prescriptions/{id}` | doctor, admin, patient | Prescription detail |
| PUT | `/prescriptions/{id}` | doctor | Update prescription |
| GET | `/my-prescriptions` | patient | Own prescriptions |

### Schedules
| Method | Endpoint | Roles | Description |
|--------|----------|-------|-------------|
| GET | `/schedules/today` | patient | Today's medication schedule |
| GET | `/schedules?from=&to=&patient_id=` | patient, doctor | Schedule in date range |
| POST | `/schedules/{id}/take` | patient | Mark as taken |
| POST | `/schedules/{id}/skip` | patient | Mark as skipped + note |

### Appointments
| Method | Endpoint | Roles | Description |
|--------|----------|-------|-------------|
| GET | `/appointments` | doctor, patient, admin | List appointments |
| POST | `/appointments` | doctor | Create appointment |
| PUT | `/appointments/{id}` | doctor | Update/cancel |

### Notifications
| Method | Endpoint | Roles | Description |
|--------|----------|-------|-------------|
| GET | `/notifications` | all | List own notifications |
| POST | `/notifications/{id}/read` | all | Mark one as read |
| POST | `/notifications/read-all` | all | Mark all as read |
| GET | `/notifications/unread-count` | all | Returns `{ count: N }` |

### Adherence
| Method | Endpoint | Roles | Description |
|--------|----------|-------|-------------|
| GET | `/adherence?patient_id=X&from=&to=` | patient, doctor | Daily adherence logs |
| GET | `/adherence/summary?patient_id=X` | patient, doctor | Weekly/monthly summary stats |

---

## 7. Key Controller Logic

### 7.1 `AuthController::login()`
```php
public function login(): void {
    $body  = Request::json();
    $email = sanitize($body['email'] ?? '');
    $pass  = $body['password'] ?? '';

    $db   = Database::getInstance();
    $user = $db->prepare("
        SELECT u.*, r.name AS role_name 
        FROM users u JOIN roles r ON r.id = u.role_id 
        WHERE u.email = ? AND u.is_active = 1
    ")->execute([$email])->fetch();
    // Note: use $stmt->execute then ->fetch() properly with PDOStatement

    if (!$user || !password_verify($pass, $user['password']))
        Response::error('Invalid email or password', 401);

    // Update last login
    $db->prepare("UPDATE users SET last_login = NOW() WHERE id = ?")->execute([$user['id']]);

    $tokens = Auth::issueTokens($user);
    unset($user['password']);

    Response::json([...$tokens, 'user' => $user]);
}
```

### 7.2 `PrescriptionController::store()` — Schedule Generation
```php
public function store(): void {
    $body = Request::json();
    $db   = Database::getInstance();
    $db->beginTransaction();

    try {
        // 1. Insert prescription
        $stmt = $db->prepare("INSERT INTO prescriptions (patient_id, doctor_id, hospital_id, diagnosis, notes, start_date, end_date) VALUES (?,?,?,?,?,?,?)");
        $stmt->execute([$body['patient_id'], $this->auth['uid'], $this->auth['hid'], $body['diagnosis'], $body['notes'], $body['start_date'], $body['end_date'] ?? null]);
        $prescriptionId = $db->lastInsertId();

        // 2. Insert each medication + generate schedules
        foreach ($body['medications'] as $med) {
            $stmt = $db->prepare("INSERT INTO prescription_medications (prescription_id, medication_id, dosage, frequency, times_of_day, with_food, with_water, special_instructions, duration_days) VALUES (?,?,?,?,?,?,?,?,?)");
            $stmt->execute([$prescriptionId, $med['medication_id'], $med['dosage'], $med['frequency'], json_encode($med['times_of_day']), $med['with_food'] ? 1 : 0, $med['with_water'] ? 1 : 0, $med['special_instructions'] ?? null, $med['duration_days'] ?? null]);
            $pmId = $db->lastInsertId();

            // Generate medication_schedules
            $startDate  = new DateTime($body['start_date']);
            $durationDays = $med['duration_days'] ?? (isset($body['end_date']) ? (new DateTime($body['start_date']))->diff(new DateTime($body['end_date']))->days + 1 : 30);

            $scheduleInserts = [];
            for ($day = 0; $day < $durationDays; $day++) {
                $date = clone $startDate;
                $date->modify("+{$day} days");
                foreach ($med['times_of_day'] as $time) {
                    [$hour, $minute] = explode(':', $time);
                    $scheduleInserts[] = [$pmId, $body['patient_id'], $date->format('Y-m-d') . " {$hour}:{$minute}:00"];
                }
            }
            // Batch insert schedules
            $placeholders = implode(',', array_fill(0, count($scheduleInserts), '(?,?,?)'));
            $flatValues    = array_merge(...$scheduleInserts);
            $db->prepare("INSERT INTO medication_schedules (prescription_medication_id, patient_id, scheduled_time) VALUES {$placeholders}")->execute($flatValues);
        }

        // 3. Insert lifestyle advice
        foreach ($body['lifestyle_advice'] ?? [] as $advice) {
            $db->prepare("INSERT INTO lifestyle_advice (prescription_id, advice_type, title, description, frequency, duration_minutes) VALUES (?,?,?,?,?,?)")
               ->execute([$prescriptionId, $advice['type'], $advice['title'], $advice['description'], $advice['frequency'] ?? null, $advice['duration_minutes'] ?? null]);
        }

        // 4. Send in-app notification to patient
        insertNotification($db, [
            'recipient_id'   => $body['patient_id'],
            'sender_id'      => $this->auth['uid'],
            'title'          => '📋 New Prescription',
            'body'           => "Dr. {$this->auth['name']} has issued a new prescription for you. Open the app to view your medications and schedule.",
            'type'           => 'prescription',
            'reference_id'   => $prescriptionId,
            'reference_table'=> 'prescriptions',
        ]);

        $db->commit();
        Response::json(['prescription_id' => $prescriptionId], 201);
    } catch (Exception $e) {
        $db->rollBack();
        Response::error('Failed to create prescription: ' . $e->getMessage(), 500);
    }
}
```

### 7.3 Image Upload Helper (`core/Upload.php`)
```php
<?php
function uploadImage(array $file, string $subfolder): string {
    if ($file['error'] !== UPLOAD_ERR_OK) throw new Exception('Upload failed');
    if ($file['size'] > MAX_UPLOAD_BYTES) throw new Exception('File too large');

    $finfo    = new finfo(FILEINFO_MIME_TYPE);
    $mime     = $finfo->file($file['tmp_name']);
    $allowed  = ['image/jpeg' => 'jpg', 'image/png' => 'png', 'image/webp' => 'webp'];
    if (!isset($allowed[$mime])) throw new Exception('Invalid file type');

    $ext      = $allowed[$mime];
    $filename = uniqid('img_', true) . '.' . $ext;
    $dir      = UPLOAD_PATH . '/' . $subfolder;
    if (!is_dir($dir)) mkdir($dir, 0755, true);
    if (!move_uploaded_file($file['tmp_name'], "{$dir}/{$filename}"))
        throw new Exception('Could not save file');

    return UPLOAD_URL . '/' . $subfolder . '/' . $filename;
}
```

---

## 8. PHP Cron Jobs

Set up in Linux crontab (`crontab -e`):
```cron
# Send medication reminders — every 5 minutes
*/5 * * * * /usr/bin/php /var/www/meditrack-api/cron/send_medication_reminders.php >> /var/log/meditrack/reminders.log 2>&1

# Send appointment reminders — every hour
0 * * * * /usr/bin/php /var/www/meditrack-api/cron/send_appointment_reminders.php >> /var/log/meditrack/appointments.log 2>&1

# Mark overdue medications as missed — every 15 minutes
*/15 * * * * /usr/bin/php /var/www/meditrack-api/cron/mark_missed_medications.php >> /var/log/meditrack/missed.log 2>&1

# Compute daily adherence — every night at midnight
0 0 * * * /usr/bin/php /var/www/meditrack-api/cron/compute_adherence.php >> /var/log/meditrack/adherence.log 2>&1
```

### 8.1 `cron/send_medication_reminders.php`
```php
<?php
require_once __DIR__ . '/../config/config.php';
require_once __DIR__ . '/../core/Database.php';

$db  = Database::getInstance();
$now = new DateTime();
$in24h = (clone $now)->modify('+24 hours');

// Fetch pending schedules within next 24h without notifications sent
$stmt = $db->prepare("
    SELECT
        ms.id, ms.scheduled_time, ms.patient_id,
        u.onesignal_player_id, u.full_name,
        pm.dosage, pm.with_food, pm.with_water, pm.special_instructions,
        m.name AS med_name, m.description AS med_desc
    FROM medication_schedules ms
    JOIN users u ON u.id = ms.patient_id
    JOIN prescription_medications pm ON pm.id = ms.prescription_medication_id
    JOIN medications m ON m.id = pm.medication_id
    WHERE ms.status = 'pending'
      AND ms.onesignal_notification_id IS NULL
      AND ms.scheduled_time BETWEEN ? AND ?
      AND u.onesignal_player_id IS NOT NULL
");
$stmt->execute([$now->format('Y-m-d H:i:s'), $in24h->format('Y-m-d H:i:s')]);
$schedules = $stmt->fetchAll();

foreach ($schedules as $s) {
    $scheduledTime = new DateTime($s['scheduled_time']);
    $advanceTime   = (clone $scheduledTime)->modify('-2 hours');
    $instructions  = buildInstructions($s);

    // Advance reminder (2 hours before)
    if ($advanceTime > $now) {
        $advId = sendOneSignalNotification(
            $s['onesignal_player_id'],
            "⏰ Upcoming: {$s['med_name']}",
            "You will need to take {$s['med_name']} ({$s['dosage']}) in 2 hours. {$instructions}",
            ['type' => 'advance_reminder', 'schedule_id' => (string)$s['id']],
            $advanceTime->format(DateTime::ATOM)
        );
        $db->prepare("UPDATE medication_schedules SET advance_notification_id = ?, advance_reminder_sent_at = NOW() WHERE id = ?")
           ->execute([$advId, $s['id']]);
    }

    // Due reminder (at scheduled time)
    $dueId = sendOneSignalNotification(
        $s['onesignal_player_id'],
        "💊 Time to take {$s['med_name']}",
        "Take {$s['dosage']} of {$s['med_name']} now. {$instructions}",
        ['type' => 'medication_reminder', 'schedule_id' => (string)$s['id']],
        $scheduledTime->format(DateTime::ATOM)
    );
    $db->prepare("UPDATE medication_schedules SET onesignal_notification_id = ?, reminder_sent_at = NOW() WHERE id = ?")
       ->execute([$dueId, $s['id']]);
}

function buildInstructions(array $s): string {
    $parts = [];
    if ($s['with_food'])  $parts[] = 'Take with food';
    if ($s['with_water']) $parts[] = 'Drink plenty of water';
    if ($s['special_instructions']) $parts[] = $s['special_instructions'];
    return implode('. ', $parts);
}

function sendOneSignalNotification(string $playerId, string $title, string $body, array $data = [], ?string $sendAfter = null): ?string {
    $payload = [
        'app_id'             => ONESIGNAL_APP_ID,
        'include_player_ids' => [$playerId],
        'headings'           => ['en' => $title],
        'contents'           => ['en' => $body],
        'data'               => $data,
    ];
    if ($sendAfter) $payload['send_after'] = $sendAfter;

    $ch = curl_init('https://onesignal.com/api/v1/notifications');
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST           => true,
        CURLOPT_HTTPHEADER     => ['Content-Type: application/json', 'Authorization: Basic ' . ONESIGNAL_KEY],
        CURLOPT_POSTFIELDS     => json_encode($payload),
    ]);
    $result = json_decode(curl_exec($ch), true);
    curl_close($ch);
    return $result['id'] ?? null;
}
```

### 8.2 `cron/mark_missed_medications.php`
```php
<?php
require_once __DIR__ . '/../config/config.php';
require_once __DIR__ . '/../core/Database.php';

$db = Database::getInstance();
// Mark as missed: status=pending AND scheduled_time < now - 1 hour
$db->prepare("
    UPDATE medication_schedules
    SET status = 'missed'
    WHERE status = 'pending'
      AND scheduled_time < DATE_SUB(NOW(), INTERVAL 1 HOUR)
")->execute();

echo "[" . date('Y-m-d H:i:s') . "] Missed medications updated.\n";
```

### 8.3 `cron/compute_adherence.php`
```php
<?php
require_once __DIR__ . '/../config/config.php';
require_once __DIR__ . '/../core/Database.php';

$db        = Database::getInstance();
$yesterday = date('Y-m-d', strtotime('-1 day'));

$stmt = $db->query("SELECT DISTINCT patient_id FROM medication_schedules WHERE DATE(scheduled_time) = '{$yesterday}'");
$patients = $stmt->fetchAll(PDO::FETCH_COLUMN);

foreach ($patients as $patientId) {
    $counts = $db->prepare("
        SELECT
            COUNT(*) AS total,
            SUM(status = 'taken')   AS taken,
            SUM(status = 'missed')  AS missed,
            SUM(status = 'skipped') AS skipped
        FROM medication_schedules
        WHERE patient_id = ? AND DATE(scheduled_time) = ?
    ")->execute([$patientId, $yesterday])->fetch();

    $pct = $counts['total'] > 0 ? round(($counts['taken'] / $counts['total']) * 100, 2) : 0;

    $db->prepare("
        INSERT INTO adherence_logs (patient_id, log_date, total_scheduled, total_taken, total_missed, total_skipped, adherence_percentage)
        VALUES (?,?,?,?,?,?,?)
        ON DUPLICATE KEY UPDATE total_scheduled=VALUES(total_scheduled), total_taken=VALUES(total_taken),
            total_missed=VALUES(total_missed), total_skipped=VALUES(total_skipped), adherence_percentage=VALUES(adherence_percentage)
    ")->execute([$patientId, $yesterday, $counts['total'], $counts['taken'], $counts['missed'], $counts['skipped'], $pct]);
}

echo "[" . date('Y-m-d H:i:s') . "] Adherence computed for " . count($patients) . " patients.\n";
```

---

## 9. Flutter Frontend — Project Structure

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_strings.dart
│   ├── errors/
│   │   └── app_exception.dart
│   ├── extensions/
│   │   ├── context_extensions.dart
│   │   └── date_extensions.dart
│   └── services/
│       ├── api_service.dart          # Dio HTTP client (replaces Supabase)
│       ├── auth_service.dart         # JWT token store/refresh
│       ├── onesignal_service.dart
│       └── storage_service.dart      # flutter_secure_storage wrapper
├── features/
│   ├── auth/
│   ├── super_admin/
│   ├── hospital_admin/
│   ├── doctor/
│   ├── patient/
│   ├── notifications/
│   └── shared/widgets/
└── router/
    └── app_router.dart
```

### 9.1 `core/services/api_service.dart`
```dart
class ApiService {
  static const baseUrl = 'https://api.yourdomain.com/api/v1';
  late final Dio _dio;

  ApiService(this._storage) {
    _dio = Dio(BaseOptions(baseUrl: baseUrl, connectTimeout: const Duration(seconds: 10)));

    // Attach JWT on every request
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'access_token');
        if (token != null) options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
      onError: (error, handler) async {
        // 401 → try refresh token
        if (error.response?.statusCode == 401) {
          final refreshed = await _refreshToken();
          if (refreshed) {
            // Retry original request
            final token = await _storage.read(key: 'access_token');
            error.requestOptions.headers['Authorization'] = 'Bearer $token';
            final response = await _dio.fetch(error.requestOptions);
            return handler.resolve(response);
          }
        }
        return handler.next(error);
      },
    ));
  }

  Future<bool> _refreshToken() async {
    try {
      final refresh = await _storage.read(key: 'refresh_token');
      if (refresh == null) return false;
      final res = await Dio().post('$baseUrl/auth/refresh', data: {'refresh_token': refresh});
      await _storage.write(key: 'access_token',  value: res.data['data']['access_token']);
      await _storage.write(key: 'refresh_token', value: res.data['data']['refresh_token']);
      return true;
    } catch (_) { return false; }
  }

  Future<Map<String, dynamic>> get(String path, {Map<String, dynamic>? params}) async {
    final res = await _dio.get(path, queryParameters: params);
    return res.data;
  }
  Future<Map<String, dynamic>> post(String path, {dynamic data}) async {
    final res = await _dio.post(path, data: data);
    return res.data;
  }
  Future<Map<String, dynamic>> put(String path, {dynamic data}) async {
    final res = await _dio.put(path, data: data);
    return res.data;
  }
  // uploadFile uses FormData + multipart
  Future<Map<String, dynamic>> uploadFile(String path, File file, String field) async {
    final form = FormData.fromMap({field: await MultipartFile.fromFile(file.path)});
    final res  = await _dio.post(path, data: form);
    return res.data;
  }

  final FlutterSecureStorage _storage;
}
```

### 9.2 Auth Service (`auth_service.dart`)
```dart
class AuthService {
  final ApiService _api;
  final FlutterSecureStorage _storage;

  Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await _api.post('/auth/login', data: {'email': email, 'password': password});
    await _storage.write(key: 'access_token',  value: res['data']['access_token']);
    await _storage.write(key: 'refresh_token', value: res['data']['refresh_token']);
    await _storage.write(key: 'user',          value: jsonEncode(res['data']['user']));
    return res['data']['user'];
  }

  Future<void> logout() async {
    try { await _api.post('/auth/logout'); } catch (_) {}
    await _storage.deleteAll();
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final raw = await _storage.read(key: 'user');
    return raw != null ? jsonDecode(raw) as Map<String, dynamic> : null;
  }

  Future<bool> isLoggedIn() async {
    return await _storage.containsKey(key: 'access_token');
  }
}
```

### 9.3 OneSignal Service (`onesignal_service.dart`)
```dart
class OneSignalService {
  final ApiService _api;

  Future<void> init() async {
    OneSignal.initialize('YOUR_ONESIGNAL_APP_ID');
    await OneSignal.Notifications.requestPermission(true);
    await _syncPlayerId();

    // Handle notification taps → navigate to correct screen
    OneSignal.Notifications.addClickListener((event) {
      final data = event.notification.additionalData;
      if (data == null) return;
      final type = data['type'];
      final id   = data['schedule_id'] ?? data['appointment_id'] ?? data['prescription_id'];
      // Use GoRouter to navigate based on type
      navigatorKey.currentContext?.go(resolveRoute(type, id));
    });
  }

  Future<void> _syncPlayerId() async {
    final playerId = OneSignal.User.pushSubscription.id;
    if (playerId != null) {
      await _api.put('/users/onesignal-id', data: {'onesignal_player_id': playerId});
    }
  }
}
```

---

## 10. Flutter App — Notification Polling

Since there is no Supabase Realtime, the Flutter app polls for unread notification count every 30 seconds to update the bell badge.

```dart
// In the Riverpod provider:
@riverpod
Stream<int> unreadNotificationCount(UnreadNotificationCountRef ref) async* {
  final api = ref.read(apiServiceProvider);
  while (true) {
    try {
      final res = await api.get('/notifications/unread-count');
      yield (res['data']['count'] as int?) ?? 0;
    } catch (_) { yield 0; }
    await Future.delayed(const Duration(seconds: 30));
  }
}
```

---

## 11. Flutter Screens (All features preserved)

### 11.1 Authentication
- **SplashScreen:** Check `FlutterSecureStorage` for access_token → call `/profile` to validate → redirect to role dashboard or `/login`
- **LoginScreen:** Email + password → POST `/auth/login` → store tokens → redirect
- **ForgotPasswordScreen:** Email field → placeholder (implement email sending separately on server)

### 11.2 Super Admin
- **Dashboard:** GET `/dashboard` → stats cards (hospitals, users, adherence rate)
- **HospitalsListScreen:** GET `/hospitals` → list cards
- **AddHospitalScreen:** POST `/hospitals` + logo upload via multipart
- **HospitalDetailScreen:** GET `/hospitals/{id}` → details, admin list, POST `/users` to create admin

### 11.3 Hospital Admin
- **AdminDashboard:** GET `/dashboard` (role-filtered response)
- **ManageDoctorsScreen:** GET `/users?role=doctor&hospital_id=X`
- **AddDoctorScreen:** POST `/users` with `{role: "doctor", hospital_id: X}`
- **ManagePatientsScreen:** GET `/users?role=patient&hospital_id=X`
- **AddPatientScreen:** POST `/users` with `{role: "patient", ...}`
- **AssignPatientScreen:** POST `/users/{patient_id}/assign` with `{doctor_id: X}`
- **HospitalReportsScreen:** GET `/adherence/summary` with hospital filter

### 11.4 Doctor
- **DoctorDashboard:** GET `/dashboard` → my patients count, today's appointments, adherence averages
- **MyPatientsScreen:** GET `/users?role=patient&doctor_id=me`
- **PatientDetailScreen:** GET `/users/{id}` + GET `/adherence?patient_id=X` + GET `/prescriptions?patient_id=X`
- **CreatePrescriptionScreen (4-step):**
  1. Prescription info (diagnosis, dates, notes)
  2. Add medications (select from GET `/medications`, set dosage, frequency, times, instructions)
  3. Add lifestyle advice (type, title, description, frequency, duration)
  4. Review → POST `/prescriptions` (single call that generates all schedules)
- **MedicationLibraryScreen:** GET `/medications` + inline add modal → POST `/medications`
- **ScheduleAppointmentScreen:** POST `/appointments`

### 11.5 Patient
- **PatientDashboard:**
  - Greeting + date
  - Today's schedule preview (GET `/schedules/today`)
  - Adherence ring (GET `/adherence/summary`)
  - Next appointment card (GET `/appointments?status=scheduled&limit=1`)
  - Lifestyle advice of the day (from GET `/my-prescriptions`, pick random advice)
  - Notification bell → unread count from polling provider

- **TodayScheduleScreen:**
  - Timeline of today's medications from GET `/schedules/today`
  - "Mark Taken" → POST `/schedules/{id}/take`
  - "Skip" → POST `/schedules/{id}/skip`
  - Overdue (past + still pending) shown in red "MISSED" (handled server-side by cron, or detected by comparing `scheduled_time` to `DateTime.now()`)

- **MedicationDetailScreen:** Full drug info, dosage, instructions, related lifestyle advice

- **MyPrescriptionsScreen:** GET `/my-prescriptions` → active first, then past

- **LifestyleAdviceScreen:** Parsed from prescription detail, grouped by type

- **AppointmentsScreen:** GET `/appointments` → upcoming + past tabs

- **AdherenceReportScreen:**
  - Weekly bar chart (GET `/adherence?from=X&to=Y`)
  - Monthly calendar heatmap
  - Stats: overall %, streak, taken vs scheduled

### 11.6 Notifications Screen
- GET `/notifications` → list newest first
- POST `/notifications/{id}/read` on tap
- POST `/notifications/read-all` button
- Navigate to relevant screen on tap using `data.reference_table + reference_id`

---

## 12. Notification Types & Push Payloads

| Type | Title | Body | OneSignal `data` |
|------|-------|------|-----------------|
| `advance_reminder` | ⏰ Upcoming: [MedName] | "Take [MedName] ([Dosage]) in 2 hours. [Instructions]" | `{type, schedule_id}` |
| `medication_reminder` | 💊 Time to take [MedName] | "Take [Dosage] of [MedName] now. [Instructions]" | `{type, schedule_id}` |
| `appointment` | 📅 Appointment Tomorrow | "Appointment with Dr. [Name] at [Time]" | `{type, appointment_id}` |
| `prescription` | 📋 New Prescription | "Dr. [Name] has issued a new prescription." | `{type, prescription_id}` |
| `advice` | 💡 Health Reminder | "[Title]: [Description]" | `{type, prescription_id}` |

---

## 13. UI Design System (Flutter — unchanged)

### Color Palette
```dart
class AppColors {
  static const primary       = Color(0xFF0B7EAE);
  static const primaryLight  = Color(0xFFE0F4FF);
  static const primaryDark   = Color(0xFF085C80);
  static const accent        = Color(0xFFF59E0B);
  static const accentLight   = Color(0xFFFEF3C7);
  static const success       = Color(0xFF10B981);
  static const error         = Color(0xFFEF4444);
  static const warning       = Color(0xFFF59E0B);
  static const info          = Color(0xFF3B82F6);
  static const background    = Color(0xFFF8FAFC);
  static const surface       = Color(0xFFFFFFFF);
  static const border        = Color(0xFFE2E8F0);
  static const textPrimary   = Color(0xFF0F172A);
  static const textSecondary = Color(0xFF64748B);
  static const textMuted     = Color(0xFF94A3B8);
  static const superAdminColor = Color(0xFF7C3AED);
  static const adminColor      = Color(0xFF0B7EAE);
  static const doctorColor     = Color(0xFF059669);
  static const patientColor    = Color(0xFFEA580C);
}
```

- **Font:** Plus Jakarta Sans (Google Fonts)
- **Cards:** borderRadius 16, elevation 0, border 1px AppColors.border
- **Buttons:** Primary filled teal | Secondary outlined | Danger filled red
- **Avatars:** Circular, initials fallback with role-color background
- **Status badges:** Pill shape, color-coded
- **Bottom Nav:** 4–5 items, icon + label, selected = teal

---

## 14. Riverpod Providers (API-based)

```dart
// All providers now use ApiService instead of Supabase client

@riverpod
Future<Map<String, dynamic>?> currentUser(CurrentUserRef ref) async {
  final auth = ref.read(authServiceProvider);
  return auth.getCurrentUser();
}

@riverpod
Future<List<Map<String, dynamic>>> hospitals(HospitalsRef ref) async {
  final api = ref.read(apiServiceProvider);
  final res = await api.get('/hospitals');
  return List<Map<String, dynamic>>.from(res['data']);
}

@riverpod
Future<List<Map<String, dynamic>>> myPatients(MyPatientsRef ref) async {
  final api = ref.read(apiServiceProvider);
  final res = await api.get('/users', params: {'role': 'patient', 'doctor_id': 'me'});
  return List<Map<String, dynamic>>.from(res['data']);
}

@riverpod
Future<List<Map<String, dynamic>>> todaySchedules(TodaySchedulesRef ref) async {
  final api = ref.read(apiServiceProvider);
  final res = await api.get('/schedules/today');
  return List<Map<String, dynamic>>.from(res['data']);
}

@riverpod
Stream<int> unreadNotificationCount(UnreadNotificationCountRef ref) async* {
  // 30-second polling — defined in section 10
}
```

---

## 15. Security

**PHP API:**
- JWT verified on every protected request via `Auth::fromRequest()`
- Role checked in `RoleMiddleware` for every endpoint
- All SQL: PDO prepared statements — no interpolation
- All inputs: `htmlspecialchars()` + `strip_tags()` via `sanitize()`
- Upload MIME verification, random filenames, PHP execution disabled in `/uploads/`
- Refresh tokens stored as SHA-256 hash, expire after 30 days
- Rate limit login: track failed attempts per IP in a `login_attempts` table (5 failures → 15 min lockout)
- CORS: restricted to app's domain in production (currently `*` for development)

**Flutter:**
- Access token stored in `flutter_secure_storage` (Keychain on iOS, Keystore on Android)
- Token auto-refreshed by Dio interceptor on 401
- Never log tokens
- Certificate pinning recommended for production

---

## 16. Business Logic Rules (unchanged)

1. **Hospital isolation:** Every API query filters by `hospital_id` from the JWT token payload. A doctor at Hospital A can never access data from Hospital B.

2. **Prescription → Schedule generation:** Done server-side in `PrescriptionController::store()`. Generates one schedule row per dose time per day across the prescription duration. Batch-inserted in a single SQL statement.

3. **Missed medication auto-mark:** PHP cron (`mark_missed_medications.php`) runs every 15 minutes, sets `status = 'missed'` for all pending schedules more than 1 hour past due.

4. **Notification content** always includes: medication name, dosage, with-food/water instructions, special instructions, any lifestyle tip.

5. **No direct messaging:** All doctor-patient communication is structured notifications only — no free-text chat.

6. **User creation:** Only admins/super admin can create users via POST `/users`. No public registration endpoint.

7. **Deactivation cascade:** Deactivating a hospital → POST `/hospitals/{id}/toggle` sets `users.is_active = 0` for all that hospital's users. Deactivating a doctor → their assignment rows set `is_active = 0` but patients remain.

---

## 17. Environment & Deployment

### Server Requirements
- PHP 8.2+ with extensions: `pdo_mysql`, `mbstring`, `json`, `curl`, `fileinfo`, `openssl`
- MySQL 8.0+
- Apache 2.4+ with `mod_rewrite` enabled (or Nginx)
- Composer installed
- Crontab access

### Setup Steps
1. Clone API to server, run `composer install`
2. Copy `.env.example` → `.env`, fill all values
3. Run `database/schema.sql` to create all tables
4. Run `database/seed.sql` to insert default roles and super admin
5. Configure `UPLOAD_PATH` to writable directory outside webroot or serve via PHP
6. Add cron jobs (Section 8)
7. Enable `mod_rewrite`, ensure `.htaccess` is active
8. Set `JWT_SECRET` to a cryptographically random 64+ character string

### Flutter Setup
1. Set `baseUrl` in `api_service.dart` to your API URL
2. Set `YOUR_ONESIGNAL_APP_ID` in `onesignal_service.dart`
3. Configure Firebase (for OneSignal Android) and APNS (iOS)
4. Run `flutter pub get` then `dart run build_runner build`

---

## 18. Implementation Phases

### Phase 1 — Backend Foundation (Week 1)
- [ ] Set up PHP project: Composer, folder structure, `.env`, `.htaccess`
- [ ] Create MySQL database, run all schema SQL in order
- [ ] Seed: roles, super admin user, test hospital
- [ ] `Database.php`, `Auth.php`, `Response.php`, `Request.php`, `Helpers.php`
- [ ] `index.php` router with full route map
- [ ] `AuthController` — login, refresh, logout, change-password
- [ ] `HospitalController` — CRUD for hospitals
- [ ] `UserController` — CRUD, assign patient, profile endpoints
- [ ] `Upload.php` — image upload handler
- [ ] Test all auth + hospital + user endpoints with Postman/Insomnia

### Phase 2 — Medications, Prescriptions & Schedules (Week 1–2)
- [ ] `MedicationController` — list, create, update medication library
- [ ] `PrescriptionController` — create (with schedule generation), list, show
- [ ] `ScheduleController` — today's schedule, date range, mark taken/skip
- [ ] `AppointmentController` — CRUD for appointments
- [ ] `AdherenceController` — logs and summary stats
- [ ] Test prescription → schedule generation end-to-end
- [ ] Test schedule mark-taken flow

### Phase 3 — Notifications & Cron (Week 2)
- [ ] `NotificationController` — list, mark read, unread count, update player ID
- [ ] `insertNotification()` helper function (shared by all controllers)
- [ ] `cron/send_medication_reminders.php` — full OneSignal integration
- [ ] `cron/send_appointment_reminders.php`
- [ ] `cron/mark_missed_medications.php`
- [ ] `cron/compute_adherence.php`
- [ ] Set up crontab on server
- [ ] Test: create prescription → schedules generated → cron sends OneSignal push → patient receives notification

### Phase 4 — Flutter Foundation (Week 2–3)
- [ ] Initialize Flutter project, add all packages, run `build_runner`
- [ ] `ApiService` with Dio + JWT interceptor + auto-refresh
- [ ] `AuthService` with secure storage
- [ ] `OneSignalService` init + player ID sync
- [ ] `AppRouter` (GoRouter) — all routes, role-based redirect
- [ ] `SplashScreen` — token check → role redirect
- [ ] `LoginScreen` — calls POST `/auth/login`
- [ ] `AppColors`, `AppTextStyles`, `AppStrings`
- [ ] Shared widgets: app bar, loading shimmer, empty state, error widget, status badges

### Phase 5 — Super Admin Flutter (Week 3)
- [ ] `SuperAdminDashboard` — GET `/dashboard`
- [ ] `HospitalsListScreen` — GET `/hospitals`
- [ ] `AddHospitalScreen` — POST `/hospitals` + logo multipart upload
- [ ] `HospitalDetailScreen` — details + admin list + create admin form

### Phase 6 — Hospital Admin Flutter (Week 3)
- [ ] `AdminDashboard`
- [ ] `ManageDoctorsScreen` + `AddDoctorScreen`
- [ ] `ManagePatientsScreen` + `AddPatientScreen`
- [ ] `AssignPatientScreen` — POST `/users/{id}/assign`
- [ ] `HospitalReportsScreen` — adherence chart

### Phase 7 — Doctor Flutter (Week 3–4)
- [ ] `DoctorDashboard`
- [ ] `MyPatientsScreen` + `PatientDetailScreen` with adherence chart
- [ ] `CreatePrescriptionScreen` (4-step stepper)
- [ ] Medication library picker + inline add
- [ ] Lifestyle advice form
- [ ] `ScheduleAppointmentScreen`

### Phase 8 — Patient Flutter (Week 4)
- [ ] `PatientDashboard` — full with adherence ring, next appointment, advice of the day
- [ ] `TodayScheduleScreen` — timeline, mark taken, skip, overdue detection
- [ ] `MedicationDetailScreen` — full drug info + instructions
- [ ] `MyPrescriptionsScreen` + prescription detail
- [ ] `LifestyleAdviceScreen` — grouped by type
- [ ] `AppointmentsScreen` — upcoming + past
- [ ] `AdherenceReportScreen` — bar chart + heatmap calendar

### Phase 9 — Notifications & Polish (Week 4–5)
- [ ] `NotificationsScreen` — list, read/unread, mark read, tap-navigate
- [ ] Unread count badge (30-second polling stream)
- [ ] OneSignal tap handler → navigate to correct screen
- [ ] Profile screen (edit name, phone, upload avatar)
- [ ] Logout (clear secure storage, call `/auth/logout`)
- [ ] Shimmer loading on all lists
- [ ] Pull-to-refresh on all data screens
- [ ] Offline detection banner
- [ ] Form validation on all forms
- [ ] End-to-end test: add hospital → add admin → add doctor → add patient → assign → doctor prescribes → cron sends push → patient marks taken → adherence logged

---

## 19. Deliverables Checklist

- [ ] Complete PHP API (`meditrack-api/`) with all controllers
- [ ] MySQL schema SQL file (`database/schema.sql`)
- [ ] MySQL seed SQL file (`database/seed.sql`)
- [ ] All 4 cron scripts functional and tested
- [ ] Complete Flutter app (`meditrack-app/`) — all screens functional
- [ ] All 4 roles working end-to-end
- [ ] Push notifications received on device (advance + due reminders)
- [ ] Adherence charts rendering real data from API
- [ ] Image uploads working (avatars, hospital logos, drug images)
- [ ] JWT refresh flow working (access token auto-renewed)
- [ ] README.md: API setup, Flutter setup, cron setup, test credentials

---

---

## 20. Missing Controller Implementations

### 20.1 `core/Request.php`
```php
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
        $header = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
        if (preg_match('/Bearer\s+(.+)/i', $header, $m)) return $m[1];
        return null;
    }

    public static function ip(): string {
        return $_SERVER['HTTP_X_FORWARDED_FOR']
            ?? $_SERVER['REMOTE_ADDR']
            ?? '0.0.0.0';
    }
}
```

### 20.2 `core/Helpers.php`
```php
<?php
function sanitize(string $input): string {
    return htmlspecialchars(strip_tags(trim($input)), ENT_QUOTES, 'UTF-8');
}

function generateCode(PDO $db, string $table, string $column, string $prefix, int $padding = 4): string {
    $stmt = $db->prepare("SELECT $column FROM $table ORDER BY id DESC LIMIT 1");
    $stmt->execute();
    $last = $stmt->fetchColumn();
    $num  = $last ? (int)substr($last, strlen($prefix) + 1) + 1 : 1;
    return $prefix . '-' . str_pad($num, $padding, '0', STR_PAD_LEFT);
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
        if (!isset($data[$f]) || trim((string)$data[$f]) === '') $missing[] = $f;
    }
    return $missing;
}

function hashPassword(string $plain): string {
    return password_hash($plain, PASSWORD_BCRYPT, ['cost' => 12]);
}

function randomPassword(int $length = 10): string {
    return substr(str_shuffle('ABCDEFGHJKMNPQRSTUVWXYZabcdefghjkmnpqrstuvwxyz23456789@#$'), 0, $length);
}
```

---

### 20.3 `controllers/UserController.php` — Full Implementation
```php
<?php
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Response.php';
require_once __DIR__ . '/../core/Request.php';
require_once __DIR__ . '/../core/Helpers.php';
require_once __DIR__ . '/../core/Upload.php';

class UserController {
    public function __construct(private ?array $auth) {}

    // GET /users?role=doctor&hospital_id=X&page=1
    public function index(): void {
        $db         = Database::getInstance();
        $role       = sanitize(Request::get('role', ''));
        $hospitalId = (int)Request::get('hospital_id', $this->auth['hid'] ?? 0);
        $doctorId   = Request::get('doctor_id');  // 'me' or int
        $page       = max(1, (int)Request::get('page', 1));
        $perPage    = 20;
        $offset     = paginationOffset($page, $perPage);

        $conditions = ['u.is_active = 1'];
        $params     = [];

        // Hospital isolation: non-super_admin can only see their own hospital
        if ($this->auth['role'] !== 'super_admin') {
            $conditions[] = 'u.hospital_id = ?';
            $params[]     = $this->auth['hid'];
        } elseif ($hospitalId) {
            $conditions[] = 'u.hospital_id = ?';
            $params[]     = $hospitalId;
        }

        if ($role) { $conditions[] = 'r.name = ?'; $params[] = $role; }

        // Doctor's own patients via assignments
        if ($doctorId === 'me' || ($doctorId && $this->auth['role'] === 'doctor')) {
            $conditions[] = 'EXISTS (SELECT 1 FROM doctor_patient_assignments dpa WHERE dpa.patient_id = u.id AND dpa.doctor_id = ? AND dpa.is_active = 1)';
            $params[]     = $this->auth['uid'];
        }

        $where = 'WHERE ' . implode(' AND ', $conditions);

        $total = $db->prepare("SELECT COUNT(*) FROM users u JOIN roles r ON r.id = u.role_id $where");
        $total->execute($params);
        $count = (int)$total->fetchColumn();

        $stmt = $db->prepare("
            SELECT u.id, u.full_name, u.email, u.phone, u.avatar_url, u.is_active,
                   u.date_of_birth, u.diagnosis, u.emergency_contact, u.created_at,
                   r.name AS role_name, h.name AS hospital_name
            FROM users u
            JOIN roles r ON r.id = u.role_id
            LEFT JOIN hospitals h ON h.id = u.hospital_id
            $where ORDER BY u.full_name ASC LIMIT ? OFFSET ?
        ");
        $params[] = $perPage;
        $params[] = $offset;
        $stmt->execute($params);

        Response::paginated($stmt->fetchAll(), $count, $page, $perPage);
    }

    // POST /users — create doctor / patient / hospital_admin
    public function store(): void {
        $db   = Database::getInstance();
        $body = Request::json();

        $missing = validateRequired($body, ['full_name', 'email', 'role']);
        if ($missing) Response::error('Missing fields: ' . implode(', ', $missing), 422);

        // Prevent privilege escalation
        $allowedRoles = match($this->auth['role']) {
            'super_admin'    => ['hospital_admin', 'doctor', 'patient'],
            'hospital_admin' => ['doctor', 'patient'],
            default          => [],
        };
        if (!in_array($body['role'], $allowedRoles))
            Response::error('You cannot create a user with that role', 403);

        // Determine hospital
        $hospitalId = ($this->auth['role'] === 'super_admin')
            ? ($body['hospital_id'] ?? null)
            : $this->auth['hid'];

        // Check email unique
        $exists = $db->prepare("SELECT id FROM users WHERE email = ?");
        $exists->execute([sanitize($body['email'])]);
        if ($exists->fetch()) Response::error('Email already registered', 409);

        // Role ID lookup
        $roleRow = $db->prepare("SELECT id FROM roles WHERE name = ?");
        $roleRow->execute([$body['role']]);
        $roleId  = $roleRow->fetchColumn();
        if (!$roleId) Response::error('Invalid role', 422);

        $password = $body['password'] ?? randomPassword();

        $db->prepare("
            INSERT INTO users (role_id, hospital_id, full_name, email, password, phone,
                               date_of_birth, gender, emergency_contact, diagnosis)
            VALUES (?,?,?,?,?,?,?,?,?,?)
        ")->execute([
            $roleId, $hospitalId,
            sanitize($body['full_name']),
            sanitize($body['email']),
            hashPassword($password),
            sanitize($body['phone'] ?? ''),
            $body['date_of_birth'] ?? null,
            $body['gender'] ?? null,
            sanitize($body['emergency_contact'] ?? ''),
            sanitize($body['diagnosis'] ?? ''),
        ]);
        $userId = $db->lastInsertId();

        // Return the new user + temporary password so admin can share credentials
        Response::json([
            'id'                => $userId,
            'full_name'         => $body['full_name'],
            'email'             => $body['email'],
            'role'              => $body['role'],
            'temporary_password'=> $password,
        ], 201);
    }

    // GET /users/{id}
    public function show(string $id): void {
        $db   = Database::getInstance();
        $stmt = $db->prepare("
            SELECT u.id, u.full_name, u.email, u.phone, u.avatar_url, u.date_of_birth,
                   u.gender, u.emergency_contact, u.diagnosis, u.is_active, u.last_login, u.created_at,
                   r.name AS role_name, h.name AS hospital_name, h.id AS hospital_id
            FROM users u
            JOIN roles r ON r.id = u.role_id
            LEFT JOIN hospitals h ON h.id = u.hospital_id
            WHERE u.id = ?
        ");
        $stmt->execute([(int)$id]);
        $user = $stmt->fetch();
        if (!$user) Response::error('User not found', 404);

        // Hospital isolation
        if ($this->auth['role'] !== 'super_admin' && $user['hospital_id'] != $this->auth['hid'])
            Response::error('Forbidden', 403);

        // If doctor viewing a patient, check assignment
        if ($this->auth['role'] === 'doctor') {
            $check = $db->prepare("SELECT 1 FROM doctor_patient_assignments WHERE doctor_id = ? AND patient_id = ? AND is_active = 1");
            $check->execute([$this->auth['uid'], $id]);
            if (!$check->fetch()) Response::error('Forbidden', 403);
        }

        Response::json($user);
    }

    // PUT /users/{id}
    public function update(string $id): void {
        $db   = Database::getInstance();
        $body = Request::json();

        $db->prepare("
            UPDATE users SET
                full_name = ?, phone = ?, date_of_birth = ?,
                gender = ?, emergency_contact = ?, diagnosis = ?
            WHERE id = ?
        ")->execute([
            sanitize($body['full_name'] ?? ''),
            sanitize($body['phone'] ?? ''),
            $body['date_of_birth'] ?? null,
            $body['gender'] ?? null,
            sanitize($body['emergency_contact'] ?? ''),
            sanitize($body['diagnosis'] ?? ''),
            (int)$id,
        ]);
        Response::json(['updated' => true]);
    }

    // POST /users/{id}/toggle
    public function toggle(string $id): void {
        $db = Database::getInstance();
        $db->prepare("UPDATE users SET is_active = NOT is_active WHERE id = ?")->execute([(int)$id]);

        // If deactivating a hospital_admin, also cascade to their hospital's users optionally
        Response::json(['toggled' => true]);
    }

    // POST /users/{id}/assign — assign patient to doctor
    public function assignPatient(string $patientId): void {
        $db   = Database::getInstance();
        $body = Request::json();

        $missing = validateRequired($body, ['doctor_id']);
        if ($missing) Response::error('doctor_id is required', 422);

        // Deactivate any existing assignment for this patient
        $db->prepare("UPDATE doctor_patient_assignments SET is_active = 0 WHERE patient_id = ? AND hospital_id = ?")
           ->execute([(int)$patientId, $this->auth['hid']]);

        // Create new assignment
        $db->prepare("
            INSERT INTO doctor_patient_assignments (doctor_id, patient_id, hospital_id)
            VALUES (?,?,?)
            ON DUPLICATE KEY UPDATE is_active = 1, assigned_at = NOW()
        ")->execute([(int)$body['doctor_id'], (int)$patientId, $this->auth['hid']]);

        Response::json(['assigned' => true]);
    }

    // GET /profile
    public function profile(): void {
        $db   = Database::getInstance();
        $stmt = $db->prepare("
            SELECT u.id, u.full_name, u.email, u.phone, u.avatar_url,
                   u.date_of_birth, u.gender, u.emergency_contact, u.diagnosis,
                   r.name AS role_name, h.name AS hospital_name, h.id AS hospital_id,
                   h.logo_url AS hospital_logo
            FROM users u
            JOIN roles r ON r.id = u.role_id
            LEFT JOIN hospitals h ON h.id = u.hospital_id
            WHERE u.id = ?
        ");
        $stmt->execute([$this->auth['uid']]);
        $user = $stmt->fetch();
        if (!$user) Response::error('Profile not found', 404);
        Response::json($user);
    }

    // PUT /profile
    public function updateProfile(): void {
        $db   = Database::getInstance();
        $body = Request::json();
        $db->prepare("
            UPDATE users SET full_name = ?, phone = ?, gender = ?, emergency_contact = ?
            WHERE id = ?
        ")->execute([
            sanitize($body['full_name'] ?? ''),
            sanitize($body['phone'] ?? ''),
            $body['gender'] ?? null,
            sanitize($body['emergency_contact'] ?? ''),
            $this->auth['uid'],
        ]);
        Response::json(['updated' => true]);
    }

    // POST /profile/avatar
    public function uploadAvatar(): void {
        if (empty($_FILES['avatar'])) Response::error('No file uploaded', 422);
        try {
            $url = uploadImage($_FILES['avatar'], 'avatars');
            $db  = Database::getInstance();
            $db->prepare("UPDATE users SET avatar_url = ? WHERE id = ?")->execute([$url, $this->auth['uid']]);
            Response::json(['avatar_url' => $url]);
        } catch (Exception $e) {
            Response::error($e->getMessage(), 422);
        }
    }

    // GET /dashboard  — role-specific stats
    public function dashboard(): void {
        $db   = Database::getInstance();
        $role = $this->auth['role'];
        $uid  = $this->auth['uid'];
        $hid  = $this->auth['hid'];

        Response::json($this->getDashboardData($db, $role, $uid, $hid));
    }

    private function countUsers(PDO $db, string $role, int $hospitalId): int {
        $stmt = $db->prepare("SELECT COUNT(*) FROM users u JOIN roles r ON r.id=u.role_id WHERE r.name=? AND u.hospital_id=? AND u.is_active=1");
        $stmt->execute([$role, $hospitalId]);
        return (int)$stmt->fetchColumn();
    }

    private function hospitalAdherence(PDO $db, int $hospitalId): float {
        $stmt = $db->prepare("SELECT ROUND(AVG(al.adherence_percentage),1) FROM adherence_logs al JOIN users u ON u.id=al.patient_id WHERE u.hospital_id=? AND al.log_date >= DATE_SUB(CURDATE(),INTERVAL 30 DAY)");
        $stmt->execute([$hospitalId]);
        return (float)($stmt->fetchColumn() ?? 0);
    }

    private function patientTodayStats(PDO $db, int $patientId, string $type): int {
        if ($type === 'total') {
            $stmt = $db->prepare("SELECT COUNT(*) FROM medication_schedules WHERE patient_id=? AND DATE(scheduled_time)=CURDATE()");
        } elseif ($type === 'taken') {
            $stmt = $db->prepare("SELECT COUNT(*) FROM medication_schedules WHERE patient_id=? AND DATE(scheduled_time)=CURDATE() AND status='taken'");
        } else {
            $stmt = $db->prepare("SELECT COUNT(*) FROM medication_schedules WHERE patient_id=? AND DATE(scheduled_time)=CURDATE() AND status='pending'");
        }
        $stmt->execute([$patientId]);
        return (int)$stmt->fetchColumn();
    }

    private function patientWeekAdherence(PDO $db, int $patientId): float {
        $stmt = $db->prepare("SELECT ROUND(AVG(adherence_percentage),1) FROM adherence_logs WHERE patient_id=? AND log_date >= DATE_SUB(CURDATE(),INTERVAL 7 DAY)");
        $stmt->execute([$patientId]);
        return (float)($stmt->fetchColumn() ?? 0);
    }

    private function getDashboardData(PDO $db, string $role, int $uid, ?int $hid): array {
        if ($role === 'super_admin') {
            $s1 = $db->query("SELECT COUNT(*) FROM hospitals WHERE is_active=1"); $hospitals = (int)$s1->fetchColumn();
            $s2 = $db->query("SELECT COUNT(*) FROM users WHERE is_active=1");     $users = (int)$s2->fetchColumn();
            $s3 = $db->query("SELECT COUNT(*) FROM prescriptions WHERE is_active=1"); $prescriptions = (int)$s3->fetchColumn();
            $s4 = $db->query("SELECT ROUND(AVG(adherence_percentage),1) FROM adherence_logs WHERE log_date >= DATE_SUB(CURDATE(),INTERVAL 30 DAY)"); $adherence = (float)($s4->fetchColumn() ?? 0);
            return compact('hospitals','users','prescriptions','adherence');
        }
        if ($role === 'hospital_admin') {
            return ['doctors' => $this->countUsers($db,'doctor',$hid), 'patients' => $this->countUsers($db,'patient',$hid), 'avg_adherence' => $this->hospitalAdherence($db,$hid)];
        }
        if ($role === 'doctor') {
            $s1 = $db->prepare("SELECT COUNT(*) FROM doctor_patient_assignments WHERE doctor_id=? AND is_active=1"); $s1->execute([$uid]); $patients = (int)$s1->fetchColumn();
            $s2 = $db->prepare("SELECT COUNT(*) FROM appointments WHERE doctor_id=? AND DATE(appointment_date)=CURDATE() AND status='scheduled'"); $s2->execute([$uid]); $todayAppts = (int)$s2->fetchColumn();
            $s3 = $db->prepare("SELECT COUNT(*) FROM prescriptions WHERE doctor_id=? AND is_active=1"); $s3->execute([$uid]); $prescriptions = (int)$s3->fetchColumn();
            return compact('patients','todayAppts','prescriptions');
        }
        // patient
        return ['today_total' => $this->patientTodayStats($db,$uid,'total'), 'today_taken' => $this->patientTodayStats($db,$uid,'taken'), 'today_pending' => $this->patientTodayStats($db,$uid,'pending'), 'week_adherence' => $this->patientWeekAdherence($db,$uid)];
    }
}
```

---

### 20.4 `controllers/ScheduleController.php` — Full Implementation
```php
<?php
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Response.php';
require_once __DIR__ . '/../core/Request.php';
require_once __DIR__ . '/../core/Helpers.php';

class ScheduleController {
    public function __construct(private ?array $auth) {}

    // GET /schedules/today
    public function today(): void {
        $db  = Database::getInstance();
        $uid = $this->auth['uid'];

        $stmt = $db->prepare("
            SELECT
                ms.id, ms.scheduled_time, ms.status, ms.confirmed_at, ms.notes,
                pm.dosage, pm.frequency, pm.with_food, pm.with_water, pm.special_instructions,
                m.id AS medication_id, m.name AS medication_name, m.generic_name,
                m.category, m.description AS medication_description, m.image_url,
                p.id AS prescription_id, p.diagnosis,
                u.full_name AS doctor_name,
                (SELECT GROUP_CONCAT(CONCAT(la.advice_type,':',la.title) SEPARATOR '|')
                 FROM lifestyle_advice la WHERE la.prescription_id = p.id) AS lifestyle_tips
            FROM medication_schedules ms
            JOIN prescription_medications pm ON pm.id = ms.prescription_medication_id
            JOIN medications m ON m.id = pm.medication_id
            JOIN prescriptions p ON p.id = pm.prescription_id
            JOIN users u ON u.id = p.doctor_id
            WHERE ms.patient_id = ?
              AND DATE(ms.scheduled_time) = CURDATE()
            ORDER BY ms.scheduled_time ASC
        ");
        $stmt->execute([$uid]);
        $schedules = $stmt->fetchAll();

        // Parse lifestyle_tips string into array
        foreach ($schedules as &$s) {
            $s['with_food']  = (bool)$s['with_food'];
            $s['with_water'] = (bool)$s['with_water'];
            $tips = [];
            if ($s['lifestyle_tips']) {
                foreach (explode('|', $s['lifestyle_tips']) as $tip) {
                    [$type, $title] = explode(':', $tip, 2);
                    $tips[] = ['type' => $type, 'title' => $title];
                }
            }
            $s['lifestyle_tips'] = $tips;
        }

        Response::json($schedules);
    }

    // GET /schedules?from=2024-01-01&to=2024-01-31&patient_id=X
    public function index(): void {
        $db        = Database::getInstance();
        $from      = Request::get('from', date('Y-m-d'));
        $to        = Request::get('to', date('Y-m-d'));
        $patientId = (int)Request::get('patient_id', $this->auth['uid']);

        // Doctors can only view assigned patients
        if ($this->auth['role'] === 'doctor') {
            $check = $db->prepare("SELECT 1 FROM doctor_patient_assignments WHERE doctor_id=? AND patient_id=? AND is_active=1");
            $check->execute([$this->auth['uid'], $patientId]);
            if (!$check->fetch()) Response::error('Forbidden', 403);
        } elseif ($this->auth['role'] === 'patient') {
            $patientId = $this->auth['uid']; // patients can only see their own
        }

        $stmt = $db->prepare("
            SELECT ms.id, ms.scheduled_time, ms.status, ms.confirmed_at,
                   pm.dosage, m.name AS medication_name, m.image_url,
                   p.diagnosis
            FROM medication_schedules ms
            JOIN prescription_medications pm ON pm.id = ms.prescription_medication_id
            JOIN medications m ON m.id = pm.medication_id
            JOIN prescriptions p ON p.id = pm.prescription_id
            WHERE ms.patient_id = ?
              AND DATE(ms.scheduled_time) BETWEEN ? AND ?
            ORDER BY ms.scheduled_time ASC
        ");
        $stmt->execute([$patientId, $from, $to]);
        Response::json($stmt->fetchAll());
    }

    // POST /schedules/{id}/take
    public function markTaken(string $id): void {
        $db   = Database::getInstance();
        $body = Request::json();

        // Verify ownership
        $stmt = $db->prepare("SELECT patient_id, status FROM medication_schedules WHERE id = ?");
        $stmt->execute([(int)$id]);
        $schedule = $stmt->fetch();

        if (!$schedule) Response::error('Schedule not found', 404);
        if ($schedule['patient_id'] != $this->auth['uid']) Response::error('Forbidden', 403);
        if ($schedule['status'] === 'taken') Response::error('Already marked as taken', 409);

        $db->prepare("UPDATE medication_schedules SET status='taken', confirmed_at=NOW(), notes=? WHERE id=?")
           ->execute([sanitize($body['notes'] ?? ''), (int)$id]);

        Response::json(['status' => 'taken', 'confirmed_at' => date('Y-m-d H:i:s')]);
    }

    // POST /schedules/{id}/skip
    public function markSkipped(string $id): void {
        $db   = Database::getInstance();
        $body = Request::json();

        $stmt = $db->prepare("SELECT patient_id, status FROM medication_schedules WHERE id = ?");
        $stmt->execute([(int)$id]);
        $schedule = $stmt->fetch();

        if (!$schedule) Response::error('Schedule not found', 404);
        if ($schedule['patient_id'] != $this->auth['uid']) Response::error('Forbidden', 403);
        if (in_array($schedule['status'], ['taken','missed'])) Response::error("Cannot skip a {$schedule['status']} dose", 409);

        $db->prepare("UPDATE medication_schedules SET status='skipped', confirmed_at=NOW(), notes=? WHERE id=?")
           ->execute([sanitize($body['notes'] ?? ''), (int)$id]);

        Response::json(['status' => 'skipped']);
    }
}
```

---

### 20.5 `controllers/AppointmentController.php`
```php
<?php
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Response.php';
require_once __DIR__ . '/../core/Request.php';
require_once __DIR__ . '/../core/Helpers.php';

class AppointmentController {
    public function __construct(private ?array $auth) {}

    // GET /appointments?status=scheduled&patient_id=X
    public function index(): void {
        $db     = Database::getInstance();
        $status = Request::get('status');
        $uid    = $this->auth['uid'];
        $role   = $this->auth['role'];

        $conditions = [];
        $params     = [];

        if ($role === 'patient') {
            $conditions[] = 'a.patient_id = ?'; $params[] = $uid;
        } elseif ($role === 'doctor') {
            $conditions[] = 'a.doctor_id = ?'; $params[] = $uid;
        } elseif ($role === 'hospital_admin') {
            $conditions[] = 'a.hospital_id = ?'; $params[] = $this->auth['hid'];
        }

        if ($status) { $conditions[] = 'a.status = ?'; $params[] = $status; }

        $where = $conditions ? 'WHERE ' . implode(' AND ', $conditions) : '';
        $stmt  = $db->prepare("
            SELECT a.id, a.appointment_date, a.purpose, a.notes, a.status,
                   p.full_name AS patient_name, p.phone AS patient_phone, p.avatar_url AS patient_avatar,
                   d.full_name AS doctor_name, d.phone AS doctor_phone,
                   h.name AS hospital_name
            FROM appointments a
            JOIN users p ON p.id = a.patient_id
            JOIN users d ON d.id = a.doctor_id
            JOIN hospitals h ON h.id = a.hospital_id
            $where ORDER BY a.appointment_date ASC
        ");
        $stmt->execute($params);
        Response::json($stmt->fetchAll());
    }

    // POST /appointments
    public function store(): void {
        $db   = Database::getInstance();
        $body = Request::json();

        $missing = validateRequired($body, ['patient_id', 'appointment_date', 'purpose']);
        if ($missing) Response::error('Missing: ' . implode(', ', $missing), 422);

        // Verify the patient is assigned to this doctor
        $check = $db->prepare("SELECT 1 FROM doctor_patient_assignments WHERE doctor_id=? AND patient_id=? AND is_active=1");
        $check->execute([$this->auth['uid'], (int)$body['patient_id']]);
        if (!$check->fetch()) Response::error('Patient not assigned to you', 403);

        $db->prepare("
            INSERT INTO appointments (patient_id, doctor_id, hospital_id, appointment_date, purpose, notes)
            VALUES (?,?,?,?,?,?)
        ")->execute([
            (int)$body['patient_id'],
            $this->auth['uid'],
            $this->auth['hid'],
            sanitize($body['appointment_date']),
            sanitize($body['purpose']),
            sanitize($body['notes'] ?? ''),
        ]);
        $apptId = $db->lastInsertId();

        // Notify patient
        insertNotification($db, [
            'recipient_id'   => (int)$body['patient_id'],
            'sender_id'      => $this->auth['uid'],
            'title'          => '📅 Appointment Scheduled',
            'body'           => "You have an appointment scheduled on " . date('M j, Y g:i A', strtotime($body['appointment_date'])) . ". Purpose: {$body['purpose']}",
            'type'           => 'appointment',
            'reference_id'   => $apptId,
            'reference_table'=> 'appointments',
        ]);

        Response::json(['appointment_id' => $apptId], 201);
    }

    // PUT /appointments/{id}
    public function update(string $id): void {
        $db   = Database::getInstance();
        $body = Request::json();

        // Verify doctor owns this appointment
        $stmt = $db->prepare("SELECT doctor_id FROM appointments WHERE id=?");
        $stmt->execute([(int)$id]);
        $appt = $stmt->fetch();
        if (!$appt) Response::error('Not found', 404);
        if ($appt['doctor_id'] != $this->auth['uid']) Response::error('Forbidden', 403);

        $db->prepare("
            UPDATE appointments SET
                appointment_date = ?, purpose = ?, notes = ?, status = ?
            WHERE id = ?
        ")->execute([
            sanitize($body['appointment_date'] ?? ''),
            sanitize($body['purpose'] ?? ''),
            sanitize($body['notes'] ?? ''),
            sanitize($body['status'] ?? 'scheduled'),
            (int)$id,
        ]);
        Response::json(['updated' => true]);
    }
}
```

---

### 20.6 `controllers/NotificationController.php`
```php
<?php
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Response.php';
require_once __DIR__ . '/../core/Request.php';
require_once __DIR__ . '/../core/Helpers.php';

class NotificationController {
    public function __construct(private ?array $auth) {}

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
```

---

### 20.7 `controllers/AdherenceController.php`
```php
<?php
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Response.php';
require_once __DIR__ . '/../core/Request.php';

class AdherenceController {
    public function __construct(private ?array $auth) {}

    // GET /adherence?patient_id=X&from=YYYY-MM-DD&to=YYYY-MM-DD
    public function index(): void {
        $db        = Database::getInstance();
        $patientId = (int)Request::get('patient_id', $this->auth['uid']);
        $from      = Request::get('from', date('Y-m-d', strtotime('-30 days')));
        $to        = Request::get('to', date('Y-m-d'));

        // Enforce hospital isolation
        if ($this->auth['role'] === 'patient') $patientId = $this->auth['uid'];
        if ($this->auth['role'] === 'doctor') {
            $check = $db->prepare("SELECT 1 FROM doctor_patient_assignments WHERE doctor_id=? AND patient_id=? AND is_active=1");
            $check->execute([$this->auth['uid'], $patientId]);
            if (!$check->fetch()) Response::error('Forbidden', 403);
        }

        $stmt = $db->prepare("
            SELECT log_date, total_scheduled, total_taken, total_missed, total_skipped, adherence_percentage
            FROM adherence_logs
            WHERE patient_id = ? AND log_date BETWEEN ? AND ?
            ORDER BY log_date ASC
        ");
        $stmt->execute([$patientId, $from, $to]);
        Response::json($stmt->fetchAll());
    }

    // GET /adherence/summary?patient_id=X
    public function summary(): void {
        $db        = Database::getInstance();
        $patientId = (int)Request::get('patient_id', $this->auth['uid']);
        if ($this->auth['role'] === 'patient') $patientId = $this->auth['uid'];

        // Last 7 days
        $week = $db->prepare("
            SELECT
                ROUND(AVG(adherence_percentage), 1)  AS weekly_avg,
                SUM(total_taken)                      AS weekly_taken,
                SUM(total_scheduled)                  AS weekly_scheduled,
                SUM(total_missed)                     AS weekly_missed
            FROM adherence_logs
            WHERE patient_id = ? AND log_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
        ");
        $week->execute([$patientId]);
        $weekData = $week->fetch();

        // Last 30 days
        $month = $db->prepare("
            SELECT
                ROUND(AVG(adherence_percentage), 1) AS monthly_avg,
                SUM(total_taken)                     AS monthly_taken,
                SUM(total_scheduled)                 AS monthly_scheduled,
                COUNT(CASE WHEN adherence_percentage >= 80 THEN 1 END) AS good_days
            FROM adherence_logs
            WHERE patient_id = ? AND log_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
        ");
        $month->execute([$patientId]);
        $monthData = $month->fetch();

        // Best streak (consecutive days with >= 80% adherence)
        $streak = $this->calculateStreak($db, $patientId);

        // Per-medication breakdown
        $meds = $db->prepare("
            SELECT m.name AS medication_name, pm.dosage,
                   COUNT(*) AS total_doses,
                   SUM(ms.status = 'taken') AS taken,
                   SUM(ms.status = 'missed') AS missed,
                   ROUND(SUM(ms.status='taken') / COUNT(*) * 100, 1) AS adherence_pct
            FROM medication_schedules ms
            JOIN prescription_medications pm ON pm.id = ms.prescription_medication_id
            JOIN medications m ON m.id = pm.medication_id
            WHERE ms.patient_id = ?
              AND ms.scheduled_time >= DATE_SUB(NOW(), INTERVAL 30 DAY)
            GROUP BY pm.id, m.name, pm.dosage
        ");
        $meds->execute([$patientId]);

        Response::json([
            'weekly'           => $weekData,
            'monthly'          => $monthData,
            'best_streak_days' => $streak,
            'per_medication'   => $meds->fetchAll(),
        ]);
    }

    private function calculateStreak(PDO $db, int $patientId): int {
        $stmt = $db->prepare("
            SELECT log_date, adherence_percentage
            FROM adherence_logs
            WHERE patient_id = ?
            ORDER BY log_date DESC
            LIMIT 60
        ");
        $stmt->execute([$patientId]);
        $logs   = $stmt->fetchAll();
        $streak = 0;
        foreach ($logs as $log) {
            if ((float)$log['adherence_percentage'] >= 80) $streak++;
            else break;
        }
        return $streak;
    }
}
```

---

### 20.8 `controllers/HospitalController.php`
```php
<?php
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Response.php';
require_once __DIR__ . '/../core/Request.php';
require_once __DIR__ . '/../core/Helpers.php';
require_once __DIR__ . '/../core/Upload.php';

class HospitalController {
    public function __construct(private ?array $auth) {}

    public function index(): void {
        $db   = Database::getInstance();
        $stmt = $db->query("
            SELECT h.*,
                (SELECT COUNT(*) FROM users u JOIN roles r ON r.id=u.role_id WHERE u.hospital_id=h.id AND r.name='doctor' AND u.is_active=1) AS doctor_count,
                (SELECT COUNT(*) FROM users u JOIN roles r ON r.id=u.role_id WHERE u.hospital_id=h.id AND r.name='patient' AND u.is_active=1) AS patient_count,
                (SELECT ROUND(AVG(al.adherence_percentage),1) FROM adherence_logs al JOIN users u ON u.id=al.patient_id WHERE u.hospital_id=h.id AND al.log_date >= DATE_SUB(CURDATE(),INTERVAL 30 DAY)) AS avg_adherence
            FROM hospitals h ORDER BY h.name ASC
        ");
        Response::json($stmt->fetchAll());
    }

    public function store(): void {
        $db   = Database::getInstance();
        $body = Request::json();
        $missing = validateRequired($body, ['name']);
        if ($missing) Response::error('name is required', 422);

        $logoUrl = null;
        if (!empty($_FILES['logo'])) {
            try { $logoUrl = uploadImage($_FILES['logo'], 'hospital_logos'); }
            catch (Exception $e) { Response::error($e->getMessage(), 422); }
        }

        $db->prepare("INSERT INTO hospitals (name, address, phone, email, logo_url, created_by) VALUES (?,?,?,?,?,?)")
           ->execute([sanitize($body['name']), sanitize($body['address'] ?? ''), sanitize($body['phone'] ?? ''), sanitize($body['email'] ?? ''), $logoUrl, $this->auth['uid']]);

        Response::json(['hospital_id' => $db->lastInsertId()], 201);
    }

    public function show(string $id): void {
        $db   = Database::getInstance();
        $stmt = $db->prepare("SELECT h.*, u.full_name AS created_by_name FROM hospitals h LEFT JOIN users u ON u.id=h.created_by WHERE h.id=?");
        $stmt->execute([(int)$id]);
        $hospital = $stmt->fetch();
        if (!$hospital) Response::error('Hospital not found', 404);

        // Admins for this hospital
        $admins = $db->prepare("SELECT u.id, u.full_name, u.email, u.phone FROM users u JOIN roles r ON r.id=u.role_id WHERE u.hospital_id=? AND r.name='hospital_admin' AND u.is_active=1");
        $admins->execute([(int)$id]);
        $hospital['admins'] = $admins->fetchAll();

        Response::json($hospital);
    }

    public function update(string $id): void {
        $db   = Database::getInstance();
        $body = Request::json();
        $db->prepare("UPDATE hospitals SET name=?, address=?, phone=?, email=? WHERE id=?")
           ->execute([sanitize($body['name'] ?? ''), sanitize($body['address'] ?? ''), sanitize($body['phone'] ?? ''), sanitize($body['email'] ?? ''), (int)$id]);
        Response::json(['updated' => true]);
    }

    public function toggle(string $id): void {
        $db = Database::getInstance();
        $db->prepare("UPDATE hospitals SET is_active = NOT is_active WHERE id=?")->execute([(int)$id]);
        // Cascade: deactivate all users in this hospital
        $hospital = $db->prepare("SELECT is_active FROM hospitals WHERE id=?"); $hospital->execute([(int)$id]);
        $h = $hospital->fetch();
        if (!$h['is_active']) {
            $db->prepare("UPDATE users SET is_active=0 WHERE hospital_id=?")->execute([(int)$id]);
        }
        Response::json(['toggled' => true]);
    }
}
```

---

### 20.9 `controllers/MedicationController.php`
```php
<?php
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Response.php';
require_once __DIR__ . '/../core/Request.php';
require_once __DIR__ . '/../core/Helpers.php';
require_once __DIR__ . '/../core/Upload.php';

class MedicationController {
    public function __construct(private ?array $auth) {}

    public function index(): void {
        $db         = Database::getInstance();
        $hospitalId = (int)Request::get('hospital_id', $this->auth['hid'] ?? 0);
        $search     = sanitize(Request::get('q', ''));

        $params = [$hospitalId];
        $searchSql = '';
        if ($search) { $searchSql = 'AND (m.name LIKE ? OR m.generic_name LIKE ? OR m.category LIKE ?)'; $params = array_merge($params, ["%$search%","%$search%","%$search%"]); }

        $stmt = $db->prepare("SELECT m.*, u.full_name AS created_by_name FROM medications m LEFT JOIN users u ON u.id=m.created_by WHERE m.hospital_id=? $searchSql ORDER BY m.name ASC");
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
            try { $imageUrl = uploadImage($_FILES['image'], 'drug_images'); }
            catch (Exception $e) { Response::error($e->getMessage(), 422); }
        }

        $db->prepare("INSERT INTO medications (hospital_id, created_by, name, generic_name, description, category, image_url) VALUES (?,?,?,?,?,?,?)")
           ->execute([$this->auth['hid'], $this->auth['uid'], sanitize($body['name']), sanitize($body['generic_name'] ?? ''), sanitize($body['description'] ?? ''), sanitize($body['category'] ?? ''), $imageUrl]);

        Response::json(['medication_id' => $db->lastInsertId()], 201);
    }

    public function update(string $id): void {
        $db   = Database::getInstance();
        $body = Request::json();
        $db->prepare("UPDATE medications SET name=?, generic_name=?, description=?, category=? WHERE id=? AND hospital_id=?")
           ->execute([sanitize($body['name'] ?? ''), sanitize($body['generic_name'] ?? ''), sanitize($body['description'] ?? ''), sanitize($body['category'] ?? ''), (int)$id, $this->auth['hid']]);
        Response::json(['updated' => true]);
    }
}
```

---

### 20.10 `controllers/PrescriptionController.php` — Remaining Methods
```php
// GET /prescriptions?patient_id=X&active=1
public function index(): void {
    $db        = Database::getInstance();
    $patientId = (int)Request::get('patient_id');
    $active    = Request::get('active');

    $conditions = ['p.hospital_id = ?'];
    $params     = [$this->auth['hid']];

    if ($patientId) { $conditions[] = 'p.patient_id = ?'; $params[] = $patientId; }
    if ($this->auth['role'] === 'doctor') { $conditions[] = 'p.doctor_id = ?'; $params[] = $this->auth['uid']; }
    if ($active !== null) { $conditions[] = 'p.is_active = ?'; $params[] = (int)$active; }

    $where = 'WHERE ' . implode(' AND ', $conditions);
    $stmt  = $db->prepare("
        SELECT p.id, p.diagnosis, p.start_date, p.end_date, p.is_active, p.created_at,
               pat.full_name AS patient_name, pat.avatar_url AS patient_avatar,
               doc.full_name AS doctor_name,
               (SELECT COUNT(*) FROM prescription_medications pm WHERE pm.prescription_id=p.id) AS medication_count
        FROM prescriptions p
        JOIN users pat ON pat.id = p.patient_id
        JOIN users doc ON doc.id = p.doctor_id
        $where ORDER BY p.created_at DESC
    ");
    $stmt->execute($params);
    Response::json($stmt->fetchAll());
}

// GET /prescriptions/{id}
public function show(string $id): void {
    $db   = Database::getInstance();
    $stmt = $db->prepare("
        SELECT p.*, pat.full_name AS patient_name, pat.date_of_birth, pat.avatar_url AS patient_avatar,
               doc.full_name AS doctor_name, h.name AS hospital_name
        FROM prescriptions p
        JOIN users pat ON pat.id = p.patient_id
        JOIN users doc ON doc.id = p.doctor_id
        JOIN hospitals h ON h.id = p.hospital_id
        WHERE p.id = ?
    ");
    $stmt->execute([(int)$id]);
    $prescription = $stmt->fetch();
    if (!$prescription) Response::error('Not found', 404);

    // Enforce access
    if ($this->auth['role'] === 'patient' && $prescription['patient_id'] != $this->auth['uid'])
        Response::error('Forbidden', 403);
    if ($this->auth['role'] === 'doctor' && $prescription['doctor_id'] != $this->auth['uid'])
        Response::error('Forbidden', 403);

    // Load medications
    $meds = $db->prepare("
        SELECT pm.*, m.name AS medication_name, m.generic_name, m.category,
               m.description AS medication_description, m.image_url
        FROM prescription_medications pm
        JOIN medications m ON m.id = pm.medication_id
        WHERE pm.prescription_id = ?
    ");
    $meds->execute([(int)$id]);
    $medsData = $meds->fetchAll();
    foreach ($medsData as &$med) {
        $med['times_of_day'] = json_decode($med['times_of_day'], true);
        $med['with_food']    = (bool)$med['with_food'];
        $med['with_water']   = (bool)$med['with_water'];
    }

    // Load lifestyle advice
    $advice = $db->prepare("SELECT * FROM lifestyle_advice WHERE prescription_id = ? ORDER BY advice_type ASC");
    $advice->execute([(int)$id]);

    $prescription['medications']     = $medsData;
    $prescription['lifestyle_advice'] = $advice->fetchAll();

    Response::json($prescription);
}

// GET /my-prescriptions
public function myPrescriptions(): void {
    $db   = Database::getInstance();
    $stmt = $db->prepare("
        SELECT p.id, p.diagnosis, p.start_date, p.end_date, p.is_active, p.notes, p.created_at,
               doc.full_name AS doctor_name,
               (SELECT COUNT(*) FROM prescription_medications pm WHERE pm.prescription_id=p.id) AS medication_count,
               (SELECT COUNT(*) FROM lifestyle_advice la WHERE la.prescription_id=p.id) AS advice_count
        FROM prescriptions p
        JOIN users doc ON doc.id = p.doctor_id
        WHERE p.patient_id = ?
        ORDER BY p.is_active DESC, p.created_at DESC
    ");
    $stmt->execute([$this->auth['uid']]);
    Response::json($stmt->fetchAll());
}

// PUT /prescriptions/{id}
public function update(string $id): void {
    $db   = Database::getInstance();
    $body = Request::json();

    $pres = $db->prepare("SELECT doctor_id FROM prescriptions WHERE id=?"); $pres->execute([(int)$id]);
    $row  = $pres->fetch();
    if (!$row) Response::error('Not found', 404);
    if ($row['doctor_id'] != $this->auth['uid']) Response::error('Forbidden', 403);

    $db->prepare("UPDATE prescriptions SET diagnosis=?, notes=?, end_date=?, is_active=? WHERE id=?")
       ->execute([sanitize($body['diagnosis'] ?? ''), sanitize($body['notes'] ?? ''), $body['end_date'] ?? null, isset($body['is_active']) ? (int)$body['is_active'] : 1, (int)$id]);

    Response::json(['updated' => true]);
}
```

---

## 21. Cron — Remaining Scripts

### 21.1 `cron/send_appointment_reminders.php`
```php
<?php
require_once __DIR__ . '/../config/config.php';
require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/Helpers.php';

$db       = Database::getInstance();
$tomorrow = date('Y-m-d', strtotime('+1 day'));

$stmt = $db->prepare("
    SELECT a.id, a.appointment_date, a.purpose,
           p.full_name AS patient_name, p.onesignal_player_id,
           d.full_name AS doctor_name
    FROM appointments a
    JOIN users p ON p.id = a.patient_id
    JOIN users d ON d.id = a.doctor_id
    WHERE DATE(a.appointment_date) = ?
      AND a.status = 'scheduled'
      AND a.reminder_sent = 0
      AND p.onesignal_player_id IS NOT NULL
");
$stmt->execute([$tomorrow]);
$appointments = $stmt->fetchAll();

foreach ($appointments as $appt) {
    $time    = date('g:i A', strtotime($appt['appointment_date']));
    $payload = [
        'app_id'             => ONESIGNAL_APP_ID,
        'include_player_ids' => [$appt['onesignal_player_id']],
        'headings'           => ['en' => '📅 Appointment Tomorrow'],
        'contents'           => ['en' => "You have an appointment with Dr. {$appt['doctor_name']} tomorrow at {$time}. Purpose: {$appt['purpose']}"],
        'data'               => ['type' => 'appointment', 'appointment_id' => (string)$appt['id']],
    ];

    $ch = curl_init('https://onesignal.com/api/v1/notifications');
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_POST => true, CURLOPT_HTTPHEADER => ['Content-Type: application/json', 'Authorization: Basic ' . ONESIGNAL_KEY], CURLOPT_POSTFIELDS => json_encode($payload)]);
    curl_exec($ch);
    curl_close($ch);

    // Mark as reminded + insert in-app notification
    $db->prepare("UPDATE appointments SET reminder_sent=1 WHERE id=?")->execute([$appt['id']]);
    insertNotification($db, [
        'recipient_id' => $appt['patient_id'] ?? null,  // add patient_id to query above
        'title'        => '📅 Appointment Tomorrow',
        'body'         => "Appointment with Dr. {$appt['doctor_name']} at {$time}",
        'type'         => 'appointment',
        'reference_id' => $appt['id'],
        'reference_table' => 'appointments',
    ]);
}

echo "[" . date('Y-m-d H:i:s') . "] Appointment reminders sent: " . count($appointments) . "\n";
```

---

## 22. Flutter — Data Models (Freezed)

Create all models in `lib/features/[feature]/domain/models/`. Run `dart run build_runner build` after adding all models.

```dart
// lib/features/auth/domain/models/user_profile.dart
@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required int id,
    required String fullName,
    required String email,
    String? phone,
    required String roleName,
    int? hospitalId,
    String? hospitalName,
    String? hospitalLogo,
    String? avatarUrl,
    String? dateOfBirth,
    String? gender,
    String? emergencyContact,
    String? diagnosis,
    required bool isActive,
  }) = _UserProfile;
  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}

// lib/features/super_admin/domain/models/hospital.dart
@freezed
class Hospital with _$Hospital {
  const factory Hospital({
    required int id,
    required String name,
    String? address,
    String? phone,
    String? email,
    String? logoUrl,
    required bool isActive,
    int? doctorCount,
    int? patientCount,
    double? avgAdherence,
  }) = _Hospital;
  factory Hospital.fromJson(Map<String, dynamic> json) => _$HospitalFromJson(json);
}

// lib/features/doctor/domain/models/prescription.dart
@freezed
class Prescription with _$Prescription {
  const factory Prescription({
    required int id,
    required String diagnosis,
    String? notes,
    required String startDate,
    String? endDate,
    required bool isActive,
    required String doctorName,
    String? patientName,
    int? medicationCount,
    int? adviceCount,
    List<PrescriptionMedication>? medications,
    List<LifestyleAdvice>? lifestyleAdvice,
  }) = _Prescription;
  factory Prescription.fromJson(Map<String, dynamic> json) => _$PrescriptionFromJson(json);
}

// lib/features/doctor/domain/models/prescription_medication.dart
@freezed
class PrescriptionMedication with _$PrescriptionMedication {
  const factory PrescriptionMedication({
    required int id,
    required int medicationId,
    required String medicationName,
    String? genericName,
    String? category,
    String? medicationDescription,
    String? imageUrl,
    required String dosage,
    required String frequency,
    required List<String> timesOfDay,
    required bool withFood,
    required bool withWater,
    String? specialInstructions,
    int? durationDays,
  }) = _PrescriptionMedication;
  factory PrescriptionMedication.fromJson(Map<String, dynamic> json) => _$PrescriptionMedicationFromJson(json);
}

// lib/features/doctor/domain/models/lifestyle_advice.dart
@freezed
class LifestyleAdvice with _$LifestyleAdvice {
  const factory LifestyleAdvice({
    required int id,
    required int prescriptionId,
    required String adviceType,  // exercise, diet, hydration, sleep, general
    required String title,
    required String description,
    String? frequency,
    int? durationMinutes,
  }) = _LifestyleAdvice;
  factory LifestyleAdvice.fromJson(Map<String, dynamic> json) => _$LifestyleAdviceFromJson(json);
}

// lib/features/patient/domain/models/medication_schedule.dart
@freezed
class MedicationSchedule with _$MedicationSchedule {
  const factory MedicationSchedule({
    required int id,
    required String scheduledTime,
    required String status,        // pending, taken, missed, skipped
    String? confirmedAt,
    String? notes,
    required String dosage,
    required String medicationName,
    String? imageUrl,
    required bool withFood,
    required bool withWater,
    String? specialInstructions,
    String? prescriptionId,
    String? doctorName,
    String? diagnosis,
    List<Map<String, String>>? lifestyleTips,
  }) = _MedicationSchedule;
  factory MedicationSchedule.fromJson(Map<String, dynamic> json) => _$MedicationScheduleFromJson(json);
}

// lib/features/patient/domain/models/appointment.dart
@freezed
class AppointmentModel with _$AppointmentModel {
  const factory AppointmentModel({
    required int id,
    required String appointmentDate,
    required String purpose,
    String? notes,
    required String status,
    String? patientName,
    String? patientAvatar,
    String? doctorName,
    String? hospitalName,
  }) = _AppointmentModel;
  factory AppointmentModel.fromJson(Map<String, dynamic> json) => _$AppointmentModelFromJson(json);
}

// lib/features/notifications/domain/models/app_notification.dart
@freezed
class AppNotification with _$AppNotification {
  const factory AppNotification({
    required int id,
    required String title,
    required String body,
    required String type,
    int? referenceId,
    String? referenceTable,
    required bool isRead,
    required String sentAt,
    String? readAt,
    String? senderName,
  }) = _AppNotification;
  factory AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);
}

// lib/features/patient/domain/models/adherence_log.dart
@freezed
class AdherenceLog with _$AdherenceLog {
  const factory AdherenceLog({
    required String logDate,
    required int totalScheduled,
    required int totalTaken,
    required int totalMissed,
    required int totalSkipped,
    required double adherencePercentage,
  }) = _AdherenceLog;
  factory AdherenceLog.fromJson(Map<String, dynamic> json) => _$AdherenceLogFromJson(json);
}
```

---

## 23. Flutter — GoRouter Setup

```dart
// lib/router/app_router.dart
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

GoRouter buildRouter(WidgetRef ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/splash',
    redirect: (context, state) async {
      final auth    = ref.read(authServiceProvider);
      final loggedIn = await auth.isLoggedIn();
      final onAuth   = state.matchedLocation.startsWith('/login');

      if (!loggedIn && !onAuth && state.matchedLocation != '/splash')
        return '/login';
      return null;
    },
    routes: [
      GoRoute(path: '/splash',  builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/login',   builder: (_, __) => const LoginScreen()),

      // Super Admin
      ShellRoute(
        builder: (ctx, state, child) => AppShell(child: child),
        routes: [
          GoRoute(path: '/super-admin/dashboard',      builder: (_, __) => const SuperAdminDashboard()),
          GoRoute(path: '/super-admin/hospitals',      builder: (_, __) => const HospitalsListScreen()),
          GoRoute(path: '/super-admin/hospitals/add',  builder: (_, __) => const AddHospitalScreen()),
          GoRoute(path: '/super-admin/hospitals/:id',  builder: (_, s)  => HospitalDetailScreen(id: int.parse(s.pathParameters['id']!))),
        ],
      ),

      // Hospital Admin
      ShellRoute(
        builder: (ctx, state, child) => AppShell(child: child),
        routes: [
          GoRoute(path: '/admin/dashboard',            builder: (_, __) => const AdminDashboard()),
          GoRoute(path: '/admin/doctors',              builder: (_, __) => const ManageDoctorsScreen()),
          GoRoute(path: '/admin/doctors/add',          builder: (_, __) => const AddDoctorScreen()),
          GoRoute(path: '/admin/patients',             builder: (_, __) => const ManagePatientsScreen()),
          GoRoute(path: '/admin/patients/add',         builder: (_, __) => const AddPatientScreen()),
          GoRoute(path: '/admin/patients/:id/assign',  builder: (_, s)  => AssignPatientScreen(patientId: int.parse(s.pathParameters['id']!))),
          GoRoute(path: '/admin/reports',              builder: (_, __) => const HospitalReportsScreen()),
        ],
      ),

      // Doctor
      ShellRoute(
        builder: (ctx, state, child) => AppShell(child: child),
        routes: [
          GoRoute(path: '/doctor/dashboard',           builder: (_, __) => const DoctorDashboard()),
          GoRoute(path: '/doctor/patients',            builder: (_, __) => const MyPatientsScreen()),
          GoRoute(path: '/doctor/patients/:id',        builder: (_, s)  => PatientDetailScreen(patientId: int.parse(s.pathParameters['id']!))),
          GoRoute(path: '/doctor/prescribe/:patientId',builder: (_, s)  => CreatePrescriptionScreen(patientId: int.parse(s.pathParameters['patientId']!))),
          GoRoute(path: '/doctor/medications',         builder: (_, __) => const MedicationLibraryScreen()),
          GoRoute(path: '/doctor/appointments/new',    builder: (_, __) => const ScheduleAppointmentScreen()),
        ],
      ),

      // Patient
      ShellRoute(
        builder: (ctx, state, child) => AppShell(child: child),
        routes: [
          GoRoute(path: '/patient/dashboard',          builder: (_, __) => const PatientDashboard()),
          GoRoute(path: '/patient/schedule',           builder: (_, __) => const TodayScheduleScreen()),
          GoRoute(path: '/patient/medications/:id',    builder: (_, s)  => MedicationDetailScreen(scheduleId: int.parse(s.pathParameters['id']!))),
          GoRoute(path: '/patient/prescriptions',      builder: (_, __) => const MyPrescriptionsScreen()),
          GoRoute(path: '/patient/prescriptions/:id',  builder: (_, s)  => PrescriptionDetailScreen(id: int.parse(s.pathParameters['id']!))),
          GoRoute(path: '/patient/lifestyle',          builder: (_, __) => const LifestyleAdviceScreen()),
          GoRoute(path: '/patient/appointments',       builder: (_, __) => const AppointmentsScreen()),
          GoRoute(path: '/patient/adherence',          builder: (_, __) => const AdherenceReportScreen()),
        ],
      ),

      // Shared
      GoRoute(path: '/notifications',                  builder: (_, __) => const NotificationsScreen()),
      GoRoute(path: '/profile',                        builder: (_, __) => const ProfileScreen()),
    ],
  );
}

// Route resolver for notification taps
String resolveRoute(String? type, dynamic id) {
  return switch (type) {
    'medication_reminder' || 'advance_reminder' => '/patient/schedule',
    'appointment'   => '/patient/appointments',
    'prescription'  => '/patient/prescriptions/${id ?? ''}',
    _               => '/notifications',
  };
}
```

---

## 24. Database Seed SQL

```sql
-- database/seed.sql
USE meditrack;

-- Roles (already created in schema, but safe to re-run)
INSERT IGNORE INTO roles (name) VALUES ('super_admin'),('hospital_admin'),('doctor'),('patient');

-- Default super admin (password: Admin@1234)
INSERT IGNORE INTO users (role_id, full_name, email, password)
SELECT r.id, 'System Admin', 'admin@meditrack.app',
       '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi'
FROM roles r WHERE r.name = 'super_admin';

-- Sample hospital
INSERT IGNORE INTO hospitals (name, address, phone, email) VALUES
  ('Bishop Stuart University Hospital', 'Mbarara, Uganda', '+256 712 345678', 'hospital@bsu.ac.ug');

-- Sample hospital admin (password: Admin@1234)
INSERT IGNORE INTO users (role_id, hospital_id, full_name, email, password)
SELECT r.id, h.id, 'Hospital Admin', 'hadmin@meditrack.app',
       '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi'
FROM roles r, hospitals h WHERE r.name = 'hospital_admin' AND h.name = 'Bishop Stuart University Hospital';

-- Sample doctor (password: Admin@1234)
INSERT IGNORE INTO users (role_id, hospital_id, full_name, email, password, phone)
SELECT r.id, h.id, 'Dr. Sarah Mukasa', 'doctor@meditrack.app',
       '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+256 701 000001'
FROM roles r, hospitals h WHERE r.name = 'doctor' AND h.name = 'Bishop Stuart University Hospital';

-- Sample patient (password: Admin@1234)
INSERT IGNORE INTO users (role_id, hospital_id, full_name, email, password, phone, diagnosis, date_of_birth, gender)
SELECT r.id, h.id, 'John Sserwanga', 'patient@meditrack.app',
       '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
       '+256 702 000002', 'Type 2 Diabetes', '1985-03-15', 'male'
FROM roles r, hospitals h WHERE r.name = 'patient' AND h.name = 'Bishop Stuart University Hospital';

-- Assign patient to doctor
INSERT IGNORE INTO doctor_patient_assignments (doctor_id, patient_id, hospital_id)
SELECT d.id, p.id, h.id
FROM users d, users p, hospitals h, roles rd, roles rp
WHERE d.email='doctor@meditrack.app' AND p.email='patient@meditrack.app'
  AND h.name='Bishop Stuart University Hospital'
  AND d.role_id=rd.id AND rd.name='doctor'
  AND p.role_id=rp.id AND rp.name='patient';

-- Sample medication library
INSERT IGNORE INTO medications (hospital_id, created_by, name, generic_name, description, category) VALUES
  ((SELECT id FROM hospitals WHERE name='Bishop Stuart University Hospital'),
   (SELECT id FROM users WHERE email='doctor@meditrack.app'),
   'Metformin', 'Metformin Hydrochloride',
   'Used to treat Type 2 Diabetes by lowering blood glucose levels. Take with food to reduce stomach upset.',
   'antidiabetic'),
  ((SELECT id FROM hospitals WHERE name='Bishop Stuart University Hospital'),
   (SELECT id FROM users WHERE email='doctor@meditrack.app'),
   'Lisinopril', 'Lisinopril',
   'ACE inhibitor used to treat high blood pressure and heart failure.',
   'antihypertensive'),
  ((SELECT id FROM hospitals WHERE name='Bishop Stuart University Hospital'),
   (SELECT id FROM users WHERE email='doctor@meditrack.app'),
   'Atorvastatin', 'Atorvastatin Calcium',
   'Used to lower cholesterol and triglycerides in the blood.',
   'statin');
```

---

## 25. README.md Template

```markdown
# MediTrack API — Setup Guide

## Requirements
- PHP 8.2+ with extensions: pdo_mysql, mbstring, json, curl, fileinfo, openssl
- MySQL 8.0+
- Apache 2.4+ with mod_rewrite OR Nginx
- Composer
- Crontab access

## Installation

### 1. Clone and install dependencies
git clone https://github.com/yourorg/meditrack-api.git
cd meditrack-api
composer install

### 2. Configure environment
cp .env.example .env
# Edit .env — fill in DB credentials, JWT_SECRET (min 64 chars), OneSignal keys

### 3. Create database and run migrations
mysql -u root -p -e "CREATE DATABASE meditrack CHARACTER SET utf8mb4"
mysql -u root -p meditrack < database/schema.sql
mysql -u root -p meditrack < database/seed.sql

### 4. Create upload directories
mkdir -p uploads/avatars uploads/hospital_logos uploads/drug_images
chmod 755 uploads/

### 5. Configure web server
# Apache: ensure mod_rewrite is enabled and .htaccess is allowed
# Nginx: set try_files $uri $uri/ /index.php?$query_string;

### 6. Set up cron jobs
crontab -e
# Paste the cron lines from Section 8 of the build spec

## Test Accounts
| Role           | Email                    | Password    |
|----------------|--------------------------|-------------|
| Super Admin    | admin@meditrack.app      | Admin@1234  |
| Hospital Admin | hadmin@meditrack.app     | Admin@1234  |
| Doctor         | doctor@meditrack.app     | Admin@1234  |
| Patient        | patient@meditrack.app    | Admin@1234  |

## Flutter Setup
1. Set API_BASE_URL in lib/core/services/api_service.dart
2. Set ONESIGNAL_APP_ID in lib/core/services/onesignal_service.dart
3. Add google-services.json (Android) and GoogleService-Info.plist (iOS) for OneSignal Firebase
4. flutter pub get
5. dart run build_runner build --delete-conflicting-outputs
6. flutter run

## API Base URL
All endpoints: POST/GET/PUT to https://yourdomain.com/api/v1/{endpoint}
All protected endpoints require: Authorization: Bearer {access_token}

## Folder Structure
meditrack-api/     — PHP REST API
meditrack-app/     — Flutter mobile app
```

---

*End of Build Specification — MediTrack v2.0 (PHP + MySQL + Flutter)*
