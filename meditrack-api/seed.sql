-- Seed default super admin
-- Password is 'Admin@1234'
INSERT INTO users (role_id, full_name, email, password) VALUES
  (1, 'System Admin', 'admin@meditrack.app', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi');

-- ### 1. Sample Hospital
INSERT INTO hospitals (id, name, address, phone, email, is_active) VALUES
  (1, 'Bishop Stuart University Hospital', 'Mbarara, Uganda', '+256 712 345678', 'hospital@bsu.ac.ug', 1);

-- ### 2. Sample Users (Password for all: Admin@1234)
-- Hospital Admin
INSERT INTO users (id, role_id, hospital_id, full_name, email, password, is_active) VALUES
  (2, 2, 1, 'Sarah Admin', 'hadmin@meditrack.app', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1);

-- Doctor
INSERT INTO users (id, role_id, hospital_id, full_name, email, password, phone, is_active) VALUES
  (3, 3, 1, 'Dr. John Doe', 'doctor@meditrack.app', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+256 700 111222', 1);

-- Patient
INSERT INTO users (id, role_id, hospital_id, full_name, email, password, phone, date_of_birth, gender, diagnosis, is_active) VALUES
  (4, 4, 1, 'Jane Patient', 'patient@meditrack.app', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+256 755 333444', '1990-05-15', 'female', 'Hypertension & Type 2 Diabetes', 1);

-- ### 3. Doctor-Patient Assignment
INSERT INTO doctor_patient_assignments (doctor_id, patient_id, hospital_id, is_active) VALUES
  (3, 4, 1, 1);

-- ### 4. Medication Library
INSERT INTO medications (id, hospital_id, created_by, name, generic_name, description, category) VALUES
  (1, 1, 3, 'Metformin', 'Metformin Hydrochloride', 'Used to lower blood glucose levels.', 'antidiabetic'),
  (2, 1, 3, 'Lisinopril', 'Lisinopril', 'Used to treat high blood pressure.', 'antihypertensive'),
  (3, 1, 3, 'Atorvastatin', 'Atorvastatin Calcium', 'Used to treat high cholesterol.', 'statin');

-- ### 5. Prescriptions
INSERT INTO prescriptions (id, patient_id, doctor_id, hospital_id, diagnosis, notes, start_date, is_active) VALUES
  (1, 4, 3, 1, 'Chronic Management', 'Take meds regularly as discussed.', CURDATE(), 1);

-- ### 6. Prescription Medications
INSERT INTO prescription_medications (id, prescription_id, medication_id, dosage, frequency, times_of_day, with_food, with_water) VALUES
  (1, 1, 1, '500mg', 'Twice daily', '["08:00", "20:00"]', 1, 1),
  (2, 1, 2, '10mg', 'Once daily', '["09:00"]', 0, 1);

-- ### 7. Lifestyle Advice
INSERT INTO lifestyle_advice (prescription_id, advice_type, title, description, frequency) VALUES
  (1, 'exercise', 'Daily Morning Walk', 'Walk for at least 30 minutes every morning.', 'Daily'),
  (1, 'diet', 'Low Salt Intake', 'Avoid adding extra salt to your meals.', 'Always');

-- ### 8. Medication Schedules (Sample for Today)
INSERT INTO medication_schedules (prescription_medication_id, patient_id, scheduled_time, status) VALUES
  (1, 4, CONCAT(CURDATE(), ' 08:00:00'), 'taken'),
  (1, 4, CONCAT(CURDATE(), ' 20:00:00'), 'pending'),
  (2, 4, CONCAT(CURDATE(), ' 09:00:00'), 'taken');

-- ### 9. Appointments
INSERT INTO appointments (patient_id, doctor_id, hospital_id, appointment_date, purpose, status) VALUES
  (4, 3, 1, DATE_ADD(NOW(), INTERVAL 7 DAY), 'Monthly Routine Checkup', 'scheduled');

-- ### 10. Notifications
INSERT INTO notifications (recipient_id, sender_id, title, body, type, reference_id, reference_table) VALUES
  (4, 3, '📋 New Prescription', 'Dr. John Doe has issued a new prescription for you.', 'prescription', 1, 'prescriptions'),
  (4, 3, '📅 Appointment Scheduled', 'You have a checkup scheduled for next week.', 'appointment', 1, 'appointments');

-- ### 11. Adherence Logs (History for Testing Charts)
INSERT INTO adherence_logs (patient_id, log_date, total_scheduled, total_taken, total_missed, total_skipped, adherence_percentage) VALUES
  (4, DATE_SUB(CURDATE(), INTERVAL 3 DAY), 3, 3, 0, 0, 100.00),
  (4, DATE_SUB(CURDATE(), INTERVAL 2 DAY), 3, 2, 1, 0, 66.67),
  (4, DATE_SUB(CURDATE(), INTERVAL 1 DAY), 3, 3, 0, 0, 100.00);

-- ### 12. Refresh Token Mock
INSERT INTO refresh_tokens (user_id, token, expires_at) VALUES
  (4, 'mock_token_for_testing_ Jane', DATE_ADD(NOW(), INTERVAL 30 DAY));