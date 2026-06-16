-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 10, 2026 at 03:08 PM
-- Server version: 11.4.10-MariaDB-cll-lve-log
-- PHP Version: 8.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `onlinbvn_meditrack`
--

-- --------------------------------------------------------

--
-- Table structure for table `adherence_logs`
--

CREATE TABLE `adherence_logs` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `log_date` date NOT NULL,
  `total_scheduled` int(11) DEFAULT 0,
  `total_taken` int(11) DEFAULT 0,
  `total_missed` int(11) DEFAULT 0,
  `total_skipped` int(11) DEFAULT 0,
  `adherence_percentage` decimal(5,2) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `adherence_logs`
--

INSERT INTO `adherence_logs` (`id`, `patient_id`, `log_date`, `total_scheduled`, `total_taken`, `total_missed`, `total_skipped`, `adherence_percentage`, `created_at`) VALUES
(1, 4, '2026-06-06', 3, 3, 0, 0, 100.00, '2026-06-06 15:35:44'),
(2, 4, '2026-06-04', 3, 2, 1, 0, 66.67, '2026-06-04 15:35:44'),
(3, 4, '2026-05-01', 3, 3, 0, 0, 100.00, '2026-06-01 15:35:44'),
(4, 4, '2026-06-09', 3, 3, 0, 0, 100.00, '2026-06-09 23:59:59'),
(5, 4, '2026-06-08', 3, 1, 2, 0, 33.33, '2026-06-08 23:59:59'),
(6, 4, '2026-06-07', 3, 3, 0, 0, 100.00, '2026-06-07 23:59:59'),
(7, 4, '2026-06-05', 3, 2, 1, 0, 66.67, '2026-06-05 23:59:59'),
(8, 4, '2026-06-03', 3, 3, 0, 0, 100.00, '2026-06-03 23:59:59');

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `hospital_id` int(11) NOT NULL,
  `appointment_date` datetime NOT NULL,
  `purpose` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `status` enum('scheduled','completed','cancelled','rescheduled') DEFAULT 'scheduled',
  `reminder_sent` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`id`, `patient_id`, `doctor_id`, `hospital_id`, `appointment_date`, `purpose`, `notes`, `status`, `reminder_sent`, `created_at`, `updated_at`) VALUES
