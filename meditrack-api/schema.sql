CREATE TABLE roles (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(50) NOT NULL UNIQUE  -- 'super_admin','hospital_admin','doctor','patient'
);

INSERT INTO roles (name) VALUES
  ('super_admin'), ('hospital_admin'), ('doctor'), ('patient');


-- ### 4.2 `hospitals`

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


-- ### 4.3 `users`

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


-- ### 4.4 `doctor_patient_assignments`

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


-- ### 4.5 `medications`

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


-- ### 4.6 `prescriptions`

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


-- ### 4.7 `prescription_medications`

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


-- ### 4.8 `lifestyle_advice`

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


-- ### 4.9 `medication_schedules`

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


-- ### 4.10 `appointments`

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


-- ### 4.11 `notifications`

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


-- ### 4.12 `adherence_logs`

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

-- ### 4.13 `refresh_tokens`
CREATE TABLE refresh_tokens (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  user_id     INT NOT NULL,
  token       VARCHAR(512) NOT NULL UNIQUE,
  expires_at  DATETIME NOT NULL,
  revoked     TINYINT(1) DEFAULT 0,
  created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
