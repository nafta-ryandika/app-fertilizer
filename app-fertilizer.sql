-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.51-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for app-fertilizer
CREATE DATABASE IF NOT EXISTS `app-fertilizer` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `app-fertilizer`;

-- Dumping structure for table app-fertilizer.m_access
CREATE TABLE IF NOT EXISTS `m_access` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `role_id` int(16) DEFAULT NULL,
  `menu_id` int(16) DEFAULT NULL,
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

-- Dumping data for table app-fertilizer.m_access: ~16 rows (approximately)
DELETE FROM `m_access`;
INSERT INTO `m_access` (`id`, `role_id`, `menu_id`, `created_by`, `created_at`) VALUES
	(1, 1, 1, 'Administrator', '2023-12-12 10:31:47'),
	(3, 2, 2, 'Administrator', '2023-12-12 10:32:49'),
	(4, 1, 3, 'Administrator', '2023-12-12 10:32:49'),
	(12, 1, 2, NULL, NULL),
	(17, 1, 4, NULL, NULL),
	(18, 1, 5, NULL, '2024-03-04 10:54:50'),
	(19, 1, 7, NULL, '2024-03-18 15:24:46'),
	(20, 3, 4, NULL, '2024-05-18 16:20:49'),
	(21, 3, 5, NULL, '2024-05-18 16:20:52'),
	(22, 4, 4, NULL, '2024-05-18 16:21:29'),
	(23, 5, 5, NULL, '2024-05-18 16:21:53'),
	(24, 3, 2, NULL, '2024-05-18 16:20:49'),
	(26, 5, 2, NULL, '2024-05-18 16:21:53'),
	(27, 1, 8, NULL, '2024-05-21 10:23:59'),
	(29, 6, 8, NULL, '2024-05-23 23:27:36'),
	(30, 1, 9, NULL, '2024-06-18 14:53:00');

-- Dumping structure for table app-fertilizer.m_company
CREATE TABLE IF NOT EXISTS `m_company` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `company` varchar(256) DEFAULT NULL,
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_company: ~0 rows (approximately)
DELETE FROM `m_company`;
INSERT INTO `m_company` (`id`, `company`, `created_by`, `created_at`) VALUES
	(1, 'PT MEGA MARINE PRIDE', 'administrator', '2024-01-30 11:13:48');

