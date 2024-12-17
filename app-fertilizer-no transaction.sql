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

-- Data exporting was unselected.

-- Dumping structure for table app-fertilizer.m_company
CREATE TABLE IF NOT EXISTS `m_company` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `company` varchar(256) DEFAULT NULL,
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

-- Dumping structure for table app-fertilizer.m_department
CREATE TABLE IF NOT EXISTS `m_department` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `department` varchar(256) DEFAULT NULL,
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

-- Dumping structure for table app-fertilizer.m_menu
CREATE TABLE IF NOT EXISTS `m_menu` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `menu` varchar(128) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '0 = hide; 1 show;',
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table app-fertilizer.m_position
CREATE TABLE IF NOT EXISTS `m_position` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `position` varchar(256) DEFAULT NULL,
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

-- Dumping structure for table app-fertilizer.m_role
CREATE TABLE IF NOT EXISTS `m_role` (
  `id` int(16) unsigned NOT NULL AUTO_INCREMENT,
  `role` varchar(256) DEFAULT NULL,
  `created_by` varchar(256) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table app-fertilizer.m_token
CREATE TABLE IF NOT EXISTS `m_token` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(16) NOT NULL,
  `token` varchar(128) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
