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

// Background Task Runner (Poor Man's Cron)
// This allows automated clinical tasks to run without dedicated system-level cron jobs.
// It detaches the response from the client before executing long-running tasks.
register_shutdown_function(function() {
    // Only process on actual API requests, not preflight OPTIONS
    if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') return;

    $can_detach = function_exists('fastcgi_finish_request');
    
    // On shared hosting (PHP 7.4/LiteSpeed), only run background tasks on 
    // write actions (POST/PUT/DELETE) if we can detach. 
    // For GET requests (dashboards), skip unless we can detach to avoid 500 errors.
    if (!$can_detach && $_SERVER['REQUEST_METHOD'] === 'GET') return;
    
    $is_write_action = in_array($_SERVER['REQUEST_METHOD'], ['POST', 'PUT', 'DELETE']);
    if (!$can_detach && $is_write_action) return;

    $cron_dir = __DIR__ . '/cron';
    $lock_file = $cron_dir . '/cron_last_run.json';
    $now = time();
    
    // Load last run times to avoid redundant execution per request
    $last_runs = file_exists($lock_file) ? json_decode(file_get_contents($lock_file), true) : [];
    if (!is_array($last_runs)) $last_runs = [];

    $tasks = [
        'send_medication_reminders.php'  => 10,   // Reduced for instant testing
        'mark_missed_medications.php'    => 10,   // Reduced for instant testing
        'send_appointment_reminders.php' => 10,   // Reduced for instant testing
        'compute_adherence.php'          => 10,   // Reduced for instant testing
    ];

    $to_run = [];
    foreach ($tasks as $script => $interval) {
        if ($now - ($last_runs[$script] ?? 0) >= $interval) {
            $to_run[] = $script;
        }
    }

    if (empty($to_run)) return;

    // Background execution optimization: Detach from client
    ignore_user_abort(true);
    set_time_limit(0);
    
    if ($can_detach) fastcgi_finish_request(); 

    $updated = false;
    foreach ($to_run as $script) {
        if (file_exists("$cron_dir/$script")) {
            try {
                ob_start(); // Prevent script echoes from corrupting any accidental output
                include "$cron_dir/$script";
                ob_end_clean();
                $last_runs[$script] = $now;
                $updated = true;
            } catch (Throwable $e) {
                // Fail silently in background so we don't trigger a 500 error for the user
                if (ob_get_level() > 0) ob_end_clean();
            }
        }
    }
    if ($updated) @file_put_contents($lock_file, json_encode($last_runs));
});

$uri    = strtok(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), '?');

// Remove the base project directory from the URI (e.g., /meditrack-api)
$basePath = dirname($_SERVER['SCRIPT_NAME']);
if ($basePath !== '/' && strpos($uri, $basePath) === 0) {
    $uri = substr($uri, strlen($basePath));
}

//$uri    = preg_replace('#^/api/v1#', '', $uri);
// Handle subdirectory hosting and strip API version prefix
if (($pos = strpos($uri, '/api/v1')) !== false) {
    $uri = substr($uri, $pos + 7);
}
if (!$uri) $uri = '/';
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
    ['GET',  '/users',                'UserController',         'index',                ['super_admin','hospital_admin','doctor']],
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
    $controllerFile = "controllers/{$controllerName}.php";
    if (!file_exists($controllerFile)) Response::error('Controller not found', 500);
    // PHP 7.4: Constructor property promotion is not available, so pass $auth explicitly
    require_once $controllerFile;
    $controller = new $controllerName($tokenData);
    call_user_func_array([$controller, $action], $matches);
    exit;
}

Response::error('Not Found', 404);