# MediTrack

MediTrack is a multi-hospital Medication Adherence & Chronic Disease Monitoring platform. It consists of a high-performance PHP REST API backend and a cross-platform Flutter mobile application.

## 📌 Project Overview

MediTrack allows hospitals to manage patients with chronic conditions by providing digital prescriptions, automated medication reminders via push notifications, and detailed adherence tracking.

- **Backend:** PHP 8.2 (Pure PDO) with JWT Authentication.
- **Frontend:** Flutter 3.19+ (Riverpod for state management, GoRouter for navigation).
- **Database:** MySQL 8.0+.
- **Notifications:** OneSignal Push Integration.

---

## 🚀 Developer Setup Guide

### 1. Backend (meditrack-api)
Located in `/meditrack-api`

**Requirements:**
- PHP 8.2+
- Composer
- MySQL 8.0+
- Apache/Nginx (with mod_rewrite enabled)

**Setup Steps:**
1. Navigate to the api folder: `cd meditrack-api`
2. Install dependencies: `composer install`
3. Create a `.env` file from `.env.example` and update your database credentials and OneSignal keys.
4. Import the database schema: `mysql -u root -p meditrack < database/schema.sql`
5. Seed default data: `mysql -u root -p meditrack < database/seed.sql`
6. **Cron Jobs:** Set up the following cron tasks on your server to handle reminders:
   - `send_medication_reminders.php` (Every 5 mins)
   - `mark_missed_medications.php` (Every 15 mins)
   - `compute_adherence.php` (Daily at midnight)

### 2. Mobile App (medical)
Located in `/medical`

**Requirements:**
- Flutter SDK (>= 3.19)
- Android Studio / Xcode

**Setup Steps:**
1. Navigate to the app folder: `cd medical`
2. Install packages: `flutter pub get`
3. Generate models: `dart run build_runner build --delete-conflicting-outputs`
4. **Configuration:** 
   - Update `baseUrl` in `lib/core/services/api_service.dart` to your API URL.
   - Update OneSignal App ID in `lib/core/services/onesignal_service.dart`.
5. Run the app: `flutter run`

### 3. Cron Job Setup (Namecheap cPanel)
To ensure automated reminders and adherence tracking work correctly, follow these steps in your hosting control panel:

1. **Find Cron Jobs:** Log in to cPanel, scroll to the **Advanced** section, and click on **Cron Jobs**.
2. **Command Template:** (Replace `yourusername` with your actual cPanel username)
   ```bash
   /usr/local/bin/php /home/yourusername/public_html/meditrack-api/cron/[SCRIPT_NAME].php >> /home/yourusername/logs/[SCRIPT_NAME].log 2>&1
   ```
3. **Add the following tasks:**
   - **Reminders:** 
     - Interval: Every 5 minutes (`*/5 * * * *`)
     - Script: `send_medication_reminders.php`
   - **Missed Doses:** 
     - Interval: Every 15 minutes (`*/15 * * * *`)
     - Script: `mark_missed_medications.php`
   - **Adherence:** 
     - Interval: Once Per Day (Midnight - `0 0 * * *`)
     - Script: `compute_adherence.php`

> **Note:** If the `/usr/local/bin/php` path differs on your server, check the "Select PHP Version" tool in cPanel or contact support for the correct PHP binary path.

---

## 📖 User Manual & Navigation

### 🔑 Authentication
- **Login:** Use your registered email and password.
- **Splash Screen:** The app automatically detects your role and redirects you to the appropriate dashboard.

### 👑 Super Admin (Platform Manager)
**Role:** Manages hospitals and top-level platform analytics.
- **Dashboard:** Overview of total hospitals, users, and platform-wide adherence rates.
- **Hospitals:** View all onboarded hospitals, add new ones, or deactivate them.
- **Admin Creation:** Assign a Hospital Admin to a specific hospital.

### 🏥 Hospital Admin (Facility Manager)
**Role:** Manages staff and patients within their specific hospital.
- **Dashboard:** Stats on doctors, patients, and facility adherence averages.
- **Doctors:** Register new doctors and view their active patient counts.
- **Patients:** Register new patients and **Assign** them to specific doctors.
- **Reports:** Generate adherence reports for the entire facility.

### 👨‍⚕️ Doctor (Healthcare Provider)
**Role:** Issues prescriptions and monitors patient progress.
- **Dashboard:** View upcoming appointments and patients with low adherence.
- **My Patients:** List of assigned patients. Tap a patient to see their full history and adherence charts.
- **Prescribing:**
  1. Select a patient.
  2. Add medications (dosage, frequency, instructions).
  3. Add lifestyle advice (diet, exercise).
  4. Review and submit to generate the patient's schedule.
- **Appointments:** Schedule follow-up visits.

### 🧑‍placeholder Patient
**Role:** Follows treatment plans and logs medication intake.
- **Dashboard:** 
  - **Adherence Ring:** Visual representation of your weekly progress.
  - **Next Dose:** Quick view of the next medication due.
  - **Advice:** Daily health tips from your doctor.
