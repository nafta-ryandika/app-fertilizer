-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.51-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             12.8.0.6908
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

-- Dumping data for table app-fertilizer.m_access: ~18 rows (approximately)
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
	(30, 1, 9, NULL, '2024-06-18 14:53:00'),
	(31, 1, 10, NULL, '2024-08-20 10:30:55'),
	(32, 1, 11, NULL, '2024-09-06 10:49:17');

-- Dumping structure for table app-fertilizer.m_company
CREATE TABLE IF NOT EXISTS `m_company` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `company` varchar(256) DEFAULT NULL,
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_company: ~1 rows (approximately)
DELETE FROM `m_company`;
INSERT INTO `m_company` (`id`, `company`, `created_by`, `created_at`) VALUES
	(1, 'PT AGRI MAKMUR MEGA PERKASA INDO', 'administrator', '2024-01-30 11:13:48');

-- Dumping structure for table app-fertilizer.m_counter
CREATE TABLE IF NOT EXISTS `m_counter` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `transaction` varchar(256) DEFAULT NULL,
  `counter` int(16) DEFAULT NULL,
  `period` varchar(16) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `period` (`period`),
  KEY `counter` (`counter`),
  KEY `transaction` (`transaction`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_counter: ~11 rows (approximately)
DELETE FROM `m_counter`;
INSERT INTO `m_counter` (`id`, `transaction`, `counter`, `period`, `status`, `created_by`, `created_at`) VALUES
	(2, 'purchase', 20, '072024', 1, 'admin', '2024-07-21 21:20:33'),
	(3, 'purchase', 3, '082024', 1, 'admin', '2024-08-07 14:22:46'),
	(4, 'sales', 5, '082024', 1, 'admin', '2024-08-29 14:25:42'),
	(5, 'purchase', 1, '092024', 1, 'admin', '2024-09-11 10:27:38'),
	(6, 'inv-receipt', 3, '092024', 1, 'admin', '2024-09-28 10:59:25'),
	(7, 'inv-in', 17, '102024', 1, 'admin', '2024-10-31 15:21:37'),
	(8, 'inv-receipt', 1, '102024', 1, 'admin', '2024-10-30 16:02:07'),
	(9, 'inv-receipt', 10, '112024', 1, 'admin', '2024-11-20 11:35:07'),
	(10, 'inv-in', 31, '112024', 1, 'admin', '2024-11-23 16:01:32'),
	(11, 'purchase', 4, '112024', 1, 'admin', '2024-11-20 11:31:46'),
	(12, 'inv-goodsReceipt', 1, '112024', 1, 'admin', '2024-11-26 11:06:38');

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

-- Dumping structure for table app-fertilizer.m_customer
CREATE TABLE IF NOT EXISTS `m_customer` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `customer` varchar(256) DEFAULT NULL,
  `pic` varchar(256) DEFAULT NULL,
  `email` varchar(256) DEFAULT NULL,
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

-- Dumping data for table app-fertilizer.m_customer: ~6 rows (approximately)
DELETE FROM `m_customer`;
INSERT INTO `m_customer` (`id`, `customer`, `pic`, `email`, `phone`, `address`, `remark`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'Abadi Jaya', 'Andi', NULL, '088847228293', 'Serang', NULL, 1, 'administrator', '2024-06-24 14:00:28', NULL, NULL),
	(2, 'Berkah Bersinar', 'Budi', NULL, '089518693827', 'Jakarta', NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(3, 'Cahaya Alam', 'Caca', NULL, '083882515493', 'Bandung', NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(4, 'Dadi Makmur', 'Dani', NULL, '084314134921', 'Semarang', NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(5, 'Edi Putra', 'Edi', NULL, '083373986943', 'Yogyakarta', NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(6, 'Fandi Utama', 'Fredi', NULL, '085324383234', 'Surabaya', NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL);

-- Dumping structure for table app-fertilizer.m_department
CREATE TABLE IF NOT EXISTS `m_department` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `department` varchar(256) DEFAULT NULL,
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

-- Dumping data for table app-fertilizer.m_department: ~21 rows (approximately)
DELETE FROM `m_department`;
INSERT INTO `m_department` (`id`, `department`, `created_by`, `created_at`) VALUES
	(1, 'Director', 'administrator', '2024-04-29 15:58:54'),
	(2, 'Production', 'administrator', '2024-04-29 15:58:54'),
	(3, 'Engineering', 'administrator', '2024-04-29 15:58:54'),
	(4, 'PPIC', 'administrator', '2024-04-29 15:58:54'),
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
	(22, 'Kesehatan', 'administrator', '2024-04-29 15:58:54');

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

-- Dumping data for table app-fertilizer.m_division: ~52 rows (approximately)
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
	(42, 21, 'Legal', 'administrator', '2024-04-29 15:58:26'),
	(43, 21, 'Legal & Permit', 'administrator', '2024-04-29 15:58:26'),
	(44, 22, 'Dokter', 'administrator', '2024-04-29 15:58:26'),
	(45, 22, 'Admin Kesehatan/Bidan', 'administrator', '2024-04-29 15:58:26'),
	(56, 2, 'Adm Produksi', 'administrator', '2024-04-29 15:58:26'),
	(57, 2, 'Custom Proses', 'administrator', '2024-04-29 15:58:26'),
	(80, 3, 'Mekanik', 'administrator', '2024-04-29 15:58:26'),
	(81, 3, 'Maintenance', 'administrator', '2024-04-29 15:58:26'),
	(82, 3, 'Refrigeration System', 'administrator', '2024-04-29 15:58:26'),
	(83, 3, 'Welding', 'administrator', '2024-04-29 15:58:26'),
	(84, 3, 'Boiler', 'administrator', '2024-04-29 15:58:26'),
	(85, 3, 'Workshop', 'administrator', '2024-04-29 15:58:26'),
	(87, 15, 'Kendaraan', 'administrator', '2024-04-29 15:58:26'),
	(88, 15, 'Limbah', 'administrator', '2024-04-29 15:58:26'),
	(91, 13, 'Accounting', 'administrator', '2024-04-29 15:58:26');

-- Dumping structure for table app-fertilizer.m_goods
CREATE TABLE IF NOT EXISTS `m_goods` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `goods` varchar(256) DEFAULT NULL,
  `unit_id` int(16) DEFAULT NULL,
  `goods_type_id` int(16) DEFAULT NULL,
  `qty` varchar(256) DEFAULT NULL,
  `remark` text,
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `log_by` varchar(256) DEFAULT NULL,
  `log_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `unit_id` (`unit_id`),
  KEY `type_id` (`goods_type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_goods: ~13 rows (approximately)
DELETE FROM `m_goods`;
INSERT INTO `m_goods` (`id`, `goods`, `unit_id`, `goods_type_id`, `qty`, `remark`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'AMMONIUM CHLORIDE', 2, 1, NULL, NULL, 1, 'administrator', '2024-06-24 14:00:28', NULL, NULL),
	(2, 'UREA', 2, 1, NULL, NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(3, 'AMMONIUM BICARBONATE', 2, 1, NULL, NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(4, 'POTASSIUM CHLORIDE', 2, 1, NULL, NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(5, 'CLAY', 2, 1, NULL, NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(6, 'FILM COATING AGENT', 2, 1, NULL, NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(7, 'UREA', 2, 2, NULL, NULL, 1, 'administrator', '2024-08-27 10:20:21', NULL, NULL),
	(8, 'ZA (ZWAVELZURE AMONIUM)', 2, 2, NULL, NULL, 1, 'administrator', '2024-08-27 10:20:21', NULL, NULL),
	(9, 'SP-36 (SUPER PHOSPHATE)', 2, 2, NULL, NULL, 1, 'administrator', '2024-08-27 10:20:21', NULL, NULL),
	(10, 'KCL (KALIUM KLORIDA)', 2, 2, NULL, NULL, 1, 'administrator', '2024-08-27 10:20:21', NULL, NULL),
	(11, 'NPK PHONSKA (NITROGEN PHOSPATE KALIUM)', 2, 2, NULL, NULL, 1, 'administrator', '2024-08-27 10:20:21', NULL, NULL),
	(12, 'DOLOMITE (KAPUR KARBONAT)', 2, 2, NULL, NULL, 1, 'administrator', '2024-08-27 10:20:21', NULL, NULL),
	(13, 'ZK (ZWAVELZURE KALI)', 2, 2, NULL, NULL, 1, 'administrator', '2024-08-27 10:20:21', NULL, NULL);

-- Dumping structure for table app-fertilizer.m_goods_type
CREATE TABLE IF NOT EXISTS `m_goods_type` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `type` varchar(256) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `log_by` varchar(256) DEFAULT NULL,
  `log_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_goods_type: ~4 rows (approximately)
DELETE FROM `m_goods_type`;
INSERT INTO `m_goods_type` (`id`, `type`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'Raw Material', 1, 'administrator', '2024-06-24 14:00:28', NULL, NULL),
	(2, 'Finish Goods', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(3, 'Goods', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(4, 'Services', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL);

-- Dumping structure for table app-fertilizer.m_inventory_type
CREATE TABLE IF NOT EXISTS `m_inventory_type` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `type` varchar(256) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `log_by` varchar(256) DEFAULT NULL,
  `log_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_inventory_type: ~7 rows (approximately)
DELETE FROM `m_inventory_type`;
INSERT INTO `m_inventory_type` (`id`, `type`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'Receipt', 1, 'administrator', '2024-06-24 14:00:28', NULL, NULL),
	(2, 'Goods Receipt', 1, 'administrator', '2024-11-26 10:40:52', NULL, NULL),
	(3, 'In', 1, 'administrator', '2024-06-24 14:00:28', NULL, NULL),
	(4, 'Out', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(5, 'Return', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(6, 'Adjustment In', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(7, 'Adjustment Out', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL);

-- Dumping structure for table app-fertilizer.m_menu
CREATE TABLE IF NOT EXISTS `m_menu` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `menu` varchar(128) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '0 = hide; 1 show;',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_menu: ~7 rows (approximately)
DELETE FROM `m_menu`;
INSERT INTO `m_menu` (`id`, `menu`, `status`, `created_by`, `created_at`) VALUES
	(1, 'Administrator', 1, 'Administrator', '2023-12-12 10:43:22'),
	(2, 'User', 1, 'Administrator', '2023-12-12 10:43:22'),
	(3, 'Menu', 1, 'Administrator', '2023-12-12 10:43:22'),
	(7, 'User_management', 0, 'admin', '2024-03-18 15:24:16'),
	(9, 'Purchase', 1, 'admin', '2024-06-18 14:49:21'),
	(10, 'Sales', 1, 'admin', '2024-08-20 10:25:01'),
	(11, 'Inventory', 1, 'admin', '2024-09-06 10:42:02');

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
	(1, 'Goods', 1, 'administrator', '2024-06-24 14:00:28', NULL, NULL),
	(2, 'Service', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL);

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

-- Dumping structure for table app-fertilizer.m_sales_status
CREATE TABLE IF NOT EXISTS `m_sales_status` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `type` varchar(256) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `log_by` varchar(256) DEFAULT NULL,
  `log_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_sales_status: ~4 rows (approximately)
DELETE FROM `m_sales_status`;
INSERT INTO `m_sales_status` (`id`, `type`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'Pending', 1, 'administrator', '2024-06-24 14:00:28', NULL, NULL),
	(2, 'Shipped', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(3, 'Delivered', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(4, 'Cancelled', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_submenu: ~10 rows (approximately)
DELETE FROM `m_submenu`;
INSERT INTO `m_submenu` (`id`, `menu_id`, `title`, `url`, `icon`, `status`, `created_by`, `created_at`) VALUES
	(1, 1, 'Dashboard', 'administrator', 'fas fa-fw fa-tachometer-alt', 1, 'Administrator', '2023-12-12 10:28:19'),
	(2, 2, 'My Profile', 'user', 'fas fa-fw fa-user', 1, 'Administrator', '2023-12-12 10:28:19'),
	(3, 2, 'Edit Profile', 'user/edit', 'fas fa-fw fa-user-edit', 1, 'Administrator', '2023-12-12 10:28:19'),
	(4, 3, 'Menu Management', 'menu', 'fas fa-fw fa-folder', 1, 'Administrator', '2023-12-12 10:28:19'),
	(5, 3, 'Submenu Management', 'menu/submenu', 'fas fa-fw fa-folder-open', 1, 'Administrator', '2023-12-12 10:28:19'),
	(7, 1, 'Role', 'administrator/role', 'fas fa-fw fa-key', 1, 'Administrator', '2023-12-12 10:28:19'),
	(11, 1, 'User', 'user_management', 'fas fa-fw fa-user', 1, NULL, '2024-03-18 14:51:33'),
	(13, 9, 'Purchase', 'purchase', 'fas fa-fw fa-cart-shopping', 1, NULL, '2024-06-18 14:52:41'),
	(14, 10, 'Sales', 'sales', 'fas fa-fw fa-file-invoice-dollar', 1, NULL, '2024-08-20 10:30:45'),
	(15, 11, 'Inventory', 'inventory', 'fas fa-fw fa-boxes-stacked', 1, NULL, '2024-09-06 10:47:59');

-- Dumping structure for table app-fertilizer.m_supplier
CREATE TABLE IF NOT EXISTS `m_supplier` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `supplier` varchar(256) DEFAULT NULL,
  `pic` varchar(256) DEFAULT NULL,
  `email` varchar(256) DEFAULT NULL,
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
INSERT INTO `m_supplier` (`id`, `supplier`, `pic`, `email`, `phone`, `address`, `remark`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'Abadi Jaya', 'Andi', NULL, '088847228293', 'Serang', NULL, 1, 'administrator', '2024-06-24 14:00:28', NULL, NULL),
	(2, 'Berkah Bersinar', 'Budi', NULL, '089518693827', 'Jakarta', NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(3, 'Cahaya Alam', 'Caca', NULL, '083882515493', 'Bandung', NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(4, 'Dadi Makmur', 'Dani', NULL, '084314134921', 'Semarang', NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(5, 'Edi Putra', 'Edi', NULL, '083373986943', 'Yogyakarta', NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(6, 'Fandi Utama', 'Fredi', NULL, '085324383234', 'Surabaya', NULL, 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL);

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
  `status` int(16) DEFAULT NULL,
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table app-fertilizer.m_user: ~1 rows (approximately)
DELETE FROM `m_user`;
INSERT INTO `m_user` (`id`, `user_id`, `name`, `email`, `image`, `password`, `company_id`, `department_id`, `division_id`, `role_id`, `status`, `created_by`, `created_at`) VALUES
	(1, 'admin', 'admin', '-', 'default.png', '$2y$10$31nTmbo9IVv6NnjV7FHNHetkM4aIr18q8XRsRsI/y7qHXaNvtYKxK', 1, 4, 1, 1, 1, 'administrator', '2023-11-29 07:41:59');

-- Dumping structure for table app-fertilizer.m_warehouse
CREATE TABLE IF NOT EXISTS `m_warehouse` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `warehouse` varchar(256) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `log_by` varchar(256) DEFAULT NULL,
  `log_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_warehouse: ~3 rows (approximately)
DELETE FROM `m_warehouse`;
INSERT INTO `m_warehouse` (`id`, `warehouse`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'Warehouse A - Finish Goods', 1, 'administrator', '2024-06-24 14:00:28', NULL, NULL),
	(2, 'Warehouse B - Raw Material', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(3, 'Warehouse C - Process', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL);

-- Dumping structure for table app-fertilizer.t_inventory
CREATE TABLE IF NOT EXISTS `t_inventory` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `inventory_id` varchar(16) NOT NULL,
  `date` date DEFAULT NULL,
  `inventory_type_id` int(16) DEFAULT NULL,
  `warehouse_id` int(16) NOT NULL DEFAULT '0',
  `transaction_id` varchar(16) DEFAULT NULL,
  `remark` text,
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `log_by` varchar(256) DEFAULT NULL,
  `log_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`inventory_id`) USING BTREE,
  KEY `date` (`date`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `purchase_type_id` (`warehouse_id`) USING BTREE,
  KEY `purchase_id` (`inventory_id`) USING BTREE,
  KEY `tax_type` (`transaction_id`) USING BTREE,
  KEY `inventory_type_id` (`inventory_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.t_inventory: ~63 rows (approximately)
DELETE FROM `t_inventory`;
INSERT INTO `t_inventory` (`id`, `inventory_id`, `date`, `inventory_type_id`, `warehouse_id`, `transaction_id`, `remark`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'RCP/092024/00001', '2024-09-26', 1, 2, 'PO/082024/00002', 'test', 0, 'admin', '2024-09-26 17:40:41', 'admin', '2024-10-07 15:23:23'),
	(2, 'RCP/092024/00002', '2024-09-28', 1, 2, 'PO/082024/00002', 'test', 1, 'admin', '2024-09-28 09:47:53', NULL, NULL),
	(3, 'RCP/092024/00003', '2024-09-28', 1, 3, 'PO/082024/00002', 'test edit', 1, 'admin', '2024-09-28 10:59:25', 'admin', '2024-10-01 16:40:35'),
	(4, 'IN/102024/00001', '2024-10-23', 2, 3, 'RCP/092024/00002', '', 1, 'admin', '2024-10-23 13:47:12', NULL, NULL),
	(5, 'IN/102024/00002', '2024-10-24', 2, 2, 'RCP/092024/00003', '', 1, 'admin', '2024-10-24 10:24:08', NULL, NULL),
	(6, 'IN/102024/00003', '2024-10-24', 2, 2, 'RCP/092024/00003', '', 1, 'admin', '2024-10-24 15:47:47', NULL, NULL),
	(7, 'IN/102024/00004', '2024-10-24', 2, 2, 'RCP/092024/00003', '', 1, 'admin', '2024-10-24 15:49:14', NULL, NULL),
	(8, 'RCP/102024/00001', '2024-10-30', 1, 2, 'PO/082024/00002', '', 1, 'admin', '2024-10-30 16:02:07', 'admin', '2024-10-31 15:21:37'),
	(9, 'IN/102024/00005', '2024-10-30', 2, 2, 'RCP/102024/00001', '', 1, 'admin', '2024-10-30 16:06:01', NULL, NULL),
	(10, 'IN/102024/00006', '2024-10-30', 2, 2, 'RCP/102024/00001', '', 1, 'admin', '2024-10-30 16:07:19', NULL, NULL),
	(11, 'IN/102024/00007', '2024-10-30', 2, 2, 'RCP/102024/00001', '', 1, 'admin', '2024-10-30 16:08:19', NULL, NULL),
	(12, 'IN/102024/00008', '2024-10-30', 2, 2, 'RCP/102024/00001', '', 1, 'admin', '2024-10-30 16:59:38', NULL, NULL),
	(13, 'IN/102024/00009', '2024-10-30', 2, 2, 'RCP/102024/00001', '', 1, 'admin', '2024-10-30 17:09:33', NULL, NULL),
	(14, 'IN/102024/00010', '2024-10-30', 2, 2, 'RCP/102024/00001', '', 1, 'admin', '2024-10-30 17:10:16', NULL, NULL),
	(15, 'IN/102024/00011', '2024-10-30', 2, 2, 'RCP/102024/00001', '', 1, 'admin', '2024-10-30 17:20:05', NULL, NULL),
	(16, 'IN/102024/00012', '2024-10-31', 2, 2, 'RCP/102024/00001', '', 1, 'admin', '2024-10-31 09:17:18', NULL, NULL),
	(17, 'IN/102024/00013', '2024-10-31', 2, 2, 'RCP/102024/00001', '', 1, 'admin', '2024-10-31 11:00:46', NULL, NULL),
	(18, 'IN/102024/00014', '2024-10-31', 2, 2, 'RCP/102024/00001', '', 1, 'admin', '2024-10-31 11:07:35', NULL, NULL),
	(19, 'IN/102024/00015', '2024-10-31', 2, 2, 'RCP/102024/00001', '', 1, 'admin', '2024-10-31 11:14:16', NULL, NULL),
	(20, 'IN/102024/00016', '2024-10-31', 2, 2, 'RCP/102024/00001', '', 1, 'admin', '2024-10-31 15:18:43', NULL, NULL),
	(21, 'IN/102024/00017', '2024-10-31', 2, 2, 'RCP/102024/00001', '', 1, 'admin', '2024-10-31 15:21:37', NULL, NULL),
	(22, 'RCP/112024/00001', '2024-11-04', 1, 3, 'PO/092024/00001', 'insert update delete update', 2, 'admin', '2024-11-04 10:58:31', 'admin', '2024-11-09 13:47:59'),
	(23, 'IN/112024/00001', '2024-11-04', 2, 2, 'RCP/112024/00001', 'test', 0, 'admin', '2024-11-04 13:51:46', 'admin', '2024-11-07 09:32:12'),
	(24, 'RCP/112024/00002', '2024-11-07', 1, 2, 'PO/092024/00001', '', 0, 'admin', '2024-11-07 09:45:58', 'admin', '2024-11-07 09:46:14'),
	(25, 'IN/112024/00002', '2024-11-07', 2, 2, 'RCP/112024/00001', '', 0, 'admin', '2024-11-07 09:46:49', 'admin', '2024-11-07 09:47:08'),
	(26, 'RCP/112024/00003', '2024-11-07', 1, 2, 'PO/092024/00001', '', 1, 'admin', '2024-11-07 09:48:11', NULL, NULL),
	(27, 'IN/112024/00003', '2024-11-09', 2, 2, 'RCP/112024/00001', '', 0, 'admin', '2024-11-09 13:47:59', 'admin', '2024-11-09 13:50:13'),
	(28, 'RCP/112024/00004', '2024-11-15', 1, 2, 'PO/112024/00001', '', 2, 'admin', '2024-11-15 15:13:39', 'admin', '2024-11-19 09:27:49'),
	(29, 'IN/112024/00004', '2024-11-15', 2, 2, 'RCP/112024/00004', '', 1, 'admin', '2024-11-15 16:24:29', NULL, NULL),
	(30, 'IN/112024/00005', '2024-11-15', 2, 2, 'RCP/112024/00004', '', 1, 'admin', '2024-11-15 16:38:39', NULL, NULL),
	(31, 'IN/112024/00006', '2024-11-15', 2, 2, 'RCP/112024/00004', '', 1, 'admin', '2024-11-15 16:43:32', NULL, NULL),
	(32, 'IN/112024/00007', '2024-11-16', 2, 2, 'RCP/112024/00004', '', 1, 'admin', '2024-11-16 16:41:54', NULL, NULL),
	(33, 'IN/112024/00008', '2024-11-18', 2, 2, 'RCP/112024/00004', '', 1, 'admin', '2024-11-18 14:18:58', NULL, NULL),
	(34, 'IN/112024/00009', '2024-11-18', 2, 2, 'RCP/112024/00004', '', 1, 'admin', '2024-11-18 14:20:08', NULL, NULL),
	(35, 'IN/112024/00010', '2024-11-18', 2, 2, 'RCP/112024/00004', '', 1, 'admin', '2024-11-18 14:35:46', NULL, NULL),
	(36, 'IN/112024/00011', '2024-11-18', 2, 2, 'RCP/112024/00004', '', 1, 'admin', '2024-11-18 14:47:18', NULL, NULL),
	(37, 'IN/112024/00012', '2024-11-18', 2, 2, 'RCP/112024/00004', '', 1, 'admin', '2024-11-18 14:49:19', NULL, NULL),
	(38, 'RCP/112024/00005', '2024-11-18', 1, 2, 'PO/082024/00003', '', 2, 'admin', '2024-11-18 14:51:04', 'admin', '2024-11-18 14:51:47'),
	(39, 'IN/112024/00013', '2024-11-18', 2, 2, 'RCP/112024/00005', '', 1, 'admin', '2024-11-18 14:51:47', NULL, NULL),
	(40, 'IN/112024/00014', '2024-11-18', 2, 2, 'RCP/112024/00004', '', 1, 'admin', '2024-11-18 15:01:37', NULL, NULL),
	(41, 'IN/112024/00015', '2024-11-18', 2, 2, 'RCP/112024/00004', '', 1, 'admin', '2024-11-18 15:15:11', NULL, NULL),
	(42, 'IN/112024/00016', '2024-11-18', 2, 2, 'RCP/112024/00004', '', 1, 'admin', '2024-11-18 15:22:39', NULL, NULL),
	(43, 'IN/112024/00017', '2024-11-18', 2, 2, 'RCP/112024/00004', '', 1, 'admin', '2024-11-18 15:23:51', NULL, NULL),
	(44, 'IN/112024/00018', '2024-11-18', 2, 2, 'RCP/112024/00004', '', 1, 'admin', '2024-11-18 15:37:07', NULL, NULL),
	(45, 'IN/112024/00019', '2024-11-19', 2, 2, 'RCP/112024/00004', '', 1, 'admin', '2024-11-19 09:18:50', NULL, NULL),
	(46, 'IN/112024/00020', '2024-11-19', 2, 2, 'RCP/112024/00004', '', 1, 'admin', '2024-11-19 09:27:37', NULL, NULL),
	(47, 'IN/112024/00021', '2024-11-19', 2, 2, 'RCP/112024/00004', '', 1, 'admin', '2024-11-19 09:27:49', NULL, NULL),
	(48, 'RCP/112024/00006', '2024-11-19', 1, 2, 'PO/112024/00002', '', 1, 'admin', '2024-11-19 09:49:10', NULL, NULL),
	(49, 'RCP/112024/00007', '2024-11-19', 1, 2, 'PO/112024/00002', '', 2, 'admin', '2024-11-19 09:49:37', 'admin', '2024-11-19 10:10:27'),
	(50, 'IN/112024/00022', '2024-11-19', 2, 2, 'RCP/112024/00007', '', 1, 'admin', '2024-11-19 10:00:45', NULL, NULL),
	(51, 'IN/112024/00023', '2024-11-19', 2, 2, 'RCP/112024/00007', '', 1, 'admin', '2024-11-19 10:10:27', NULL, NULL),
	(52, 'RCP/112024/00008', '2024-11-19', 1, 2, 'PO/112024/00003', '', 2, 'admin', '2024-11-19 15:38:13', 'admin', '2024-11-20 09:18:52'),
	(53, 'IN/112024/00024', '2024-11-19', 2, 3, 'RCP/112024/00008', '', 0, 'admin', '2024-11-20 09:18:52', 'admin', '2024-11-20 11:30:47'),
	(54, 'RCP/112024/00009', '2024-11-20', 1, 2, 'PO/112024/00004', 'test update', 2, 'admin', '2024-11-20 11:33:56', 'admin', '2024-11-25 10:41:03'),
	(55, 'RCP/112024/00010', '2024-11-20', 1, 2, 'PO/112024/00004', '', 2, 'admin', '2024-11-20 11:35:07', 'admin', '2024-11-26 11:06:38'),
	(56, 'IN/112024/00025', '2024-11-21', 2, 1, 'RCP/112024/00009', '', 0, 'admin', '2024-11-21 11:47:46', 'admin', '2024-11-22 23:44:25'),
	(57, 'IN/112024/00026', '2024-11-22', 2, 2, 'RCP/112024/00009', '', 0, 'admin', '2024-11-22 23:45:32', 'admin', '2024-11-22 23:51:18'),
	(58, 'IN/112024/00027', '2024-11-22', 2, 2, 'RCP/112024/00009', '', 0, 'admin', '2024-11-22 23:46:45', 'admin', '2024-11-22 23:51:24'),
	(59, 'IN/112024/00028', '2024-11-22', 2, 2, 'RCP/112024/00009', '', 0, 'admin', '2024-11-22 23:52:38', 'admin', '2024-11-22 23:58:59'),
	(60, 'IN/112024/00029', '2024-11-22', 2, 2, 'RCP/112024/00009', '', 0, 'admin', '2024-11-22 23:59:08', 'admin', '2024-11-23 01:15:36'),
	(61, 'IN/112024/00030', '2024-11-22', 2, 2, 'RCP/112024/00009', 'test update', 1, 'admin', '2024-11-23 01:16:00', 'admin', '2024-11-26 10:21:54'),
	(62, 'IN/112024/00031', '2024-11-23', 2, 2, 'RCP/112024/00009', 'test update', 1, 'admin', '2024-11-23 16:01:32', 'admin', '2024-11-26 10:19:47'),
	(63, 'GRC/112024/00001', '2024-11-26', 2, 2, 'RCP/112024/00010', 'test', 1, 'admin', '2024-11-26 11:06:38', 'admin', '2024-11-26 11:07:03');

-- Dumping structure for table app-fertilizer.t_inventory_detail
CREATE TABLE IF NOT EXISTS `t_inventory_detail` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `inventory_id` varchar(16) NOT NULL,
  `goods_id` varchar(16) DEFAULT NULL,
  `qty` float DEFAULT NULL,
  `unit_id` varchar(16) DEFAULT NULL,
  `qty_taken` float DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `log_by` varchar(256) DEFAULT NULL,
  `log_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`inventory_id`) USING BTREE,
  KEY `goods_id` (`goods_id`) USING BTREE,
  KEY `unit_id` (`unit_id`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `purchase_id` (`inventory_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.t_inventory_detail: ~106 rows (approximately)
DELETE FROM `t_inventory_detail`;
INSERT INTO `t_inventory_detail` (`id`, `inventory_id`, `goods_id`, `qty`, `unit_id`, `qty_taken`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'RCP/092024/00001', '2', 1, '4', NULL, 0, 'admin', '2024-09-26 17:40:41', 'admin', '2024-10-07 15:23:23'),
	(2, 'RCP/092024/00001', '3', 2, '1', NULL, 0, 'admin', '2024-09-26 17:40:41', 'admin', '2024-10-07 15:23:23'),
	(3, 'RCP/092024/00002', '2', 1, '4', NULL, 1, 'admin', '2024-09-28 09:47:53', NULL, NULL),
	(4, 'RCP/092024/00002', '3', 2, '1', NULL, 1, 'admin', '2024-09-28 09:47:53', NULL, NULL),
	(5, 'RCP/092024/00003', '2', 3, '4', NULL, 1, 'admin', '2024-09-28 10:59:25', 'admin', '2024-10-01 16:40:35'),
	(6, 'RCP/092024/00003', '3', 3, '1', NULL, 1, 'admin', '2024-09-28 10:59:26', 'admin', '2024-10-01 16:40:35'),
	(7, 'RCP/092024/00002', '3', 2, '1', NULL, 1, 'admin', '2024-09-28 09:47:53', NULL, NULL),
	(8, 'RCP/092024/00002', '3', 2, '1', NULL, 1, 'admin', '2024-09-28 09:47:53', NULL, NULL),
	(9, 'RCP/092024/00002', '3', 2, '1', NULL, 1, 'admin', '2024-09-28 09:47:53', NULL, NULL),
	(10, 'RCP/092024/00002', '3', 2, '1', NULL, 1, 'admin', '2024-09-28 09:47:53', NULL, NULL),
	(11, 'RCP/092024/00002', '3', 2, '1', NULL, 1, 'admin', '2024-09-28 09:47:53', NULL, NULL),
	(12, 'RCP/092024/00002', '3', 2, '1', NULL, 1, 'admin', '2024-09-28 09:47:53', NULL, NULL),
	(13, 'IN/102024/00001', '2', 1, '4', NULL, 1, 'admin', '2024-10-23 13:47:12', NULL, NULL),
	(14, 'IN/102024/00001', '3', 2, '1', NULL, 1, 'admin', '2024-10-23 13:47:12', NULL, NULL),
	(15, 'IN/102024/00001', '3', 2, '1', NULL, 1, 'admin', '2024-10-23 13:47:12', NULL, NULL),
	(16, 'IN/102024/00001', '3', 2, '1', NULL, 1, 'admin', '2024-10-23 13:47:12', NULL, NULL),
	(17, 'IN/102024/00001', '3', 2, '1', NULL, 1, 'admin', '2024-10-23 13:47:13', NULL, NULL),
	(18, 'IN/102024/00001', '3', 2, '1', NULL, 1, 'admin', '2024-10-23 13:47:13', NULL, NULL),
	(19, 'IN/102024/00001', '3', 2, '1', NULL, 1, 'admin', '2024-10-23 13:47:13', NULL, NULL),
	(20, 'IN/102024/00001', '3', 2, '1', NULL, 1, 'admin', '2024-10-23 13:47:13', NULL, NULL),
	(21, 'IN/102024/00002', '2', 2, '4', NULL, 1, 'admin', '2024-10-24 10:24:08', NULL, NULL),
	(22, 'IN/102024/00002', '3', 3, '1', NULL, 1, 'admin', '2024-10-24 10:24:08', NULL, NULL),
	(23, 'IN/102024/00003', '2', 2, '4', NULL, 1, 'admin', '2024-10-24 15:47:47', NULL, NULL),
	(24, 'IN/102024/00003', '3', 2, '1', NULL, 1, 'admin', '2024-10-24 15:47:47', NULL, NULL),
	(25, 'IN/102024/00004', '2', 2, '4', NULL, 1, 'admin', '2024-10-24 15:49:14', NULL, NULL),
	(26, 'IN/102024/00004', '3', 2, '1', NULL, 1, 'admin', '2024-10-24 15:49:14', NULL, NULL),
	(27, 'RCP/102024/00001', '2', 1, '4', NULL, 1, 'admin', '2024-10-30 16:02:07', 'admin', '2024-10-31 15:21:37'),
	(28, 'RCP/102024/00001', '3', 2, '1', NULL, 1, 'admin', '2024-10-30 16:02:07', 'admin', '2024-10-31 15:21:37'),
	(29, 'IN/102024/00005', '2', 1, '4', NULL, 2, 'admin', '2024-10-30 16:06:01', 'admin', '2024-10-30 16:06:01'),
	(30, 'IN/102024/00006', '2', 1, '4', NULL, 2, 'admin', '2024-10-30 16:07:19', 'admin', '2024-10-30 16:07:19'),
	(31, 'IN/102024/00007', '2', 1, '4', NULL, 2, 'admin', '2024-10-30 16:08:19', 'admin', '2024-10-30 16:08:19'),
	(32, 'IN/102024/00007', '3', 2, '1', NULL, 2, 'admin', '2024-10-30 16:08:19', 'admin', '2024-10-30 16:08:19'),
	(33, 'IN/102024/00008', '2', 1, '4', NULL, 2, 'admin', '2024-10-30 16:59:38', 'admin', '2024-10-30 16:59:38'),
	(34, 'IN/102024/00009', '2', 1, '4', NULL, 1, 'admin', '2024-10-30 17:09:33', NULL, NULL),
	(35, 'IN/102024/00010', '2', 1, '4', NULL, 1, 'admin', '2024-10-30 17:10:16', NULL, NULL),
	(36, 'IN/102024/00011', '2', 1, '4', NULL, 1, 'admin', '2024-10-30 17:20:05', NULL, NULL),
	(37, 'IN/102024/00011', '3', 2, '1', NULL, 1, 'admin', '2024-10-30 17:20:05', NULL, NULL),
	(38, 'IN/102024/00012', '2', 1, '4', NULL, 1, 'admin', '2024-10-31 09:17:18', NULL, NULL),
	(39, 'IN/102024/00012', '3', 2, '1', NULL, 1, 'admin', '2024-10-31 09:17:18', NULL, NULL),
	(40, 'IN/102024/00013', '2', 0, '4', NULL, 1, 'admin', '2024-10-31 11:00:46', NULL, NULL),
	(41, 'IN/102024/00013', '3', 2, '1', NULL, 1, 'admin', '2024-10-31 11:00:46', NULL, NULL),
	(42, 'IN/102024/00014', '2', 0, '4', NULL, 1, 'admin', '2024-10-31 11:07:35', NULL, NULL),
	(43, 'IN/102024/00014', '3', 2, '1', NULL, 1, 'admin', '2024-10-31 11:07:35', NULL, NULL),
	(44, 'IN/102024/00015', '2', 1, '4', NULL, 1, 'admin', '2024-10-31 11:14:16', NULL, NULL),
	(45, 'IN/102024/00015', '3', 2, '1', NULL, 1, 'admin', '2024-10-31 11:14:16', NULL, NULL),
	(46, 'IN/102024/00016', '2', 1, '4', NULL, 1, 'admin', '2024-10-31 15:18:43', NULL, NULL),
	(47, 'IN/102024/00016', '3', 2, '1', NULL, 1, 'admin', '2024-10-31 15:18:43', NULL, NULL),
	(48, 'IN/102024/00017', '3', 2, '1', NULL, 1, 'admin', '2024-10-31 15:21:37', NULL, NULL),
	(49, 'IN/102024/00017', '2', 1, '4', NULL, 1, 'admin', '2024-10-31 15:21:37', NULL, NULL),
	(50, 'RCP/112024/00001', '5', 8, '2', NULL, 2, 'admin', '2024-11-04 10:58:31', 'admin', '2024-11-09 13:47:59'),
	(51, 'IN/112024/00001', '5', 10, '2', NULL, 0, 'admin', '2024-11-04 13:51:46', 'admin', '2024-11-07 09:32:12'),
	(53, 'RCP/112024/00002', '5', 11, '2', NULL, 0, 'admin', '2024-11-07 09:45:58', 'admin', '2024-11-07 09:46:14'),
	(54, 'IN/112024/00002', '5', 12, '2', NULL, 0, 'admin', '2024-11-07 09:46:49', 'admin', '2024-11-07 09:47:08'),
	(55, 'RCP/112024/00003', '5', 12, '2', NULL, 1, 'admin', '2024-11-07 09:48:11', NULL, NULL),
	(56, 'IN/112024/00003', '5', 12, '2', NULL, 0, 'admin', '2024-11-09 13:47:59', 'admin', '2024-11-09 13:50:13'),
	(57, 'RCP/112024/00004', '5', 30, '2', NULL, 2, 'admin', '2024-11-15 15:13:39', 'admin', '2024-11-19 09:27:49'),
	(58, 'RCP/112024/00004', '3', 10, '2', NULL, 2, 'admin', '2024-11-15 15:13:39', 'admin', '2024-11-19 09:27:49'),
	(59, 'IN/112024/00004', '3', 5, '2', NULL, 1, 'admin', '2024-11-15 16:24:29', NULL, NULL),
	(60, 'IN/112024/00004', '5', 20, '2', NULL, 1, 'admin', '2024-11-15 16:24:29', NULL, NULL),
	(61, 'IN/112024/00005', '3', 5, '2', NULL, 1, 'admin', '2024-11-15 16:38:39', NULL, NULL),
	(62, 'IN/112024/00005', '5', 20, '2', NULL, 1, 'admin', '2024-11-15 16:38:39', NULL, NULL),
	(63, 'IN/112024/00006', '3', 5, '2', NULL, 1, 'admin', '2024-11-15 16:43:32', NULL, NULL),
	(64, 'IN/112024/00007', '3', 5, '2', NULL, 1, 'admin', '2024-11-16 16:41:54', NULL, NULL),
	(65, 'IN/112024/00008', '3', 5, '2', NULL, 1, 'admin', '2024-11-18 14:18:58', NULL, NULL),
	(66, 'IN/112024/00008', '5', 20, '2', NULL, 1, 'admin', '2024-11-18 14:18:58', NULL, NULL),
	(67, 'IN/112024/00009', '5', 20, '2', NULL, 1, 'admin', '2024-11-18 14:20:08', NULL, NULL),
	(68, 'IN/112024/00010', '3', 5, '2', NULL, 1, 'admin', '2024-11-18 14:35:46', NULL, NULL),
	(69, 'IN/112024/00010', '5', 20, '2', NULL, 1, 'admin', '2024-11-18 14:35:46', NULL, NULL),
	(70, 'IN/112024/00011', '3', 20, '2', NULL, 1, 'admin', '2024-11-18 14:47:18', NULL, NULL),
	(71, 'IN/112024/00011', '5', 20, '2', NULL, 1, 'admin', '2024-11-18 14:47:18', NULL, NULL),
	(72, 'IN/112024/00012', '3', 20, '2', NULL, 1, 'admin', '2024-11-18 14:49:19', NULL, NULL),
	(73, 'IN/112024/00012', '5', 100, '2', NULL, 1, 'admin', '2024-11-18 14:49:19', NULL, NULL),
	(74, 'RCP/112024/00005', '3', 11, '1', NULL, 2, 'admin', '2024-11-18 14:51:04', 'admin', '2024-11-18 14:51:47'),
	(75, 'IN/112024/00013', '3', 15, '1', NULL, 1, 'admin', '2024-11-18 14:51:47', NULL, NULL),
	(76, 'IN/112024/00014', '3', 100, '2', NULL, 1, 'admin', '2024-11-18 15:01:37', NULL, NULL),
	(77, 'IN/112024/00014', '5', 20, '2', NULL, 1, 'admin', '2024-11-18 15:01:37', NULL, NULL),
	(78, 'IN/112024/00015', '3', 10, '2', NULL, 1, 'admin', '2024-11-18 15:15:11', NULL, NULL),
	(79, 'IN/112024/00015', '5', 20, '2', NULL, 1, 'admin', '2024-11-18 15:15:11', NULL, NULL),
	(80, 'IN/112024/00016', '3', 20, '2', NULL, 1, 'admin', '2024-11-18 15:22:39', NULL, NULL),
	(81, 'IN/112024/00016', '5', 20, '2', NULL, 1, 'admin', '2024-11-18 15:22:39', NULL, NULL),
	(82, 'IN/112024/00017', '3', 10, '2', NULL, 1, 'admin', '2024-11-18 15:23:51', NULL, NULL),
	(83, 'IN/112024/00017', '5', 15, '2', NULL, 1, 'admin', '2024-11-18 15:23:51', NULL, NULL),
	(84, 'IN/112024/00018', '3', 5, '2', NULL, 1, 'admin', '2024-11-18 15:37:07', NULL, NULL),
	(85, 'IN/112024/00018', '5', 20, '2', NULL, 1, 'admin', '2024-11-18 15:37:07', NULL, NULL),
	(86, 'IN/112024/00019', '3', 10, '2', NULL, 1, 'admin', '2024-11-19 09:18:50', NULL, NULL),
	(87, 'IN/112024/00019', '5', 20, '2', NULL, 1, 'admin', '2024-11-19 09:18:50', NULL, NULL),
	(88, 'IN/112024/00020', '3', 5, '2', NULL, 1, 'admin', '2024-11-19 09:27:37', NULL, NULL),
	(89, 'IN/112024/00020', '5', 10, '2', NULL, 1, 'admin', '2024-11-19 09:27:37', NULL, NULL),
	(90, 'IN/112024/00021', '3', 5, '2', NULL, 1, 'admin', '2024-11-19 09:27:49', NULL, NULL),
	(91, 'IN/112024/00021', '5', 10, '2', NULL, 1, 'admin', '2024-11-19 09:27:49', NULL, NULL),
	(92, 'RCP/112024/00006', '2', 65, '2', NULL, 1, 'admin', '2024-11-19 09:49:10', NULL, NULL),
	(93, 'RCP/112024/00007', '2', 35, '2', NULL, 2, 'admin', '2024-11-19 09:49:37', 'admin', '2024-11-19 10:10:27'),
	(94, 'IN/112024/00022', '2', 35, '2', NULL, 1, 'admin', '2024-11-19 10:00:45', NULL, NULL),
	(95, 'IN/112024/00023', '2', 65, '2', NULL, 1, 'admin', '2024-11-19 10:10:27', NULL, NULL),
	(96, 'RCP/112024/00008', '2', 15, '2', NULL, 2, 'admin', '2024-11-19 15:38:13', 'admin', '2024-11-20 09:18:52'),
	(97, 'IN/112024/00024', '2', 5, '2', NULL, 0, 'admin', '2024-11-20 09:18:52', 'admin', '2024-11-20 11:30:47'),
	(98, 'RCP/112024/00009', '3', 60, '2', 25, 2, 'admin', '2024-11-20 11:33:56', 'admin', '2024-11-23 16:01:32'),
	(99, 'RCP/112024/00010', '3', 40, '2', 5, 2, 'admin', '2024-11-20 11:35:07', 'admin', '2024-11-26 11:06:38'),
	(100, 'IN/112024/00025', '3', 10, '2', NULL, 0, 'admin', '2024-11-21 11:47:46', 'admin', '2024-11-22 23:44:25'),
	(101, 'IN/112024/00026', '3', 10, '2', NULL, 0, 'admin', '2024-11-22 23:45:32', 'admin', '2024-11-22 23:51:18'),
	(102, 'IN/112024/00027', '3', 10, '2', NULL, 0, 'admin', '2024-11-22 23:46:45', 'admin', '2024-11-22 23:51:25'),
	(103, 'IN/112024/00028', '3', 10, '2', NULL, 0, 'admin', '2024-11-22 23:52:38', 'admin', '2024-11-22 23:58:59'),
	(104, 'IN/112024/00029', '3', 10, '2', NULL, 0, 'admin', '2024-11-22 23:59:08', 'admin', '2024-11-23 01:15:36'),
	(105, 'IN/112024/00030', '3', 10, '2', NULL, 1, 'admin', '2024-11-23 01:16:00', 'admin', '2024-11-26 10:21:54'),
	(106, 'IN/112024/00031', '3', 15, '2', NULL, 1, 'admin', '2024-11-23 16:01:32', 'admin', '2024-11-26 10:19:47'),
	(107, 'GRC/112024/00001', '3', 5, '2', NULL, 1, 'admin', '2024-11-26 11:06:38', 'admin', '2024-11-26 11:07:03');

-- Dumping structure for table app-fertilizer.t_purchase
CREATE TABLE IF NOT EXISTS `t_purchase` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `purchase_id` varchar(16) NOT NULL,
  `date` date DEFAULT NULL,
  `purchase_type_id` int(16) NOT NULL DEFAULT '0',
  `supplier_id` int(16) NOT NULL DEFAULT '0',
  `due_date` date DEFAULT NULL,
  `remark` text,
  `currency_id` int(16) unsigned DEFAULT NULL,
  `discount` int(16) DEFAULT NULL,
  `tax_type` tinyint(4) DEFAULT NULL COMMENT ' 1 = Include; 0 = Exclude;',
  `tax` int(16) DEFAULT NULL,
  `total` int(16) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.t_purchase: ~15 rows (approximately)
DELETE FROM `t_purchase`;
INSERT INTO `t_purchase` (`id`, `purchase_id`, `date`, `purchase_type_id`, `supplier_id`, `due_date`, `remark`, `currency_id`, `discount`, `tax_type`, `tax`, `total`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(2, 'PO/072024/00013', '2024-07-07', 1, 6, '2024-07-07', 'test', NULL, 10, NULL, 11, 0, 0, 'admin', '2024-07-07 10:16:55', 'admin', '2024-09-23 15:26:36'),
	(3, 'PO/072024/00014', '2024-07-07', 1, 6, '2024-07-07', 'test', NULL, 10, NULL, 0, 108, 0, 'admin', '2024-07-07 10:27:11', 'admin', '2024-09-23 15:26:33'),
	(4, 'PO/072024/00015', '2024-07-07', 1, 6, '2024-07-07', 'test', NULL, 10, NULL, 11, 44033, 0, 'admin', '2024-07-07 10:33:35', 'admin', '2024-09-23 15:26:30'),
	(6, 'PO/072024/00017', '2024-07-07', 1, 4, '2024-07-07', '', NULL, 5, NULL, 11, 85950, 0, 'admin', '2024-07-07 14:04:00', 'admin', '2024-09-23 15:26:27'),
	(7, 'PO/072024/00018', '2024-07-09', 2, 1, '2024-07-16', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', NULL, 20, NULL, 0, 1985806, 0, 'admin', '2024-07-09 09:48:45', 'admin', '2024-09-23 15:26:24'),
	(8, 'PO/072024/00019', '2024-07-21', 1, 6, '2024-07-21', 'test', NULL, 0, NULL, 0, 29500, 0, 'admin', '2024-07-21 08:57:14', 'admin', '2024-07-21 09:50:29'),
	(9, 'PO/072024/00020', '2024-07-21', 1, 1, '2024-07-21', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', NULL, 0, NULL, 0, 1000, 0, 'admin', '2024-07-21 21:20:33', 'admin', '2024-09-23 15:26:22'),
	(10, 'PO/082024/00001', '2024-08-06', 1, 1, '2024-08-07', 'test', NULL, 0, NULL, 11, 5, 0, 'admin', '2024-08-06 15:08:56', 'admin', '2024-09-23 15:24:46'),
	(11, 'PO/082024/00002', '2024-08-06', 1, 1, '2024-08-07', 'test 2', 1, 1, 0, 2, 5, 1, 'admin', '2024-08-06 15:52:33', 'admin', '2024-08-06 15:53:35'),
	(12, 'PO/082024/00003', '2024-08-07', 1, 1, '2024-08-07', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 1, 1, 0, 2, 5, 1, 'admin', '2024-08-07 14:22:46', 'admin', '2024-08-08 12:00:32'),
	(13, 'PO/092024/00001', '2024-09-11', 1, 1, '2024-09-11', 'test', 3, 10, 1, 11, 949, 1, 'admin', '2024-09-11 10:27:38', NULL, NULL),
	(14, 'PO/112024/00001', '2024-11-15', 1, 1, '2024-11-30', 'test Receipt', 1, 0, 0, 0, 300, 1, 'admin', '2024-11-15 15:09:03', NULL, NULL),
	(15, 'PO/112024/00002', '2024-11-19', 1, 2, '2024-11-19', 'test PO dengan receipt parsial', 1, 0, 0, 0, 10000, 1, 'admin', '2024-11-19 09:39:13', NULL, NULL),
	(16, 'PO/112024/00003', '2024-11-19', 1, 1, '2024-11-19', 'test', 1, 0, 0, 0, 10000, 1, 'admin', '2024-11-19 15:35:07', NULL, NULL),
	(17, 'PO/112024/00004', '2024-11-20', 1, 1, '2024-11-20', '', 1, 0, 0, 0, 100000, 1, 'admin', '2024-11-20 11:31:46', NULL, NULL);

-- Dumping structure for table app-fertilizer.t_purchase_detail
CREATE TABLE IF NOT EXISTS `t_purchase_detail` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
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
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.t_purchase_detail: ~62 rows (approximately)
DELETE FROM `t_purchase_detail`;
INSERT INTO `t_purchase_detail` (`id`, `purchase_id`, `goods_id`, `qty`, `unit_id`, `price`, `discount`, `subtotal`, `qty_received`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(3, 'PO/072024/00014', '2', 20, '4', 2000, 5, 38000, NULL, 0, 'admin', '2024-07-07 10:27:11', 'admin', '2024-09-23 15:26:33'),
	(4, 'PO/072024/00014', '3', 10, '1', 500, 0, 5000, NULL, 0, 'admin', '2024-07-07 10:27:11', 'admin', '2024-09-23 15:26:33'),
	(5, 'PO/072024/00014', '4', 5, '1', 200, NULL, 1000, NULL, 0, 'admin', '2024-07-07 10:27:11', 'admin', '2024-09-23 15:26:33'),
	(6, 'PO/072024/00015', '2', 20, '4', 2000, 1, 38000, NULL, 0, 'admin', '2024-07-07 10:33:35', 'admin', '2024-09-23 15:26:30'),
	(7, 'PO/072024/00015', '3', 10, '1', 500, 0, 5000, NULL, 0, 'admin', '2024-07-07 10:33:35', 'admin', '2024-09-23 15:26:30'),
	(8, 'PO/072024/00015', '4', 5, '1', 200, 0, 1000, NULL, 0, 'admin', '2024-07-07 10:33:35', 'admin', '2024-09-23 15:26:30'),
	(9, 'PO/072024/00016', '', 0, '', 0, 1, 0, NULL, 1, 'admin', '2024-07-07 10:59:07', NULL, NULL),
	(10, 'PO/072024/00017', '2', 100, '4', 500, 1, 47500, NULL, 0, 'admin', '2024-07-07 14:04:00', 'admin', '2024-09-23 15:26:27'),
	(11, 'PO/072024/00017', '5', 2, '3', 10000, 0, 20000, NULL, 0, 'admin', '2024-07-07 14:04:00', 'admin', '2024-09-23 15:26:27'),
	(12, 'PO/072024/00018', '2', 500, '4', 2001, 0, 890445, NULL, 0, 'admin', '2024-07-09 09:48:45', 'admin', '2024-09-23 15:26:24'),
	(13, 'PO/072024/00018', '1', 300, '1', 1001, 0, 240240, NULL, 0, 'admin', '2024-07-09 09:48:45', 'admin', '2024-09-23 15:26:24'),
	(14, 'PO/072024/00018', '4', 2100, '1', 101, 0, 180285, NULL, 0, 'admin', '2024-07-16 14:31:05', 'admin', '2024-09-23 15:26:24'),
	(15, 'PO/072024/00018', '4', 2200, '1', 101, 0, 211090, NULL, 0, 'admin', '2024-07-16 14:52:56', 'admin', '2024-09-23 15:26:24'),
	(16, 'PO/072024/00018', '1', 100, '1', 500, 0, 48500, NULL, 0, 'admin', '2024-07-16 14:56:11', 'admin', '2024-09-23 15:26:24'),
	(17, 'PO/072024/00018', '2', 1000, '4', 500, 0, 475000, NULL, 0, 'admin', '2024-07-16 17:41:16', 'admin', '2024-09-23 15:26:24'),
	(18, 'PO/072024/00018', '2', 1, '4', 5000, 0, 4700, NULL, 0, 'admin', '2024-07-17 10:33:51', 'admin', '2024-09-23 15:26:24'),
	(19, 'PO/072024/00018', '2', 1, '4', 5000, 0, 4650, NULL, 0, 'admin', '2024-07-17 10:36:03', 'admin', '2024-09-23 15:26:24'),
	(20, 'PO/072024/00018', '1', 1, '1', 1000, 0, 920, NULL, 0, 'admin', '2024-07-17 10:36:03', 'admin', '2024-09-23 15:26:24'),
	(21, 'PO/072024/00018', '4', 10, '1', 10, 0, 91, NULL, 0, 'admin', '2024-07-17 11:08:32', 'admin', '2024-09-23 15:26:24'),
	(22, 'PO/072024/00018', '4', 10, '1', 10, 0, 90, NULL, 0, 'admin', '2024-07-17 13:25:31', 'admin', '2024-09-23 15:26:24'),
	(23, 'PO/072024/00018', '1', 100, '1', 100, 0, 8900, NULL, 0, 'admin', '2024-07-17 13:25:31', 'admin', '2024-09-23 15:26:24'),
	(24, 'PO/072024/00018', '4', 10, '1', 10, 0, 88, NULL, 0, 'admin', '2024-07-17 14:22:21', 'admin', '2024-09-23 15:26:24'),
	(25, 'PO/072024/00018', '1', 100, '1', 100, 0, 8700, NULL, 0, 'admin', '2024-07-17 14:22:21', 'admin', '2024-09-23 15:26:24'),
	(26, 'PO/072024/00018', '4', 10, '1', 10, 0, 86, NULL, 0, 'admin', '2024-07-17 14:22:21', 'admin', '2024-09-23 15:26:24'),
	(27, 'PO/072024/00018', '4', 10, '1', 10, 0, 85, NULL, 0, 'admin', '2024-07-17 15:20:34', 'admin', '2024-09-23 15:26:24'),
	(28, 'PO/072024/00018', '1', 100, '1', 100, 0, 10000, NULL, 0, 'admin', '2024-07-17 15:20:34', 'admin', '2024-09-23 15:26:24'),
	(29, 'PO/072024/00018', '4', 10, '1', 10, 0, 99, NULL, 0, 'admin', '2024-07-17 15:20:34', 'admin', '2024-09-23 15:26:24'),
	(30, 'PO/072024/00018', '2', 123, '4', 456, 0, 56088, NULL, 0, 'admin', '2024-07-17 15:32:59', 'admin', '2024-09-23 15:26:24'),
	(31, 'PO/072024/00018', '2', 10, '4', 200, 0, 2000, NULL, 0, 'admin', '2024-07-18 10:18:13', 'admin', '2024-09-23 15:26:24'),
	(32, 'PO/072024/00018', '2', 100, '4', 123, 0, 12300, NULL, 0, 'admin', '2024-07-18 10:50:39', 'admin', '2024-09-23 15:26:24'),
	(33, 'PO/072024/00018', '2', 200, '4', 456, 0, 91200, NULL, 0, 'admin', '2024-07-18 10:52:22', 'admin', '2024-09-23 15:26:24'),
	(34, 'PO/072024/00018', '4', 300, '1', 789, 0, 236700, NULL, 0, 'admin', '2024-07-18 10:53:58', 'admin', '2024-09-23 15:26:24'),
	(35, 'PO/072024/00017', '1', 200, '1', 50, 10, 9000, NULL, 0, 'admin', '2024-07-18 16:04:35', 'admin', '2024-09-23 15:26:27'),
	(36, 'PO/072024/00017', '2', 500, '4', 10, 0, 5000, NULL, 0, 'admin', '2024-07-18 16:19:55', 'admin', '2024-09-23 15:26:27'),
	(37, 'PO/072024/00017', '4', 1, '1', 2, 0, 2, NULL, 0, 'admin', '2024-07-18 16:58:41', 'admin', '2024-09-23 15:26:27'),
	(38, 'PO/072024/00017', '3', 2, '1', 3, 4, 5.76, NULL, 0, 'admin', '2024-07-18 16:58:41', 'admin', '2024-09-23 15:26:27'),
	(39, 'PO/072024/00015', '4', 1, '1', 2, 0, 2, NULL, 0, 'admin', '2024-07-18 17:01:18', 'admin', '2024-09-23 15:26:30'),
	(40, 'PO/072024/00015', '4', 4, '1', 5, 6, 18.8, NULL, 0, 'admin', '2024-07-18 17:01:47', 'admin', '2024-09-23 15:26:30'),
	(41, 'PO/072024/00015', '4', 7, '1', 8, 0, 56, NULL, 0, 'admin', '2024-07-18 17:01:47', 'admin', '2024-09-23 15:26:30'),
	(42, 'PO/072024/00013', '5', 100, '3', 1, 0, 100, NULL, 0, 'admin', '2024-07-19 22:44:48', 'admin', '2024-09-23 15:26:36'),
	(43, 'PO/072024/00013', '4', 200, '1', 1, 5, 190, NULL, 0, 'admin', '2024-07-19 22:46:03', 'admin', '2024-09-23 15:26:36'),
	(44, 'PO/072024/00013', '5', 300, '3', 1, 10, 270, NULL, 0, 'admin', '2024-07-19 23:17:02', 'admin', '2024-09-23 15:26:36'),
	(45, 'PO/072024/00013', '1', 400, '1', 1, 0, 400, NULL, 0, 'admin', '2024-07-19 23:17:02', 'admin', '2024-09-23 15:26:36'),
	(46, 'PO/072024/00014', '4', 10, '1', 500, 0, 5000, NULL, 0, 'admin', '2024-07-19 23:43:43', 'admin', '2024-09-23 15:26:33'),
	(47, 'PO/072024/00014', '3', 100, '1', 100, 0, 10000, NULL, 0, 'admin', '2024-07-19 23:43:56', 'admin', '2024-09-23 15:26:33'),
	(48, 'PO/072024/00014', '1', 12, '1', 10, 0, 120, NULL, 0, 'admin', '2024-07-19 23:44:54', 'admin', '2024-09-23 15:26:33'),
	(49, 'PO/072024/00013', '3', 200, '1', 100, 0, 20000, NULL, 0, 'admin', '2024-07-21 08:12:27', 'admin', '2024-09-23 15:26:36'),
	(50, 'PO/072024/00019', '2', 100, '4', 100, 5, 9500, NULL, 0, 'admin', '2024-07-21 08:57:14', 'admin', '2024-07-21 09:50:29'),
	(51, 'PO/072024/00019', '5', 200, '3', 100, 0, 20000, NULL, 0, 'admin', '2024-07-21 08:57:14', 'admin', '2024-07-21 09:50:29'),
	(53, 'PO/072024/00020', '2', 100, '4', 10, 0, 1000, NULL, 0, 'admin', '2024-07-21 21:20:33', 'admin', '2024-09-23 15:26:22'),
	(54, 'PO/082024/00001', '2', 1, '4', 1, 1, 0.99, NULL, 0, 'admin', '2024-08-06 15:08:56', 'admin', '2024-09-23 15:24:46'),
	(55, 'PO/082024/00001', '3', 2, '1', 2, 2, 3.92, NULL, 0, 'admin', '2024-08-06 15:08:56', 'admin', '2024-09-23 15:24:46'),
	(56, 'PO/082024/00002', '2', 1, '4', 1, 1, 0.99, 2, 1, 'admin', '2024-08-06 15:52:33', 'admin', '2024-10-31 15:21:37'),
	(57, 'PO/082024/00002', '3', 2, '1', 2, 2, 3.92, 1, 1, 'admin', '2024-08-06 15:52:33', 'admin', '2024-10-31 15:21:37'),
	(58, 'PO/082024/00003', '2', 1, '4', 1, 1, 0.99, 1, 1, 'admin', '2024-08-07 14:22:46', 'admin', '2024-08-08 12:00:32'),
	(59, 'PO/082024/00003', '3', 2, '1', 2, 2, 3.92, 15, 1, 'admin', '2024-08-07 14:22:46', 'admin', '2024-11-18 14:51:47'),
	(60, 'PO/092024/00001', '5', 10, '2', 100, 5, 950, 12, 1, 'admin', '2024-09-11 10:27:38', 'admin', '2024-11-09 13:47:59'),
	(61, 'PO/112024/00001', '3', 10, '2', 10, 0, 100, 10, 1, 'admin', '2024-11-15 15:09:03', 'admin', '2024-11-19 09:27:49'),
	(62, 'PO/112024/00001', '5', 20, '2', 10, 0, 200, 20, 1, 'admin', '2024-11-15 15:09:03', 'admin', '2024-11-19 09:27:49'),
	(63, 'PO/112024/00002', '2', 100, '2', 100, 0, 10000, 100, 1, 'admin', '2024-11-19 09:39:13', 'admin', '2024-11-19 10:10:27'),
	(64, 'PO/112024/00003', '2', 100, '2', 100, 0, 10000, 5, 1, 'admin', '2024-11-19 15:35:07', 'admin', '2024-11-20 09:18:52'),
	(65, 'PO/112024/00004', '3', 100, '2', 1000, 0, 100000, 30, 1, 'admin', '2024-11-20 11:31:46', 'admin', '2024-11-26 11:06:38');

-- Dumping structure for table app-fertilizer.t_sales
CREATE TABLE IF NOT EXISTS `t_sales` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `sales_id` varchar(16) NOT NULL,
  `date` date DEFAULT NULL,
  `customer_id` int(16) NOT NULL DEFAULT '0',
  `due_date` date DEFAULT NULL,
  `remark` text,
  `currency_id` int(16) unsigned DEFAULT NULL,
  `discount` int(16) DEFAULT NULL,
  `tax_type` tinyint(4) DEFAULT NULL COMMENT ' 1 = Include; 0 = Exclude;',
  `tax` int(16) DEFAULT NULL,
  `total` int(16) DEFAULT NULL,
  `sales_status_id` tinyint(4) DEFAULT NULL COMMENT ' 1 = Include; 0 = Exclude;',
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `log_by` varchar(256) DEFAULT NULL,
  `log_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`sales_id`) USING BTREE,
  KEY `date` (`date`) USING BTREE,
  KEY `due_date` (`due_date`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `currency_id` (`currency_id`) USING BTREE,
  KEY `purchase_type_id` (`customer_id`) USING BTREE,
  KEY `purchase_id` (`sales_id`) USING BTREE,
  KEY `tax_type` (`sales_status_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.t_sales: ~3 rows (approximately)
DELETE FROM `t_sales`;
INSERT INTO `t_sales` (`id`, `sales_id`, `date`, `customer_id`, `due_date`, `remark`, `currency_id`, `discount`, `tax_type`, `tax`, `total`, `sales_status_id`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'SO/082024/00003', '2024-08-27', 2, '2024-08-29', 'update', 1, 11, 0, 0, 21, NULL, 1, 'admin', '2024-08-27 11:49:12', 'admin', '2024-08-29 10:37:27'),
	(2, 'SO/082024/00004', '2024-08-27', 2, '2024-08-27', 'test', 3, 10, 1, 11, 5, NULL, 1, 'admin', '2024-08-27 22:32:03', NULL, NULL),
	(3, 'SO/082024/00005', '2024-08-29', 1, '2024-08-29', 'test', 3, 1, 1, 1, 1, NULL, 0, 'admin', '2024-08-29 14:25:42', 'admin', '2024-08-29 14:28:42');

-- Dumping structure for table app-fertilizer.t_sales_detail
CREATE TABLE IF NOT EXISTS `t_sales_detail` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `sales_id` varchar(16) NOT NULL,
  `goods_id` varchar(16) DEFAULT NULL,
  `qty` float DEFAULT NULL,
  `unit_id` varchar(16) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `discount` float DEFAULT NULL,
  `subtotal` float DEFAULT NULL,
  `qty_shipped` float DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `log_by` varchar(256) DEFAULT NULL,
  `log_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`sales_id`) USING BTREE,
  KEY `goods_id` (`goods_id`) USING BTREE,
  KEY `unit_id` (`unit_id`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `purchase_id` (`sales_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.t_sales_detail: ~6 rows (approximately)
DELETE FROM `t_sales_detail`;
INSERT INTO `t_sales_detail` (`id`, `sales_id`, `goods_id`, `qty`, `unit_id`, `price`, `discount`, `subtotal`, `qty_shipped`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'SO/082024/00003', '10', 2, '2', 2, 2, 3.92, NULL, 0, 'admin', '2024-08-27 11:49:12', 'admin', '2024-08-29 10:37:27'),
	(2, 'SO/082024/00004', '12', 1, '2', 1, 1, 0.99, NULL, 1, 'admin', '2024-08-27 22:32:03', NULL, NULL),
	(3, 'SO/082024/00004', '10', 2, '2', 2, 2, 3.92, NULL, 1, 'admin', '2024-08-27 22:32:03', NULL, NULL),
	(4, 'SO/082024/00003', '11', 3, '2', 3, 3, 8.73, NULL, 1, 'admin', '2024-08-29 10:36:34', 'admin', '2024-08-29 10:37:27'),
	(5, 'SO/082024/00003', '7', 4, '2', 4, 4, 15.36, NULL, 1, 'admin', '2024-08-29 10:37:27', NULL, NULL),
	(6, 'SO/082024/00005', '12', 1, '2', 1, 1, 0.99, NULL, 0, 'admin', '2024-08-29 14:25:42', 'admin', '2024-08-29 14:28:42');

-- Dumping structure for table app-fertilizer.t_stock
CREATE TABLE IF NOT EXISTS `t_stock` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `warehouse_id` varchar(16) NOT NULL,
  `year` year(4) DEFAULT NULL,
  `month` varchar(4) NOT NULL DEFAULT '0',
  `goods_id` varchar(16) DEFAULT NULL,
  `qty_in` float DEFAULT NULL,
  `qty_out` float DEFAULT NULL,
  `qty_balance` float DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `log_by` varchar(256) DEFAULT NULL,
  `log_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `warehouse_id` (`warehouse_id`),
  KEY `year` (`year`),
  KEY `month` (`month`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.t_stock: ~1 rows (approximately)
DELETE FROM `t_stock`;
INSERT INTO `t_stock` (`id`, `warehouse_id`, `year`, `month`, `goods_id`, `qty_in`, `qty_out`, `qty_balance`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(19, '2', '2024', '11', '3', 30, NULL, 30, 1, 'admin', '2024-11-23 01:16:00', 'admin', '2024-11-26 11:06:38');

-- Dumping structure for table app-fertilizer.t_stock_card
CREATE TABLE IF NOT EXISTS `t_stock_card` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(16) NOT NULL,
  `warehouse_id` varchar(16) NOT NULL,
  `date` date DEFAULT NULL,
  `inventory_type_id` varchar(16) NOT NULL,
  `goods_id` varchar(16) DEFAULT NULL,
  `qty` float DEFAULT NULL,
  `unit_id` varchar(16) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `log_by` varchar(256) DEFAULT NULL,
  `log_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`transaction_id`) USING BTREE,
  KEY `goods_id` (`goods_id`) USING BTREE,
  KEY `unit_id` (`unit_id`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `purchase_id` (`transaction_id`) USING BTREE,
  KEY `date` (`date`),
  KEY `warehouse_id` (`warehouse_id`),
  KEY `inventory_type_id` (`inventory_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.t_stock_card: ~3 rows (approximately)
DELETE FROM `t_stock_card`;
INSERT INTO `t_stock_card` (`id`, `transaction_id`, `warehouse_id`, `date`, `inventory_type_id`, `goods_id`, `qty`, `unit_id`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(35, 'IN/112024/00030', '2', '2024-11-22', '2', '3', 10, '2', 1, 'admin', '2024-11-23 01:16:00', NULL, NULL),
	(36, 'IN/112024/00031', '2', '2024-11-23', '2', '3', 15, '2', 1, 'admin', '2024-11-23 16:01:32', NULL, NULL),
	(37, 'GRC/112024/00001', '2', '2024-11-26', '2', '3', 5, '2', 1, 'admin', '2024-11-26 11:06:38', NULL, NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