(1, 4, 3, 1, '2026-06-10 21:14:44', 'Monthly Routine Checkup', NULL, 'scheduled', 0, '2026-06-01 15:35:44', '2026-06-10 13:53:42'),
(2, 4, 3, 1, '2026-06-03 10:00:00', 'Routine Follow-up', 'Patient is responding well to Metformin', 'completed', 1, '2026-06-01 10:00:00', '2026-06-03 11:00:00'),
(3, 4, 3, 1, '2026-06-17 14:00:00', 'Lab Results Review', 'Check HbA1c levels', 'scheduled', 0, '2026-06-10 13:00:00', '2026-06-10 13:00:00'),
(4, 5, 3, 1, '2026-06-12 09:30:00', 'Initial Consultation', 'Discuss hypertension history', 'scheduled', 0, '2026-06-10 13:30:00', '2026-06-10 13:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `doctor_patient_assignments`
--

CREATE TABLE `doctor_patient_assignments` (
  `id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `hospital_id` int(11) NOT NULL,
  `assigned_at` datetime DEFAULT current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `doctor_patient_assignments`
--

INSERT INTO `doctor_patient_assignments` (`id`, `doctor_id`, `patient_id`, `hospital_id`, `assigned_at`, `is_active`) VALUES
(1, 3, 4, 1, '2026-06-01 15:35:44', 1),
(2, 3, 5, 1, '2026-06-10 13:31:29', 1);

-- --------------------------------------------------------

--
-- Table structure for table `hospitals`
--

CREATE TABLE `hospitals` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `logo_url` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `hospitals`
--

INSERT INTO `hospitals` (`id`, `name`, `address`, `phone`, `email`, `logo_url`, `is_active`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'Bishop Stuart University Hospital', 'Mbarara, Uganda', '+256 712 345678', 'hospital@bsu.ac.ug', NULL, 1, NULL, '2026-06-01 15:35:44', '2026-06-01 15:35:44'),
(2, 'mbarara referal', 'mbarara city', '', 'mbarara@gmail.com', NULL, 1, 1, '2026-06-06 11:59:30', '2026-06-06 11:59:30');

-- --------------------------------------------------------

--
-- Table structure for table `lifestyle_advice`
--

CREATE TABLE `lifestyle_advice` (
  `id` int(11) NOT NULL,
  `prescription_id` int(11) NOT NULL,
  `advice_type` enum('exercise','diet','hydration','sleep','general') NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `frequency` varchar(100) DEFAULT NULL,
  `duration_minutes` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lifestyle_advice`
--

INSERT INTO `lifestyle_advice` (`id`, `prescription_id`, `advice_type`, `title`, `description`, `frequency`, `duration_minutes`, `created_at`) VALUES
(1, 1, 'exercise', 'Daily Morning Walk', 'Walk for at least 30 minutes every morning.', 'Daily', NULL, '2026-06-01 15:35:44'),
(2, 1, 'diet', 'Low Salt Intake', 'Avoid adding extra salt to your meals.', 'Always', NULL, '2026-06-01 15:35:44');

-- --------------------------------------------------------

--
-- Table structure for table `medications`
--

CREATE TABLE `medications` (
  `id` int(11) NOT NULL,
  `hospital_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `generic_name` varchar(200) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `medications`
--

INSERT INTO `medications` (`id`, `hospital_id`, `created_by`, `name`, `generic_name`, `description`, `category`, `image_url`, `created_at`) VALUES
(1, 1, 3, 'Metformin', 'Metformin Hydrochloride', 'Used to lower blood glucose levels.', 'antidiabetic', NULL, '2026-06-01 15:35:44'),
(2, 1, 3, 'Lisinopril', 'Lisinopril', 'Used to treat high blood pressure.', 'antihypertensive', NULL, '2026-06-01 15:35:44'),
(3, 1, 3, 'Atorvastatin', 'Atorvastatin Calcium', 'Used to treat high cholesterol.', 'statin', NULL, '2026-06-01 15:35:44');

-- --------------------------------------------------------

--
-- Table structure for table `medication_schedules`
--

CREATE TABLE `medication_schedules` (
  `id` int(11) NOT NULL,
  `prescription_medication_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `scheduled_time` datetime NOT NULL,
  `status` enum('pending','taken','missed','skipped') DEFAULT 'pending',
  `confirmed_at` datetime DEFAULT NULL,
  `onesignal_notification_id` varchar(255) DEFAULT NULL,
  `advance_notification_id` varchar(255) DEFAULT NULL,
  `reminder_sent_at` datetime DEFAULT NULL,
  `advance_reminder_sent_at` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `medication_schedules`
--

INSERT INTO `medication_schedules` (`id`, `prescription_medication_id`, `patient_id`, `scheduled_time`, `status`, `confirmed_at`, `onesignal_notification_id`, `advance_notification_id`, `reminder_sent_at`, `advance_reminder_sent_at`, `notes`, `created_at`) VALUES
(1, 1, 4, '2026-06-10 09:00:00', 'taken', '2026-06-10 14:59:59', NULL, NULL, NULL, NULL, NULL, '2026-06-10 08:35:44'),
(2, 1, 4, '2026-06-10 20:00:00', 'taken', '2026-06-10 20:46:20', NULL, NULL, NULL, NULL, NULL, '2026-06-10 06:35:44'),
(3, 2, 4, '2026-06-01 09:00:00', 'taken', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-01 15:35:44'),
(4, 1, 4, '2026-06-09 08:00:00', 'taken', '2026-06-09 08:15:00', NULL, NULL, NULL, NULL, NULL, '2026-06-01 15:35:44'),
(5, 1, 4, '2026-06-09 20:00:00', 'taken', '2026-06-09 20:05:00', NULL, NULL, NULL, NULL, NULL, '2026-06-01 15:35:44'),
(6, 2, 4, '2026-06-09 09:00:00', 'taken', '2026-06-09 09:10:00', NULL, NULL, NULL, NULL, NULL, '2026-06-01 15:35:44'),
(7, 1, 4, '2026-06-11 08:00:00', 'pending', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-01 15:35:44'),
(8, 1, 4, '2026-06-11 20:00:00', 'pending', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-01 15:35:44'),
(9, 2, 4, '2026-06-11 09:00:00', 'pending', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-01 15:35:44'),
(10, 1, 4, '2026-06-12 08:00:00', 'pending', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-01 15:35:44'),
(11, 1, 4, '2026-06-12 20:00:00', 'pending', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-01 15:35:44'),
(12, 2, 4, '2026-06-12 09:00:00', 'pending', NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-01 15:35:44');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `recipient_id` int(11) NOT NULL,
  `sender_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `type` enum('medication_reminder','advance_reminder','appointment','prescription','advice','general') NOT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `reference_table` varchar(100) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `sent_at` datetime DEFAULT current_timestamp(),
  `read_at` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `recipient_id`, `sender_id`, `title`, `body`, `type`, `reference_id`, `reference_table`, `is_read`, `sent_at`, `read_at`) VALUES
(1, 4, 3, '? New Prescription', 'Dr. John Doe has issued a new prescription for you.', 'prescription', 1, 'prescriptions', 0, '2026-06-01 15:35:44', NULL),
(2, 4, 3, '? Appointment Scheduled', 'You have a checkup scheduled for next week.', 'appointment', 1, 'appointments', 0, '2026-06-01 15:35:44', NULL),
(3, 4, 3, '📅 Appointment Tomorrow', 'Don\'t forget your consultation at 10:00 AM.', 'appointment', 2, 'appointments', 1, '2026-06-02 18:00:00', '2026-06-02 19:00:00'),
(4, 4, 3, '🔔 Adherence Alert', 'You missed some doses yesterday. Please try to stay on track!', 'general', NULL, NULL, 0, '2026-06-09 09:00:00', NULL),
(5, 5, 3, '📋 Welcome', 'Dr. Doe has assigned you to his clinic. Expect a prescription soon.', 'general', NULL, NULL, 0, '2026-06-10 13:40:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `prescriptions`
--

CREATE TABLE `prescriptions` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `hospital_id` int(11) NOT NULL,
  `diagnosis` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `prescriptions`
--

INSERT INTO `prescriptions` (`id`, `patient_id`, `doctor_id`, `hospital_id`, `diagnosis`, `notes`, `is_active`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
(1, 4, 3, 1, 'Chronic Management', 'Take meds regularly as discussed.', 1, '2026-06-01', NULL, '2026-06-01 15:35:44', '2026-06-01 15:35:44');

-- --------------------------------------------------------

--
-- Table structure for table `prescription_medications`
--

CREATE TABLE `prescription_medications` (
  `id` int(11) NOT NULL,
  `prescription_id` int(11) NOT NULL,
  `medication_id` int(11) NOT NULL,
  `dosage` varchar(100) NOT NULL,
  `frequency` varchar(100) NOT NULL,
  `times_of_day` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`times_of_day`)),
  `with_food` tinyint(1) DEFAULT 0,
  `with_water` tinyint(1) DEFAULT 1,
  `special_instructions` text DEFAULT NULL,
  `duration_days` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `prescription_medications`
--

INSERT INTO `prescription_medications` (`id`, `prescription_id`, `medication_id`, `dosage`, `frequency`, `times_of_day`, `with_food`, `with_water`, `special_instructions`, `duration_days`, `created_at`) VALUES
(1, 1, 1, '500mg', 'Twice daily', '[\"08:00\", \"20:00\"]', 1, 1, NULL, NULL, '2026-06-01 15:35:44'),
(2, 1, 2, '10mg', 'Once daily', '[\"09:00\"]', 0, 1, NULL, NULL, '2026-06-01 15:35:44');

-- --------------------------------------------------------

--
-- Table structure for table `refresh_tokens`
--

CREATE TABLE `refresh_tokens` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(512) NOT NULL,
  `expires_at` datetime NOT NULL,
  `revoked` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `refresh_tokens`
--

INSERT INTO `refresh_tokens` (`id`, `user_id`, `token`, `expires_at`, `revoked`, `created_at`) VALUES
(1, 4, 'mock_token_for_testing_ Jane', '2026-07-01 15:35:44', 1, '2026-06-01 15:35:44'),
(2, 1, '2a59081a957e2bb4559e77a78571df6294b5d8b720c635ecc4b51983b1caa80a', '2026-07-02 07:46:29', 1, '2026-06-02 03:46:29'),
(3, 1, 'b683f91b374ae7879bf50b54dead596c7ce8cec289221311b9e02aba526ca23f', '2026-07-04 12:19:03', 1, '2026-06-04 08:19:03'),
(4, 1, '5937a026562384c1735d5e803aa0c5ca7b2a8329e1b3d5c3c427d9464111720f', '2026-07-04 12:19:40', 1, '2026-06-04 08:19:40'),
(5, 1, 'f4fb30ab09f26f87e837bd60246912ebafb2a3248be81b1dff52643d890fedca', '2026-07-04 12:21:58', 0, '2026-06-04 08:21:58'),
(6, 1, '17cb6ae5537bdb260fe4888bbb127c4f9f5d51207dbb5170646d01bdc1700408', '2026-07-05 02:31:14', 0, '2026-06-04 22:31:14'),
(7, 1, 'bc50162710ddf98c9ca825b1efbbfcd8cd808a8f8050feff5b80f3a590d653c3', '2026-07-05 05:11:14', 0, '2026-06-05 01:11:14'),
(8, 1, '799112cd6c99843a959bcfe3dac395c475d27c30d9312fc565bf953b8f5a3646', '2026-07-05 07:08:32', 0, '2026-06-05 03:08:32'),
(9, 1, 'b026de9bf25553b3ed62a50d73a1dc4a944a1deb0c3ddca60270ae08b4441672', '2026-07-05 07:08:43', 0, '2026-06-05 03:08:43'),
(10, 1, 'ec7a45cd606d1740aca0f8b4e9a965ce1bb6f623ea4fd4e876d4111ab1182f9f', '2026-07-05 07:09:18', 0, '2026-06-05 03:09:18'),
(11, 1, '4b6c965a3740f099a2c8f5ee345964473be9733c2f604e821259f201fb60ae84', '2026-07-05 15:52:14', 0, '2026-06-05 11:52:14'),
(13, 1, 'aa5606106315a8b1ef5e9fe548806d6a022fa6967f913def126ec72500a47379', '2026-07-05 16:18:00', 0, '2026-06-05 12:18:00'),
(14, 1, 'eaef19b0ab17a86e8954dd9a4c7d0ba508c36c40a0993385c09abd639da5598b', '2026-07-06 05:43:06', 0, '2026-06-06 01:43:06'),
(15, 1, '77191aed4225698b620c3beedeb4326d20bdf7dcb7ffd4a07b3151b5150e1014', '2026-07-06 05:43:09', 0, '2026-06-06 01:43:09'),
(16, 1, '2545594616ef4b85f0d4589885e74a18b9b397e55e182e4ed542952ab380782b', '2026-07-06 05:43:23', 0, '2026-06-06 01:43:23'),
(17, 1, '1067c191f52a2b038672696f408696cceb5409e913cbb7229f4a257ccd4d80f4', '2026-07-06 05:44:47', 0, '2026-06-06 01:44:47'),
(18, 1, '7d5ff36cf5d6f50cd3ea4c54b64b09e6029a020612dba1d64f004718ee5d3ab2', '2026-07-06 05:44:59', 0, '2026-06-06 01:44:59'),
(19, 1, 'a49d10f6dc72539cc19c93ec8d04086c5fb0c0b4b8b833aa3f752b034b8f4e4c', '2026-07-06 06:54:06', 0, '2026-06-06 02:54:06'),
(20, 2, '14e010e1166ecf9eaee4cb8b4ca75735895d2d6d6b1d9a8cfef626aed89e4dde', '2026-07-06 06:56:32', 0, '2026-06-06 02:56:32'),
(21, 3, '7608f52c42c198ad59ee03285c62251f9c553286b0dbb9f5ed8bfda19ab3b858', '2026-07-06 07:09:33', 0, '2026-06-06 03:09:33'),
(22, 4, 'fb42cf65781f7c49e09ab96449f84cf77a464063d283b267518f0e1ecfbf22a3', '2026-07-06 07:11:42', 0, '2026-06-06 03:11:42'),
(23, 1, '47686aa5f625ee4f7ca718b185ddac9da52dd7cc7363115890b517273b5987c2', '2026-07-06 07:25:10', 0, '2026-06-06 03:25:10'),
(24, 1, '2881c718a790401c133eeaf30d64b22a39f52329afbf8507bcbad5fe7d73f42a', '2026-07-06 13:18:24', 0, '2026-06-06 09:18:24'),
(25, 1, '274e9965cbc08d80ac632430ea7c63dc35c152105e65dcba6f8b5999ffd3ab04', '2026-07-06 13:45:31', 0, '2026-06-06 09:45:31'),
(26, 1, '2ca02b5e30fc680d651dc957b81d63336bb27a848e67b1d706aa9b6b907a3b07', '2026-07-06 14:57:41', 0, '2026-06-06 10:57:41'),
(27, 1, '0a4d3fcf008301bc1bb63ca7e75fb1c5efa7900cac683a7748e50a48cd67e22c', '2026-07-06 15:54:50', 0, '2026-06-06 11:54:50'),
(28, 1, '149754473a0575e4436a11abccd8db57e305d7fb7b8d67b1f128cade3369a53d', '2026-07-06 15:58:51', 0, '2026-06-06 11:58:51'),
(29, 1, 'c6e3fb08b56b8f5b7316ec8fce7b799a38b2c1b47813b59464cffc69eca14e7c', '2026-07-06 16:30:06', 0, '2026-06-06 12:30:06'),
(30, 1, 'd001a7d85e1ede40a4adf9b3cb21a048b6c059cddab022c61e963d0ca03a3d98', '2026-07-06 16:31:16', 0, '2026-06-06 12:31:16'),
(31, 1, '0da77d20b5af8b4045cf247a1258bc9f8d1279a469b5a7ab842e9cd42dfd0b2c', '2026-07-06 18:05:36', 0, '2026-06-06 14:05:36'),
(32, 4, '86d3254052d074fd4109ba7a170277ec8cda04db3bd2820ba5d33e7233b3736e', '2026-07-06 18:06:37', 0, '2026-06-06 14:06:37'),
(33, 4, '21aab29a269f538d080e56709bc7c9562e0c10b402893ce2cc6a20200759e30b', '2026-07-06 18:41:31', 0, '2026-06-06 14:41:31'),
(34, 1, '47e540339c68adefd822243540d0444cfc0cf05d3cb210d35eaaaacc678dce8f', '2026-07-07 06:05:00', 0, '2026-06-07 02:05:00'),
(35, 2, 'b4a50a63a4d75e48a08caebe8d1c21c3efc05845e84a2b3a735a7fbcc29ca2d0', '2026-07-07 06:07:36', 0, '2026-06-07 02:07:36'),
(36, 2, '7a0e7601d978c35259b41d8e5fbe5eb7036ab7f10187bc98b5ad458ae5b8c340', '2026-07-07 06:51:09', 0, '2026-06-07 02:51:09'),
(37, 2, '766491b08b8ab6c75b10d4106f7d2ffc98c8f484e32f1b60e92bd6f8e465b4bc', '2026-07-07 07:16:25', 0, '2026-06-07 03:16:25'),
(38, 4, '3f685b318d2a3b0983618becbc8b986c7e1bcc56ecfa5c30bd533cc0460d7ff9', '2026-07-07 07:17:39', 0, '2026-06-07 03:17:39'),
(39, 4, 'd95e70204e123cd84442507d86796d19511abadb51249ed45e567b2b6adee8d7', '2026-07-07 07:18:59', 0, '2026-06-07 03:18:59'),
(40, 1, '86350257069cd1442afa90e06c68c889282050f435247cd622f646c73e3ad5e4', '2026-07-07 07:22:38', 0, '2026-06-07 03:22:38'),
(41, 1, '5ed45f0c1a241bfba65b66624a2caf591d5b928825385cfdca95e9825e501690', '2026-07-07 07:44:16', 0, '2026-06-07 03:44:16'),
(42, 1, '68fabba9de2ebe653b7d8fefec35704df7af7154c5d5dc0757f08f68d92e237d', '2026-07-07 08:00:52', 0, '2026-06-07 04:00:52'),
(43, 1, 'ef4ee46c8e29caef57bd2c4fa4bcd5c2660fac2875e58f1f400678de5c93652e', '2026-07-07 08:07:57', 0, '2026-06-07 04:07:57'),
(44, 1, 'c27a8f58ab7655418b011090128fb485f43098cd8cc649448144b11a24553b65', '2026-07-07 08:15:43', 0, '2026-06-07 04:15:43'),
(45, 2, '890784344a032f235de7094ecdf764b5fb6e6bb3cca576dfcbac4bfb380a8f46', '2026-07-08 06:52:56', 0, '2026-06-08 02:52:56'),
(46, 1, 'd6c44b7dd585a1873054221a72ff977e707c9f970786ad03b2407ca185479a7c', '2026-07-08 07:00:59', 0, '2026-06-08 03:00:59'),
(47, 1, '870e9e178b80e16f86a66692a21e43126547b9879beec090d62dfc093cd21c75', '2026-07-08 07:25:07', 0, '2026-06-08 03:25:07'),
(48, 1, 'ae184fbeb4f4565050d62ef72846a26c93492829ed13eb0cdd4f91c8651023b2', '2026-07-08 08:51:02', 0, '2026-06-08 04:51:02'),
(49, 2, '25a818fe2ab919e45fcef63703f07cc47a05bdb043a18724648f2240143194c4', '2026-07-08 08:52:20', 0, '2026-06-08 04:52:20'),
(50, 1, '4c0015762bcf545c8aca0a627447229f0972fc4ba089a117d0df7373e94dc621', '2026-07-08 09:22:01', 0, '2026-06-08 05:22:01'),
(51, 1, '9cb8c3569e370568a0a39dfe347c79fd16882783b38ee89be6fcf9cef58a26b8', '2026-07-08 09:28:07', 0, '2026-06-08 05:28:07'),
(52, 1, '1624f528bd7ec54825064068411a5d5b06202ebc28eb502b66796a451effc0e0', '2026-07-08 09:35:10', 0, '2026-06-08 05:35:10'),
(53, 2, '1448d312659eacf486c87334d622a6e0ddc14817720c6fb50afe7acd05eab4f1', '2026-07-08 09:36:39', 0, '2026-06-08 05:36:39'),
(54, 2, '36d4b6c2e5d28fa9e7d624c29a0e46a5d1dcef54e026159d73dd1e2316f56f53', '2026-07-08 09:37:24', 0, '2026-06-08 05:37:24'),
(55, 1, 'e0b03dc3ceb40426af4106bf772004e44e49286257e96f178b03e2a51d644dd9', '2026-07-08 09:38:39', 0, '2026-06-08 05:38:39'),
(56, 1, '5e7ce1556759c5cfb574a67f633f91d9c9327df166838d179530d2f12a5b8a43', '2026-07-08 10:27:09', 0, '2026-06-08 06:27:09'),
(57, 1, '5e3d3c05fe9dfec5646b1271b851a7f12e426b7b4ffee3919cb49219c5e80211', '2026-07-08 10:52:32', 0, '2026-06-08 06:52:32'),
(58, 1, '7c833032b0e70871763194a872438b66154168eee493921beb5596776c65ca0c', '2026-07-08 10:54:15', 0, '2026-06-08 06:54:15'),
(59, 2, '8e6abf71f93c4ea5a892418b419409fdca5984a91bb56aebff0a2d192916ec17', '2026-07-08 10:55:14', 0, '2026-06-08 06:55:14'),
(60, 1, 'abdffec63fed4cc4d09500ebd88159ad7dfed2f52859cc5c27a0d01b642c770e', '2026-07-08 10:58:52', 0, '2026-06-08 06:58:52'),
(61, 2, '63397f0d165953527b47306c8e702a0b201e28610cc7384d39d67589837dfc3f', '2026-07-08 10:59:41', 0, '2026-06-08 06:59:41'),
(62, 3, '8a85df92dcba8cfb0e16e3c5b51e55c9c6b48c1b6976edcea1e02c3ef688767a', '2026-07-08 11:01:17', 0, '2026-06-08 07:01:17'),
(63, 4, '14dcfbeebb3b2f12295068771f581ca266f1d36280d60d613ca22aab16866487', '2026-07-08 11:04:35', 0, '2026-06-08 07:04:35'),
(64, 4, '665908a44e698b7b02097d06a2331b9b133cb6d2afc9a818bf05620c097818aa', '2026-07-08 11:24:32', 0, '2026-06-08 07:24:32'),
(65, 4, 'c1b82775ef428324b9d6ae7693581aaa48d5e1c5d92af242bc546a35348028e9', '2026-07-08 11:43:24', 0, '2026-06-08 07:43:24'),
(66, 1, '0dfea53fb2b245a9e522e3ecc3c639b07c332e2d6b73d9af4f007ba67f7948b2', '2026-07-08 11:45:01', 0, '2026-06-08 07:45:01'),
(67, 2, 'fc9339896836b0ca6bf71d892ca979f92e3142183493eb5be7851894399cbc0e', '2026-07-08 11:46:46', 0, '2026-06-08 07:46:46'),
(68, 2, 'e6ae70fb852d606a21efa0c101b8bb783bdd1b8cc2b76056f240795f8b3a0185', '2026-07-08 12:02:31', 0, '2026-06-08 08:02:31'),
(69, 3, 'b9dc5b785d411520b2b7d7a99ef821f259afa556c4f037cd5d9445e6c63b87a6', '2026-07-08 12:04:26', 0, '2026-06-08 08:04:26'),
(70, 4, 'a868619f3a7b3bc1bb9c9c207b1db4d6fee67e0fe4ad331a6413ce8812b44aa9', '2026-07-08 12:07:42', 0, '2026-06-08 08:07:42'),
(71, 4, '7d272d473b308047c0df5a7a2cbe8f5074700833cf64fd3f45c83ef43d4af164', '2026-07-08 12:23:07', 0, '2026-06-08 08:23:07'),
(72, 3, '0d7ce83870e65f99bf356d7f5ddc30cbc31a354b8ab0345a97a7bc1678218a1a', '2026-07-08 12:29:48', 0, '2026-06-08 08:29:48'),
(73, 3, '10e193a2e32742fe155e771a9123422327d872008c1cf4d2e1c02771e383d781', '2026-07-08 13:42:45', 0, '2026-06-08 09:42:45'),
(74, 3, '8a3a4ff2c9ebc56e752e60c170f1bf4ef30a32e793f2656ca09dacbccd600967', '2026-07-09 11:33:27', 0, '2026-06-09 07:33:27'),
(75, 1, 'ddb48552d482ce2cc3134698b24470bbd390bf45a10c237e11f03758a91c228b', '2026-07-09 11:37:57', 0, '2026-06-09 07:37:57'),
(76, 2, '5b0060990139be0da512eab38723aeb44c8f45754f6e06703f1df4d6b6555293', '2026-07-09 11:40:59', 0, '2026-06-09 07:40:59'),
(77, 2, '85ecc33036832d9a310a0582f8be9a781d9056827da1b9e52018a6d9e4607564', '2026-07-09 12:26:41', 0, '2026-06-09 08:26:41'),
(78, 2, 'f659d2ec4f6b50100f153814f79306e74a52683adcb5b05222e0457819f331b2', '2026-07-09 12:49:09', 0, '2026-06-09 08:49:09'),
(79, 3, '36b9ef4f3e0acea33f9c081266a38e8b71f0d211825ad423a0d08fd4e8ac9c72', '2026-07-09 13:25:45', 0, '2026-06-09 09:25:45'),
(80, 4, 'ed7c404b1a17c752ffd9f764706afe608147f4875298e3095c240ad72ad0dc36', '2026-07-09 13:27:14', 0, '2026-06-09 09:27:14'),
(81, 3, '84ee8ca48c624f9288c8558bc5ee1bad43961dfba879f132a1745227575b33c3', '2026-07-09 13:34:02', 0, '2026-06-09 09:34:02'),
(82, 2, '762e2b18f067728708e30b18d67ebe4ea98297f5090050c5f164186bab28c387', '2026-07-09 13:37:48', 0, '2026-06-09 09:37:48'),
(83, 2, '1ad3ef54461102bfe02a39e45a4fc86286accb6ed577a2d6d2eff380b265b228', '2026-07-09 13:58:59', 0, '2026-06-09 09:58:59'),
(84, 2, '4abf4493cbfba7d7e14102adc1d1ffa0450438749c0d224660275259de0ea99e', '2026-07-10 06:05:12', 0, '2026-06-10 02:05:12'),
(85, 3, '80fd1a8919fa9c9ad2a1c9bd8409cf73af2cb4714145482ff9b5b829f26b75fc', '2026-07-10 06:06:09', 0, '2026-06-10 02:06:09'),
(86, 3, 'dd6ad29aa51de08d7cba27e73fbfb2cb38802f1871988bf69d32493639f08e2e', '2026-07-10 17:27:05', 0, '2026-06-10 13:27:05'),
(87, 2, 'e18d3903851bb97fc49d04073bd649ab1e861486808e3b71c34035372acc5c5d', '2026-07-10 17:28:53', 0, '2026-06-10 13:28:53'),
(88, 1, '70cfade4a35c8f5551b9337464eff248caf11ab83decbfb82724650531a9c07b', '2026-07-10 17:35:22', 0, '2026-06-10 13:35:22'),
(89, 4, 'bfaaa5a8a5d4c74ccb9b1c5f8b2c7c5499267eb2f05fcb6499833e7a2d4fa5a8', '2026-07-10 17:41:06', 0, '2026-06-10 13:41:06'),
(90, 4, '8b22f39e4874153a5bb7f284183a5c355bbfc713a34c17cd03ff24df4a6f1cb4', '2026-07-10 17:45:00', 0, '2026-06-10 13:45:00'),
(91, 3, '3d79526adfbc7d3dcd9f3c2be83e8079ede0ce2700f9c619b7201b8e09374360', '2026-07-10 17:50:41', 0, '2026-06-10 13:50:41'),
(92, 2, '5cfcee539569aa27e3959d3afddc98785eb1b558e7ef54d679b3a0027755e69b', '2026-07-10 17:56:08', 0, '2026-06-10 13:56:08'),
(93, 1, '4f1f5a523e7b945f1c2b3ba8352e95cb165c460aeaf49c63932d20b38d518305', '2026-07-10 17:58:41', 0, '2026-06-10 13:58:41'),
(94, 2, '5b5357ef104171014ebeb022c62da010418d3195aa964f1c20acd9d06ba690c2', '2026-07-10 18:04:10', 0, '2026-06-10 14:04:10'),
(95, 3, '5326a0942a3aa4f989452a23312516ea4da43cfda36d104b7d471c443bcc7149', '2026-07-10 18:06:25', 0, '2026-06-10 14:06:25'),
(96, 1, 'd609d8d5e06c988fd2215ca3f2ea288e1c19de65381a66bdb51b2adf48297b11', '2026-07-10 18:11:00', 0, '2026-06-10 14:11:00'),
(97, 2, 'e80d18bb5986b2a9e3259aab60468e57f1c3f48117b72dcfa93cac0bee132f1e', '2026-07-10 18:13:48', 0, '2026-06-10 14:13:48'),
(98, 6, 'f35152a60fff6c4a0f24179cc121409a822b4a977acde13e92468191d821e3b4', '2026-07-10 18:19:01', 0, '2026-06-10 14:19:01'),
(99, 3, '590762374d54b3ec0ffaa82890a143473eded802ebb8eb91df80f3809452268f', '2026-07-10 18:20:36', 0, '2026-06-10 14:20:36'),
(100, 4, 'd9341e3f91ba21ac7b87c04b5f71c43bb8477d5ea5f4854f9178efa012ae3283', '2026-07-10 18:24:27', 0, '2026-06-10 14:24:27'),
(101, 3, '6821ca971785e9cec98b2fd94a27a071e62632e7f2cc21d23324a77d2e591b79', '2026-07-10 18:26:24', 0, '2026-06-10 14:26:24'),
(102, 3, 'ece9f5bc067ff23da55bada7b83f34c2b063bf67b8938aaf68fe24e7c6e40498', '2026-07-10 18:41:33', 0, '2026-06-10 14:41:33'),
(103, 3, '85eb85593a439bffff9251a30c240dd7da23edd7ddf0ea36b560b3edabbbb4cd', '2026-07-10 18:57:42', 0, '2026-06-10 14:57:42'),
(104, 4, '1116f5b3c0bc140cb1bf9ae48ff6d07e316f5dffc2a35500c50a9efbe581f83a', '2026-07-10 18:59:34', 0, '2026-06-10 14:59:34'),
(105, 2, '4a106c73d4352ad6d987047d2d1eb616141fad26bae618b6567c48e574a16c86', '2026-07-10 19:02:13', 0, '2026-06-10 15:02:13'),
(106, 3, 'eb57db86e0dbadacbc357a07786348a3ca05c9ce1de58b3241d54329f140aa7d', '2026-07-10 19:03:11', 0, '2026-06-10 15:03:11'),
(107, 4, '57b42022ab5620129d3241af6368007906fcbc38fe9aeff46d29c73666e10ffa', '2026-07-10 19:05:55', 0, '2026-06-10 15:05:55');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'super_admin'),
(2, 'hospital_admin'),
(3, 'doctor'),
(4, 'patient');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `hospital_id` int(11) DEFAULT NULL,
  `full_name` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  `onesignal_player_id` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `emergency_contact` varchar(200) DEFAULT NULL,
  `diagnosis` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `last_login` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `hospital_id`, `full_name`, `email`, `password`, `phone`, `avatar_url`, `onesignal_player_id`, `date_of_birth`, `gender`, `emergency_contact`, `diagnosis`, `is_active`, `last_login`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 'System Admin', 'admin@meditrack.app', '$2y$12$/QIX3r1zUsh0uUGvlIkUZO5U63MzXus2o7X5CD1eclo3NwlSsR4au', '', NULL, NULL, NULL, 'male', '070316376', NULL, 1, '2026-06-10 14:11:00', '2026-06-01 15:35:44', '2026-06-10 14:11:00'),
(2, 2, 1, 'Sarah Admin', 'hadmin@meditrack.app', '$2y$12$SaJezxIZhoWBuHgOaHseB.I.88s4/GWad7vHRQKF5vojoXrygiteu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2026-06-10 15:02:13', '2026-06-01 15:35:44', '2026-06-10 15:02:13'),
(3, 3, 1, 'Dr. John Doe', 'doctor@meditrack.app', '$2y$12$4oWSpEpASRFqXKUaHXGNWuYP/KfYG1Tmc6AhLpx4XWa4s2EhvE4mW', '+256 700 111222', NULL, NULL, NULL, 'male', '0787889898', NULL, 1, '2026-06-10 15:03:11', '2026-06-01 15:35:44', '2026-06-10 15:03:11'),
(4, 4, 1, 'Jane Patient', 'patient@meditrack.app', '$2y$12$OmvXKFbMsNhC0/fCE8GY7.tpJd7n.0mb5iOi2mIfDdi3LAr5v.5Ze', '+256 755 333446', NULL, NULL, '1990-05-15', 'female', '', 'Hypertension & Type 2 Diabetes', 1, '2026-06-10 15:05:55', '2026-06-01 15:35:44', '2026-06-10 15:05:55'),
(5, 4, 2, 'nobs is coding', 'nobs@meditrack.app', '$2y$12$v/HhviKZqKXG6cFL3ZU5uufMQphBc1f7ch6P4gGynmOzfQb/Ghoh2', '', NULL, NULL, NULL, NULL, '', 'nothing', 1, NULL, '2026-06-10 13:30:14', '2026-06-10 14:10:15'),
(6, 3, 1, 'nobs doctor', 'doctornobs@meditrack.app', '$2y$12$imBIKGJENcvnx62013uTXu7Ii9qx/KGNUEoqkYmsqAU9ni9ved6Tm', '', NULL, NULL, NULL, NULL, '', '', 1, '2026-06-10 14:19:01', '2026-06-10 14:14:38', '2026-06-10 14:19:01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adherence_logs`
--
ALTER TABLE `adherence_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_patient_date` (`patient_id`,`log_date`);

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `doctor_id` (`doctor_id`),
  ADD KEY `hospital_id` (`hospital_id`);

--
-- Indexes for table `doctor_patient_assignments`
--
ALTER TABLE `doctor_patient_assignments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_assignment` (`doctor_id`,`patient_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `hospital_id` (`hospital_id`);

--
-- Indexes for table `hospitals`
--
ALTER TABLE `hospitals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lifestyle_advice`
--
ALTER TABLE `lifestyle_advice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `prescription_id` (`prescription_id`);

--
-- Indexes for table `medications`
--
ALTER TABLE `medications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hospital_id` (`hospital_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `medication_schedules`
--
ALTER TABLE `medication_schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `prescription_medication_id` (`prescription_medication_id`),
  ADD KEY `idx_patient_scheduled` (`patient_id`,`scheduled_time`),
  ADD KEY `idx_status_scheduled` (`status`,`scheduled_time`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `idx_recipient_read` (`recipient_id`,`is_read`);

--
-- Indexes for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `doctor_id` (`doctor_id`),
  ADD KEY `hospital_id` (`hospital_id`);

--
-- Indexes for table `prescription_medications`
--
ALTER TABLE `prescription_medications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `prescription_id` (`prescription_id`),
  ADD KEY `medication_id` (`medication_id`);

--
-- Indexes for table `refresh_tokens`
--
ALTER TABLE `refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `hospital_id` (`hospital_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `adherence_logs`
--
ALTER TABLE `adherence_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `doctor_patient_assignments`
--
ALTER TABLE `doctor_patient_assignments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `hospitals`
--
ALTER TABLE `hospitals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `lifestyle_advice`
--
ALTER TABLE `lifestyle_advice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `medications`
--
ALTER TABLE `medications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `medication_schedules`
--
ALTER TABLE `medication_schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `prescriptions`
--
ALTER TABLE `prescriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `prescription_medications`
--
ALTER TABLE `prescription_medications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `refresh_tokens`
--
ALTER TABLE `refresh_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