-- Dumping structure for table app-fertilizer.m_counter
CREATE TABLE IF NOT EXISTS `m_counter` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `transaction` varchar(256) DEFAULT NULL,
  `counter` int(11) DEFAULT NULL,
  `period` varchar(16) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `period` (`period`),
  KEY `counter` (`counter`),
  KEY `transaction` (`transaction`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_counter: ~0 rows (approximately)
DELETE FROM `m_counter`;
INSERT INTO `m_counter` (`id`, `transaction`, `counter`, `period`, `status`, `created_by`, `created_at`) VALUES
	(2, 'purchase', 20, '072024', 1, 'admin', '2024-07-21 21:20:33'),
	(3, 'purchase', 3, '082024', 1, 'admin', '2024-08-07 14:22:46');

-- Dumping structure for table app-fertilizer.m_currency
CREATE TABLE IF NOT EXISTS `m_currency` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `currency` varchar(256) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `log_by` varchar(256) DEFAULT NULL,
  `log_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_currency: ~4 rows (approximately)
DELETE FROM `m_currency`;
INSERT INTO `m_currency` (`id`, `currency`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'IDR', 1, 'administrator', '2024-06-24 14:00:28', NULL, NULL),
	(2, 'USD', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(3, 'CNY', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(4, 'RMB', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL);

-- Dumping structure for table app-fertilizer.m_department
CREATE TABLE IF NOT EXISTS `m_department` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `department` varchar(256) DEFAULT NULL,
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

-- Dumping data for table app-fertilizer.m_department: ~25 rows (approximately)
DELETE FROM `m_department`;
INSERT INTO `m_department` (`id`, `department`, `created_by`, `created_at`) VALUES
	(1, 'Director', 'administrator', '2024-04-29 15:58:54'),
	(2, 'Production', 'administrator', '2024-04-29 15:58:54'),
	(3, 'Engineering', 'administrator', '2024-04-29 15:58:54'),
	(4, 'PPIC', 'administrator', '2024-04-29 15:58:54'),
	(5, 'Crab', 'administrator', '2024-04-29 15:58:54'),
	(6, 'Warehouse', 'administrator', '2024-04-29 15:58:54'),
	(7, 'Civil Engineering', 'administrator', '2024-04-29 15:58:54'),
	(8, 'HSE', 'administrator', '2024-04-29 15:58:54'),
	(9, 'Marketing', 'administrator', '2024-04-29 15:58:54'),
	(10, 'Exim', 'administrator', '2024-04-29 15:58:54'),
	(11, 'Finance', 'administrator', '2024-04-29 15:58:54'),
	(12, 'Personal / HRD', 'administrator', '2024-04-29 15:58:54'),
	(13, 'Accounting', 'administrator', '2024-04-29 15:58:54'),
	(14, 'Security', 'administrator', '2024-04-29 15:58:54'),
	(15, 'General Affair', 'administrator', '2024-04-29 15:58:54'),
	(16, 'Custom', 'administrator', '2024-04-29 15:58:54'),
	(17, 'QA', 'administrator', '2024-04-29 15:58:54'),
	(18, 'Purchasing Raw Material', 'administrator', '2024-04-29 15:58:54'),
	(19, 'Purchasing Non Raw Material', 'administrator', '2024-04-29 15:58:54'),
	(20, 'I T', 'administrator', '2024-04-29 15:58:54'),
	(21, 'Legal', 'administrator', '2024-04-29 15:58:54'),
	(22, 'Kesehatan', 'administrator', '2024-04-29 15:58:54'),
	(23, 'Food Product', 'administrator', '2024-04-29 15:58:54'),
	(24, 'Fish Product', 'administrator', '2024-04-29 15:58:54'),
	(25, 'Sanitasi', 'administrator', '2024-04-29 15:58:54');

-- Dumping structure for table app-fertilizer.m_division
CREATE TABLE IF NOT EXISTS `m_division` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `department_id` int(16) NOT NULL,
  `division` varchar(256) DEFAULT NULL,
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`department_id`) USING BTREE,
  KEY `department_id` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_division: ~90 rows (approximately)
DELETE FROM `m_division`;
INSERT INTO `m_division` (`id`, `department_id`, `division`, `created_by`, `created_at`) VALUES
	(1, 1, 'Managing Director', 'administrator', '2024-04-29 15:58:26'),
	(2, 1, 'Operation Director', 'administrator', '2024-04-29 15:58:26'),
	(3, 4, 'Coldstorage', 'administrator', '2024-04-29 15:58:26'),
	(4, 4, 'PPIC & MIS', 'administrator', '2024-04-29 15:58:26'),
	(5, 6, 'Warehouse', 'administrator', '2024-04-29 15:58:26'),
	(6, 7, 'Civil Engineering', 'administrator', '2024-04-29 15:58:26'),
	(7, 8, 'HSE', 'administrator', '2024-04-29 15:58:26'),
	(8, 1, 'Sales & Marketing Director', 'administrator', '2024-04-29 15:58:26'),
	(9, 9, 'Marketing', 'administrator', '2024-04-29 15:58:26'),
	(10, 10, 'Exim', 'administrator', '2024-04-29 15:58:26'),
	(11, 10, 'Bea Cukai', 'administrator', '2024-04-29 15:58:26'),
	(12, 1, 'General Affair & Finance Director', 'administrator', '2024-04-29 15:58:26'),
	(14, 13, 'Tax', 'administrator', '2024-04-29 15:58:26'),
	(15, 11, 'Finance', 'administrator', '2024-04-29 15:58:26'),
	(16, 11, 'Kas', 'administrator', '2024-04-29 15:58:26'),
	(17, 11, 'Bank', 'administrator', '2024-04-29 15:58:26'),
	(18, 11, 'Piutang', 'administrator', '2024-04-29 15:58:26'),
	(19, 13, 'Persediaan', 'administrator', '2024-04-29 15:58:26'),
	(20, 11, 'Hutang', 'administrator', '2024-04-29 15:58:26'),
	(21, 16, 'Custom (BC)', 'administrator', '2024-04-29 15:58:26'),
	(22, 12, 'Personal / HRD', 'administrator', '2024-04-29 15:58:26'),
	(23, 14, 'Security', 'administrator', '2024-04-29 15:58:26'),
	(24, 15, 'General Affair', 'administrator', '2024-04-29 15:58:26'),
	(25, 1, 'Quality Assurance Director', 'administrator', '2024-04-29 15:58:26'),
	(26, 17, 'QA', 'administrator', '2024-04-29 15:58:26'),
	(27, 17, 'QSD', 'administrator', '2024-04-29 15:58:26'),
	(28, 17, 'Laborat', 'administrator', '2024-04-29 15:58:26'),
	(29, 17, 'R&D', 'administrator', '2024-04-29 15:58:26'),
	(30, 17, 'QC', 'administrator', '2024-04-29 15:58:26'),
	(31, 17, 'Specification', 'administrator', '2024-04-29 15:58:26'),
	(32, 17, 'Specification Product', 'administrator', '2024-04-29 15:58:26'),
	(33, 17, 'Specification Packaging', 'administrator', '2024-04-29 15:58:26'),
	(34, 17, 'QC Environment', 'administrator', '2024-04-29 15:58:26'),
	(35, 17, 'House Keeping', 'administrator', '2024-04-29 15:58:26'),
	(36, 18, 'Purchasing Raw Material', 'administrator', '2024-04-29 15:58:26'),
	(37, 19, 'Purchasing Non Raw Material', 'administrator', '2024-04-29 15:58:26'),
	(38, 20, 'IT', 'administrator', '2024-04-29 15:58:26'),
	(39, 2, 'SOAKING', 'administrator', '2024-04-29 15:58:26'),
	(40, 2, 'Soaking Raw', 'administrator', '2024-04-29 15:58:26'),
	(41, 2, 'Soaking Cooked', 'administrator', '2024-04-29 15:58:26'),
	(42, 21, 'Legal', 'administrator', '2024-04-29 15:58:26'),
	(43, 21, 'Legal & Permit', 'administrator', '2024-04-29 15:58:26'),
	(44, 22, 'Dokter', 'administrator', '2024-04-29 15:58:26'),
	(45, 22, 'Admin Kesehatan/Bidan', 'administrator', '2024-04-29 15:58:26'),
	(46, 2, 'Shrimp product', 'administrator', '2024-04-29 15:58:26'),
	(47, 2, 'Receiving Area', 'administrator', '2024-04-29 15:58:26'),
	(48, 2, 'RM Preparation-deheading', 'administrator', '2024-04-29 15:58:26'),
	(49, 2, 'RM Preparation-sorting', 'administrator', '2024-04-29 15:58:26'),
	(50, 2, 'Raw Product & Peeling', 'administrator', '2024-04-29 15:58:26'),
	(51, 2, 'Nobashi Ebi 1', 'administrator', '2024-04-29 15:58:26'),
	(52, 2, 'Nobashi Ebi 2', 'administrator', '2024-04-29 15:58:26'),
	(53, 2, 'Cooked', 'administrator', '2024-04-29 15:58:26'),
	(54, 2, 'Sushi Ebi', 'administrator', '2024-04-29 15:58:26'),
	(55, 2, 'Freezing & Packing', 'administrator', '2024-04-29 15:58:26'),
	(56, 2, 'Adm Produksi', 'administrator', '2024-04-29 15:58:26'),
	(57, 2, 'Custom Proses', 'administrator', '2024-04-29 15:58:26'),
	(58, 2, 'Raw Product & Peeling 2', 'administrator', '2024-04-29 15:58:26'),
	(59, 2, 'Freezing Packing Raw', 'administrator', '2024-04-29 15:58:26'),
	(60, 2, 'Freezing Packing Cooked', 'administrator', '2024-04-29 15:58:26'),
	(61, 2, 'CIS', 'administrator', '2024-04-29 15:58:26'),
	(62, 2, 'Boil', 'administrator', '2024-04-29 15:58:26'),
	(63, 2, 'Raw Product & Peeling NE', 'administrator', '2024-04-29 15:58:26'),
	(64, 2, 'Raw Product & Peeling Cooked', 'administrator', '2024-04-29 15:58:26'),
	(65, 2, 'Raw Product & Peeling Raw', 'administrator', '2024-04-29 15:58:26'),
	(66, 2, 'Shrimp Ring', 'administrator', '2024-04-29 15:58:26'),
	(67, 2, 'Custom Proses Shrimp', 'administrator', '2024-04-29 15:58:26'),
	(68, 2, 'Freezing Packing Custom Shrimp', 'administrator', '2024-04-29 15:58:26'),
	(69, 2, 'Custom Proses Crab', 'administrator', '2024-04-29 15:58:26'),
	(70, 2, 'Freezing Packing Custom Crab', 'administrator', '2024-04-29 15:58:26'),
	(71, 5, 'Crab Product', 'administrator', '2024-04-29 15:58:26'),
	(72, 5, 'Crab Meat Japan 1', 'administrator', '2024-04-29 15:58:26'),
	(73, 5, 'Crab Meat USA 1', 'administrator', '2024-04-29 15:58:26'),
	(74, 5, 'Crab In Shell Japan 1', 'administrator', '2024-04-29 15:58:26'),
	(75, 5, 'Crab In Shell USA 1', 'administrator', '2024-04-29 15:58:26'),
	(76, 23, 'Food Product', 'administrator', '2024-04-29 15:58:26'),
	(77, 23, 'Breaded', 'administrator', '2024-04-29 15:58:26'),
	(78, 24, 'Kabag Fish Product', 'administrator', '2024-04-29 15:58:26'),
	(79, 24, 'Fish / Ikan', 'administrator', '2024-04-29 15:58:26'),
	(80, 3, 'Mekanik', 'administrator', '2024-04-29 15:58:26'),
	(81, 3, 'Maintenance', 'administrator', '2024-04-29 15:58:26'),
	(82, 3, 'Refrigeration System', 'administrator', '2024-04-29 15:58:26'),
	(83, 3, 'Welding', 'administrator', '2024-04-29 15:58:26'),
	(84, 3, 'Boiler', 'administrator', '2024-04-29 15:58:26'),
	(85, 3, 'Workshop', 'administrator', '2024-04-29 15:58:26'),
	(86, 2, 'Production Engineering', 'administrator', '2024-04-29 15:58:26'),
	(87, 15, 'Kendaraan', 'administrator', '2024-04-29 15:58:26'),
	(88, 15, 'Limbah', 'administrator', '2024-04-29 15:58:26'),
	(89, 25, 'Sanitasi Dalam', 'administrator', '2024-04-29 15:58:26'),
	(90, 25, 'Sanitasi Luar', 'administrator', '2024-04-29 15:58:26'),
	(91, 13, 'Accounting', 'administrator', '2024-04-29 15:58:26');

-- Dumping structure for table app-fertilizer.m_goods
CREATE TABLE IF NOT EXISTS `m_goods` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `goods` varchar(256) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `qty` varchar(256) DEFAULT NULL,
  `remark` text,
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `log_by` varchar(256) DEFAULT NULL,
  `log_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `unit_id` (`unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_goods: ~5 rows (approximately)
DELETE FROM `m_goods`;
INSERT INTO `m_goods` (`id`, `goods`, `unit_id`, `qty`, `remark`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'Zak', 1, NULL, NULL, 1, 'administrator', '2024-06-24 14:00:28', NULL, NULL),
	(2, 'Isolasi', 4, NULL, NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(3, 'Kardus', 1, NULL, NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(4, 'Plastik Bag', 1, NULL, NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(5, 'Oli', 3, NULL, NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL);

-- Dumping structure for table app-fertilizer.m_menu
CREATE TABLE IF NOT EXISTS `m_menu` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `menu` varchar(128) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '0 = hide; 1 show;',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_menu: ~5 rows (approximately)
DELETE FROM `m_menu`;
INSERT INTO `m_menu` (`id`, `menu`, `status`, `created_by`, `created_at`) VALUES
	(1, 'Administrator', 1, 'Administrator', '2023-12-12 10:43:22'),
	(2, 'User', 1, 'Administrator', '2023-12-12 10:43:22'),
	(3, 'Menu', 1, 'Administrator', '2023-12-12 10:43:22'),
	(7, 'User_management', 0, 'admin', '2024-03-18 15:24:16'),
	(9, 'Purchase', 1, 'admin', '2024-06-18 14:49:21');

-- Dumping structure for table app-fertilizer.m_position
CREATE TABLE IF NOT EXISTS `m_position` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `position` varchar(256) DEFAULT NULL,
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_position: ~12 rows (approximately)
DELETE FROM `m_position`;
INSERT INTO `m_position` (`id`, `position`, `created_by`, `created_at`) VALUES
	(1, 'DIRECTOR', 'administrator', '2024-01-31 10:45:26'),
	(2, 'SENIOR MANAGER', 'administrator', '2024-01-31 10:45:26'),
	(3, 'GENERAL MANAGER', 'administrator', '2024-01-31 10:45:26'),
	(4, 'MANAGER', 'administrator', '2024-01-31 10:45:26'),
	(5, 'GENERAL SECTION HEAD', 'administrator', '2024-01-31 10:45:26'),
	(6, 'SECTION HEAD', 'administrator', '2024-01-31 10:45:26'),
	(7, 'SUPERVISOR', 'administrator', '2024-01-31 10:45:26'),
	(8, 'ASISTEN SUPERVISOR', 'administrator', '2024-01-31 10:45:26'),
	(9, 'OPERATOR KANTOR/ADMIN', 'administrator', '2024-01-31 10:45:26'),
	(10, 'OPERATOR', 'administrator', '2024-01-31 10:45:26'),
	(11, 'OPERATOR TIME BASED', 'administrator', '2024-01-31 10:45:26'),
	(12, 'OPERATOR BORONGAN', 'administrator', '2024-01-31 10:45:26');

-- Dumping structure for table app-fertilizer.m_purchase_type
CREATE TABLE IF NOT EXISTS `m_purchase_type` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `type` varchar(256) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `log_by` varchar(256) DEFAULT NULL,
  `log_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_purchase_type: ~2 rows (approximately)
DELETE FROM `m_purchase_type`;
INSERT INTO `m_purchase_type` (`id`, `type`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'Barang', 1, 'administrator', '2024-06-24 14:00:28', NULL, NULL),
	(2, 'Jasa', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL);

-- Dumping structure for table app-fertilizer.m_role
CREATE TABLE IF NOT EXISTS `m_role` (
  `id` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `role` varchar(256) DEFAULT NULL,
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Dumping data for table app-fertilizer.m_role: ~6 rows (approximately)
DELETE FROM `m_role`;
INSERT INTO `m_role` (`id`, `role`, `created_by`, `created_at`) VALUES
	(1, 'Administrator', 'Administrator', '2023-12-12 10:38:47'),
	(2, 'User', 'Administrator', '2023-12-12 10:38:50'),
	(3, 'Hrd', 'admin', '2024-05-18 16:20:32'),
	(4, 'Security', 'admin', '2024-05-18 16:21:12'),
	(5, 'Audit', 'admin', '2024-05-18 16:21:48'),
	(6, 'Vote', 'admin', '2024-05-23 23:26:56');

-- Dumping structure for table app-fertilizer.m_submenu
CREATE TABLE IF NOT EXISTS `m_submenu` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `menu_id` int(16) DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `url` varchar(128) DEFAULT NULL,
  `icon` varchar(128) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_submenu: ~8 rows (approximately)
DELETE FROM `m_submenu`;
INSERT INTO `m_submenu` (`id`, `menu_id`, `title`, `url`, `icon`, `status`, `created_by`, `created_at`) VALUES
	(1, 1, 'Dashboard', 'administrator', 'fas fa-fw fa-tachometer-alt', 1, 'Administrator', '2023-12-12 10:28:19'),
	(2, 2, 'My Profile', 'user', 'fas fa-fw fa-user', 1, 'Administrator', '2023-12-12 10:28:19'),
	(3, 2, 'Edit Profile', 'user/edit', 'fas fa-fw fa-user-edit', 1, 'Administrator', '2023-12-12 10:28:19'),
	(4, 3, 'Menu Management', 'menu', 'fas fa-fw fa-folder', 1, 'Administrator', '2023-12-12 10:28:19'),
	(5, 3, 'Submenu Management', 'menu/submenu', 'fas fa-fw fa-folder-open', 1, 'Administrator', '2023-12-12 10:28:19'),
	(7, 1, 'Role', 'administrator/role', 'fas fa-fw fa-key', 1, 'Administrator', '2023-12-12 10:28:19'),
	(11, 1, 'User', 'user_management', 'fas fa-fw fa-user', 1, NULL, '2024-03-18 14:51:33'),
	(13, 9, 'Purchase', 'purchase', 'fas fa-fw fa-cart-shopping', 1, NULL, '2024-06-18 14:52:41');

-- Dumping structure for table app-fertilizer.m_supplier
CREATE TABLE IF NOT EXISTS `m_supplier` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `supplier` varchar(256) DEFAULT NULL,
  `pic` varchar(256) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `address` text,
  `remark` text,
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `log_by` varchar(256) DEFAULT NULL,
  `log_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_supplier: ~6 rows (approximately)
DELETE FROM `m_supplier`;
INSERT INTO `m_supplier` (`id`, `supplier`, `pic`, `phone`, `address`, `remark`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'Abadi Jaya', 'Andi', '088847228293', 'Serang', NULL, 1, 'administrator', '2024-06-24 14:00:28', NULL, NULL),
	(2, 'Berkah Bersinar', 'Budi', '089518693827', 'Jakarta', NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(3, 'Cahaya Alam', 'Caca', '083882515493', 'Bandung', NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(4, 'Dadi Makmur', 'Dani', '084314134921', 'Semarang', NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(5, 'Edi Putra', 'Edi', '083373986943', 'Yogyakarta', NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(6, 'Fandi Utama', 'Fredi', '085324383234', 'Surabaya', NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL);

-- Dumping structure for table app-fertilizer.m_token
CREATE TABLE IF NOT EXISTS `m_token` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(16) NOT NULL,
  `token` varchar(128) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table app-fertilizer.m_token: ~0 rows (approximately)
DELETE FROM `m_token`;

-- Dumping structure for table app-fertilizer.m_unit
CREATE TABLE IF NOT EXISTS `m_unit` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `unit` varchar(256) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `log_by` varchar(256) DEFAULT NULL,
  `log_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_unit: ~5 rows (approximately)
DELETE FROM `m_unit`;
INSERT INTO `m_unit` (`id`, `unit`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'Pcs', 1, 'administrator', '2024-06-24 14:00:28', NULL, NULL),
	(2, 'Kg', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(3, 'Drum', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(4, 'Roll', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(5, 'Cartoon', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL);

-- Dumping structure for table app-fertilizer.m_user
CREATE TABLE IF NOT EXISTS `m_user` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(16) DEFAULT NULL,
  `name` varchar(256) DEFAULT NULL,
  `email` varchar(256) DEFAULT NULL,
  `image` varchar(256) DEFAULT NULL,
  `password` varchar(256) DEFAULT NULL,
  `company_id` int(16) DEFAULT '1',
  `department_id` int(16) DEFAULT NULL,
  `division_id` int(16) DEFAULT NULL,
  `role_id` int(16) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

-- Dumping data for table app-fertilizer.m_user: ~8 rows (approximately)
DELETE FROM `m_user`;
INSERT INTO `m_user` (`id`, `user_id`, `name`, `email`, `image`, `password`, `company_id`, `department_id`, `division_id`, `role_id`, `status`, `created_by`, `created_at`) VALUES
	(1, 'admin', 'admin', 'sysdev@megamarinepride.com', 'default.png', '$2y$10$31nTmbo9IVv6NnjV7FHNHetkM4aIr18q8XRsRsI/y7qHXaNvtYKxK', 1, 4, 1, 1, 1, 'administrator', '2023-11-29 07:41:59'),
	(2, 'user', 'user', 'user@gmail.com', 'default.png', '$2y$10$mqX3iwzex/G/K2cEd5Yer.2DOAYn2AF0G1rFyW249xPh6dS5pX8Fq', 1, 4, 1, 2, 1, 'administrator', '2023-12-08 05:19:30'),
	(6, 'coba', 'coba', 'sysdev@megamarinepride.com', 'default.png', '$2y$10$6XJQ75PwG6mkgr3iOILQKudcwHW/a3Dv3ROLJOQ3yGGscsLkolFDa', 1, 20, 38, 1, 0, 'admin', '2024-05-16 16:50:37'),
	(23, '1234', 'test edit', 'sysdev@megamarinepride.com', 'default.png', '$2y$10$a8vOjhMDIznyMK9PiJqwWuD4r2pLFnJF8vdEIDPvItqZl09EPjvMW', 1, 20, 38, 1, 1, 'admin', '2024-05-16 16:49:35'),
	(24, 'hrd', 'hrd', '', 'default.png', '$2y$10$.qPGVgOxVSxvJWcPnAiEM.e70Jf4RIGvFaoUeLFm5cPUhVFROHVJC', 1, 12, 22, 3, 1, 'admin', '2024-05-18 16:22:42'),
	(25, 'security', 'security', '', 'default.png', '$2y$10$swhOc3ETAs0BBgw8Ih7Ek.sTFYnlpmD76JUfh0oDx3FSqcNmqbpfS', 1, 14, 23, 4, 1, 'admin', '2024-05-18 16:25:26'),
	(26, 'audit', 'audit', '', 'default.png', '$2y$10$NDfADe49btw6ciicwTs6qeyXrQCAMgi9MEjyM/Sr2WF5w1UF4rONW', 1, 12, 22, 5, 1, 'admin', '2024-05-18 16:26:15'),
	(27, 'vote', 'vote', '', 'default.png', '$2y$10$2c08SzztPfP2Rd1Tij37HeGgbqpOE54mksVgF/IWwiMuSE/3QRAjC', 1, 20, 38, 6, 1, 'admin', '2024-05-23 23:31:11');

-- Dumping structure for table app-fertilizer.t_purchase
CREATE TABLE IF NOT EXISTS `t_purchase` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `purchase_id` varchar(16) NOT NULL,
  `date` date DEFAULT NULL,
  `purchase_type_id` int(11) NOT NULL DEFAULT '0',
  `supplier_id` int(11) NOT NULL DEFAULT '0',
  `due_date` date DEFAULT NULL,
  `remark` text,
  `currency_id` int(11) unsigned DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `tax_type` tinyint(4) DEFAULT NULL COMMENT ' 1 = Include; 0 = Exclude;',
  `tax` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `log_by` varchar(256) DEFAULT NULL,
  `log_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`purchase_id`) USING BTREE,
  KEY `date` (`date`),
  KEY `due_date` (`due_date`),
  KEY `purchase_type_id` (`purchase_type_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `status` (`status`),
  KEY `purchase_id` (`purchase_id`),
  KEY `currency_id` (`currency_id`),
  KEY `tax_type` (`tax_type`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.t_purchase: ~9 rows (approximately)
DELETE FROM `t_purchase`;
INSERT INTO `t_purchase` (`id`, `purchase_id`, `date`, `purchase_type_id`, `supplier_id`, `due_date`, `remark`, `currency_id`, `discount`, `tax_type`, `tax`, `total`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(2, 'PO/072024/00013', '2024-07-07', 1, 6, '2024-07-07', 'test', NULL, 10, NULL, 11, 0, 1, 'admin', '2024-07-07 10:16:55', 'admin', '2024-07-21 08:57:46'),
	(3, 'PO/072024/00014', '2024-07-07', 1, 6, '2024-07-07', 'test', NULL, 10, NULL, 0, 108, 1, 'admin', '2024-07-07 10:27:11', 'admin', '2024-07-19 23:45:23'),
	(4, 'PO/072024/00015', '2024-07-07', 1, 6, '2024-07-07', 'test', NULL, 10, NULL, 11, 44033, 1, 'admin', '2024-07-07 10:33:35', 'admin', '2024-07-18 17:01:47'),
	(6, 'PO/072024/00017', '2024-07-07', 1, 4, '2024-07-07', '', NULL, 5, NULL, 11, 85950, 1, 'admin', '2024-07-07 14:04:00', 'admin', '2024-07-18 16:58:41'),
	(7, 'PO/072024/00018', '2024-07-09', 2, 1, '2024-07-16', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', NULL, 20, NULL, 0, 1985806, 1, 'admin', '2024-07-09 09:48:45', 'admin', '2024-07-23 16:39:59'),
	(8, 'PO/072024/00019', '2024-07-21', 1, 6, '2024-07-21', 'test', NULL, 0, NULL, 0, 29500, 0, 'admin', '2024-07-21 08:57:14', 'admin', '2024-07-21 09:50:29'),
	(9, 'PO/072024/00020', '2024-07-21', 1, 1, '2024-07-21', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', NULL, 0, NULL, 0, 1000, 1, 'admin', '2024-07-21 21:20:33', NULL, NULL),
	(10, 'PO/082024/00001', '2024-08-06', 1, 1, '2024-08-07', 'test', NULL, 0, NULL, 11, 5, 1, 'admin', '2024-08-06 15:08:56', NULL, NULL),
	(11, 'PO/082024/00002', '2024-08-06', 1, 1, '2024-08-07', 'test 2', 1, 1, 0, 2, 5, 1, 'admin', '2024-08-06 15:52:33', 'admin', '2024-08-06 15:53:35'),
	(12, 'PO/082024/00003', '2024-08-07', 1, 1, '2024-08-07', 'test', 3, 1, 1, 2, 5, 1, 'admin', '2024-08-07 14:22:46', NULL, NULL);

-- Dumping structure for table app-fertilizer.t_purchase_detail
CREATE TABLE IF NOT EXISTS `t_purchase_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_id` varchar(16) NOT NULL,
  `goods_id` varchar(16) DEFAULT NULL,
  `qty` float DEFAULT NULL,
  `unit_id` varchar(16) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `discount` float DEFAULT NULL,
  `subtotal` float DEFAULT NULL,
  `qty_received` float DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `log_by` varchar(256) DEFAULT NULL,
  `log_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`purchase_id`) USING BTREE,
  KEY `purchase_id` (`purchase_id`),
  KEY `goods_id` (`goods_id`),
  KEY `unit_id` (`unit_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.t_purchase_detail: ~50 rows (approximately)
DELETE FROM `t_purchase_detail`;
INSERT INTO `t_purchase_detail` (`id`, `purchase_id`, `goods_id`, `qty`, `unit_id`, `price`, `discount`, `subtotal`, `qty_received`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(3, 'PO/072024/00014', '2', 20, '4', 2000, 5, 38000, NULL, 0, 'admin', '2024-07-07 10:27:11', 'admin', '2024-07-19 23:43:43'),
	(4, 'PO/072024/00014', '3', 10, '1', 500, 0, 5000, NULL, 0, 'admin', '2024-07-07 10:27:11', 'admin', '2024-07-19 23:43:56'),
	(5, 'PO/072024/00014', '4', 5, '1', 200, NULL, 1000, NULL, 0, 'admin', '2024-07-07 10:27:11', 'admin', '2024-07-19 23:21:07'),
	(6, 'PO/072024/00015', '2', 20, '4', 2000, 1, 38000, NULL, 1, 'admin', '2024-07-07 10:33:35', 'admin', '2024-07-18 17:01:47'),
	(7, 'PO/072024/00015', '3', 10, '1', 500, 0, 5000, NULL, 1, 'admin', '2024-07-07 10:33:35', 'admin', '2024-07-18 17:01:47'),
	(8, 'PO/072024/00015', '4', 5, '1', 200, 0, 1000, NULL, 1, 'admin', '2024-07-07 10:33:35', 'admin', '2024-07-18 17:01:47'),
	(9, 'PO/072024/00016', '', 0, '', 0, 1, 0, NULL, 1, 'admin', '2024-07-07 10:59:07', NULL, NULL),
	(10, 'PO/072024/00017', '2', 100, '4', 500, 1, 47500, NULL, 1, 'admin', '2024-07-07 14:04:00', 'admin', '2024-07-18 16:58:41'),
	(11, 'PO/072024/00017', '5', 2, '3', 10000, 0, 20000, NULL, 1, 'admin', '2024-07-07 14:04:00', 'admin', '2024-07-18 16:58:41'),
	(12, 'PO/072024/00018', '2', 500, '4', 2001, 0, 890445, NULL, 1, 'admin', '2024-07-09 09:48:45', 'admin', '2024-07-23 16:39:59'),
	(13, 'PO/072024/00018', '1', 300, '1', 1001, 0, 240240, NULL, 1, 'admin', '2024-07-09 09:48:45', 'admin', '2024-07-23 16:39:59'),
	(14, 'PO/072024/00018', '4', 2100, '1', 101, 0, 180285, NULL, 1, 'admin', '2024-07-16 14:31:05', 'admin', '2024-07-23 16:39:59'),
	(15, 'PO/072024/00018', '4', 2200, '1', 101, 0, 211090, NULL, 1, 'admin', '2024-07-16 14:52:56', 'admin', '2024-07-23 16:39:59'),
	(16, 'PO/072024/00018', '1', 100, '1', 500, 0, 48500, NULL, 1, 'admin', '2024-07-16 14:56:11', 'admin', '2024-07-23 16:39:59'),
	(17, 'PO/072024/00018', '2', 1000, '4', 500, 0, 475000, NULL, 1, 'admin', '2024-07-16 17:41:16', 'admin', '2024-07-23 16:39:59'),
	(18, 'PO/072024/00018', '2', 1, '4', 5000, 0, 4700, NULL, 1, 'admin', '2024-07-17 10:33:51', 'admin', '2024-07-23 16:39:59'),
	(19, 'PO/072024/00018', '2', 1, '4', 5000, 0, 4650, NULL, 1, 'admin', '2024-07-17 10:36:03', 'admin', '2024-07-23 16:39:59'),
	(20, 'PO/072024/00018', '1', 1, '1', 1000, 0, 920, NULL, 1, 'admin', '2024-07-17 10:36:03', 'admin', '2024-07-23 16:39:59'),
	(21, 'PO/072024/00018', '4', 10, '1', 10, 0, 91, NULL, 1, 'admin', '2024-07-17 11:08:32', 'admin', '2024-07-23 16:39:59'),
	(22, 'PO/072024/00018', '4', 10, '1', 10, 0, 90, NULL, 1, 'admin', '2024-07-17 13:25:31', 'admin', '2024-07-23 16:39:59'),
	(23, 'PO/072024/00018', '1', 100, '1', 100, 0, 8900, NULL, 1, 'admin', '2024-07-17 13:25:31', 'admin', '2024-07-23 16:39:59'),
	(24, 'PO/072024/00018', '4', 10, '1', 10, 0, 88, NULL, 1, 'admin', '2024-07-17 14:22:21', 'admin', '2024-07-23 16:39:59'),
	(25, 'PO/072024/00018', '1', 100, '1', 100, 0, 8700, NULL, 1, 'admin', '2024-07-17 14:22:21', 'admin', '2024-07-23 16:39:59'),
	(26, 'PO/072024/00018', '4', 10, '1', 10, 0, 86, NULL, 1, 'admin', '2024-07-17 14:22:21', 'admin', '2024-07-23 16:39:59'),
	(27, 'PO/072024/00018', '4', 10, '1', 10, 0, 85, NULL, 1, 'admin', '2024-07-17 15:20:34', 'admin', '2024-07-23 16:39:59'),
	(28, 'PO/072024/00018', '1', 100, '1', 100, 0, 10000, NULL, 1, 'admin', '2024-07-17 15:20:34', 'admin', '2024-07-23 16:39:59'),
	(29, 'PO/072024/00018', '4', 10, '1', 10, 0, 99, NULL, 1, 'admin', '2024-07-17 15:20:34', 'admin', '2024-07-23 16:39:59'),
	(30, 'PO/072024/00018', '2', 123, '4', 456, 0, 56088, NULL, 1, 'admin', '2024-07-17 15:32:59', 'admin', '2024-07-23 16:39:59'),
	(31, 'PO/072024/00018', '2', 10, '4', 200, 0, 2000, NULL, 1, 'admin', '2024-07-18 10:18:13', 'admin', '2024-07-23 16:39:59'),
	(32, 'PO/072024/00018', '2', 100, '4', 123, 0, 12300, NULL, 1, 'admin', '2024-07-18 10:50:39', 'admin', '2024-07-23 16:39:59'),
	(33, 'PO/072024/00018', '2', 200, '4', 456, 0, 91200, NULL, 1, 'admin', '2024-07-18 10:52:22', 'admin', '2024-07-23 16:39:59'),
	(34, 'PO/072024/00018', '4', 300, '1', 789, 0, 236700, NULL, 1, 'admin', '2024-07-18 10:53:58', 'admin', '2024-07-23 16:39:59'),
	(35, 'PO/072024/00017', '1', 200, '1', 50, 10, 9000, NULL, 1, 'admin', '2024-07-18 16:04:35', 'admin', '2024-07-18 16:58:41'),
	(36, 'PO/072024/00017', '2', 500, '4', 10, 0, 5000, NULL, 1, 'admin', '2024-07-18 16:19:55', 'admin', '2024-07-18 16:58:41'),
	(37, 'PO/072024/00017', '4', 1, '1', 2, 0, 2, NULL, 1, 'admin', '2024-07-18 16:58:41', NULL, NULL),
	(38, 'PO/072024/00017', '3', 2, '1', 3, 4, 5.76, NULL, 1, 'admin', '2024-07-18 16:58:41', NULL, NULL),
	(39, 'PO/072024/00015', '4', 1, '1', 2, 0, 2, NULL, 1, 'admin', '2024-07-18 17:01:18', 'admin', '2024-07-18 17:01:47'),
	(40, 'PO/072024/00015', '4', 4, '1', 5, 6, 18.8, NULL, 1, 'admin', '2024-07-18 17:01:47', NULL, NULL),
	(41, 'PO/072024/00015', '4', 7, '1', 8, 0, 56, NULL, 1, 'admin', '2024-07-18 17:01:47', NULL, NULL),
	(42, 'PO/072024/00013', '5', 100, '3', 1, 0, 100, NULL, 0, 'admin', '2024-07-19 22:44:48', 'admin', '2024-07-21 08:12:27'),
	(43, 'PO/072024/00013', '4', 200, '1', 1, 5, 190, NULL, 0, 'admin', '2024-07-19 22:46:03', 'admin', '2024-07-21 08:12:27'),
	(44, 'PO/072024/00013', '5', 300, '3', 1, 10, 270, NULL, 0, 'admin', '2024-07-19 23:17:02', 'admin', '2024-07-21 08:12:27'),
	(45, 'PO/072024/00013', '1', 400, '1', 1, 0, 400, NULL, 0, 'admin', '2024-07-19 23:17:02', 'admin', '2024-07-21 08:12:27'),
	(46, 'PO/072024/00014', '4', 10, '1', 500, 0, 5000, NULL, 0, 'admin', '2024-07-19 23:43:43', 'admin', '2024-07-19 23:43:56'),
	(47, 'PO/072024/00014', '3', 100, '1', 100, 0, 10000, NULL, 0, 'admin', '2024-07-19 23:43:56', 'admin', '2024-07-19 23:44:54'),
	(48, 'PO/072024/00014', '1', 12, '1', 10, 0, 120, NULL, 1, 'admin', '2024-07-19 23:44:54', 'admin', '2024-07-19 23:45:23'),
	(49, 'PO/072024/00013', '3', 200, '1', 100, 0, 20000, NULL, 0, 'admin', '2024-07-21 08:12:27', 'admin', '2024-07-21 08:57:46'),
	(50, 'PO/072024/00019', '2', 100, '4', 100, 5, 9500, NULL, 0, 'admin', '2024-07-21 08:57:14', 'admin', '2024-07-21 09:50:29'),
	(51, 'PO/072024/00019', '5', 200, '3', 100, 0, 20000, NULL, 0, 'admin', '2024-07-21 08:57:14', 'admin', '2024-07-21 09:50:29'),
	(53, 'PO/072024/00020', '2', 100, '4', 10, 0, 1000, NULL, 1, 'admin', '2024-07-21 21:20:33', NULL, NULL),
	(54, 'PO/082024/00001', '2', 1, '4', 1, 1, 0.99, NULL, 1, 'admin', '2024-08-06 15:08:56', NULL, NULL),
	(55, 'PO/082024/00001', '3', 2, '1', 2, 2, 3.92, NULL, 1, 'admin', '2024-08-06 15:08:56', NULL, NULL),
	(56, 'PO/082024/00002', '2', 1, '4', 1, 1, 0.99, NULL, 1, 'admin', '2024-08-06 15:52:33', 'admin', '2024-08-06 15:53:35'),
	(57, 'PO/082024/00002', '3', 2, '1', 2, 2, 3.92, NULL, 1, 'admin', '2024-08-06 15:52:33', 'admin', '2024-08-06 15:53:35'),
	(58, 'PO/082024/00003', '2', 1, '4', 1, 1, 0.99, NULL, 1, 'admin', '2024-08-07 14:22:46', NULL, NULL),
	(59, 'PO/082024/00003', '3', 2, '1', 2, 2, 3.92, NULL, 1, 'admin', '2024-08-07 14:22:46', NULL, NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
