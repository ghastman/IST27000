CREATE DATABASE  IF NOT EXISTS `ist270` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ist270`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: ist270
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `call_leg_types`
--

DROP TABLE IF EXISTS `call_leg_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `call_leg_types` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `abbreviation` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cdr_statistics`
--

DROP TABLE IF EXISTS `cdr_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cdr_statistics` (
  `file_id` int unsigned NOT NULL,
  `ims_function` int unsigned NOT NULL,
  `fiveminuteepoch` datetime NOT NULL,
  `call_leg_id` int NOT NULL,
  `disco_id` int NOT NULL,
  `count` int unsigned NOT NULL,
  `duration` int unsigned NOT NULL,
  PRIMARY KEY (`file_id`,`ims_function`,`fiveminuteepoch`,`call_leg_id`,`disco_id`),
  KEY `ims_idx` (`ims_function`),
  KEY `call_leg_idx` (`call_leg_id`),
  KEY `disco_idx` (`disco_id`),
  CONSTRAINT `call_leg` FOREIGN KEY (`call_leg_id`) REFERENCES `call_leg_types` (`id`),
  CONSTRAINT `disco` FOREIGN KEY (`disco_id`) REFERENCES `disconnect_codes` (`id`),
  CONSTRAINT `ims_func` FOREIGN KEY (`ims_function`) REFERENCES `ims_functions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `diameter_messages`
--

DROP TABLE IF EXISTS `diameter_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diameter_messages` (
  `diameter_id` int unsigned NOT NULL,
  `cdr_data` varchar(255) NOT NULL,
  PRIMARY KEY (`diameter_id`,`cdr_data`),
  CONSTRAINT `diameter` FOREIGN KEY (`diameter_id`) REFERENCES `diameter_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `diameter_types`
--

DROP TABLE IF EXISTS `diameter_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diameter_types` (
  `id` int unsigned NOT NULL,
  `name` varchar(45) NOT NULL COMMENT 'Known types are \nipv4, carrier_name, mta, route label\n\nunknown number of types',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `disconnect_codes`
--

DROP TABLE IF EXISTS `disconnect_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disconnect_codes` (
  `id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `files_cdr`
--

DROP TABLE IF EXISTS `files_cdr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `files_cdr` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(1024) NOT NULL,
  `ims_function` int unsigned NOT NULL,
  `ccf_node` int NOT NULL,
  `file_create_time` datetime NOT NULL,
  `file_delivery_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filename_UNIQUE` (`filename`),
  KEY `ims_idx` (`ims_function`),
  KEY `node_idx` (`ccf_node`),
  CONSTRAINT `ims` FOREIGN KEY (`ims_function`) REFERENCES `ims_functions` (`id`),
  CONSTRAINT `node` FOREIGN KEY (`ccf_node`) REFERENCES `nodes_ccf` (`id_node`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ims_functions`
--

DROP TABLE IF EXISTS `ims_functions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ims_functions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `filename_key` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filename_key_UNIQUE` (`filename_key`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nodes_ccf`
--

DROP TABLE IF EXISTS `nodes_ccf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nodes_ccf` (
  `id_node` int NOT NULL AUTO_INCREMENT,
  `node_fqdn` varchar(255) NOT NULL DEFAULT 'unknown' COMMENT 'contains FQDN of serving node\n',
  `filename_key` varchar(45) NOT NULL,
  PRIMARY KEY (`id_node`),
  UNIQUE KEY `node_fqdn_UNIQUE` (`node_fqdn`),
  UNIQUE KEY `filename_key_UNIQUE` (`filename_key`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reason_header`
--

DROP TABLE IF EXISTS `reason_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reason_header` (
  `ims_function_id` int unsigned NOT NULL,
  `call_leg_id` int NOT NULL,
  `cdr_data` varchar(255) NOT NULL,
  `validated` int DEFAULT '0',
  PRIMARY KEY (`ims_function_id`,`call_leg_id`,`cdr_data`),
  KEY `ims_idx` (`ims_function_id`),
  KEY `leg_idx` (`call_leg_id`),
  CONSTRAINT `rh_ims` FOREIGN KEY (`ims_function_id`) REFERENCES `ims_functions` (`id`),
  CONSTRAINT `rh_leg` FOREIGN KEY (`call_leg_id`) REFERENCES `call_leg_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-04  9:54:35
