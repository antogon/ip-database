-- MySQL dump 10.13  Distrib 5.5.28, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ip_development
-- ------------------------------------------------------
-- Server version	5.5.28-0ubuntu0.12.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `ip_development`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ip_development` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `ip_development`;

--
-- Table structure for table `device_types`
--

DROP TABLE IF EXISTS `device_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_types`
--

LOCK TABLES `device_types` WRITE;
/*!40000 ALTER TABLE `device_types` DISABLE KEYS */;
INSERT INTO `device_types` VALUES (1,'Router','2012-11-26 20:01:08','2012-11-26 20:01:08');
/*!40000 ALTER TABLE `device_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dhcp_ranges`
--

DROP TABLE IF EXISTS `dhcp_ranges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dhcp_ranges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `network_parent` int(11) DEFAULT NULL,
  `start_ip` tinyblob NOT NULL,
  `end_ip` tinyblob NOT NULL,
  `ip_v4` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dhcp_ranges`
--

LOCK TABLES `dhcp_ranges` WRITE;
/*!40000 ALTER TABLE `dhcp_ranges` DISABLE KEYS */;
INSERT INTO `dhcp_ranges` VALUES (1,'2012-11-26 20:00:31','2012-11-26 20:00:31',6,'c000028c','c00002b4',1),(2,'2012-11-26 20:07:11','2012-11-26 20:07:11',2,'c0000000','c00000ff',1);
/*!40000 ALTER TABLE `dhcp_ranges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dns_device_assocs`
--

DROP TABLE IF EXISTS `dns_device_assocs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dns_device_assocs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dns_device_assocs`
--

LOCK TABLES `dns_device_assocs` WRITE;
/*!40000 ALTER TABLE `dns_device_assocs` DISABLE KEYS */;
/*!40000 ALTER TABLE `dns_device_assocs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dns_ip_joins`
--

DROP TABLE IF EXISTS `dns_ip_joins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dns_ip_joins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dns_id` int(11) NOT NULL,
  `ip_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dns_ip_joins`
--

LOCK TABLES `dns_ip_joins` WRITE;
/*!40000 ALTER TABLE `dns_ip_joins` DISABLE KEYS */;
/*!40000 ALTER TABLE `dns_ip_joins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ip_addresses`
--

DROP TABLE IF EXISTS `ip_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `device_type` int(11) NOT NULL,
  `network_parent` int(11) DEFAULT NULL,
  `desc` text COLLATE utf8_unicode_ci,
  `is_static_dhcp` tinyint(1) NOT NULL DEFAULT '0',
  `has_dns_assoc` tinyint(1) NOT NULL DEFAULT '0',
  `mac_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ip_v4` tinyblob,
  `ip_v6` tinyblob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ip_addresses`
--

LOCK TABLES `ip_addresses` WRITE;
/*!40000 ALTER TABLE `ip_addresses` DISABLE KEYS */;
INSERT INTO `ip_addresses` VALUES (1,'Evan Wechsler','Clemson',1,6,'',1,0,'00:00:00:00:00:00','2012-11-26 20:01:30','2012-11-26 20:01:30','c0000282',NULL);
/*!40000 ALTER TABLE `ip_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networks`
--

DROP TABLE IF EXISTS `networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `creator_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `updater_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `router_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_vrf` tinyint(1) NOT NULL DEFAULT '0',
  `is_hsrp` tinyint(1) NOT NULL DEFAULT '0',
  `desc` text COLLATE utf8_unicode_ci,
  `vlan_no` int(11) DEFAULT NULL,
  `network_parent` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `network_no` tinyblob NOT NULL,
  `netmask` tinyblob NOT NULL,
  `ip_v4` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networks`
--

LOCK TABLES `networks` WRITE;
/*!40000 ALTER TABLE `networks` DISABLE KEYS */;
INSERT INTO `networks` VALUES (1,'Master 192.0.0.0','Evan',NULL,'MASTER ROUTER',0,1,'',NULL,NULL,'2012-11-26 19:37:10','2012-11-26 19:37:10','c0000000','ffff0000',1),(2,'SubMaster 192.0.0.0/24','Evan',NULL,'Router',0,1,'',NULL,1,'2012-11-26 19:41:51','2012-11-26 19:41:51','c0000000','ffffff00',1),(3,'SubMaster 192.0.1.0/24','Evan',NULL,'Router',0,1,'',NULL,1,'2012-11-26 19:42:34','2012-11-26 19:42:34','c0000100','ffffff00',1),(4,'Master 192.1.0.0','Evan',NULL,'Router',0,1,'',NULL,NULL,'2012-11-26 19:44:07','2012-11-26 19:44:07','c0010000','ffff0000',1),(5,'SubMaster 192.0.2.0/25','Evan',NULL,'Router',0,1,'',NULL,1,'2012-11-26 19:46:23','2012-11-26 19:46:23','c0000200','ffffff80',1),(6,'SubMaster 192.0.2.128/26','',NULL,'',0,1,'',NULL,1,'2012-11-26 19:47:51','2012-11-26 19:47:51','c0000280','ffffffc0',1),(7,'Master 1:1:1:1:1:1:1:1/64','Evan',NULL,'Router',0,1,'Testing large ipv6 network',NULL,NULL,'2012-11-26 20:23:32','2012-11-26 22:28:42','00010001000100010001000100010001','ffffffffffffffff0000000000000000',0);
/*!40000 ALTER TABLE `networks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `note_type` varchar(7) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'note',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20120913185744'),('20120913205056'),('20120914201310'),('20120915005208'),('20120918142840'),('20120918145519'),('20120918154900'),('20121020233754'),('20121025000151'),('20121026015419'),('20121103205952'),('20121108003242'),('20121108181957'),('20121111012722'),('20121111013653'),('20121122200814'),('20121122202808'),('20121123024357'),('20121123031130');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-11-26 19:45:19
