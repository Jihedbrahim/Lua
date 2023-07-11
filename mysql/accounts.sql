-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 25, 2023 at 08:02 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mta`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `accountID` int(12) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(40) NOT NULL,
  `email` varchar(225) NOT NULL,
  `serial` varchar(225) NOT NULL,
  `IP` varchar(225) NOT NULL,
  `language` tinyint(3) NOT NULL,
  `wanted` tinyint(1) NOT NULL DEFAULT 0,
  `money` bigint(10) NOT NULL DEFAULT 1500,
  `health` tinyint(3) NOT NULL DEFAULT 100,
  `armor` tinyint(3) NOT NULL DEFAULT 0,
  `skin` int(10) NOT NULL,
  `position` varchar(225) NOT NULL DEFAULT '[ { "y": -2245, "x": 1680, "dim": 0, "z": 14, "int": 0, "rotation": 180 } ]',
  `helperLevel` smallint(1) NOT NULL DEFAULT 0,
  `adminLevel` smallint(1) NOT NULL DEFAULT 0,
  `adminNickname` varchar(255) NOT NULL,
  `playtime` int(12) NOT NULL DEFAULT 0,
  `registrationDate` varchar(255) NOT NULL,
  `lastOnlineTime` varchar(255) NOT NULL,
  `premium` mediumint(12) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`accountID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `accountID` int(12) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
