-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.51 - MySQL Community Server (GPL)
-- Server OS:                    Linux
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_counter: ~14 rows (approximately)
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
	(12, 'inv-goodsReceipt', 1, '112024', 1, 'admin', '2024-11-26 11:06:38'),
	(13, 'purchase', 1, '122024', 1, 'admin', '2024-12-17 07:37:28'),
	(14, 'inv-receipt', 1, '122024', 1, 'admin', '2024-12-17 07:53:27'),
	(15, 'sales', 1, '122024', 1, 'admin', '2024-12-17 08:31:23');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table app-fertilizer.m_department: ~0 rows (approximately)
DELETE FROM `m_department`;

-- Dumping structure for table app-fertilizer.m_division
CREATE TABLE IF NOT EXISTS `m_division` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `department_id` int(16) NOT NULL,
  `division` varchar(256) DEFAULT NULL,
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`department_id`) USING BTREE,
  KEY `department_id` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_division: ~0 rows (approximately)
DELETE FROM `m_division`;

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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_goods: ~21 rows (approximately)
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
	(13, 'ZK (ZWAVELZURE KALI)', 2, 2, NULL, NULL, 1, 'administrator', '2024-08-27 10:20:21', NULL, NULL),
	(14, 'MONTMORILLONITE CLAY', 6, 1, NULL, NULL, 1, 'administrator', '2024-08-27 10:20:21', NULL, NULL),
	(15, 'AMMONIUM CHLORIDE 25-0-0', 6, 1, NULL, NULL, 1, 'administrator', '2024-08-27 10:20:21', NULL, NULL),
	(16, 'ANTI-CAKING AGENT (PASTE)', 6, 1, NULL, NULL, 1, 'administrator', '2024-08-27 10:20:21', NULL, NULL),
	(17, 'ANTI-CAKING AGENT (POWDER)', 6, 1, NULL, NULL, 1, 'administrator', '2024-08-27 10:20:21', NULL, NULL),
	(18, 'PUNCAK KASTIL 15 + 15 + 15\n', 2, 2, NULL, NULL, 1, 'administrator', '2024-08-27 10:20:21', NULL, NULL),
	(19, 'PUNCAK KASTIL 16 + 16 + 16', 2, 2, NULL, NULL, 1, 'administrator', '2024-08-27 10:20:21', NULL, NULL),
	(20, 'GREEN WATER 15 + 15 + 15', 2, 2, NULL, NULL, 1, 'administrator', '2024-08-27 10:20:21', NULL, NULL),
	(21, 'GREEN WATER 16 + 16 + 16', 2, 2, NULL, NULL, 1, 'administrator', '2024-08-27 10:20:21', NULL, NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_position: ~0 rows (approximately)
DELETE FROM `m_position`;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_supplier: ~1 rows (approximately)
DELETE FROM `m_supplier`;
INSERT INTO `m_supplier` (`id`, `supplier`, `pic`, `email`, `phone`, `address`, `remark`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'TAIZHOU ZHEHAO TRADE CO.,LTD', NULL, 'zhehaotraoe@126.com', NULL, 'NO 61 ZONE 2 NANMENG VILLAGE JINQING TOWN LUQIAO DISTRICT TAIZHOU ZHEJIAN CHINA', NULL, 1, 'administrator', '2024-12-17 07:20:51', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.m_unit: ~6 rows (approximately)
DELETE FROM `m_unit`;
INSERT INTO `m_unit` (`id`, `unit`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'Pcs', 1, 'administrator', '2024-06-24 14:00:28', NULL, NULL),
	(2, 'Kg', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(3, 'Drum', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(4, 'Roll', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(5, 'Cartoon', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL),
	(6, 'Ton', 1, 'administrator', '2024-06-24 14:00:35', NULL, NULL);

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
  `destination_id` int(16) NOT NULL DEFAULT '0',
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
  KEY `purchase_id` (`inventory_id`) USING BTREE,
  KEY `tax_type` (`transaction_id`) USING BTREE,
  KEY `inventory_type_id` (`inventory_type_id`),
  KEY `purchase_type_id` (`destination_id`) USING BTREE,
  KEY `warehouse_id` (`warehouse_id`),
  KEY `destination_id` (`destination_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.t_inventory: ~1 rows (approximately)
DELETE FROM `t_inventory`;
INSERT INTO `t_inventory` (`id`, `inventory_id`, `date`, `inventory_type_id`, `warehouse_id`, `destination_id`, `transaction_id`, `remark`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'RCP/122024/00001', '2024-12-17', 1, 2, 0, 'PO/122024/00001', 'TEST', 1, 'admin', '2024-12-17 07:53:27', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.t_inventory_detail: ~1 rows (approximately)
DELETE FROM `t_inventory_detail`;
INSERT INTO `t_inventory_detail` (`id`, `inventory_id`, `goods_id`, `qty`, `unit_id`, `qty_taken`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'RCP/122024/00001', '14', 50, '6', NULL, 1, 'admin', '2024-12-17 07:53:27', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.t_purchase: ~1 rows (approximately)
DELETE FROM `t_purchase`;
INSERT INTO `t_purchase` (`id`, `purchase_id`, `date`, `purchase_type_id`, `supplier_id`, `due_date`, `remark`, `currency_id`, `discount`, `tax_type`, `tax`, `total`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'PO/122024/00001', '2024-12-17', 1, 1, '2024-12-17', 'TEST', 3, 0, 0, 0, 500, 1, 'admin', '2024-12-17 07:37:28', 'admin', '2024-12-17 14:38:01');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.t_purchase_detail: ~1 rows (approximately)
DELETE FROM `t_purchase_detail`;
INSERT INTO `t_purchase_detail` (`id`, `purchase_id`, `goods_id`, `qty`, `unit_id`, `price`, `discount`, `subtotal`, `qty_received`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(1, 'PO/122024/00001', '14', 100, '6', 5000000, 0, 500000000, NULL, 1, 'admin', '2024-12-17 07:37:28', 'admin', '2024-12-17 14:38:01');

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.t_sales: ~1 rows (approximately)
DELETE FROM `t_sales`;
INSERT INTO `t_sales` (`id`, `sales_id`, `date`, `customer_id`, `due_date`, `remark`, `currency_id`, `discount`, `tax_type`, `tax`, `total`, `sales_status_id`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(4, 'SO/122024/00001', '2024-12-17', 1, '2024-12-17', 'TEST', 1, 0, 0, 0, 100000000, NULL, 1, 'admin', '2024-12-17 08:31:23', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.t_sales_detail: ~1 rows (approximately)
DELETE FROM `t_sales_detail`;
INSERT INTO `t_sales_detail` (`id`, `sales_id`, `goods_id`, `qty`, `unit_id`, `price`, `discount`, `subtotal`, `qty_shipped`, `status`, `created_by`, `created_at`, `log_by`, `log_at`) VALUES
	(7, 'SO/122024/00001', '18', 100, '2', 1000000, 0, 100000000, NULL, 1, 'admin', '2024-12-17 08:31:23', NULL, NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.t_stock: ~0 rows (approximately)
DELETE FROM `t_stock`;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table app-fertilizer.t_stock_card: ~0 rows (approximately)
DELETE FROM `t_stock_card`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
