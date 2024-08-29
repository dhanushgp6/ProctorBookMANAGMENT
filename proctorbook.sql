-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 22, 2024 at 06:44 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `proctorbook`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `enroll_id` int(11) NOT NULL,
  `ia1_at` float DEFAULT NULL,
  `ia2_at` float DEFAULT NULL,
  `ia3_at` float DEFAULT NULL,
  `total_at` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`enroll_id`, `ia1_at`, `ia2_at`, `ia3_at`, `total_at`) VALUES
(61, 48, 63, 77, 62.6667),
(62, 94, 66, 100, 86.6667),
(63, 73, 62, 31, 55.3333),
(64, 0, 0, 0, 0),
(65, 0, 0, 0, 0),
(66, 0, 0, 0, 0),
(73, 0, 0, 0, 0),
(74, 0, 0, 0, 0),
(75, 0, 0, 0, 0),
(76, 0, 0, 0, 0),
(77, 0, 0, 0, 0),
(78, 67, 75, 88, 76.6667),
(79, 66, 44, 88, 66),
(80, 0, 0, 0, 0),
(81, 0, 0, 0, 0),
(82, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE `branch` (
  `branch_id` int(11) NOT NULL,
  `branch_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`branch_id`, `branch_name`) VALUES
(1, 'Computer Science Engineering'),
(2, 'Electronics & Communication Engineering'),
(3, 'Civil Engineering'),
(4, 'Mechanical Engineering'),
(5, 'Artificial Intelligence & Data Science');

-- --------------------------------------------------------

--
-- Table structure for table `enrollment`
--

CREATE TABLE `enrollment` (
  `enroll_id` int(11) NOT NULL,
  `s_usn` varchar(10) NOT NULL,
  `sub_id` varchar(11) NOT NULL,
  `sem_no` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enrollment`
--

INSERT INTO `enrollment` (`enroll_id`, `s_usn`, `sub_id`, `sem_no`) VALUES
(61, '1KG21CS008', '21CS51', 5),
(62, '1KG21CS008', '21CS52', 5),
(63, '1KG21CS008', '21CS53', 5),
(64, '1KG21CS004', '21CS51', 5),
(65, '1KG21CS004', '21CS52', 5),
(66, '1KG21CS004', '21CS53', 5),
(73, '1KG21CS031', '21CS51', 5),
(74, '1KG21CS031', '21CS52', 5),
(75, '1KG21CS031', '21CS53', 5),
(76, '1KG21ME024', '21ME32', 5),
(77, '1KG21ME024', '21ME52', 5),
(78, '1KG21ME025', '21ME32', 5),
(79, '1KG21ME025', '21ME52', 5),
(80, '1KG21CS010', '21CS51', 5),
(81, '1KG21CS010', '21CS52', 5),
(82, '1KG21CS010', '21CS53', 5);

--
-- Triggers `enrollment`
--
DELIMITER $$
CREATE TRIGGER `enroll_marks_attend` BEFORE DELETE ON `enrollment` FOR EACH ROW BEGIN
	DELETE FROM marks
	WHERE marks.enroll_id=OLD.enroll_id;
	DELETE FROM attendance
	WHERE attendance.enroll_id=OLD.enroll_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `enrollment_repetition` BEFORE INSERT ON `enrollment` FOR EACH ROW BEGIN
DECLARE result INT;
SELECT COUNT(*) INTO result
FROM enrollment
WHERE s_usn = NEW.s_usn AND sub_id = NEW.sub_id;

IF result > 0 THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Enrollment already exists for this student and subject.';
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `marks`
--

CREATE TABLE `marks` (
  `enroll_id` int(11) NOT NULL,
  `ia1_marks` float DEFAULT NULL,
  `ia2_marks` float DEFAULT NULL,
  `ia3_marks` float DEFAULT NULL,
  `int_marks` float DEFAULT NULL,
  `ext_marks` float DEFAULT NULL,
  `final_marks` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `marks`
--

INSERT INTO `marks` (`enroll_id`, `ia1_marks`, `ia2_marks`, `ia3_marks`, `int_marks`, `ext_marks`, `final_marks`) VALUES
(61, 20, 18, 17, 50, 44, 94),
(62, 14, 25, 30, 50, 40, 90),
(63, 20, 13, 18, 15, 34, 49),
(64, NULL, NULL, NULL, NULL, NULL, NULL),
(65, NULL, NULL, NULL, NULL, NULL, NULL),
(66, NULL, NULL, NULL, NULL, NULL, NULL),
(73, NULL, NULL, NULL, NULL, NULL, NULL),
(74, NULL, NULL, NULL, NULL, NULL, NULL),
(75, NULL, NULL, NULL, NULL, NULL, NULL),
(76, NULL, NULL, NULL, NULL, NULL, NULL),
(77, NULL, NULL, NULL, NULL, NULL, NULL),
(78, NULL, NULL, NULL, NULL, NULL, NULL),
(79, NULL, NULL, NULL, NULL, NULL, NULL),
(80, NULL, NULL, NULL, NULL, NULL, NULL),
(81, NULL, NULL, NULL, NULL, NULL, NULL),
(82, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `proctor`
--

CREATE TABLE `proctor` (
  `proct_id` int(11) NOT NULL,
  `proct_name` varchar(30) NOT NULL,
  `proct_branch` int(11) NOT NULL,
  `proct_desig` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proctor`
--

INSERT INTO `proctor` (`proct_id`, `proct_name`, `proct_branch`, `proct_desig`) VALUES
(1, 'kavitha', 1, 'asst proffesor'),
(2, 'Nita', 1, 'asst proffesor'),
(3, 'neela', 4, 'asst proffesor'),
(4, 'abhishek', 1, 'asst proffesor');

-- --------------------------------------------------------

--
-- Table structure for table `schemes`
--

CREATE TABLE `schemes` (
  `scheme_no` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schemes`
--

INSERT INTO `schemes` (`scheme_no`) VALUES
(2018),
(2020),
(2021);

-- --------------------------------------------------------

--
-- Table structure for table `sem`
--

CREATE TABLE `sem` (
  `sem_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sem`
--

INSERT INTO `sem` (`sem_id`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_usn` varchar(10) NOT NULL,
  `s_fname` varchar(30) NOT NULL,
  `s_mname` varchar(10) DEFAULT NULL,
  `s_lname` varchar(20) NOT NULL,
  `s_dob` date NOT NULL,
  `s_address` varchar(50) NOT NULL,
  `s_email` varchar(20) NOT NULL,
  `s_pno` char(10) NOT NULL,
  `s_gender` char(1) DEFAULT NULL,
  `s_fathername` varchar(20) DEFAULT NULL,
  `s_mothername` varchar(20) DEFAULT NULL,
  `s_guardian` varchar(20) DEFAULT NULL,
  `s_parentno` char(10) NOT NULL,
  `s_proct_id` int(11) NOT NULL,
  `s_branchid` int(11) NOT NULL,
  `s_semid` int(11) NOT NULL,
  `scheme_no` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_usn`, `s_fname`, `s_mname`, `s_lname`, `s_dob`, `s_address`, `s_email`, `s_pno`, `s_gender`, `s_fathername`, `s_mothername`, `s_guardian`, `s_parentno`, `s_proct_id`, `s_branchid`, `s_semid`, `scheme_no`) VALUES
('1KG21CS004', 'ABHISHEK ', '', 'V', '2003-08-25', 'ISRO layout', 'sjv@gmail.com', '9112436729', 'M', 'sai', 'sumita', '', '7645345986', 2, 1, 5, 2021),
('1KG21CS008', 'Amith ', 'C', 'suri', '2003-12-27', '#63 cubbonpete main road Bangalore-560002', 'amithsuri818@gmail.c', '9148832783', 'M', 'Chakrapani S', 'Usha N', '', '7353818181', 1, 1, 5, 2021),
('1KG21CS010', 'Ankitha', '', 'L', '2003-02-12', 'shantinagar bangalore', 'ankitha@gmail.com', '928272637', 'F', 'arnav', 'aalia', '', '7362526377', 1, 1, 5, 2021),
('1KG21CS031', 'dhanush ', '', 'GP', '2003-03-12', 'kathriguppe cross bangalore', 'gp@gmail.com', '9128273647', 'M', 'g prakash', 'kalki', '', '4645545674', 2, 1, 5, 2021),
('1KG21ME024', 'Sathish', '', 'S', '2003-06-22', 'Kamalanagar bangalore', 'satish@gmail.com', '7865456786', 'M', 'sharma', 'sita', '', '7463736475', 3, 4, 5, 2021),
('1KG21ME025', 'mythri', '', 'M', '2003-03-31', 'maruthu nagar bangalore', 'mythri@gmail.com', '5463456872', 'F', 'james', 'augustine', '', '4543235643', 3, 4, 5, 2021);

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `subject_id` varchar(11) NOT NULL,
  `subject_name` varchar(30) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `sub_semid` int(11) NOT NULL,
  `scheme` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subject`
--

INSERT INTO `subject` (`subject_id`, `subject_name`, `branch_id`, `sub_semid`, `scheme`) VALUES
('21CS51', 'automata theory', 1, 5, 2021),
('21CS52', 'computer networks', 1, 5, 2021),
('21CS53', 'Database management system', 1, 5, 2021),
('21ME32', 'thermodynamics', 4, 5, 2021),
('21ME52', 'String theory', 4, 5, 2021);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_name` varchar(100) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_password` varchar(1000) NOT NULL,
  `user_type` char(1) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_name`, `user_email`, `user_password`, `user_type`, `user_id`) VALUES
('amith', 'amithsuri818@gmail.com', 'scrypt:32768:8:1$FfsRfHnBuOMK4GR6$a20448d4013c41fc84fffae9e7befbdbf3933e6b88c52ada5ef2312597ed29c1e8e2a2919670e8b1f4ca93808a2e7509dfca8fb6a6db3f5a33b05e43d4002436', 'p', 23),
('am', 'laazyguy9916@gmail.com', 'scrypt:32768:8:1$gDDEGENGSAFzA9eA$42cf0038dccaaea49c9bbe29d27186d6b7e099bff7247564641ea506e06200c35e3afec5c1f0b813a147ccba88cd9ba9d486b1b175047a1384f7d629fa269a01', 's', 25),
('surya', 'monotrem333@gmail.com', 'scrypt:32768:8:1$xSNvPOmhKGhaz5Hm$98cc65148be92a7ed2c61796d69da7ce818318929c50bfbcc48f0d6b0e619f116d4560fa6a9f5dfb135494dae8dd1d53ccbdb7046568c62be5038d4b69bd456d', 'p', 26),
('nita', 'nita@gmail.com', 'scrypt:32768:8:1$2bQP0C2g2K7nbXds$d06342776167edfd63b4ed9cd45f9e2cf2fb73c4512f17c347eb254ea310827be082bc37600b1afde1d7a16ddc8ac14435787be807f33494923c8fb14952675a', 'p', 29),
('mouse', 'mouse@gmail.com', 'scrypt:32768:8:1$8VRdiUlvWwM63RVT$f452cc1e4288bc1ed552d39c7547ffbb930348ba0eb8cd0f49f710e226bf9ee2718ae552b285f36439a86b021901045212371152f01cd6b5c9ed7ec3a7f3c964', 'p', 30);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`enroll_id`);

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`branch_id`);

--
-- Indexes for table `enrollment`
--
ALTER TABLE `enrollment`
  ADD PRIMARY KEY (`enroll_id`),
  ADD KEY `enroll_usn` (`s_usn`),
  ADD KEY `enroll_sem` (`sem_no`),
  ADD KEY `enroll_sub` (`sub_id`);

--
-- Indexes for table `marks`
--
ALTER TABLE `marks`
  ADD PRIMARY KEY (`enroll_id`);

--
-- Indexes for table `proctor`
--
ALTER TABLE `proctor`
  ADD PRIMARY KEY (`proct_id`),
  ADD KEY `proctor_branch` (`proct_branch`);

--
-- Indexes for table `schemes`
--
ALTER TABLE `schemes`
  ADD PRIMARY KEY (`scheme_no`);

--
-- Indexes for table `sem`
--
ALTER TABLE `sem`
  ADD PRIMARY KEY (`sem_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_usn`),
  ADD KEY `student_proct` (`s_proct_id`),
  ADD KEY `student_branch` (`s_branchid`),
  ADD KEY `student_sem` (`s_semid`),
  ADD KEY `student_scheme` (`scheme_no`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`subject_id`),
  ADD KEY `branch_subject` (`branch_id`),
  ADD KEY `subject_sem` (`sub_semid`),
  ADD KEY `sub_scheme` (`scheme`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `enrollment`
--
ALTER TABLE `enrollment`
  MODIFY `enroll_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attend_enroll` FOREIGN KEY (`enroll_id`) REFERENCES `enrollment` (`enroll_id`);

--
-- Constraints for table `enrollment`
--
ALTER TABLE `enrollment`
  ADD CONSTRAINT `enroll_sem` FOREIGN KEY (`sem_no`) REFERENCES `sem` (`sem_id`),
  ADD CONSTRAINT `enroll_sub` FOREIGN KEY (`sub_id`) REFERENCES `subject` (`subject_id`),
  ADD CONSTRAINT `enroll_usn` FOREIGN KEY (`s_usn`) REFERENCES `students` (`student_usn`);

--
-- Constraints for table `proctor`
--
ALTER TABLE `proctor`
  ADD CONSTRAINT `proctor_branch` FOREIGN KEY (`proct_branch`) REFERENCES `branch` (`branch_id`);

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `student_branch` FOREIGN KEY (`s_branchid`) REFERENCES `branch` (`branch_id`),
  ADD CONSTRAINT `student_proct` FOREIGN KEY (`s_proct_id`) REFERENCES `proctor` (`proct_id`),
  ADD CONSTRAINT `student_scheme` FOREIGN KEY (`scheme_no`) REFERENCES `schemes` (`scheme_no`),
  ADD CONSTRAINT `student_sem` FOREIGN KEY (`s_semid`) REFERENCES `sem` (`sem_id`);

--
-- Constraints for table `subject`
--
ALTER TABLE `subject`
  ADD CONSTRAINT `branch_subject` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`),
  ADD CONSTRAINT `sub_scheme` FOREIGN KEY (`scheme`) REFERENCES `schemes` (`scheme_no`),
  ADD CONSTRAINT `subject_sem` FOREIGN KEY (`sub_semid`) REFERENCES `sem` (`sem_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
