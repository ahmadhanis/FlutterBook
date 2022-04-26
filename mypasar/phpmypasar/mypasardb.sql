-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2022 at 09:53 AM
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
  `product_id` int(5) NOT NULL,
  `user_email` varchar(30) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `product_desc` varchar(500) NOT NULL,
  `product_price` varchar(10) NOT NULL,
  `product_qty` varchar(5) NOT NULL,
  `product_state` varchar(50) NOT NULL,
  `product_loc` varchar(50) NOT NULL,
  `product_lat` varchar(50) NOT NULL,
  `product_long` varchar(50) NOT NULL,
  `product_date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_products`
--

INSERT INTO `tbl_products` (`product_id`, `user_email`, `product_name`, `product_desc`, `product_price`, `product_qty`, `product_state`, `product_loc`, `product_lat`, `product_long`, `product_date`) VALUES
(1, 'slumberjer@gmail.com', 'Samsung Smart Tv', '2 years old, 42inc tv', '1500', '1', 'Kedah', 'Bukit Kayu Hitam', '6.4422867', '100.4259233', '2022-04-26 12:40:11.298390'),
(2, 'jscenna@gmail.com', 'Sofa Kain', '3 tahun Ada kotoran sikit boleh cuci', '600', '1', 'Kedah', 'Bukit Kayu Hitam', '6.4422867', '100.4259233', '2022-04-26 13:53:17.601441'),
(3, 'jscenna@gmail.com', 'Shoe Rack', '5 month, moving out', '50', '1', 'Kedah', 'Bukit Kayu Hitam', '6.4422867', '100.4259233', '2022-04-26 15:11:48.229317');

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
  `user_otp` int(5) NOT NULL,
  `user_credit` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`user_id`, `user_email`, `user_name`, `user_password`, `user_phone`, `user_address`, `user_datereg`, `user_otp`, `user_credit`) VALUES
(1, 'slumberjer@gmail.com', 'Ahmad Hanis Mohd Shabli', 'bec75d2e4e2acf4f4ab038144c0d862505e52d07', '0194702493', 'na', '2022-04-25 22:05:50.328236', 1, 0),
(2, 'jscenna@gmail.com', 'John Cenna', 'bec75d2e4e2acf4f4ab038144c0d862505e52d07', '0194443392', 'na', '2022-04-26 14:33:10.753301', 1, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_products`
--
ALTER TABLE `tbl_products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_products`
--
ALTER TABLE `tbl_products`
  MODIFY `product_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