- **Daily Schedule:** Timeline of all doses for today.
  - **Mark Taken:** Confirm you've taken the dose.
  - **Skip:** Provide a reason if you cannot take a dose.
- **Adherence Report:** View monthly calendars and weekly bar charts of your progress.
- **Notifications:** Receive alerts 2 hours before a dose and exactly when it is due.

---

## 📂 Project Structure

```text
├── meditrack-api/           # PHP Backend
│   ├── config/              # App configuration
│   ├── controllers/         # API logic per module
│   ├── core/                # Database and Auth helpers
│   ├── cron/                # Scheduled tasks (Reminders)
│   └── uploads/             # Avatars and Hospital logos
│
├── medical/                 # Flutter Frontend
│   ├── lib/
│   │   ├── core/            # Services and Constants
│   │   ├── features/        # Modularized business logic (Auth, Doctor, Patient, etc.)
│   │   ├── router/          # GoRouter navigation config
│   │   └── sharedwidgets/   # Reusable UI components
```

---

## 🛡 Security & Best Practices
- **Isolation:** Each hospital's data is isolated via `hospital_id` in the API.
- **Authentication:** All requests are secured using JWT (JSON Web Tokens).
- **Validation:** Server-side sanitization and validation on all inputs.
- **Error Handling:** Centralized exception handling on both App and API.

---

## 🛠 Troubleshooting

**1. Notifications not appearing:**
- Ensure the OneSignal App ID is correct in both `.env` (API) and `onesignal_service.dart` (App).
- Verify that the PHP cron jobs are running on the server.

**2. Connection Error in Flutter:**
- If running on an Android Emulator, use `10.0.2.2` instead of `localhost` for your `baseUrl`.
- Ensure your PHP server allows CORS.

**3. Build Runner Fails:**
- Run `flutter clean` then `flutter pub get` and try again.

---
© 2024 MediTrack Solutions
```


The system handles reminders and notifications through a coordinated effort between your PHP backend, OneSignal's delivery service, and the Flutter app's interactions.

Here is a breakdown of how the process works from start to finish:

1. The Trigger (The "Poor Man's Cron")
Since you aren't using traditional system-level cron jobs, the "engine" that powers everything is the register_shutdown_function in your index.php.

How it fires: Every time a user interacts with the app (especially when they pull to refresh the dashboard), the app calls triggerInternalTasks().
The Lock Mechanism: On the server, index.php checks a file called cron_last_run.json. It looks at the current time and compares it to when the scripts last ran.
Background Execution: If the interval (set to 10 seconds for your current testing) has passed, PHP finishes the request to the app immediately so the user doesn't experience lag, then stays "awake" in the background to run the reminder scripts.
2. Medication Reminders (send_medication_reminders.php)
This is the most critical part of the adherence system. It works by "looking ahead."

Scanning: The script scans the database for any medication schedules for the next 24 hours that haven't had notifications created yet.
OneSignal Scheduling (send_after): This is the clever part. The PHP script doesn't just tell OneSignal to send a message "now." It uses the send_after parameter.
It calculates the exact time the patient needs to take the pill.
It tells OneSignal: "Queue this notification and deliver it to this specific patient at exactly 08:00 AM."
Because OneSignal stores this "future" notification, the patient receives it even if your server is idle or no one is using the app at 08:00 AM.
Dual-Alert System: In production, it sets up two alerts:
Advance Reminder: Sent 2 hours (or 5 mins in your testing) before the dose so the patient can prepare.
Due Reminder: Sent at the exact time the medication is due.
3. Appointment Reminders (send_appointment_reminders.php)
These work similarly but focus on the daily schedule.

The Check: The script checks for any appointments scheduled for tomorrow (or "today" in your testing setup).
Immediate Push: It sends a notification to the patient immediately alerting them of the upcoming visit.
In-App Record: Unlike medication reminders which are mostly push-based, this script calls insertNotification(). This creates a persistent record in your notifications database table, allowing the patient to see the alert in their in-app notification center (the bell icon).
4. Automatic Cleanup (mark_missed_medications.php)
To keep the adherence data accurate, the system must handle cases where a patient forgets to log a dose.

Status Update: If a medication was scheduled for 10:00 AM and it is now 11:00 AM (or 5 minutes later in testing) and the status is still "pending," this script automatically changes the status to "missed."
Adherence Impact: Once marked as missed, the compute_adherence.php script will factor this into the patient's weekly and monthly percentage, which they see as the "Adherence Ring" on their dashboard.
5. The App's Role
The Flutter app acts as the user interface for these events:

Polling: It periodically checks for new unread counts for the notification bell.
Interactive Notifications: When a patient taps a medication notification, the app uses the data payload (like schedule_id) sent by the API to navigate directly to the specific medication log screen where they can mark it as "Taken" or "Skipped."
Summary of Testing Intervals
Because we reduced the intervals for your tests:

The server checks for work every 10 seconds.
A dose becomes "Missed" if not taken within 5 minutes.
Reminders are queued if the dose is within the next 5 minutes