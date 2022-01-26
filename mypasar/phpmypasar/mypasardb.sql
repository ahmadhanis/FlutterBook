-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 26, 2022 at 11:39 AM
-- Server version: 10.3.32-MariaDB-cll-lve
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `slumber6_mypasarv2db`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_orders`
--

CREATE TABLE `tbl_orders` (
  `order_id` int(5) NOT NULL,
  `order_receiptid` varchar(10) NOT NULL,
  `order_custid` varchar(50) NOT NULL,
  `order_paid` varchar(5) NOT NULL,
  `order_date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_products`
--

CREATE TABLE `tbl_products` (
  `prid` int(5) NOT NULL,
  `pridowner` varchar(30) NOT NULL,
  `prname` varchar(50) NOT NULL,
  `prdesc` varchar(500) NOT NULL,
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
(2, '6', 'Flat TV 60 inch', '2 years old tv', '1500', '1', '10', 'Kedah', 'Bukit Kayu Hitam', '6.4422867', '100.4259233', '2021-11-24 21:05:27.742782'),
(3, '6', 'Wall decoration', 'Decoration for your wall', '25', '5', '1', 'Kedah', 'Changlun', '6.4280083', '100.446565', '2021-11-29 11:22:44.347697'),
(5, '6', 'Toshiba Fridge', '2 years old Fridge in working condition', '800', '1', '10', 'Kedah', 'Changlun', '6.4280083', '100.446565', '2021-11-29 12:12:48.499515'),
(6, '6', 'Shoe rack', '2m x 1m x 0.5m size used', '30', '1', '1', 'Kedah', 'Changlun', '6.4280083', '100.446565', '2021-11-30 12:35:48.762128'),
(7, '6', 'Kitchen Table', '6 chairs 1 table', '250', '1', '10', 'Kedah', 'Changlun', '6.4280083', '100.446565', '2021-11-30 12:43:58.168981'),
(9, '6', 'Kitchen set', '5 years old set', '550', '1', '0', 'Kedah', 'Changlun', '6.4280083', '100.446565', '2021-11-30 12:51:07.390576'),
(10, '6', 'Bookshelf 5 layers', '2 years old', '50', '5', '1', 'Kedah', 'Changlun', '6.4280083', '100.446565', '2021-11-30 12:55:15.805866'),
(18, '6', 'Cat Statue', 'ceramic statue', '25', '5', '1', 'Kedah', 'Universiti Utara Malaysia', '6.4768583', '100.5011283', '2021-12-16 10:21:03.560030'),
(19, '6', 'Sofa Pillow', '3 pieces', '55', '5', '1', 'Kedah', 'Changlun', '6.4431767', '100.4955117', '2021-12-16 10:21:50.561374'),
(20, '6', 'Stove', 'Used 2 years old butterfly brand', '55', '1', '1', 'Kedah', 'Changlun', '6.4431767', '100.4955117', '2021-12-16 10:22:51.351432'),
(21, '6', 'Dog Statue', 'Plastic', '24', '5', '1', 'Kedah', 'Changlun', '6.4431767', '100.4955117', '2021-12-16 10:23:34.845515'),
(22, '6', 'Door Mat', 'grey', '15', '20', '0.50', 'Kedah', 'Changlun', '6.4431767', '100.4955117', '2021-12-16 10:24:18.734689'),
(23, '6', 'Vent', 'Used', '259', '1', '5', 'Kedah', 'Changlun', '6.4431767', '100.4955117', '2021-12-16 10:24:58.937511'),
(24, '6', 'TV Drawer', 'Used', '150', '1', '10', 'Kedah', 'Changlun', '6.4431767', '100.4955117', '2021-12-16 10:27:22.943320'),
(25, '6', 'Wall Screen', '3x3 meters', '120', '5', '1', 'Kedah', 'Changlun', '6.4431767', '100.4955117', '2021-12-16 10:28:30.552047'),
(27, '6', 'Kitchen Cabinet Design', 'Sets contain a lot of items such as the bottom cabinet, top cabinet.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco. urabitur sagittis ex dolor. In a mauris in elit dapibus volutpat. Vivamus pretium nunc felis, vitae pretium ligula vehicula quis. Nullam eu venenatis quam. Duis sit amet tincidunt purus.', '4500', '10', '50', 'Kedah', 'Changlun', '6.4431767', '100.4955117', '2021-12-16 10:32:32.874431'),
(28, '6', 'Door', 'Wood door', '250', '10', '1', 'Kedah', 'Changlun', '6.4431767', '100.4955117', '2021-12-16 10:33:20.131527'),
(29, '13', 'Abstract Wallpaper', '1 meter by 1 meter. Minimum order 10 meters', '5', '100', '0.50', 'Kedah', 'Bukit Kayu Hitam', '6.4422867', '100.4259233', '2022-01-17 10:55:25.173453'),
(30, '13', 'Coffee Desk IKEA', '2 months not suitable for my room', '80', '1', '1', 'Kedah', 'Bukit Kayu Hitam', '6.4422867', '100.4259233', '2022-01-24 11:01:42.242444'),
(31, '13', 'Shoe rack', 'Clearing house', '30', '1', '0', 'Kedah', 'Bukit Kayu Hitam', '6.4422867', '100.4259233', '2022-01-24 11:05:42.366840'),
(33, '13', 'Oven', 'Moving to US', '500', '1', '1', 'Kedah', 'Bukit Kayu Hitam', '6.4422867', '100.4259233', '2022-01-24 11:10:29.590970'),
(34, '13', 'Samsung TV', '2 years moving out', '450', '1', '1', 'Kedah', 'Bukit Kayu Hitam', '6.4422867', '100.4259233', '2022-01-24 11:13:30.796037'),
(35, '13', 'Dog', 'moving to states', '10', '1', '1', 'Kedah', 'Bukit Kayu Hitam', '6.4422867', '100.4259233', '2022-01-24 11:14:49.461023'),
(36, '13', 'Set diners', 'complete set', '500', '1', '2', 'Kedah', 'Bukit Kayu Hitam', '6.4422867', '100.4259233', '2022-01-24 11:17:44.988438'),
(37, '13', 'Picture', 'Test pic', '10', '20', '1', 'Kedah', 'Bukit Kayu Hitam', '6.4422867', '100.4259233', '2022-01-24 11:19:14.948325'),
(38, '13', 'Moving service', 'hourly paid rm50', '50', '10', '0', 'Kedah', 'Bukit Kayu Hitam', '6.4422867', '100.4259233', '2022-01-24 11:23:23.221712'),
(39, '13', 'Rice', 'Bag of rice', '10', '20', '0.50', 'Kedah', 'Bukit Kayu Hitam', '6.4422867', '100.4259233', '2022-01-24 11:25:44.250725');

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
  `otp` int(5) NOT NULL,
  `users_credit` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`user_id`, `user_email`, `user_name`, `user_password`, `user_phone`, `user_address`, `user_datereg`, `otp`, `users_credit`) VALUES
(6, 'slumberjer@gmail.com', 'Ahmad Hanis M. Shabli', 'bec75d2e4e2acf4f4ab038144c0d862505e52d07', '019555444', 'na', '2021-10-10 08:27:24.927577', 1, 10),
(7, 'js@gmail.com', 'John Cenna', 'bec75d2e4e2acf4f4ab038144c0d862505e52d07', 'na', 'na', '2021-11-11 11:20:21.019023', 35327, 10),
(8, 'johndoe@test.com', 'John Doe', 'bec75d2e4e2acf4f4ab038144c0d862505e52d07', 'na', 'na', '2021-11-12 13:15:56.180906', 52658, 10),
(12, 'rebas49969@rezunz.com', 'Rebas', 'bec75d2e4e2acf4f4ab038144c0d862505e52d07', 'na', 'na', '2022-01-13 11:33:58.492277', 1, 10),
(13, 'caresiy270@leezro.com', 'Ali bin Abu', 'bec75d2e4e2acf4f4ab038144c0d862505e52d07', '01955588844', 'na', '2022-01-17 10:29:24.640607', 1, 82);

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
  MODIFY `prid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
