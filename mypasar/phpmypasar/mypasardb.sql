-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 22, 2021 at 07:48 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mypasardb`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_products`
--

CREATE TABLE `tbl_products` (
  `prid` int(5) NOT NULL,
  `pridowner` varchar(30) NOT NULL,
  `prname` varchar(50) NOT NULL,
  `prdesc` varchar(250) NOT NULL,
  `prprice` varchar(10) NOT NULL,
  `prqty` varchar(5) NOT NULL,
  `prdel` varchar(5) NOT NULL,
  `prstate` varchar(50) NOT NULL,
  `prloc` varchar(50) NOT NULL,
  `prlat` varchar(50) NOT NULL,
  `prlong` varchar(50) NOT NULL,
  `prdate` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_products`
--

INSERT INTO `tbl_products` (`prid`, `pridowner`, `prname`, `prdesc`, `prprice`, `prqty`, `prdel`, `prstate`, `prloc`, `prlat`, `prlong`, `prdate`) VALUES
(1, '6', 'Sony Earphones', '2 years old running gear', '100', '1', '1', 'Kedah', 'Changlun', '6.4280083', '100.446565', '2021-11-22 12:11:53.762046');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `user_id` int(11) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_name` varchar(30) NOT NULL,
  `user_password` varchar(40) NOT NULL,
  `user_phone` varchar(15) NOT NULL,
  `user_address` varchar(250) NOT NULL,
  `user_datereg` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `otp` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`user_id`, `user_email`, `user_name`, `user_password`, `user_phone`, `user_address`, `user_datereg`, `otp`) VALUES
(6, 'slumberjer@gmail.com', 'Hanis', 'bec75d2e4e2acf4f4ab038144c0d862505e52d07', 'na', 'na', '2021-10-10 08:27:24.927577', 18092),
(7, 'js@gmail.com', 'John Cenna', 'bec75d2e4e2acf4f4ab038144c0d862505e52d07', 'na', 'na', '2021-11-11 11:20:21.019023', 35327),
(8, 'johndoe@test.com', 'John Doe', 'bec75d2e4e2acf4f4ab038144c0d862505e52d07', 'na', 'na', '2021-11-12 13:15:56.180906', 52658);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_products`
--
ALTER TABLE `tbl_products`
  ADD PRIMARY KEY (`prid`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_products`
--
ALTER TABLE `tbl_products`
  MODIFY `prid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
