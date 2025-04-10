-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 18, 2025 at 08:53 PM
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
-- Database: `events_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `location` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `event_type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `name`, `date`, `location`, `description`, `event_type`) VALUES
(1, 'London Tech Conference', '2025-05-20', 'London', 'An elite conference showcasing cutting-edge tech advancements.', 'Conference'),
(2, 'Manchester Night Bash', '2025-06-15', 'Manchester', 'A high-energy party with live music and DJs.', 'Party'),
(3, 'Oxford AI Workshop', '2025-07-10', 'Oxford', 'An interactive workshop exploring the latest in AI technology.', 'Workshop'),
(4, 'Hillary and Roy Grand Wedding', '2025-08-25', 'Cambridge', 'A beautiful wedding celebration in the heart of Cambridge.', 'Wedding'),
(5, 'Birmingham Festival Party', '2025-09-05', 'Birmingham', 'A lively festival featuring music, dance, and entertainment.', 'Party');

-- --------------------------------------------------------

--
-- Table structure for table `rsvps`
--

CREATE TABLE `rsvps` (
  `id` int(11) NOT NULL,
  `event_id` int(11) DEFAULT NULL,
  `user_name` varchar(100) NOT NULL,
  `status` enum('Attending','Not Attending') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rsvps`
--

INSERT INTO `rsvps` (`id`, `event_id`, `user_name`, `status`) VALUES
(1, 1, 'Alice Johnson', 'Attending'),
(2, 1, 'Tom Davies', 'Not Attending'),
(3, 2, 'Emily White', 'Attending'),
(4, 2, 'James Brown', 'Attending'),
(5, 3, 'Oliver Wilson', 'Attending'),
(6, 3, 'Sophia Green', 'Not Attending'),
(7, 4, 'Daniel Evans', 'Attending'),
(8, 4, 'Mia Clarke', 'Not Attending'),
(9, 5, 'Jack Thompson', 'Attending'),
(10, 5, 'Lily Hall', 'Attending'),
(11, 2, 'Bobby', 'Not Attending'),
(12, 2, 'John', 'Attending');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rsvps`
--
ALTER TABLE `rsvps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_id` (`event_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `rsvps`
--
ALTER TABLE `rsvps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `rsvps`
--
ALTER TABLE `rsvps`
  ADD CONSTRAINT `rsvps_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
