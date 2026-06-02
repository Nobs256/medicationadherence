# MediTrack REST API — Medication Adherence & Monitoring

## 🚀 Overview
MediTrack is a multi-hospital medication adherence platform. This backend is a high-performance, framework-less PHP REST API designed for strict data isolation, clinical accuracy, and automated patient engagement.

## 🛠 Tech Stack
- **Language:** PHP 8.2+ (Pure procedural style with Core helpers)
- **Database:** MySQL 8.0+ (PDO with Prepared Statements)
- **Auth:** JWT (JSON Web Tokens) via `firebase/php-jwt`
- **Push Notifications:** OneSignal REST API integration
- **Testing:** VS Code REST Client (`test.http`)

---

## 🏗 Architecture & Logic

### 1. Framework-less Routing
The API does not use a framework (like Laravel or Slim). Routing is handled in `index.php`. 
- It parses the URI, strips subdirectories (critical for XAMPP environments), and matches the path against a route map.
- **Middleware Layer:** Role-based access control (RBAC) is enforced directly in the router. Before a controller is instantiated, the system verifies the JWT and checks if the user's role has permission for that specific endpoint.

### 2. Multi-Hospital Data Isolation
The system is designed for multi-tenancy. Every piece of data (Users, Medications, Prescriptions) is scoped by a `hospital_id`.
- **Logic:** A user's `hospital_id` is embedded in their JWT payload. Controllers use this ID to filter every query, ensuring a Doctor from Hospital A can never view records from Hospital B.

### 3. The Clinical Engine (Prescription -> Schedule)
The core value of MediTrack is the automatic generation of medication timelines.
- **How it works:** When a Doctor calls `POST /prescriptions`, the `PrescriptionController` triggers a generation loop.
- It takes the `start_date`, `duration_days`, and the `times_of_day` (JSON array) for each medication.
- It batch-inserts rows into the `medication_schedules` table for every single dose the patient needs to take for the entire duration of the treatment.

### 4. The Automation Engine (Cron Jobs)
The API relies on four background tasks to keep patients on track:
- **Reminders:** Sends push notifications 2 hours before a dose and at the exact time of the dose.
- **Missed Dose Detection:** Automatically marks doses as "missed" if a patient hasn't responded within 1 hour of the scheduled time.
- **Adherence Computation:** A daily job that calculates a patient's adherence percentage (Taken vs. Scheduled) to power the analytical charts.

---

## 📁 Project Structure
```text
meditrack-api/
├── config/         # Environment loading and global constants
├── core/           # The "Engine" (Database, Auth, Request, Response, Upload helpers)
├── controllers/    # Business logic (Pure PHP classes)
├── cron/           # Automated background scripts
├── uploads/        # Storage for avatars, drug images, and logos
├── database/       # SQL Schema and comprehensive Seed data
├── test.http       # Full API test suite
└── index.php       # The central Router and RBAC gateway
```

---

## 🚦 Getting Started for Developers

### 1. Local Environment Setup (XAMPP)
- Clone the repository into `C:\xampp\htdocs\meditrack-api`.
- Ensure Apache and MySQL are running.
- Run `composer install` to fetch the JWT and Dotenv libraries.

### 2. Database Migration
- Access `phpMyAdmin` and create a database named `meditrack`.
- Import `database/schema.sql` first.
- Import `database/seed.sql` to populate roles and test accounts.

### 3. Configuration
- Copy `.env.example` to `.env`.
- Set a long random string for `JWT_SECRET`.
- Ensure `DB_PASS` is empty (default XAMPP) or set your password.

### 4. Authorization Header Fix
XAMPP often strips the `Authorization` header. We have implemented a fix in `.htaccess`:
```apache
RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]
```
*If you move to Nginx or a different server, ensure the header is passed to PHP.*

---

## 🧪 How to Test
We use the **VS Code REST Client** extension for testing.
1. Open `test.http`.
2. Run the **Login Test** request.
3. Copy the `access_token` from the response.
4. Paste it into the `@token` variable at the top of the file.
5. You can now run any endpoint in the file to verify logic.

### Test Accounts (Password: Admin@1234)
| Role | Email |
| :--- | :--- |
| **Super Admin** | `admin@meditrack.app` |
| **Hospital Admin** | `hadmin@meditrack.app` |
| **Doctor** | `doctor@meditrack.app` |
| **Patient** | `patient@meditrack.app` |

---

## 🛡 Security Standards
- **Prepared Statements:** No raw SQL concatenation is allowed to prevent SQL Injection.
- **Input Sanitation:** All user inputs must pass through the `sanitize()` helper.
- **JWT Scoping:** Never trust user input for IDs; where possible, pull the `uid` or `hid` directly from the token data.
- **Upload Security:** The `uploads` directory has an `.htaccess` file that disables PHP execution to prevent malicious script uploads.

---

## 📈 Scaling the API
To add a new feature:
1. Update `database/schema.sql` with new tables.
2. Add the routes to the `$routes` array in `index.php`.
3. Create a new Controller in `controllers/`.
4. Add test cases to `test.http`.

---

*MediTrack API v2.0 - Build with precision, save lives.*