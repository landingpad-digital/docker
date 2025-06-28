/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.6.22-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: nextcloud
-- ------------------------------------------------------
-- Server version	10.6.22-MariaDB-ubu2004

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `oc_accounts`
--

DROP TABLE IF EXISTS `oc_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_accounts` (
  `uid` varchar(64) NOT NULL DEFAULT '',
  `data` longtext NOT NULL DEFAULT '',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_accounts`
--

LOCK TABLES `oc_accounts` WRITE;
/*!40000 ALTER TABLE `oc_accounts` DISABLE KEYS */;
INSERT INTO `oc_accounts` VALUES ('Landing Pad Digital','{\"displayname\":{\"value\":\"Landing Pad Digital\",\"scope\":\"v2-federated\",\"verified\":\"0\"},\"address\":{\"value\":\"Thailand\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"website\":{\"value\":\"https:\\/\\/www.landingpad.digital?utm_source=cloud\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"email\":{\"value\":\"support@landingpad.digital\",\"scope\":\"v2-federated\",\"verified\":\"0\"},\"avatar\":{\"value\":\"\",\"scope\":\"v2-federated\",\"verified\":\"0\"},\"phone\":{\"value\":\"\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"twitter\":{\"value\":\"\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"fediverse\":{\"value\":\"\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"organisation\":{\"value\":\"Landing Pad Digital Co., Ltd.\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"role\":{\"value\":\"Website  & Landing Page Builder\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"headline\":{\"value\":\"Build Faster, Dream Bigger: Drag, Drop, Launch \\ud83d\\ude80\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"biography\":{\"value\":\"Launch stunning websites in minutes. Website & Landing Page creation made simple: no code needed.\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"birthdate\":{\"value\":\"2025-06-10T00:00:00.000Z\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"profile_enabled\":{\"value\":\"1\",\"scope\":\"v2-local\",\"verified\":\"0\"},\"pronouns\":{\"value\":\"\",\"scope\":\"v2-federated\",\"verified\":\"0\"}}');
/*!40000 ALTER TABLE `oc_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_accounts_data`
--

DROP TABLE IF EXISTS `oc_accounts_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_accounts_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `value` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `accounts_data_uid` (`uid`),
  KEY `accounts_data_name` (`name`),
  KEY `accounts_data_value` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=379 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_accounts_data`
--

LOCK TABLES `oc_accounts_data` WRITE;
/*!40000 ALTER TABLE `oc_accounts_data` DISABLE KEYS */;
INSERT INTO `oc_accounts_data` VALUES (365,'Landing Pad Digital','displayname','Landing Pad Digital'),(366,'Landing Pad Digital','address','Thailand'),(367,'Landing Pad Digital','website','https://www.landingpad.digital?utm_source=cloud'),(368,'Landing Pad Digital','email','support@landingpad.digital'),(369,'Landing Pad Digital','phone',''),(370,'Landing Pad Digital','twitter',''),(371,'Landing Pad Digital','fediverse',''),(372,'Landing Pad Digital','organisation','Landing Pad Digital Co., Ltd.'),(373,'Landing Pad Digital','role','Website  & Landing Page Builder'),(374,'Landing Pad Digital','headline','Build Faster, Dream Bigger: Drag, Drop, Launch 🚀'),(375,'Landing Pad Digital','biography','Launch stunning websites in minutes. Website & Landing Page creation made simple: no code needed.'),(376,'Landing Pad Digital','birthdate','2025-06-10T00:00:00.000Z'),(377,'Landing Pad Digital','profile_enabled','1'),(378,'Landing Pad Digital','pronouns','');
/*!40000 ALTER TABLE `oc_accounts_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_activity`
--

DROP TABLE IF EXISTS `oc_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_activity` (
  `activity_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `timestamp` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) NOT NULL DEFAULT 0,
  `type` varchar(255) DEFAULT NULL,
  `user` varchar(64) DEFAULT NULL,
  `affecteduser` varchar(64) NOT NULL,
  `app` varchar(32) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `subjectparams` longtext NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `messageparams` longtext DEFAULT NULL,
  `file` varchar(4000) DEFAULT NULL,
  `link` varchar(4000) DEFAULT NULL,
  `object_type` varchar(255) DEFAULT NULL,
  `object_id` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`activity_id`),
  KEY `activity_user_time` (`affecteduser`,`timestamp`),
  KEY `activity_filter_by` (`affecteduser`,`user`,`timestamp`),
  KEY `activity_filter` (`affecteduser`,`type`,`app`,`timestamp`),
  KEY `activity_object` (`object_type`,`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_activity`
--

LOCK TABLES `oc_activity` WRITE;
/*!40000 ALTER TABLE `oc_activity` DISABLE KEYS */;
INSERT INTO `oc_activity` VALUES (1,1750060799,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"3\":\"\\/Readme.md\"}]','','[]','/Readme.md','http://localhost/index.php/apps/files/?dir=/','files',3),(2,1750060799,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"3\":\"\\/Readme.md\"}]','','[]','/Readme.md','http://localhost/index.php/apps/files/?dir=/','files',3),(3,1750060799,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"4\":\"\\/Reasons to use Nextcloud.pdf\"}]','','[]','/Reasons to use Nextcloud.pdf','http://localhost/index.php/apps/files/?dir=/','files',4),(4,1750060799,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"4\":\"\\/Reasons to use Nextcloud.pdf\"}]','','[]','/Reasons to use Nextcloud.pdf','http://localhost/index.php/apps/files/?dir=/','files',4),(5,1750060799,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"5\":\"\\/Templates credits.md\"}]','','[]','/Templates credits.md','http://localhost/index.php/apps/files/?dir=/','files',5),(6,1750060800,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"5\":\"\\/Templates credits.md\"}]','','[]','/Templates credits.md','http://localhost/index.php/apps/files/?dir=/','files',5),(7,1750060800,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"6\":\"\\/Nextcloud intro.mp4\"}]','','[]','/Nextcloud intro.mp4','http://localhost/index.php/apps/files/?dir=/','files',6),(8,1750060800,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"6\":\"\\/Nextcloud intro.mp4\"}]','','[]','/Nextcloud intro.mp4','http://localhost/index.php/apps/files/?dir=/','files',6),(9,1750060800,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"7\":\"\\/Photos\"}]','','[]','/Photos','http://localhost/index.php/apps/files/?dir=/','files',7),(10,1750060800,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"8\":\"\\/Photos\\/Gorilla.jpg\"}]','','[]','/Photos/Gorilla.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',8),(11,1750060800,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"8\":\"\\/Photos\\/Gorilla.jpg\"}]','','[]','/Photos/Gorilla.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',8),(12,1750060800,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"9\":\"\\/Photos\\/Readme.md\"}]','','[]','/Photos/Readme.md','http://localhost/index.php/apps/files/?dir=/Photos','files',9),(13,1750060800,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"9\":\"\\/Photos\\/Readme.md\"}]','','[]','/Photos/Readme.md','http://localhost/index.php/apps/files/?dir=/Photos','files',9),(14,1750060800,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"10\":\"\\/Photos\\/Birdie.jpg\"}]','','[]','/Photos/Birdie.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',10),(15,1750060800,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"10\":\"\\/Photos\\/Birdie.jpg\"}]','','[]','/Photos/Birdie.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',10),(16,1750060800,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"11\":\"\\/Photos\\/Toucan.jpg\"}]','','[]','/Photos/Toucan.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',11),(17,1750060800,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"11\":\"\\/Photos\\/Toucan.jpg\"}]','','[]','/Photos/Toucan.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',11),(18,1750060800,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"12\":\"\\/Photos\\/Library.jpg\"}]','','[]','/Photos/Library.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',12),(19,1750060800,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"12\":\"\\/Photos\\/Library.jpg\"}]','','[]','/Photos/Library.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',12),(20,1750060800,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"13\":\"\\/Photos\\/Vineyard.jpg\"}]','','[]','/Photos/Vineyard.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',13),(21,1750060800,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"13\":\"\\/Photos\\/Vineyard.jpg\"}]','','[]','/Photos/Vineyard.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',13),(22,1750060800,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"14\":\"\\/Photos\\/Steps.jpg\"}]','','[]','/Photos/Steps.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',14),(23,1750060800,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"14\":\"\\/Photos\\/Steps.jpg\"}]','','[]','/Photos/Steps.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',14),(24,1750060800,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"15\":\"\\/Photos\\/Nextcloud community.jpg\"}]','','[]','/Photos/Nextcloud community.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',15),(25,1750060800,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"15\":\"\\/Photos\\/Nextcloud community.jpg\"}]','','[]','/Photos/Nextcloud community.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',15),(26,1750060800,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"16\":\"\\/Photos\\/Frog.jpg\"}]','','[]','/Photos/Frog.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',16),(27,1750060800,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"16\":\"\\/Photos\\/Frog.jpg\"}]','','[]','/Photos/Frog.jpg','http://localhost/index.php/apps/files/?dir=/Photos','files',16),(28,1750060800,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"17\":\"\\/Nextcloud Manual.pdf\"}]','','[]','/Nextcloud Manual.pdf','http://localhost/index.php/apps/files/?dir=/','files',17),(29,1750060800,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"17\":\"\\/Nextcloud Manual.pdf\"}]','','[]','/Nextcloud Manual.pdf','http://localhost/index.php/apps/files/?dir=/','files',17),(30,1750060800,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"18\":\"\\/Nextcloud.png\"}]','','[]','/Nextcloud.png','http://localhost/index.php/apps/files/?dir=/','files',18),(31,1750060800,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"18\":\"\\/Nextcloud.png\"}]','','[]','/Nextcloud.png','http://localhost/index.php/apps/files/?dir=/','files',18),(32,1750060800,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"19\":\"\\/Templates\"}]','','[]','/Templates','http://localhost/index.php/apps/files/?dir=/','files',19),(33,1750060800,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"20\":\"\\/Templates\\/Mind map.whiteboard\"}]','','[]','/Templates/Mind map.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',20),(34,1750060800,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"20\":\"\\/Templates\\/Mind map.whiteboard\"}]','','[]','/Templates/Mind map.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',20),(35,1750060800,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"21\":\"\\/Templates\\/Simple.odp\"}]','','[]','/Templates/Simple.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',21),(36,1750060800,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"21\":\"\\/Templates\\/Simple.odp\"}]','','[]','/Templates/Simple.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',21),(37,1750060800,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"22\":\"\\/Templates\\/Brainstorming.whiteboard\"}]','','[]','/Templates/Brainstorming.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',22),(38,1750060800,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"22\":\"\\/Templates\\/Brainstorming.whiteboard\"}]','','[]','/Templates/Brainstorming.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',22),(39,1750060801,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"23\":\"\\/Templates\\/Party invitation.odt\"}]','','[]','/Templates/Party invitation.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',23),(40,1750060801,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"23\":\"\\/Templates\\/Party invitation.odt\"}]','','[]','/Templates/Party invitation.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',23),(41,1750060801,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"24\":\"\\/Templates\\/Mindmap.odg\"}]','','[]','/Templates/Mindmap.odg','http://localhost/index.php/apps/files/?dir=/Templates','files',24),(42,1750060801,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"24\":\"\\/Templates\\/Mindmap.odg\"}]','','[]','/Templates/Mindmap.odg','http://localhost/index.php/apps/files/?dir=/Templates','files',24),(43,1750060801,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"25\":\"\\/Templates\\/Readme.md\"}]','','[]','/Templates/Readme.md','http://localhost/index.php/apps/files/?dir=/Templates','files',25),(44,1750060801,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"25\":\"\\/Templates\\/Readme.md\"}]','','[]','/Templates/Readme.md','http://localhost/index.php/apps/files/?dir=/Templates','files',25),(45,1750060801,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"26\":\"\\/Templates\\/Elegant.odp\"}]','','[]','/Templates/Elegant.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',26),(46,1750060801,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"26\":\"\\/Templates\\/Elegant.odp\"}]','','[]','/Templates/Elegant.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',26),(47,1750060801,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"27\":\"\\/Templates\\/Syllabus.odt\"}]','','[]','/Templates/Syllabus.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',27),(48,1750060801,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"27\":\"\\/Templates\\/Syllabus.odt\"}]','','[]','/Templates/Syllabus.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',27),(49,1750060801,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"28\":\"\\/Templates\\/Modern company.odp\"}]','','[]','/Templates/Modern company.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',28),(50,1750060801,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"28\":\"\\/Templates\\/Modern company.odp\"}]','','[]','/Templates/Modern company.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',28),(51,1750060801,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"29\":\"\\/Templates\\/Expense report.ods\"}]','','[]','/Templates/Expense report.ods','http://localhost/index.php/apps/files/?dir=/Templates','files',29),(52,1750060801,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"29\":\"\\/Templates\\/Expense report.ods\"}]','','[]','/Templates/Expense report.ods','http://localhost/index.php/apps/files/?dir=/Templates','files',29),(53,1750060801,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"30\":\"\\/Templates\\/Kanban board.whiteboard\"}]','','[]','/Templates/Kanban board.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',30),(54,1750060801,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"30\":\"\\/Templates\\/Kanban board.whiteboard\"}]','','[]','/Templates/Kanban board.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',30),(55,1750060802,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"31\":\"\\/Templates\\/Sticky notes.whiteboard\"}]','','[]','/Templates/Sticky notes.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',31),(56,1750060802,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"31\":\"\\/Templates\\/Sticky notes.whiteboard\"}]','','[]','/Templates/Sticky notes.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',31),(57,1750060802,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"32\":\"\\/Templates\\/Meeting agenda.whiteboard\"}]','','[]','/Templates/Meeting agenda.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',32),(58,1750060802,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"32\":\"\\/Templates\\/Meeting agenda.whiteboard\"}]','','[]','/Templates/Meeting agenda.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',32),(59,1750060803,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"33\":\"\\/Templates\\/Mother\'s day.odt\"}]','','[]','/Templates/Mother\'s day.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',33),(60,1750060803,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"33\":\"\\/Templates\\/Mother\'s day.odt\"}]','','[]','/Templates/Mother\'s day.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',33),(61,1750060803,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"34\":\"\\/Templates\\/Flowchart.odg\"}]','','[]','/Templates/Flowchart.odg','http://localhost/index.php/apps/files/?dir=/Templates','files',34),(62,1750060803,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"34\":\"\\/Templates\\/Flowchart.odg\"}]','','[]','/Templates/Flowchart.odg','http://localhost/index.php/apps/files/?dir=/Templates','files',34),(63,1750060803,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"35\":\"\\/Templates\\/Resume.odt\"}]','','[]','/Templates/Resume.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',35),(64,1750060803,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"35\":\"\\/Templates\\/Resume.odt\"}]','','[]','/Templates/Resume.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',35),(65,1750060803,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"36\":\"\\/Templates\\/Impact effort.whiteboard\"}]','','[]','/Templates/Impact effort.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',36),(66,1750060804,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"36\":\"\\/Templates\\/Impact effort.whiteboard\"}]','','[]','/Templates/Impact effort.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',36),(67,1750060804,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"37\":\"\\/Templates\\/Photo book.odt\"}]','','[]','/Templates/Photo book.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',37),(68,1750060804,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"37\":\"\\/Templates\\/Photo book.odt\"}]','','[]','/Templates/Photo book.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',37),(69,1750060804,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"38\":\"\\/Templates\\/Business model canvas.whiteboard\"}]','','[]','/Templates/Business model canvas.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',38),(70,1750060804,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"38\":\"\\/Templates\\/Business model canvas.whiteboard\"}]','','[]','/Templates/Business model canvas.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',38),(71,1750060804,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"39\":\"\\/Templates\\/Meeting notes.md\"}]','','[]','/Templates/Meeting notes.md','http://localhost/index.php/apps/files/?dir=/Templates','files',39),(72,1750060804,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"39\":\"\\/Templates\\/Meeting notes.md\"}]','','[]','/Templates/Meeting notes.md','http://localhost/index.php/apps/files/?dir=/Templates','files',39),(73,1750060804,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"40\":\"\\/Templates\\/Timeline.whiteboard\"}]','','[]','/Templates/Timeline.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',40),(74,1750060804,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"40\":\"\\/Templates\\/Timeline.whiteboard\"}]','','[]','/Templates/Timeline.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',40),(75,1750060804,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"41\":\"\\/Templates\\/Invoice.odt\"}]','','[]','/Templates/Invoice.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',41),(76,1750060804,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"41\":\"\\/Templates\\/Invoice.odt\"}]','','[]','/Templates/Invoice.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',41),(77,1750060804,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"42\":\"\\/Templates\\/Business model canvas.ods\"}]','','[]','/Templates/Business model canvas.ods','http://localhost/index.php/apps/files/?dir=/Templates','files',42),(78,1750060804,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"42\":\"\\/Templates\\/Business model canvas.ods\"}]','','[]','/Templates/Business model canvas.ods','http://localhost/index.php/apps/files/?dir=/Templates','files',42),(79,1750060804,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"43\":\"\\/Templates\\/Venn diagram.whiteboard\"}]','','[]','/Templates/Venn diagram.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',43),(80,1750060804,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"43\":\"\\/Templates\\/Venn diagram.whiteboard\"}]','','[]','/Templates/Venn diagram.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',43),(81,1750060804,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"44\":\"\\/Templates\\/Timesheet.ods\"}]','','[]','/Templates/Timesheet.ods','http://localhost/index.php/apps/files/?dir=/Templates','files',44),(82,1750060804,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"44\":\"\\/Templates\\/Timesheet.ods\"}]','','[]','/Templates/Timesheet.ods','http://localhost/index.php/apps/files/?dir=/Templates','files',44),(83,1750060804,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"45\":\"\\/Templates\\/Gotong royong.odp\"}]','','[]','/Templates/Gotong royong.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',45),(84,1750060804,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"45\":\"\\/Templates\\/Gotong royong.odp\"}]','','[]','/Templates/Gotong royong.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',45),(85,1750060804,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"46\":\"\\/Templates\\/Letter.odt\"}]','','[]','/Templates/Letter.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',46),(86,1750060804,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"46\":\"\\/Templates\\/Letter.odt\"}]','','[]','/Templates/Letter.odt','http://localhost/index.php/apps/files/?dir=/Templates','files',46),(87,1750060804,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"47\":\"\\/Templates\\/Diagram & table.ods\"}]','','[]','/Templates/Diagram & table.ods','http://localhost/index.php/apps/files/?dir=/Templates','files',47),(88,1750060804,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"47\":\"\\/Templates\\/Diagram & table.ods\"}]','','[]','/Templates/Diagram & table.ods','http://localhost/index.php/apps/files/?dir=/Templates','files',47),(89,1750060804,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"48\":\"\\/Templates\\/Flowchart.whiteboard\"}]','','[]','/Templates/Flowchart.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',48),(90,1750060804,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"48\":\"\\/Templates\\/Flowchart.whiteboard\"}]','','[]','/Templates/Flowchart.whiteboard','http://localhost/index.php/apps/files/?dir=/Templates','files',48),(91,1750060804,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"49\":\"\\/Templates\\/Product plan.md\"}]','','[]','/Templates/Product plan.md','http://localhost/index.php/apps/files/?dir=/Templates','files',49),(92,1750060804,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"49\":\"\\/Templates\\/Product plan.md\"}]','','[]','/Templates/Product plan.md','http://localhost/index.php/apps/files/?dir=/Templates','files',49),(93,1750060804,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"50\":\"\\/Templates\\/Business model canvas.odg\"}]','','[]','/Templates/Business model canvas.odg','http://localhost/index.php/apps/files/?dir=/Templates','files',50),(94,1750060804,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"50\":\"\\/Templates\\/Business model canvas.odg\"}]','','[]','/Templates/Business model canvas.odg','http://localhost/index.php/apps/files/?dir=/Templates','files',50),(95,1750060804,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"51\":\"\\/Templates\\/Org chart.odg\"}]','','[]','/Templates/Org chart.odg','http://localhost/index.php/apps/files/?dir=/Templates','files',51),(96,1750060804,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"51\":\"\\/Templates\\/Org chart.odg\"}]','','[]','/Templates/Org chart.odg','http://localhost/index.php/apps/files/?dir=/Templates','files',51),(97,1750060804,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"52\":\"\\/Templates\\/Yellow idea.odp\"}]','','[]','/Templates/Yellow idea.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',52),(98,1750060805,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"52\":\"\\/Templates\\/Yellow idea.odp\"}]','','[]','/Templates/Yellow idea.odp','http://localhost/index.php/apps/files/?dir=/Templates','files',52),(99,1750060805,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"53\":\"\\/Documents\"}]','','[]','/Documents','http://localhost/index.php/apps/files/?dir=/','files',53),(100,1750060805,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"54\":\"\\/Documents\\/Readme.md\"}]','','[]','/Documents/Readme.md','http://localhost/index.php/apps/files/?dir=/Documents','files',54),(101,1750060805,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"54\":\"\\/Documents\\/Readme.md\"}]','','[]','/Documents/Readme.md','http://localhost/index.php/apps/files/?dir=/Documents','files',54),(102,1750060805,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"55\":\"\\/Documents\\/Nextcloud flyer.pdf\"}]','','[]','/Documents/Nextcloud flyer.pdf','http://localhost/index.php/apps/files/?dir=/Documents','files',55),(103,1750060805,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"55\":\"\\/Documents\\/Nextcloud flyer.pdf\"}]','','[]','/Documents/Nextcloud flyer.pdf','http://localhost/index.php/apps/files/?dir=/Documents','files',55),(104,1750060805,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"56\":\"\\/Documents\\/Welcome to Nextcloud Hub.docx\"}]','','[]','/Documents/Welcome to Nextcloud Hub.docx','http://localhost/index.php/apps/files/?dir=/Documents','files',56),(105,1750060805,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"56\":\"\\/Documents\\/Welcome to Nextcloud Hub.docx\"}]','','[]','/Documents/Welcome to Nextcloud Hub.docx','http://localhost/index.php/apps/files/?dir=/Documents','files',56),(106,1750060805,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"57\":\"\\/Documents\\/Example.md\"}]','','[]','/Documents/Example.md','http://localhost/index.php/apps/files/?dir=/Documents','files',57),(107,1750060805,30,'file_changed','Landing Pad Digital','Landing Pad Digital','files','changed_self','[{\"57\":\"\\/Documents\\/Example.md\"}]','','[]','/Documents/Example.md','http://localhost/index.php/apps/files/?dir=/Documents','files',57),(108,1750060805,30,'calendar','Landing Pad Digital','Landing Pad Digital','dav','calendar_add_self','{\"actor\":\"Landing Pad Digital\",\"calendar\":{\"id\":1,\"uri\":\"personal\",\"name\":\"Personal\"}}','','[]','','','calendar',1),(109,1750060805,30,'contacts','Landing Pad Digital','Landing Pad Digital','dav','addressbook_add_self','{\"actor\":\"Landing Pad Digital\",\"addressbook\":{\"id\":2,\"uri\":\"contacts\",\"name\":\"Contacts\"}}','','[]','','','addressbook',2),(110,1750750082,30,'calendar','Landing Pad Digital','system','dav','calendar_add','{\"actor\":\"Landing Pad Digital\",\"calendar\":{\"id\":2,\"uri\":\"contact_birthdays\",\"name\":\"Contact birthdays\"}}','','[]','','','calendar',2),(111,1750750099,30,'personal_settings','Landing Pad Digital','Landing Pad Digital','settings','email_changed_self','[]','','[]','','','',0),(112,1750750139,30,'calendar_event','Landing Pad Digital','system','dav','object_add_event','{\"actor\":\"Landing Pad Digital\",\"calendar\":{\"id\":2,\"uri\":\"contact_birthdays\",\"name\":\"Contact birthdays\"},\"object\":{\"id\":\"Landing Pad Digital\",\"name\":\"\\ud83c\\udf82 Landing Pad Digital (2002)\",\"classified\":false}}','','[]','','','calendar',2),(113,1750750141,30,'calendar_event','Landing Pad Digital','system','dav','object_update_event','{\"actor\":\"Landing Pad Digital\",\"calendar\":{\"id\":2,\"uri\":\"contact_birthdays\",\"name\":\"Contact birthdays\"},\"object\":{\"id\":\"Landing Pad Digital\",\"name\":\"\\ud83c\\udf82 Landing Pad Digital (2002)\",\"classified\":false}}','','[]','','','calendar',2),(114,1750750142,30,'calendar_event','Landing Pad Digital','system','dav','object_update_event','{\"actor\":\"Landing Pad Digital\",\"calendar\":{\"id\":2,\"uri\":\"contact_birthdays\",\"name\":\"Contact birthdays\"},\"object\":{\"id\":\"Landing Pad Digital\",\"name\":\"\\ud83c\\udf82 Landing Pad Digital (2002)\",\"classified\":false}}','','[]','','','calendar',2),(115,1750750142,30,'calendar_event','Landing Pad Digital','system','dav','object_update_event','{\"actor\":\"Landing Pad Digital\",\"calendar\":{\"id\":2,\"uri\":\"contact_birthdays\",\"name\":\"Contact birthdays\"},\"object\":{\"id\":\"Landing Pad Digital\",\"name\":\"\\ud83c\\udf82 Landing Pad Digital (2002)\",\"classified\":false}}','','[]','','','calendar',2),(116,1750750145,30,'calendar_event','Landing Pad Digital','system','dav','object_update_event','{\"actor\":\"Landing Pad Digital\",\"calendar\":{\"id\":2,\"uri\":\"contact_birthdays\",\"name\":\"Contact birthdays\"},\"object\":{\"id\":\"Landing Pad Digital\",\"name\":\"\\ud83c\\udf82 Landing Pad Digital (2005)\",\"classified\":false}}','','[]','','','calendar',2),(117,1750750145,30,'calendar_event','Landing Pad Digital','system','dav','object_update_event','{\"actor\":\"Landing Pad Digital\",\"calendar\":{\"id\":2,\"uri\":\"contact_birthdays\",\"name\":\"Contact birthdays\"},\"object\":{\"id\":\"Landing Pad Digital\",\"name\":\"\\ud83c\\udf82 Landing Pad Digital (2002)\",\"classified\":false}}','','[]','','','calendar',2),(118,1750750150,30,'calendar_event','Landing Pad Digital','system','dav','object_update_event','{\"actor\":\"Landing Pad Digital\",\"calendar\":{\"id\":2,\"uri\":\"contact_birthdays\",\"name\":\"Contact birthdays\"},\"object\":{\"id\":\"Landing Pad Digital\",\"name\":\"\\ud83c\\udf82 Landing Pad Digital (2002)\",\"classified\":false}}','','[]','','','calendar',2),(119,1750750152,30,'calendar_event','Landing Pad Digital','system','dav','object_update_event','{\"actor\":\"Landing Pad Digital\",\"calendar\":{\"id\":2,\"uri\":\"contact_birthdays\",\"name\":\"Contact birthdays\"},\"object\":{\"id\":\"Landing Pad Digital\",\"name\":\"\\ud83c\\udf82 Landing Pad Digital (2025)\",\"classified\":false}}','','[]','','','calendar',2),(120,1750750156,30,'calendar_event','Landing Pad Digital','system','dav','object_update_event','{\"actor\":\"Landing Pad Digital\",\"calendar\":{\"id\":2,\"uri\":\"contact_birthdays\",\"name\":\"Contact birthdays\"},\"object\":{\"id\":\"Landing Pad Digital\",\"name\":\"\\ud83c\\udf82 Landing Pad Digital (2025)\",\"classified\":false}}','','[]','','','calendar',2),(121,1750754878,30,'file_deleted','Landing Pad Digital','Landing Pad Digital','files','deleted_self','[{\"18\":\"\\/Nextcloud.png\"}]','','[]','/Nextcloud.png','https://cloud.landingpad.digital/apps/files/?dir=/','files',18),(122,1750754878,30,'file_deleted','Landing Pad Digital','Landing Pad Digital','files','deleted_self','[{\"3\":\"\\/Readme.md\"}]','','[]','/Readme.md','https://cloud.landingpad.digital/apps/files/?dir=/','files',3),(123,1750754878,30,'file_deleted','Landing Pad Digital','Landing Pad Digital','files','deleted_self','[{\"5\":\"\\/Templates credits.md\"}]','','[]','/Templates credits.md','https://cloud.landingpad.digital/apps/files/?dir=/','files',5),(124,1750754878,30,'file_deleted','Landing Pad Digital','Landing Pad Digital','files','deleted_self','[{\"6\":\"\\/Nextcloud intro.mp4\"}]','','[]','/Nextcloud intro.mp4','https://cloud.landingpad.digital/apps/files/?dir=/','files',6),(125,1750754878,30,'file_deleted','Landing Pad Digital','Landing Pad Digital','files','deleted_self','[{\"4\":\"\\/Reasons to use Nextcloud.pdf\"}]','','[]','/Reasons to use Nextcloud.pdf','https://cloud.landingpad.digital/apps/files/?dir=/','files',4),(126,1750754995,30,'calendar','Landing Pad Digital','Landing Pad Digital','dav','calendar_add_self','{\"actor\":\"Landing Pad Digital\",\"calendar\":{\"id\":3,\"uri\":\"contact_birthdays\",\"name\":\"Contact birthdays\"}}','','[]','','','calendar',3),(127,1750755047,30,'calendar','Landing Pad Digital','Landing Pad Digital','dav','calendar_add_self','{\"actor\":\"Landing Pad Digital\",\"calendar\":{\"id\":4,\"uri\":\"landing-pad-outings\",\"name\":\"Landing Pad Outings\"}}','','[]','','','calendar',4),(128,1750755058,30,'calendar','Landing Pad Digital','Landing Pad Digital','dav','calendar_add_self','{\"actor\":\"Landing Pad Digital\",\"calendar\":{\"id\":5,\"uri\":\"landing-pad-team\",\"name\":\"Landing Pad Team\"}}','','[]','','','calendar',5),(129,1750755071,30,'calendar','Landing Pad Digital','Landing Pad Digital','dav','calendar_add_self','{\"actor\":\"Landing Pad Digital\",\"calendar\":{\"id\":6,\"uri\":\"landing-pad-tata\",\"name\":\"Landing Pad Tata\"}}','','[]','','','calendar',6),(130,1750755226,30,'file_deleted','Landing Pad Digital','Landing Pad Digital','files','deleted_self','[{\"14\":\"\\/Photos\\/Steps.jpg\"}]','','[]','/Photos/Steps.jpg','https://cloud.landingpad.digital/apps/files/?dir=/Photos','files',14),(131,1750755226,30,'file_deleted','Landing Pad Digital','Landing Pad Digital','files','deleted_self','[{\"12\":\"\\/Photos\\/Library.jpg\"}]','','[]','/Photos/Library.jpg','https://cloud.landingpad.digital/apps/files/?dir=/Photos','files',12),(132,1750755226,30,'file_deleted','Landing Pad Digital','Landing Pad Digital','files','deleted_self','[{\"11\":\"\\/Photos\\/Toucan.jpg\"}]','','[]','/Photos/Toucan.jpg','https://cloud.landingpad.digital/apps/files/?dir=/Photos','files',11),(133,1750755226,30,'file_deleted','Landing Pad Digital','Landing Pad Digital','files','deleted_self','[{\"13\":\"\\/Photos\\/Vineyard.jpg\"}]','','[]','/Photos/Vineyard.jpg','https://cloud.landingpad.digital/apps/files/?dir=/Photos','files',13),(134,1750755226,30,'file_deleted','Landing Pad Digital','Landing Pad Digital','files','deleted_self','[{\"15\":\"\\/Photos\\/Nextcloud community.jpg\"}]','','[]','/Photos/Nextcloud community.jpg','https://cloud.landingpad.digital/apps/files/?dir=/Photos','files',15),(135,1750755256,30,'file_created','Landing Pad Digital','Landing Pad Digital','files','created_self','[{\"350\":\"\\/S3 Cloud\"}]','','[]','/S3 Cloud','https://cloud.landingpad.digital/apps/files/?dir=/','files',350);
/*!40000 ALTER TABLE `oc_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_activity_mq`
--

DROP TABLE IF EXISTS `oc_activity_mq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_activity_mq` (
  `mail_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `amq_timestamp` int(11) NOT NULL DEFAULT 0,
  `amq_latest_send` int(11) NOT NULL DEFAULT 0,
  `amq_type` varchar(255) NOT NULL,
  `amq_affecteduser` varchar(64) NOT NULL,
  `amq_appid` varchar(32) NOT NULL,
  `amq_subject` varchar(255) NOT NULL,
  `amq_subjectparams` longtext DEFAULT NULL,
  `object_type` varchar(255) DEFAULT NULL,
  `object_id` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`mail_id`),
  KEY `amp_user` (`amq_affecteduser`),
  KEY `amp_latest_send_time` (`amq_latest_send`),
  KEY `amp_timestamp_time` (`amq_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_activity_mq`
--

LOCK TABLES `oc_activity_mq` WRITE;
/*!40000 ALTER TABLE `oc_activity_mq` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_activity_mq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_addressbookchanges`
--

DROP TABLE IF EXISTS `oc_addressbookchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_addressbookchanges` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) DEFAULT NULL,
  `synctoken` int(10) unsigned NOT NULL DEFAULT 1,
  `addressbookid` bigint(20) NOT NULL,
  `operation` smallint(6) NOT NULL,
  `created_at` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `addressbookid_synctoken` (`addressbookid`,`synctoken`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_addressbookchanges`
--

LOCK TABLES `oc_addressbookchanges` WRITE;
/*!40000 ALTER TABLE `oc_addressbookchanges` DISABLE KEYS */;
INSERT INTO `oc_addressbookchanges` VALUES (1,'Database:Landing Pad Digital.vcf',1,1,1,1750750082),(2,'Database:Landing Pad Digital.vcf',2,1,2,1750750099),(3,'Database:Landing Pad Digital.vcf',3,1,2,1750750134),(4,'Database:Landing Pad Digital.vcf',4,1,2,1750750139),(5,'Database:Landing Pad Digital.vcf',5,1,2,1750750141),(6,'Database:Landing Pad Digital.vcf',6,1,2,1750750142),(7,'Database:Landing Pad Digital.vcf',7,1,2,1750750142),(8,'Database:Landing Pad Digital.vcf',8,1,2,1750750145),(9,'Database:Landing Pad Digital.vcf',9,1,2,1750750145),(10,'Database:Landing Pad Digital.vcf',10,1,2,1750750149),(11,'Database:Landing Pad Digital.vcf',11,1,2,1750750150),(12,'Database:Landing Pad Digital.vcf',12,1,2,1750750152),(13,'Database:Landing Pad Digital.vcf',13,1,2,1750750156),(14,'Database:Landing Pad Digital.vcf',14,1,2,1750750167),(15,'Database:Landing Pad Digital.vcf',15,1,2,1750750171),(16,'Database:Landing Pad Digital.vcf',16,1,2,1750750186),(17,'Database:Landing Pad Digital.vcf',17,1,2,1750750193),(18,'Database:Landing Pad Digital.vcf',18,1,2,1750750211),(19,'Database:Landing Pad Digital.vcf',19,1,2,1750750256),(20,'Database:Landing Pad Digital.vcf',20,1,2,1750750260),(21,'Database:Landing Pad Digital.vcf',21,1,2,1750750286),(22,'Database:Landing Pad Digital.vcf',22,1,2,1750750334),(23,'Database:Landing Pad Digital.vcf',23,1,2,1750750341),(24,'Database:Landing Pad Digital.vcf',24,1,2,1750750344),(25,'Database:Landing Pad Digital.vcf',25,1,2,1750750346),(26,'Database:Landing Pad Digital.vcf',26,1,2,1750750348),(27,'Database:Landing Pad Digital.vcf',27,1,2,1750753800);
/*!40000 ALTER TABLE `oc_addressbookchanges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_addressbooks`
--

DROP TABLE IF EXISTS `oc_addressbooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_addressbooks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `principaluri` varchar(255) DEFAULT NULL,
  `displayname` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `synctoken` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `addressbook_index` (`principaluri`,`uri`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_addressbooks`
--

LOCK TABLES `oc_addressbooks` WRITE;
/*!40000 ALTER TABLE `oc_addressbooks` DISABLE KEYS */;
INSERT INTO `oc_addressbooks` VALUES (1,'principals/system/system','system','system','System addressbook which holds all users of this instance',28),(2,'principals/users/Landing Pad Digital','Contacts','contacts',NULL,1);
/*!40000 ALTER TABLE `oc_addressbooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_appconfig`
--

DROP TABLE IF EXISTS `oc_appconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_appconfig` (
  `appid` varchar(32) NOT NULL DEFAULT '',
  `configkey` varchar(64) NOT NULL DEFAULT '',
  `configvalue` longtext DEFAULT NULL,
  `type` int(10) unsigned NOT NULL DEFAULT 2,
  `lazy` smallint(5) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`appid`,`configkey`),
  KEY `ac_lazy_i` (`lazy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_appconfig`
--

LOCK TABLES `oc_appconfig` WRITE;
/*!40000 ALTER TABLE `oc_appconfig` DISABLE KEYS */;
INSERT INTO `oc_appconfig` VALUES ('activity','enabled','yes',2,0),('activity','installed_version','4.0.0',2,0),('activity','types','filesystem',2,0),('app_api','enabled','yes',2,0),('app_api','installed_version','5.0.2',2,0),('app_api','types','',2,0),('appointments','enabled','yes',2,0),('appointments','hk','6877502150cdff3d13572476a740817bd7324fc7c586fbeca583f5d87e8b1e38',2,0),('appointments','installed_version','2.4.5',2,0),('appointments','tiv','1dcc1efd1bcbc863eb7473838327cd2d',2,0),('appointments','types','dav',2,0),('backgroundjob','lastjob','3',2,0),('bruteforcesettings','apply_allowlist_to_ratelimit','0',2,0),('bruteforcesettings','enabled','yes',2,0),('bruteforcesettings','installed_version','4.0.0',2,0),('bruteforcesettings','types','',2,0),('calendar','enabled','yes',2,0),('calendar','installed_version','5.3.3',2,0),('calendar','types','',2,0),('circles','enabled','yes',2,0),('circles','installed_version','31.0.0',2,0),('circles','loopback_tmp_scheme','https',2,0),('circles','maintenance_run','0',2,0),('circles','maintenance_update','{\"3\":1750995901,\"2\":1750996801,\"1\":1750997101}',2,0),('circles','types','filesystem,dav',2,0),('cloud_federation_api','enabled','yes',2,0),('cloud_federation_api','installed_version','1.14.0',2,0),('cloud_federation_api','types','filesystem',2,0),('comments','enabled','yes',2,0),('comments','installed_version','1.21.0',2,0),('comments','types','logging',2,0),('contacts','enabled','yes',2,0),('contacts','installed_version','7.1.3',2,0),('contacts','types','dav',2,0),('contactsinteraction','enabled','yes',2,0),('contactsinteraction','installed_version','1.12.0',2,0),('contactsinteraction','types','dav',2,0),('core','backgroundjobs_mode','cron',4,0),('core','emailTestSuccessful','1',2,0),('core','files_metadata','{\"photos-original_date_time\":{\"value\":null,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"photos-exif\":{\"value\":null,\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":null,\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":null,\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"blurhash\":{\"value\":null,\"type\":\"string\",\"etag\":\"390d435df9ee5eeddda99047278b4b6d\",\"indexed\":false,\"editPermission\":0}}',64,1),('core','installedat','1750060794.6472',2,0),('core','lastcron','1750997101',8,0),('core','lastupdateResult','[]',2,0),('core','lastupdatedat','1750916557',8,0),('core','metadataGenerationDone','1',32,0),('core','oc.integritycheck.checker','[]',64,1),('core','public_files','files_sharing/public.php',2,0),('core','vendor','nextcloud',2,0),('dashboard','enabled','yes',2,0),('dashboard','installed_version','7.11.0',2,0),('dashboard','types','',2,0),('dav','enabled','yes',2,0),('dav','installed_version','1.33.0',2,0),('dav','types','filesystem',2,0),('federatedfilesharing','enabled','yes',2,0),('federatedfilesharing','installed_version','1.21.0',2,0),('federatedfilesharing','types','',2,0),('federation','enabled','yes',2,0),('federation','installed_version','1.21.0',2,0),('federation','types','authentication',2,0),('files','enabled','yes',2,0),('files','installed_version','2.3.1',2,0),('files','types','filesystem',2,0),('files_downloadlimit','enabled','yes',2,0),('files_downloadlimit','installed_version','4.0.0',2,0),('files_downloadlimit','types','',2,0),('files_external','enabled','yes',2,0),('files_external','installed_version','1.23.0',2,0),('files_external','types','filesystem',2,0),('files_external_ethswarm','enabled','no',2,0),('files_external_ethswarm','installed_version','0.6.3',2,0),('files_external_ethswarm','types','filesystem,dav',2,0),('files_pdfviewer','enabled','yes',2,0),('files_pdfviewer','installed_version','4.0.0',2,0),('files_pdfviewer','types','',2,0),('files_reminders','enabled','yes',2,0),('files_reminders','installed_version','1.4.0',2,0),('files_reminders','types','',2,0),('files_sharing','enabled','yes',2,0),('files_sharing','installed_version','1.23.1',2,0),('files_sharing','types','filesystem',2,0),('files_trashbin','enabled','yes',2,0),('files_trashbin','installed_version','1.21.0',2,0),('files_trashbin','types','filesystem,dav',2,0),('files_versions','enabled','yes',2,0),('files_versions','installed_version','1.24.0',2,0),('files_versions','types','filesystem,dav',2,0),('firstrunwizard','enabled','yes',2,0),('firstrunwizard','installed_version','4.0.0',2,0),('firstrunwizard','types','',2,0),('logreader','enabled','yes',2,0),('logreader','installed_version','4.0.0',2,0),('logreader','types','logging',2,0),('lookup_server_connector','enabled','yes',2,0),('lookup_server_connector','installed_version','1.19.0',2,0),('lookup_server_connector','types','authentication',2,0),('nextcloud_announcements','enabled','yes',2,0),('nextcloud_announcements','installed_version','3.0.0',2,0),('nextcloud_announcements','pub_date','Thu, 24 Oct 2019 00:00:00 +0200',2,0),('nextcloud_announcements','types','logging',2,0),('notifications','enabled','yes',2,0),('notifications','installed_version','4.0.0',2,0),('notifications','types','logging',2,0),('oauth2','enabled','yes',2,0),('oauth2','installed_version','1.19.1',2,0),('oauth2','types','authentication',2,0),('password_policy','enabled','yes',2,0),('password_policy','installed_version','3.0.0',2,0),('password_policy','types','authentication',2,0),('photos','enabled','yes',2,0),('photos','installed_version','4.0.0-dev.1',2,0),('photos','lastPlaceMappedUser','Landing Pad Digital',2,0),('photos','lastPlaceMappingDone','true',2,0),('photos','types','dav,authentication',2,0),('privacy','enabled','yes',2,0),('privacy','installed_version','3.0.0',2,0),('privacy','types','',2,0),('profile','enabled','yes',2,0),('profile','installed_version','1.0.0',2,0),('profile','types','',2,0),('provisioning_api','enabled','yes',2,0),('provisioning_api','installed_version','1.21.0',2,0),('provisioning_api','types','prevent_group_restriction',2,0),('recommendations','enabled','yes',2,0),('recommendations','installed_version','4.0.0',2,0),('recommendations','types','',2,0),('related_resources','enabled','yes',2,0),('related_resources','installed_version','2.0.0',2,0),('related_resources','types','',2,0),('serverinfo','cached_count_appdata_files','278',8,0),('serverinfo','cached_count_filecache','369',8,0),('serverinfo','cached_count_storages','4',8,0),('serverinfo','enabled','yes',2,0),('serverinfo','installed_version','3.0.0',2,0),('serverinfo','size_appdata_storage','0',16,0),('serverinfo','types','',2,0),('settings','appstore-fetcher-lastFailure','1750916618',2,0),('settings','enabled','yes',2,0),('settings','installed_version','1.14.0',2,0),('settings','types','',2,0),('sharebymail','enabled','yes',2,0),('sharebymail','installed_version','1.21.0',2,0),('sharebymail','types','filesystem',2,0),('support','enabled','yes',2,0),('support','installed_version','3.0.0',2,0),('support','types','session',2,0),('survey_client','enabled','yes',2,0),('survey_client','installed_version','3.0.0',2,0),('survey_client','types','',2,0),('systemtags','enabled','yes',2,0),('systemtags','installed_version','1.21.1',2,0),('systemtags','types','logging',2,0),('text','enabled','yes',2,0),('text','installed_version','5.0.0',2,0),('text','types','dav',2,0),('theming','backgroundMime','image/webp',2,0),('theming','background_color','#1a1760',4,0),('theming','cachebuster','7',2,0),('theming','enabled','yes',2,0),('theming','faviconMime','image/png',2,0),('theming','installed_version','2.6.1',2,0),('theming','logoDimensions','1536x1536',2,0),('theming','logoMime','image/png',2,0),('theming','name','Landing Pad Digital',2,0),('theming','primary_color','#783CB2',4,0),('theming','types','logging',2,0),('theming','url','https://www.landingpad.digital/',2,0),('twofactor_backupcodes','enabled','yes',2,0),('twofactor_backupcodes','installed_version','1.20.0',2,0),('twofactor_backupcodes','types','',2,0),('updatenotification','enabled','yes',2,0),('updatenotification','installed_version','1.21.0',2,0),('updatenotification','types','',2,0),('updatenotification','update_check_errors','0',8,0),('user_status','enabled','yes',2,0),('user_status','installed_version','1.11.0',2,0),('user_status','types','',2,0),('viewer','enabled','yes',2,0),('viewer','installed_version','4.0.0',2,0),('viewer','types','',2,0),('weather_status','enabled','yes',2,0),('weather_status','installed_version','1.11.0',2,0),('weather_status','types','',2,0),('webhook_listeners','enabled','yes',2,0),('webhook_listeners','installed_version','1.2.0',2,0),('webhook_listeners','types','filesystem',2,0),('workflowengine','enabled','yes',2,0),('workflowengine','installed_version','2.13.0',2,0),('workflowengine','types','filesystem',2,0);
/*!40000 ALTER TABLE `oc_appconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_appconfig_ex`
--

DROP TABLE IF EXISTS `oc_appconfig_ex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_appconfig_ex` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `configkey` varchar(64) NOT NULL,
  `configvalue` longtext DEFAULT NULL,
  `sensitive` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `appconfig_ex__idx` (`appid`,`configkey`),
  KEY `appconfig_ex__configkey` (`configkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_appconfig_ex`
--

LOCK TABLES `oc_appconfig_ex` WRITE;
/*!40000 ALTER TABLE `oc_appconfig_ex` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_appconfig_ex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_appointments_hash`
--

DROP TABLE IF EXISTS `oc_appointments_hash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_appointments_hash` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) NOT NULL,
  `hash` varchar(32) NOT NULL,
  `user_id` varchar(64) DEFAULT NULL,
  `start` bigint(20) unsigned DEFAULT NULL,
  `status` int(10) unsigned DEFAULT NULL,
  `page_id` varchar(4) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `appt_doc` varbinary(32768) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `appointments_hash_uid_index` (`uid`),
  KEY `appointments_hash_user_index` (`user_id`),
  KEY `appointments_hash_start_index` (`start`),
  KEY `appointments_hash_status_index` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_appointments_hash`
--

LOCK TABLES `oc_appointments_hash` WRITE;
/*!40000 ALTER TABLE `oc_appointments_hash` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_appointments_hash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_appointments_pref_v2`
--

DROP TABLE IF EXISTS `oc_appointments_pref_v2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_appointments_pref_v2` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(96) NOT NULL,
  `user_id` varchar(64) NOT NULL,
  `page_id` varchar(3) NOT NULL,
  `data` text NOT NULL,
  `reminders` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `appt__user_page_constr` (`user_id`,`page_id`),
  UNIQUE KEY `appt__token_index` (`token`),
  KEY `appt__user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_appointments_pref_v2`
--

LOCK TABLES `oc_appointments_pref_v2` WRITE;
/*!40000 ALTER TABLE `oc_appointments_pref_v2` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_appointments_pref_v2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_appointments_sync`
--

DROP TABLE IF EXISTS `oc_appointments_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_appointments_sync` (
  `id` bigint(20) unsigned NOT NULL,
  `lastsync` int(10) unsigned NOT NULL DEFAULT 0,
  `synctoken` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_appointments_sync`
--

LOCK TABLES `oc_appointments_sync` WRITE;
/*!40000 ALTER TABLE `oc_appointments_sync` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_appointments_sync` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_authorized_groups`
--

DROP TABLE IF EXISTS `oc_authorized_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_authorized_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` varchar(200) NOT NULL,
  `class` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `admindel_groupid_idx` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_authorized_groups`
--

LOCK TABLES `oc_authorized_groups` WRITE;
/*!40000 ALTER TABLE `oc_authorized_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_authorized_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_authtoken`
--

DROP TABLE IF EXISTS `oc_authtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_authtoken` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) NOT NULL DEFAULT '',
  `login_name` varchar(255) NOT NULL DEFAULT '',
  `password` longtext DEFAULT NULL,
  `name` longtext NOT NULL DEFAULT '',
  `token` varchar(200) NOT NULL DEFAULT '',
  `type` smallint(5) unsigned DEFAULT 0,
  `remember` smallint(5) unsigned DEFAULT 0,
  `last_activity` int(10) unsigned DEFAULT 0,
  `last_check` int(10) unsigned DEFAULT 0,
  `scope` longtext DEFAULT NULL,
  `expires` int(10) unsigned DEFAULT NULL,
  `private_key` longtext DEFAULT NULL,
  `public_key` longtext DEFAULT NULL,
  `version` smallint(5) unsigned NOT NULL DEFAULT 1,
  `password_invalid` tinyint(1) DEFAULT 0,
  `password_hash` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `authtoken_token_index` (`token`),
  KEY `authtoken_last_activity_idx` (`last_activity`),
  KEY `authtoken_uid_index` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_authtoken`
--

LOCK TABLES `oc_authtoken` WRITE;
/*!40000 ALTER TABLE `oc_authtoken` DISABLE KEYS */;
INSERT INTO `oc_authtoken` VALUES (1,'Landing Pad Digital','Landing Pad Digital','Pl7hX8nQ0RPizBDZKlBplkSJ8pUgtVHgbSNVzwzPrJ5W1DqwFFAgUBcE+5Bz/4pazO5Ndlk3rhXGd67NJSR1o94mvu6peVnAEzR7XyHNp6qLhDgd31PzinYgPUVqY5r7Pqz8llxgYub740nBd5Utfh5XNC/893kOKeAa0VpE+8I0Ugv5nX78ggT9UDKbef107F3qwkgqVk71/O1k9Fj6a4b33MbCYx+F2Ori5SKGcZP7x7Ni+3qG0lxzdf4rJR2oZNwndVUBRw+JJ0L0W29uqjUOjUiyQzQA7v2AcECG2i/+kSNP87WyA4T3xqTEAgtGFKOxtTxGE/KqjuBy2zntHA==','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36','e61a39bff38572ce728e709dfa9c43feff655e98c63ccdc133de977dde971c0ba06cd6fe1b31e6184167a9960d8930f425b7f576f62877f60ce4396bd897bdb2',0,1,1750990154,1750990154,NULL,NULL,'64644582985e13c9b62ed44bdbd8f1814331bbf2608413c951c6fc4c10ade0022b5a755045fff74f0036f24213125d2492df1282ba9ff7067af5ea85c57a9ddc8544037b85753794088b5cbcc7c8d39840122288fb776245093a9299949f8ffa91d3f1e149aea2797d8ab5d906b97ea674c97f4480ae44a46c3e8503e71f6fc79b7f23c97f254a71d1e0be80d0eed47a397fb3da1bd0dc335534cd1efe9811de434eb65184d9b68c0fc170f641cfd76a539957584dc7bf7dc893e232e80e48e02d3c1a1d1002d1d7d460eadec3d92cf014e3afa11125b87b7a9c5be341cc4224bd42f7e0822226ba5edf365a38e2d6cd5a99891fdde7d8148f3ea97c471d0cc66328b20c56b1295a83a2a931b4576fc8701fc8dca33ec5fceabcc05fe22d3b74565e127a1c144ba339618e05c37c98e8f56bde790983134a9b2c4f5a56459c52221171adc0e08de5f5d0edee9c17918d6585b254f48706cd4dfed38513976a773bdbd55ecf6a187985fed81b5bc1bab874f5e9ff976c15462bdf091c254258b5f8c62ff9cc51d3f24154e0cf5e60ab11f90d4ca4aef4f56de9ddf40089a38c32fad47e553861bb8e6f426a91bba09cfa91f214861537251969895bf20c412afadfbcb4066a003c0dd91ee1063170e07a97a739f87ba1362aec9eba194052e1e8a972c42928aee201ba0c787f5922734cf138b2288a371b9a05601876f22a2bc766ef3ad8ff8cbd4386f415683d996cb5c6bff77784746849eb33622575847e8d10f55597cd00bb0a536f301f6f7e036354ee48188ac3972cb09b58212cfd94577dcd40d0af38840f321b1d7629e556604eb82056576c4d75cc71c89c09b239938d114d5c13b98356fa6f2d79435cd70eb15be17990a0ea605629f1a0994bc1e5358f35797edd40e10def30e74c13dd1a288df20476ae21d00a726c141ecf4c5a8f2c63c3d34f1d5c82163f83a94ea5cb288d4361af0d3ed102a37ad9ecff0a1e2ff3fb1f92e2e6009c4e23c4596611b4eb01c49289e7fa5eb39344977cdb6b609eef1bbc8cb1f96b680867e0e82cec063b7fc36da0a3fe8edcaee262cb04b5626d1b4419155158150c59153eeacea020777690f2d0186524242fd5894daab1aa46e204b3598362f1471c6b6186e43c69d69fd8c8850f3820b10bc98f6cf7c38ec97d3be97378d08e8a48a77acfb85d1e0e612de1227c2f1171d8844c219fcd41af43b5a6ac44bfd5749bb55b6ee79a52ffe3c6ed53e61eab312a8f48b45cc5f87e92465a466a93d8c01db194f5fb717c9e970616b826ab6914a357aeac622dde68cfc19af74769f0c0f332bb936ba3cda0a4c5e5e9cbe9c4d32115527497a9f03b4fc7b431e323790860f541317c97057dbfcaef8438d8d1b492a07a373440d6f3e9c9e2ed15106edc6bdc834084548dee19c88dd1dae28d20773f9bf2393666873aa05863c131011723ca300e974276660ed7b2bb65eb584ad942870fcb6d287daeea2b1247ad3902ca612b01338eaef6abd8a13367ab4833c31458f38b0922b034298aad2fe4a148402fa9ad1817daee7554750236d789fd3b2557948b1520c372f661513626ca9af6391e05543b85afb8ba12d947a39625e72040c60a1e12922b415bb23e6422c087098b4dbef9aad7287b6491036c8ebd2dc478d9ba688478f9755097422488ff47bb2932881c5cfbecaaf963ea446b7499017fa9ff4b866b68c421350ce1804d7d5e8800dca8fc912979414724ee9e97ad29fd133129e432dd0314602dcb435fc6ab8a03b1f4ecbc0027d65ec073d065cd9815e45784d2c2ff39d36e09e6a28e744f75edd97c8b070d8f359b8554ae9038d26c6f3a58ed2be0cc380c6ed0c77a3f4a43dad57cee2554ba22b3df359ab99e0ca9ec5a94ad4d797501c18de9f76efd5427675db62434195cafc70f4cdaf361b05b62f7277b7e48f47ed15827227879eda537d9095b6eef11bf07b13a2f59c0316a72db9c01e8c6e9fec71935a6c88023cb5d43178f121d9914684d2ed3928e3817a4cb04415ce0e7774910e0d3579932d6bacb3b6ae8811fc53a9dd94676912b22b0437c6f9edc4a1ab23893d2a9aaf820bf32f7a76572ee6edaf9dfca6f824c63f0b440ab4124efdeec666a956178ba63c7a5a24722b31785f1ee99ced61c2de2c59e32d983f156e6722c8a27a4019a56293c3d194dbe341cc4202d83bb07b1b98ab43d646c834f80a9f1674b704c2fd1b8ac8666ac983e7208b4bd9e10293b03c00f09f6ec475ee0415c5d49acd55705f441257bb0da9fcb7eaf21b5cc0c3b01d4618aaa189b5c97d949b3ed6145857261a710d3570a8c100ffc3dec2e246653a60e558ba34550d226ba68410fb73f520eda7cdb29e0ba9adb46d78b159842b1abd51a1334d96cac65b66d1b7edf2e86f0b464a5|2f9880cc006be7c959fe9883efe00fb5|68429ceffa0c5a21d69cad4cecae56955b2918d4e607df3e5a236fa17743b0027ff709fd1e1e86414992c6560da16529fc4f8e96b4a02afaec7d3c7568e8016f|3','-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtwhulztYC/Fpltr3sPEZ\n9JAuis5gy/rUZ23yqppkfxO2LYwOQmoFs9X2L1bxBkiZbBJQGnhtRW3jt/pxyk55\nEMGXzQ8/68v7Gg3kxiwq002eG0MYMyRqv1MS02bXKiu7N9aHJBGfk7Lq3tnug/Jf\nlJZYDXKZvTj+IVWUIapaLlxdjsYR8m8fh08Q6v8Lgo7HGno+mWYusiqIpb0OACQb\nx49HrO+n+oQpQjPnesjpYeR8Jac6KqOkX/aZMjNMEji8RqxCEnRKZx+NG+JASmVv\nqj4QMljHubjj6v8PgqThgejSXRWjyLCRrPpgvpic2q+KIQ5I584AtLWC8dMz4dBh\ncwIDAQAB\n-----END PUBLIC KEY-----\n',2,0,'3|$argon2id$v=19$m=65536,t=4,p=1$ZlZnVllrVExJQ3hxa3JJeA$9ytVOsLVnFNpkOUvvPM46XUTVE0AWvw81TRL5bkeA9w'),(2,'Landing Pad Digital','Landing Pad Digital','J6TaU5RWPHBBCnfFmuSpVNZQjhja/YEJFpQZ/ELKM8xnvKgyhj2EXkx75+Yo/CGRRpJUXb3tg/j+h+uRamqPVxiRpX5O+QCLCEu74XDUQHgmjWpcIByxolUAviWkdVZIfiMFY30/pGKX/yxzP1rOY9/OzOZalLSGopPtt6HaZC4lAlxD9xogVuzBPqtwyzqhEYROaBZ9jL68aOjZRLsZWuDmZ505/025QzqIFVKAYf+EWpnntF25GQRV1D2m6iVnYi0C8qMPcrU+6UPFpu5wXBGxejkz4+KSxEXHq1J8TsLvik6Uutti/2kdcdBAsU5W+vQiOYXdoUH+Xfd960IIqg==','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36','5e3d027cd34ace0c433ac43e97ad25be00f93e9a33512c0d3c8118c2a184678805af54bb2729152853e30cad1ebea4fef80f3776a0a7a3c2442950b212e7a9b6',0,1,1750752107,1750752046,NULL,NULL,'3f6ca938db279f081ca97c6d02b7f7b74c4247c640683b7d9e20bd3726baea2f3eb9197180b3f34242d221ac4ea2b10feb45845a20bf3bd923734ef55f7b72d3a3861bb3a257392d0767b8e92f03a189d4aeb49175cba7e7952ca7abf3f0ef839c0e2fa1b63ce108a824a1fc25c4099328e76435d5596c234985ec9af13abd26d682d46dd13f71cbd7d8e79e738e7aea4625645bb9daf40573d668b9740c25c1d8658a0ed3bb5f81dfa60f68d7ba7e819ca83048ab66115445f9c7286dcd3c3bdb063c0cea3821622dbd1b2572548bb57f4ea04714a34c4ca8124f776ca5a0a46e6240fd87f9da073b7b7d6dbd648f3210371a87ea7e5c474e988b738aa701684f770944e3dee9aca26389ae2788d5b71a3598d5ce77e003d2f8b1586ca4f28626aceccd2cc9bb2963f3178dfc2f32e05e8e1bad2e5fda7fe96c94f40978a38c71a2559bf4829e98c7b0b4fbc588f9faa764e83aa4d6c5293f6245db7999552e4682afce35e54519de24c4b9f88b38eb05adc8d8a99c634cfce091d756177023e2e4d30e61b5789180016aeaa7191fe807d86e201f5fc169c7b9dc419c12315420249fb157dda95e743d0c2904862800b600ee5fcc917a18563c2325f42173207a5d5633d4486336185f4255d0a8a24c1a952dd1034ebe5ad5505767993028fd3a8ede4449c6f5a1c83f4533fc0c8152eff6044d4974cfb9960486a589a8c12dad0d7d8d4cc46d7f6f8b3fec2b5f6df61d2003902fa12f7693be3a9a14a89f2e0dc418fcea4a0f308004fadc862526dd4718a314764d59daf91a1579e297ca778a1250aac8f9e2fed40810ba77dfbe7e1964f612302c59f9a88288c1622351a16c3d68e76f46401048a1f3ef84820bc4e9e35e321a717e5cc46e35de86752327c77340cbefd39511b834b1d06a6f75edab2fa1ba409ac7badc38d95dbfc38d74b79da98f1382c4b6d2fb4be89744cd239e17980f2b146012e0e3ba2a6cdf7746c5c4534179ff6cf1cde11d29dc2b798021d395ff558d0b2b6943e9133e24d24e4fe5e82c0703e6daaa826ee432c04ef9496bf37528f92702f0d73f94380bd5109349a1deeb89153785fde9c7e44d9b29334c6cfe4184f52ef83d5b7846894c53779faf8d9b8600d9439c5f6c5a23a327a401126f6ef8e9860a541cb366187f6bf24b3ae8a94b231573ca455e7a37d6cbed5eae656e3fb05e56152717b42cd25069f0010a15650758b859abdc630462a96e5ae92830c9af98e7ab95f3d3e3d75ab09d70f3fb2e37cf192837544ccb62c69dd4ca31967ff753b7ec84fe69cb879c99f6ad0529c8b331f6f7932dc1a1ebce1680761215b025a327cccea19e68e70141983295e95542c2694853b782038ca428e5d35af636a72fbb0c1cf9e097d5f39cb6e4181599c41444f9b0aa20c3a23a4db3b7b6586f54c4e217eec2e7b5cfea73bc3d27f71876174d30dde564a745607b2820627cd86c0f48231894ab1a6f71505cc86efb044a204089d1bb97ea27dc0890ba6a8fd8482ca0f6259afe700c1d09d115e2bc793036bac29a005f0ff6dcb425ee45c0d7256c3860031ec23ff82209820608bad3154b1ac8431bd1f8bf9f00147379508a6defe2c0014791b8ae3ee25ac6f67bb44ce05c9c06a8d6de9dc6d3a5eb7b3320ff056d89fadace69055e76042db15c1310014fb00cbeb4467a1b854ffcc72aaa44f15809d6a5fecf8c3b6a4d143f63f8e6a646a42db3f78323316d52267b164c03e8a147fd72bfdc42a0d4257f388266f03736e80310e7b48856c91239f551c5cf52db9844c3073994e59762508c563c455b4921a62e470d708dd3961e7f04740501a093f76722129d1d94df5e905b037f6cfe1a0cecc9a22425e6f6803f0f53c41c99dbe90be1b0c9f75f445420da16ee546143f67ac806e0302dc6fa066906d793ff9235def7ea97a8b022e47eb18ef8dcdfdfa428e11923f04062bcce29bebdf3c9c68c603953dabacfc0b57cbc3d49ca1e860f1d0ec68575b1c292d218021aa6ad20696a788c550579bca2e93c960314920173e02c5a301d246ab600630ca015f9a63d4a57e628d23bf6f887948765dfaa48be0d01849d0449b245a5e40561ca18849085f1588467887674b72bed789e507c0813b6bb0673c634d315fbbe720d76e6493e68e0cfce005cbe154f031be846f9faf5236fc08377ccca480074cc52d5959e8e38a82c0322212beba8e21cc70524c734ee8938e1c1e8619b7f2141f27caf5d8f5099904ad8e6248256bfdb4a737b083a4f0c1cd3b084373c9ed9078ffec2b64c977705424c7481c11cc640e79c58948b9c0a43498dd13efb9095baa9ccb8a4f2a338c587b8aa1c62fa3dc251d3b865fb60dee404af090cb59613c2de3296afc026e0698430abc4388844dae8710b75adf0091203|6bbab8e1fae8b56d4da7fe639384cf48|638fcb5fdb4be903eb035c859f79c820b751e162547b26cd7d29a15e241d66740dcbcbc3af1656e343f0df9d1b5a9ac681e3d66b8537289f4e1e403196f70c41|3','-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApon4wrF3Dc0VEu+Q6zmR\nHgMZYLJeLR3a3BZiKjBL0FRgcFjcTe7jNH088nYAkyqsbVeUMlssq63A539tf2WV\nt6zQBv3iKaQgybSj3Aw7EfSxWKrQwxdn7PwfvsoW/jGX4L5r0t5HokfH6xAky+M7\nbwdGqTWD/mH4Rr++hbkRuoM4Ho5kwA2DrFoXliYDUw8nsbWpVwLcBtX6wuA7SlQj\nUmNVxR8okbQMbhh9AIM9AGEWzjZiqe1SzruGlvaybCRyxBN68hpXX+nkDWPGhkRf\nl/0rsffE5ACXj9UbmW+rm5pBB+lNp81Irl/rCj96ynt/+Rz6M5v38laCvnWiuJuM\nEQIDAQAB\n-----END PUBLIC KEY-----\n',2,0,'3|$argon2id$v=19$m=65536,t=4,p=1$ZlZnVllrVExJQ3hxa3JJeA$9ytVOsLVnFNpkOUvvPM46XUTVE0AWvw81TRL5bkeA9w'),(3,'Landing Pad Digital','Landing Pad Digital','HQWs3jBwIdsRX6dpo+Nz86SidjizKEkVcOIO/ARZsY3Sf7w72mki8t1HJ1i1JAL5z5SukTqrZ7XFaLGzUqLGTjx4/8ulZJE4m49uL68hm7pIl435biE2iW1duh2da9qjUnDIfTOcoKNEcG2YhmuPtw5pmHyfFerq4Ccb4FTzxBVNJLr+YbcHBKH0vqeLr9OVjZ/+NneumdMaIi9k87QJrA8ENPMSft7QAZR/5niraQHZnV2qTcGbEYGi6xAOsAHJYrFp2yFY5L450NX2uFvX6OvB3JwfO8tbb8LgkntUa0umnTArJRH6GNLTh7xFtamUjkUgUA18XtHsqxrFDJVP4Q==','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36','30121933cecef7f7df356a6abd1be882288ff67a55ff2934e24fbc2e73ece3c80217bec2133ff944e18320d9adad13d48e3c62fdf5ff3d60cd9268ff4b39189e',0,1,1750752227,1750752227,NULL,NULL,'b6891a93854416097cb3d9d113fcfa7cbf8b3507348d5c52ef8a10ff2c81acee8216746d1df63b50f64240c8224a93bd1b41244a485ca4b566df977fe6cd4236fdb22f4a8de32cb24705217be2db92dfc63149ba821276585715081c4cc397ddc64365f421a900fa7031e5888864beb673c63e12f7004dbd7183d1e06da74ec56b2e62740aefa527e3c350079a107ba61b2f16b9bbadc3ffca9060fe264fa6e98f1c72acd6a11bae531cb9d8088322fd26e4faa794cadb42581923898ad80931c3c0b8d636251c6675ceab3171505ee71326d3eddb7a650c5bd4e7d33ea9249cc84e1d80698e6ccad9e6a000bf8d4888efa951503085cb3f58a8c77642752fc10dedd138eceb5ddd66e70a57c3c126f154c8dd577262c357502f6d3aea7f48e5f97b9a9972f8a40c23b3bb8cb52604dd6b4c681c5c34df210dfc33184c3bbb5ed6dbf0e52439a8ca105018f68f79e968b7aece3eff80963533725ccc4a05d64313866499a92822a654288c585cc2cf068d444ac5012a673b15a005d62fb7a20b352357830a07e23bd7a69c34553c472f30eca62b298909046ddceb658b391f87fb5ed1413b2535618e6152af8fa839e3b8e675068e057b2905f2b22aca7eed2839aa976add6a91f26e699af8648878698267faaccf07676b13f3f38bdf912f58e71f69e915cd0d7c762e5520141d9f78fe112b4fdd8dfb33597f8e1ed82da116b5de57aec26a01a9181aed54fe461bd6d10939b2ed48ebe0e081da1b0f46db10c97f7d9f7f2b1d6f4475e7b054a85eae224e441d3ef84fc3190b2ba598ea0e04254aba6cbfe266d503408ba35b9703fa624ae1b9bb41624a1e9dac57f7cf0fe751b6acd928870d6aabb7d0fa98e2a5846a402936a75ceb7d3a7138e2fccbead4cc0aadf7fa304c151d83bdbd759523903507ad7f5e33141be420344e5875abf336b72419f4000acf47cf9103b990d58b46098e0b4ae07dcf7cce60d8c07f4f6749c2dac7ba21491902aea403bf3176048f12521562f71f06fc3845a363d639bcf2462aa64423f38319d98c2cc84dba09a26d1964a0e7d57a1e63b4a8470cad6a080b7b2d9875cdfada29071d75f88b9f1d46e19b5d4ffd19d4a956addcbe51cb614b022c349839a8d17e0fe17dbe2e49979b491b326083ab8b30d4bc5c7ad2d533a0d723d58261e28f6f568e2ee4850112fd590198aa28a0427d04d324506372b3d4c80847c0f753b5a281dbae682447a28a5963c7ee324a205d1a8418deb8eadc3d296cf36fa919d97c0f8f0de2f1b5070ebc8c30406c28b3a12b3cc84d7a52de10392f234c36aa0f35c8400dd0c9d427b3407d95f1fb52d6586fd62fa45f8aea7abaf42b91a06dcca0e6b39163a2c05806ce950e88ee08b2fb3754666868fec6164b675755aaeb7aef6f4d8031f72eefc134f75b5074b635665914f21b3f1761c6776c580b2673ddb769b33a3040c42adb7a7d1ca1771c744caee94e5703027c114e68a08a8f8f1e38288e9e2bed6277a0a8cbc9b8cd66e6915aa1159d099c6282d06192b7030ac6036ad7573cd6c31706adf72af83dc36ed3fc768b815b6109aaab4296975808e3baa4cf981b4b29592ac4c07e1ac4f254c7ab3a696bac9205e37a2c65a8fe27ea72a4580642ba35a7243495185c56431c737404cff8855828cb83c1776170fc7d75b7d1c394c17e856e857b2c7a197fdfd05ef02b95eb2aae810215368b500d28f3f2487deb160767f984efefd4910d082f111fe19a1df8abfd48d72ec7c2348e98575e6a7d145eab46bd051d54ee2e66cbc711c9c1b5f52376454a7123a7c838e82c83f51dae9a87c1220488254c90594cdc81f1648424058640d9638e51d450729f764fe740996ee0ea94660e563fb176c3d67a5c6f1f23df6fb295f6ab82400697152a9680be04b1ee3d2bea630ea44cf2d82e800bb9d98abe105e0fdd045b37c75283e37c898dc94d47659880b3ce0a35c24d4159fbda9164a01f1f8a9db2a0420de0535c54f95bef692153228d58dbee7ed68dbc24e4865f4d3bc4c20dada8f878af18a00d100cfad7536f4376277485b84e2c2d5594f2d43224692091bbbf13d9359e0ac71a13da0e321129df19190515ec730799138895f83e31b3b378b109da83bcfc63c8b4be322e0737b6f875a3b33681f3b8aec9505b6809ed5e61220ceeae432cf6bd996a85cbdd64cd9ec84cc70da51c467865d301ac47235bd6dd7b87d483766a4587fe853fa1ccce58bdc7065ac4097325723ccb1181a8330883d7b5a15b27600aefb9e50823202ec65a8f601ea7f3e99a8faaf5b098acca8bb29f3704cb4f8e1983becc24e7bc8f14c4fb43d56bbc898cddf17f371a6fe57ecc3bc72495e37a436e5253677c3b4418b93fc7e07de27843d795866c356920a86d4dac1d2c968a|afa76d6bc43eafe8f2d6d0ac497728d5|936d9428dcbcad98cc2e373a0b18743a78cd6f70b480b2017a4e2a963b1b5df47fa40c775430453837adab265a49c34dbbc9b5b290808459f9fa7ee5e49c8806|3','-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAhk2MpLa2SF5nwAi39/QJ\n29PBmZNScMhAPBZ2Bw2Mc0z39JWUpaXAgDREdq2A+2R+EU2cu9+5eB1ym9jZPNJ+\nSZ7y8Xxuh/I4JpztDp7C9oww1m2v6h9ymH+tVQqHe7x+oK8mkxABHWGgkx62hbDq\niGBD2hXMYDibrCVQLRW0CIZP7c+1PihZBx6ZQ5yLHLxmQFTETZzJpTRgFC+EUUoI\nT8d+uJGBkOfpKjK9+4EnbD313muyYPXPKEQW4gMOnia/ko8rbfeCP51hz1kVN0Lh\nrVKk0vmpRY4qc7FrDnGJvd7yeyK597FhAc5l8mrAwstJHUoioY4d0L9A9HKsytnl\nhQIDAQAB\n-----END PUBLIC KEY-----\n',2,0,'3|$argon2id$v=19$m=65536,t=4,p=1$ZlZnVllrVExJQ3hxa3JJeA$9ytVOsLVnFNpkOUvvPM46XUTVE0AWvw81TRL5bkeA9w'),(4,'Landing Pad Digital','Landing Pad Digital','ODX6x8BDoc5TDHPTD2kaQOsBZFeJRFRw3JNrBEwK7aYjXb3MxVJ1emsEGoMcwMtYe4zQOU5fW1/Y6m+BcIl9tujvuI4vCojvGPjCfNUbhLaB+LDxIvGJceyFdulmLWwTyYM0znsxR8HJX9Cnm8DkOr41MCGDFPvHiqV2WjEvqlmqo0Sa6TSiKxafT+uilgX+w1ONgWOPr+Wg80zoZB/h6jKy46QFZ3YXD9yel/f1TXgt6CQAJPqQC4+17f3RdS9woiNLLOGnQe7axXF5ZDyOJTbtR3feezxKI9RHHxs28UZAW3eP/8gbz36xxbf9H2pkbw5Ec8n128p+/w1PQNmguA==','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36','e74348a2eb4ebc4be58adc5ad5dfc94bca87db8f927c84980852e4e0f8be5b315b700227f3661cadd86fc7649d36db4263790c5bf2782e46b9c37f0228ba9dc5',0,1,1750756454,1750756213,NULL,NULL,'b205f22f2353ad248c1208f1baded04a152c410e592448188d64c25144ca668ecb9127bb317c0d4e225a603c59f4ccb001735d5260d4d8f1ec36b51632f4e692e4b4585be783dd9171ca100940c46e12a5bc3802758c483574a00a1f58d54ed503a9f1c57f90dd86a0b31c3e88fe65b5cbcd6eb2d8ad74c2b8e23ee090c7a5439fe0a8409146619c5a8c299d52eb55e2cd896f9f866ac36bc2a30115951cecd12dca5c75fb9e611ee648a6a780d40746502d71e004c9509101a6b29afb5d28555f144ae5a38159c7b87934cc66e717592d90bb9bacc78b4ff3fd8bf79f815b19f1ccdd32f95208df3c8d2f5c21c523997096751f5824dea9078e41d61f6856b13e557c14769047357492d4d087f2a7edf4216486189700605e5bd3a3c8375477212703040e0446c0aed15cae70fb025a4b214fa21e7f579e6acd6781a18e2ea782b70bf6043936b59e351c64cac6bd297fc7ef98b0d23c7a6870e784edf11abffd6e831198eba88ab3d8949e850ea71aabcbde1c6197f4ae5872f610048f6d0a0cf473a1b3ee7ee3a1b773ace52eba6db03d2e651da52dd3fb5295344a0caafaa17a420d2db0799d6eaf600604805f1fc5899513bb4e555b6190a3cfd460b6ffa5919ff6c862ac69a09cbd06083321cb3af36ca39c55060abc231804bd828a9ce6dbc7cf3c0b22eaaeeb866b99c6532d008aca495c48cc305b33bb76f38ecc1d8dd146f4030e708092bbf0c0500ba5f5fd0bfdda680bc93d71fbd53d06d36b44d65d501300db446c823ae4130c3c6e565492d1bf75629126bb38a4e84fed28d1a9445911ba99678a3acc14bdea18c10b73383897c18a3456521ef6e3e746d708930be499a05434bd0d2d2764bb56d054cd83973ef117451390276968719b58200a47fe2bc168c1d955de8b749351aa50913f31419bd5d0ed9e4fa041ee135a5b69571673f1d90b0ec9f0a7da5cf43752775d92a257bac461b67bf58c0a9a53067fb56f0ddd3aa6a3e263b661637269e869c8bff9811847e2d1d75f37d6c0e42bbe669a16fc52acf1ff1dd49b096755cd379be34f1d420cd3eac9db5b081ab727778bf4d13217dbd120ce3a0c22ec1e75890e0378ecc28d895df0c01ed747bf09062576ea67433e6ed40caa847cc37985486cf4b6e634bf6f2b0ab6eedc9fd36d3d9e6e862ca19192ba3238a099f921ff94138b4b4f4c8d6bfc0c0a109cc31b09d6475d075c71df41311f066fd0bc3d43bf4c99cd16aa065078d5cb5edd242cca34ed69dd11e816afa81307dba21229ba9ebf9fc72384e6521eea4c8219e2019b973524b6eaa8c798927a32d485b07a59a1fed5741d12e1f4c39fa17ae989d3ec50b9e6af25ec02bf11bfe7a48ba87d55c2f62a0fa3a88812a778d601cd733a1acaf2aca476a92b79d85504394818c75a33db49473c33bf5c835155b872d9f3c301bc30e1893aafeac5b4dbf6a4725737171292d03a2206ed578413bdc0e6318ffde365f525e6687c5b002e3e813222ca30df4646111d1f4a0eb60af9c676becdbe309bc381f7817b363cc2eeb526d015264bea1ef3f70bea3212222d29ecdd9a026e9b6e63c090a41c9084ecf0b80ea347f7e07045f4f2a389e754fba7fcc43daba3afae42a9841257c58737c6b99a2d97227b3fe766314dc4ce3c7402225fd9c1a826ba7bf0734428da235c90b2f2fdf347b9baff573683d8cc60db9d814a7049275f9ddb3e0c540025c2b7731d21c3c892e381cf30657cebc2a4c3d49a7080cd01a4ef981a7c5d932b92d8d49769fed3d372e6597969321007a998ae853a52de3e8136e321be4afb9ae50fc6c0ce9589053a64480b1eafacb2b76d9998263ebdfb3c00569f385cd5fe01c26e7448d79298fe29b28856f896bd3597c92cf59d246507cb81b062bc86012ac2d872116f46a233acbb65f3d56a6134b1585457b3c6316482afc7919c67965999c1954a76c0393134d1e2052467db4eda3f7d4466224d83f0645434ecf5f3a39ea6b065c3dda60c8edd2f9df79033990fb5538938d59d985f149be771e9a0ef9df5ffbad66eb3974985b633666bef402c7e99e59e34a2aed31bebe8c4432b4f1c79e51d64d2fb8dfb4f4b84ed60a38c03eea95b6e836c057f922f38a36a1f3632ac907ff15ee3f1d76b6afc45cc0d1e884ba8e6cdb5ff58e1a5a34a9591cbb073d6d4004b682ae98c7558c7506e47d517a22caa2e492a459e0c5c94b880737a019c10551c0eb2bbddc46f29051cb1c4baf4870b4e6cb3e84311b6f35b3093a2139c07a865f7c6020507b9942231fda49e5682f0a979ceb8c84b1b13d6981699cfdf5245443cf894368ad1c89082af78d089a1f09866388df5f4b20be4744174171221708c3c7259e9d3ff4673b680e4b3982022711081ecfe808794f0670dab3235bed2bb|4e01e74829d6964374a165e8e41beb6b|7608d07bb7758013baa70fa10e24ca521c129c0570c33f0f6fa441fc68c4929b15d59e46e7394aa0d04d9572d01d3f93f079c17a33e02a33274514ea7f82efdb|3','-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu+7ZS3mEpzW+/i10iAA8\neJdZYZC6zmaUSvMW953In5sq5a5uwE5vVYb8Ta4GvmnCSdwWjOH4znHIrEiUNlKs\nC2YzX+pqsFtsAqdSh5PWSsAJgCIZvBNklcxi4V/WiUXBp20AwJb58PiCWFdhSyGH\n/4W4fjh/15/vYcWNdTOiwJeA9AtRFS+DsoK7R5j30Xpcc9Qir4mPmg54fA7lORXs\nXvlDM1XmddMaBc2iagXSRPRJKJjrof1fhGp7nC2aDJ9zfwjPiT2S1Md6/MU8hVFV\nM4NlVXlISjfCDNYGifm8P0vXgMMH5R5q4o+aHqNkUgCpfrzZqiKq12M/2gSIzgl2\nOwIDAQAB\n-----END PUBLIC KEY-----\n',2,0,'3|$argon2id$v=19$m=65536,t=4,p=1$ZlZnVllrVExJQ3hxa3JJeA$9ytVOsLVnFNpkOUvvPM46XUTVE0AWvw81TRL5bkeA9w'),(5,'Landing Pad Digital','Landing Pad Digital','NDVNpuKlmiEEDzuE+vERHMPl3VQ0OlpTBIMbjemCH71zhO8/fQe8d5b5YVwRbQ5osJfjG8u7UF8/1y8QzqtdSLlBWP5q1G82HmtZ2crCMGxkHq0DLjGoEp5FzTPl/ZQkglo8RMXejYc0ArppmgaUO8sxy0jsU1dBKrQ+51rIT4BKLvY667jT8LLb59wLBFOoqOmSabwF0bdQi21eqps629m6B4hzhe8nUo9LIhQFNUfyOOkz6cjTMA7PUOJnEkY3c827uDvtNs+gszy8vQSWUADKGPF8B81m+sfNMQWUQzsuoPSSKj+Z+YswwdWVC4uNmDs/5Pbt950kkVDkEOyzhg==','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6.1 Safari/605.1.15','a08a4333281054a5015a706e8796de1b1084bb4804a7f7cecfaf1e3307cb51ab539f4e6f8b4703f25012e091b2980daa658da6c87523ee7dce8d61964d46ec99',0,1,1750753271,1750753271,NULL,NULL,'8a71f185a442b49f5873a0209bf474e45b28ac630aa21c703f2f12a45888f3b52f1dd4409aceec54aaf548069da9a045d98c461f6824f71d032a92069d7085860fa1aa9cdc6f18e7d46e3fd029a9f0a7468bf46b604a6f47dc7e7eee9573b125b46494c22369ac39de50832a362acf5131eb078ee5c89177cb539e59c866f7d10b2dad9b59cd926ad51c0c14d87b42e52b7a0bc684da43d8d53e59268a7ab74f9f13f14ba41549a9d01a7aa036864cc64ca935993da6aee6478bc0ddc66023a3a568ca2e6fa9632909593920818b982af91e6a5c1d2538dc37c834b89d993bdab0ca6af8adc06c0623baff5e4383ad7ffe9f043e728836d68ff3bc35281440653fe9009b9bd7f73fa860fc28953fbc2438899e87d34c23c24bd02bc324647ce2f6b1b867ef79065a3fbadcbe856e2edfdae3f2b187aad3795a56f264d8b00c08f63042bb924fd06010167eae82fa9a187e943443f6675647a3509195b470e5a15575fed903100ed99343fa470d9ab5cc91e9bf8be3aff19d223c62685b79aa62d08ad94589a643730f348845ce3823ccebc86b0c21f28620b186d97246c29bafe2b8bc28c529e6d41b22dbf16bba3b7a839e564f6540ed586eff7fe9b6d9b99f4945d08c0c663cd78a4f69704e9e89cc68f87ff517a094076a624b807b6fdc30f23f00ae12e1483958cf7ec3de161f4a63b750fb03adeccfd4acd687d89ab7892ddc270191ddab70cf1a3a522cbae87a64b212a3c3034dee8f1bc730042c23e705abf9bdb47247c04f5126a103e9ed2e888360da577ce879592a1fe43b41fc22182ad7a308259d2bbd96f477af0ef4a24666cc5f17bce3caa4d5652d22f6fab611b877e26bbb827b63fef9a6e4324c0510ec95cf1b046f9e13d85d4d9e81206349b2ad85ea6e12841ad0cabb4e33c8d0305ef608112b12f5c3cc02705093c7be185e3c6e0a7fbcbd76eb766cc0e697da77c0dd6dadb9a3b68d2d654d31897a4235213054643b7c5104c557c59e1c356091097702a498a48ee2efc55d245a24b1760052e5438cf3dbd11bcba2203bd2309b977f84026c54e6bda150b56d001f7235eae991233b2eaac4227dcbacb40dbcae3cfa83c4a54ffef5691b56e9f09d7620a32e119b347b95207617a087e976c1654ea04a975b63b2176bf45c8f633b947d28b332c5c1d442608c1c448741fbb42a870a59ce6c9a7d0aec049fb868d5d3a0ca2b567acd575f8042e5122fdc6073cbafa251aa86095cddcd1b328221b17d6b2bdf7b85c2bed789de6c4446858d92a7ea115c64972355834732e9e0bb412862281a1525aebbabe3e7247378c09437a2d69b12aa5509cfd71db11619aa94eb0c2c279ea837956eb1aa0f5db0937a3dbf8d9032c23511284ac64cd5b4dcd6d3e3f72d6954b2833733ebbba5e49860a0a34afe0d380d4f18e21f1bd6ee3e3220af8bd46968040fb2f99ab5fa3b58928c85f483c36104aa39781d759ac35d72c4fc59a53ff8da3d4492cb17a5f8b5958f7197df0f23ca0621952fd192cbd536358883e0df3dfbc34b4cef74957d916ffc8defae2eedfc5fd5768f3a10b4369885ababa735e66cf4fbb586f0a23e63d2af04c248713ea83aee570e527261156e36a431f6b4ab24503e2500be9bc6765edc34f8b0fb395f22d28bf25de10235f072c66541e0e50198049f889c026de3526f5cc625db23bbd5d5f5498c2ff06ec409c1087610f5d338fb0091273851371055b4827bc6c5bf0fc8ec6d74f8acf5d190921f2a3b95b3f099882e1f6ceb22d1f0f37fd9fe4212586378fae175dad1a29f7329d8f8df33c9a9bb81923356edf275336f0be0206a7ffb3ab24b18c43c58aaa54a2b6b4e921e990db369a434d2e24d54ee554a4ec2466945d08f7e7a515a8995ec12c9d0fbc20afc7c92a988ebabbb7613a430bafd3d619aeea7ad6d1f810200469d90acd2baf2aad4cf0b91a3ede872ecd487ca018ac2a6a75f0ee7fb546bcafe38dbcc3d3d408215564306396d81717b2b49b87ee80b286bd79af1be84e22de690619f9bb5239c929b2ae1e1579d96f58cef5d740e3e691c380aef02e5038156646d4bfa30fb3d345e397227dd8bbd9be9f8d2426c3258aafc84e40d6fc9c455edb5b38956666aaa87a40ee918a5f871d6055987107882adb82b3a2ded14a75054125dbb3d298c947cbe451c018c2a85e4d2d41dfee79d01a31ca940d02b1b289da8cb2d7c6dc9c3ed3168d0b625185702bd014b788fee22e784bb4629f54f0c10972c6e679cf956429fc36f6258a9ac792097c6b0c41a19aaf798aeda3dcd76751a51a7c768f9b18c98445ecba17114db6f8a22c319ee9e25cc6f3b4bfcdb0a5e279e67911035b3c64fa88c0cd633e5057ab07cadff341fe29ea67b0fa29e80ea09a968cda28faa3512482eb1a7|fd52bc8a0cee41a42c7160c954f0f952|2ca7c8fb4df8a8c854fe72ad1a3b1201773aa659b93238898215953790fadd2d216820e42d42f1831087dae76867c365400b6b2fe1fe427890cd4617e0b1bb51|3','-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAp877SgrwTQCCDXTd5tal\nJCk3t6oYNsaC0WQo1sTpzACIjVwxcp/c6N9dt+Kc6z8fkWK73zWPGcvJBnlowrNq\n6slyiwHUW+y6xcxPCX14ke6YvUGddpO6Q26izueKfixN6DHkzpUk+fDMxozyLHzw\nZGH/4tBqUbpA3IR5dGPCKwOzZ/5CZFcSVwDmnbRKZq0vfuidZ4wJq9tCCNkZQdbs\ntAut72vIEOVIkc+uT2IyL+Q7+Rf4cTlBLLIIzjpAg8QXv/6gnABGurc1I+rEEEua\nL2izzDaeCZvEPmEFDxiJS4IrycMTcs+Fstwud9ouyszQi9foRAh3hFJ+BYKsI2GY\niQIDAQAB\n-----END PUBLIC KEY-----\n',2,0,'3|$argon2id$v=19$m=65536,t=4,p=1$ZlZnVllrVExJQ3hxa3JJeA$9ytVOsLVnFNpkOUvvPM46XUTVE0AWvw81TRL5bkeA9w');
/*!40000 ALTER TABLE `oc_authtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_bruteforce_attempts`
--

DROP TABLE IF EXISTS `oc_bruteforce_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_bruteforce_attempts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(64) NOT NULL DEFAULT '',
  `occurred` int(10) unsigned NOT NULL DEFAULT 0,
  `ip` varchar(255) NOT NULL DEFAULT '',
  `subnet` varchar(255) NOT NULL DEFAULT '',
  `metadata` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `bruteforce_attempts_ip` (`ip`),
  KEY `bruteforce_attempts_subnet` (`subnet`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_bruteforce_attempts`
--

LOCK TABLES `oc_bruteforce_attempts` WRITE;
/*!40000 ALTER TABLE `oc_bruteforce_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_bruteforce_attempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_appt_bookings`
--

DROP TABLE IF EXISTS `oc_calendar_appt_bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_appt_bookings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `appt_config_id` bigint(20) unsigned NOT NULL,
  `created_at` int(11) NOT NULL,
  `token` varchar(32) NOT NULL,
  `display_name` varchar(128) NOT NULL,
  `description` longtext DEFAULT NULL,
  `email` varchar(128) NOT NULL,
  `start` int(11) NOT NULL,
  `end` int(11) NOT NULL,
  `timezone` varchar(32) NOT NULL,
  `confirmed` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cal_appt_bk_token_uniq_idx` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_appt_bookings`
--

LOCK TABLES `oc_calendar_appt_bookings` WRITE;
/*!40000 ALTER TABLE `oc_calendar_appt_bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendar_appt_bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_appt_configs`
--

DROP TABLE IF EXISTS `oc_calendar_appt_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_appt_configs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(128) NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` longtext DEFAULT NULL,
  `location` longtext DEFAULT NULL,
  `visibility` varchar(10) NOT NULL,
  `user_id` varchar(64) NOT NULL,
  `target_calendar_uri` varchar(255) NOT NULL,
  `calendar_freebusy_uris` longtext DEFAULT NULL,
  `availability` longtext DEFAULT NULL,
  `start` int(11) DEFAULT NULL,
  `end` int(11) DEFAULT NULL,
  `length` int(11) NOT NULL,
  `increment` int(11) NOT NULL,
  `preparation_duration` int(11) NOT NULL DEFAULT 0,
  `followup_duration` int(11) NOT NULL DEFAULT 0,
  `time_before_next_slot` int(11) DEFAULT NULL,
  `daily_max` int(11) DEFAULT NULL,
  `future_limit` int(11) DEFAULT NULL,
  `create_talk_room` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cal_appt_token_uniq_idx` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_appt_configs`
--

LOCK TABLES `oc_calendar_appt_configs` WRITE;
/*!40000 ALTER TABLE `oc_calendar_appt_configs` DISABLE KEYS */;
INSERT INTO `oc_calendar_appt_configs` VALUES (1,'XqCxeGcHdejS','Catch Up with Tata','','','PRIVATE','Landing Pad Digital','landing-pad-tata','[\"personal\",\"contact_birthdays\",\"landing-pad-outings\",\"landing-pad-team\"]','{\"timezoneId\":\"Asia\\/Bangkok\",\"slots\":{\"MO\":[{\"start\":1750734000,\"end\":1750748400}],\"TU\":[{\"start\":1750730400,\"end\":1750741200}],\"WE\":[{\"start\":1750748400,\"end\":1750759200}],\"TH\":[{\"start\":1750748400,\"end\":1750759200}],\"FR\":[{\"start\":1750734000,\"end\":1750748400}],\"SA\":[],\"SU\":[]}}',NULL,NULL,1800,3600,0,0,1800,NULL,5184000,0);
/*!40000 ALTER TABLE `oc_calendar_appt_configs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_invitations`
--

DROP TABLE IF EXISTS `oc_calendar_invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_invitations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) NOT NULL,
  `recurrenceid` varchar(255) DEFAULT NULL,
  `attendee` varchar(255) NOT NULL,
  `organizer` varchar(255) NOT NULL,
  `sequence` bigint(20) unsigned DEFAULT NULL,
  `token` varchar(60) NOT NULL,
  `expiration` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_invitation_tokens` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_invitations`
--

LOCK TABLES `oc_calendar_invitations` WRITE;
/*!40000 ALTER TABLE `oc_calendar_invitations` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendar_invitations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_reminders`
--

DROP TABLE IF EXISTS `oc_calendar_reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_reminders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `calendar_id` bigint(20) NOT NULL,
  `object_id` bigint(20) NOT NULL,
  `is_recurring` smallint(6) DEFAULT NULL,
  `uid` varchar(255) NOT NULL,
  `recurrence_id` bigint(20) unsigned DEFAULT NULL,
  `is_recurrence_exception` smallint(6) NOT NULL,
  `event_hash` varchar(255) NOT NULL,
  `alarm_hash` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `is_relative` smallint(6) NOT NULL,
  `notification_date` bigint(20) unsigned NOT NULL,
  `is_repeat_based` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_reminder_objid` (`object_id`),
  KEY `calendar_reminder_uidrec` (`uid`,`recurrence_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_reminders`
--

LOCK TABLES `oc_calendar_reminders` WRITE;
/*!40000 ALTER TABLE `oc_calendar_reminders` DISABLE KEYS */;
INSERT INTO `oc_calendar_reminders` VALUES (9,2,1,1,'Landing Pad Digital',1781049600,0,'31369819436b95a573f2962fe82322ff','76093d23ab21b01668f0685b69a71007','DISPLAY',1,1781082000,0);
/*!40000 ALTER TABLE `oc_calendar_reminders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_resources`
--

DROP TABLE IF EXISTS `oc_calendar_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_resources` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `backend_id` varchar(64) DEFAULT NULL,
  `resource_id` varchar(64) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `displayname` varchar(255) DEFAULT NULL,
  `group_restrictions` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_resources_bkdrsc` (`backend_id`,`resource_id`),
  KEY `calendar_resources_email` (`email`),
  KEY `calendar_resources_name` (`displayname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_resources`
--

LOCK TABLES `oc_calendar_resources` WRITE;
/*!40000 ALTER TABLE `oc_calendar_resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendar_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_resources_md`
--

DROP TABLE IF EXISTS `oc_calendar_resources_md`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_resources_md` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `resource_id` bigint(20) unsigned NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_resources_md_idk` (`resource_id`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_resources_md`
--

LOCK TABLES `oc_calendar_resources_md` WRITE;
/*!40000 ALTER TABLE `oc_calendar_resources_md` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendar_resources_md` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_rooms`
--

DROP TABLE IF EXISTS `oc_calendar_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_rooms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `backend_id` varchar(64) DEFAULT NULL,
  `resource_id` varchar(64) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `displayname` varchar(255) DEFAULT NULL,
  `group_restrictions` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_rooms_bkdrsc` (`backend_id`,`resource_id`),
  KEY `calendar_rooms_email` (`email`),
  KEY `calendar_rooms_name` (`displayname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_rooms`
--

LOCK TABLES `oc_calendar_rooms` WRITE;
/*!40000 ALTER TABLE `oc_calendar_rooms` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendar_rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendar_rooms_md`
--

DROP TABLE IF EXISTS `oc_calendar_rooms_md`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendar_rooms_md` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` bigint(20) unsigned NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_rooms_md_idk` (`room_id`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendar_rooms_md`
--

LOCK TABLES `oc_calendar_rooms_md` WRITE;
/*!40000 ALTER TABLE `oc_calendar_rooms_md` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendar_rooms_md` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendarchanges`
--

DROP TABLE IF EXISTS `oc_calendarchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendarchanges` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) DEFAULT NULL,
  `synctoken` int(10) unsigned NOT NULL DEFAULT 1,
  `calendarid` bigint(20) NOT NULL,
  `operation` smallint(6) NOT NULL,
  `calendartype` int(11) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `calid_type_synctoken` (`calendarid`,`calendartype`,`synctoken`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendarchanges`
--

LOCK TABLES `oc_calendarchanges` WRITE;
/*!40000 ALTER TABLE `oc_calendarchanges` DISABLE KEYS */;
INSERT INTO `oc_calendarchanges` VALUES (1,'system-Database:Landing Pad Digital.vcf.ics',1,2,1,0,1750750139),(2,'system-Database:Landing Pad Digital.vcf.ics',2,2,2,0,1750750141),(3,'system-Database:Landing Pad Digital.vcf.ics',3,2,2,0,1750750142),(4,'system-Database:Landing Pad Digital.vcf.ics',4,2,2,0,1750750142),(5,'system-Database:Landing Pad Digital.vcf.ics',5,2,2,0,1750750145),(6,'system-Database:Landing Pad Digital.vcf.ics',6,2,2,0,1750750145),(7,'system-Database:Landing Pad Digital.vcf.ics',7,2,2,0,1750750150),(8,'system-Database:Landing Pad Digital.vcf.ics',8,2,2,0,1750750152),(9,'system-Database:Landing Pad Digital.vcf.ics',9,2,2,0,1750750156);
/*!40000 ALTER TABLE `oc_calendarchanges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendarobjects`
--

DROP TABLE IF EXISTS `oc_calendarobjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendarobjects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `calendardata` longblob DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `calendarid` bigint(20) unsigned NOT NULL,
  `lastmodified` int(10) unsigned DEFAULT NULL,
  `etag` varchar(32) DEFAULT NULL,
  `size` bigint(20) unsigned NOT NULL,
  `componenttype` varchar(8) DEFAULT NULL,
  `firstoccurence` bigint(20) unsigned DEFAULT NULL,
  `lastoccurence` bigint(20) unsigned DEFAULT NULL,
  `uid` varchar(255) DEFAULT NULL,
  `classification` int(11) DEFAULT 0,
  `calendartype` int(11) NOT NULL DEFAULT 0,
  `deleted_at` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `calobjects_index` (`calendarid`,`calendartype`,`uri`),
  KEY `calobj_clssfction_index` (`classification`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendarobjects`
--

LOCK TABLES `oc_calendarobjects` WRITE;
/*!40000 ALTER TABLE `oc_calendarobjects` DISABLE KEYS */;
INSERT INTO `oc_calendarobjects` VALUES (1,'BEGIN:VCALENDAR\r\nVERSION:2.0\r\nCALSCALE:GREGORIAN\r\nPRODID:-//IDN nextcloud.com//Birthday calendar//EN\r\nBEGIN:VEVENT\r\nDTSTAMP:20250624T072916Z\r\nDTSTART;VALUE=DATE:20250610\r\nDTEND;VALUE=DATE:20250611\r\nUID:Landing Pad Digital\r\nRRULE:FREQ=YEARLY\r\nSUMMARY:🎂 Landing Pad Digital (2025)\r\nTRANSP:TRANSPARENT\r\nX-NEXTCLOUD-BC-FIELD-TYPE:BDAY\r\nX-NEXTCLOUD-BC-UNKNOWN-YEAR:0\r\nX-NEXTCLOUD-BC-YEAR:2025\r\nBEGIN:VALARM\r\nTRIGGER;VALUE=DURATION:PT9H\r\nACTION:DISPLAY\r\nDESCRIPTION:🎂 Landing Pad Digital (2025)\r\nEND:VALARM\r\nEND:VEVENT\r\nEND:VCALENDAR\r\n','system-Database:Landing Pad Digital.vcf.ics',2,1750750156,'50fb6a604ed4b9608d4397ca5c5f311b',535,'VEVENT',1749513600,2145916800,'Landing Pad Digital',0,0,NULL);
/*!40000 ALTER TABLE `oc_calendarobjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendarobjects_props`
--

DROP TABLE IF EXISTS `oc_calendarobjects_props`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendarobjects_props` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `calendarid` bigint(20) NOT NULL DEFAULT 0,
  `objectid` bigint(20) unsigned NOT NULL DEFAULT 0,
  `name` varchar(64) DEFAULT NULL,
  `parameter` varchar(64) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `calendartype` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `calendarobject_index` (`objectid`,`calendartype`),
  KEY `calendarobject_name_index` (`name`,`calendartype`),
  KEY `calendarobject_value_index` (`value`,`calendartype`),
  KEY `calendarobject_calid_index` (`calendarid`,`calendartype`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendarobjects_props`
--

LOCK TABLES `oc_calendarobjects_props` WRITE;
/*!40000 ALTER TABLE `oc_calendarobjects_props` DISABLE KEYS */;
INSERT INTO `oc_calendarobjects_props` VALUES (9,2,1,'SUMMARY',NULL,'🎂 Landing Pad Digital (2025)',0);
/*!40000 ALTER TABLE `oc_calendarobjects_props` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendars`
--

DROP TABLE IF EXISTS `oc_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendars` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `principaluri` varchar(255) DEFAULT NULL,
  `displayname` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `synctoken` int(10) unsigned NOT NULL DEFAULT 1,
  `description` varchar(255) DEFAULT NULL,
  `calendarorder` int(10) unsigned NOT NULL DEFAULT 0,
  `calendarcolor` varchar(255) DEFAULT NULL,
  `timezone` longtext DEFAULT NULL,
  `components` varchar(64) DEFAULT NULL,
  `transparent` smallint(6) NOT NULL DEFAULT 0,
  `deleted_at` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `calendars_index` (`principaluri`,`uri`),
  KEY `cals_princ_del_idx` (`principaluri`,`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendars`
--

LOCK TABLES `oc_calendars` WRITE;
/*!40000 ALTER TABLE `oc_calendars` DISABLE KEYS */;
INSERT INTO `oc_calendars` VALUES (1,'principals/users/Landing Pad Digital','Personal','personal',1,NULL,0,'#00679e',NULL,'VEVENT',0,NULL),(2,'principals/system/system','Contact birthdays','contact_birthdays',10,NULL,0,'#E9D859',NULL,'VEVENT',0,NULL),(3,'principals/users/Landing Pad Digital','Contact birthdays','contact_birthdays',1,NULL,0,'#E9D859',NULL,'VEVENT',0,NULL),(4,'principals/users/Landing Pad Digital','Landing Pad Outings','landing-pad-outings',1,NULL,0,'#6EA68F','BEGIN:VCALENDAR\nPRODID:-//IDN nextcloud.com//Calendar app 5.3.3//EN\nCALSCALE:GREGORIAN\nVERSION:2.0\nBEGIN:VTIMEZONE\nTZID:Asia/Bangkok\nBEGIN:STANDARD\nTZOFFSETFROM:+0700\nTZOFFSETTO:+0700\nTZNAME:+07\nDTSTART:19700101T000000\nEND:STANDARD\nEND:VTIMEZONE\nEND:VCALENDAR','VEVENT',0,NULL),(5,'principals/users/Landing Pad Digital','Landing Pad Team','landing-pad-team',1,NULL,0,'#499AA2','BEGIN:VCALENDAR\nPRODID:-//IDN nextcloud.com//Calendar app 5.3.3//EN\nCALSCALE:GREGORIAN\nVERSION:2.0\nBEGIN:VTIMEZONE\nTZID:Asia/Bangkok\nBEGIN:STANDARD\nTZOFFSETFROM:+0700\nTZOFFSETTO:+0700\nTZNAME:+07\nDTSTART:19700101T000000\nEND:STANDARD\nEND:VTIMEZONE\nEND:VCALENDAR','VEVENT,VTODO',0,NULL),(6,'principals/users/Landing Pad Digital','Landing Pad Tata','landing-pad-tata',1,NULL,0,'#D6B461','BEGIN:VCALENDAR\nPRODID:-//IDN nextcloud.com//Calendar app 5.3.3//EN\nCALSCALE:GREGORIAN\nVERSION:2.0\nBEGIN:VTIMEZONE\nTZID:Asia/Bangkok\nBEGIN:STANDARD\nTZOFFSETFROM:+0700\nTZOFFSETTO:+0700\nTZNAME:+07\nDTSTART:19700101T000000\nEND:STANDARD\nEND:VTIMEZONE\nEND:VCALENDAR','VEVENT',0,NULL);
/*!40000 ALTER TABLE `oc_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendarsubscriptions`
--

DROP TABLE IF EXISTS `oc_calendarsubscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_calendarsubscriptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) DEFAULT NULL,
  `principaluri` varchar(255) DEFAULT NULL,
  `displayname` varchar(100) DEFAULT NULL,
  `refreshrate` varchar(10) DEFAULT NULL,
  `calendarorder` int(10) unsigned NOT NULL DEFAULT 0,
  `calendarcolor` varchar(255) DEFAULT NULL,
  `striptodos` smallint(6) DEFAULT NULL,
  `stripalarms` smallint(6) DEFAULT NULL,
  `stripattachments` smallint(6) DEFAULT NULL,
  `lastmodified` int(10) unsigned DEFAULT NULL,
  `synctoken` int(10) unsigned NOT NULL DEFAULT 1,
  `source` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `calsub_index` (`principaluri`,`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendarsubscriptions`
--

LOCK TABLES `oc_calendarsubscriptions` WRITE;
/*!40000 ALTER TABLE `oc_calendarsubscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendarsubscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_cards`
--

DROP TABLE IF EXISTS `oc_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_cards` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `addressbookid` bigint(20) NOT NULL DEFAULT 0,
  `carddata` longblob DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `lastmodified` bigint(20) unsigned DEFAULT NULL,
  `etag` varchar(32) DEFAULT NULL,
  `size` bigint(20) unsigned NOT NULL,
  `uid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cards_abiduri` (`addressbookid`,`uri`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_cards`
--

LOCK TABLES `oc_cards` WRITE;
/*!40000 ALTER TABLE `oc_cards` DISABLE KEYS */;
INSERT INTO `oc_cards` VALUES (1,1,'BEGIN:VCARD\r\nVERSION:3.0\r\nPRODID:-//Sabre//Sabre VObject 4.5.6//EN\r\nUID:Landing Pad Digital\r\nFN;X-NC-SCOPE=v2-federated:Landing Pad Digital\r\nN;X-NC-SCOPE=v2-federated:Digital;Landing;Pad;;\r\nADR;TYPE=OTHER;X-NC-SCOPE=v2-local:;;;Thailand;;;\r\nURL;X-NC-SCOPE=v2-local:https://www.landingpad.digital?utm_source=cloud\r\nEMAIL;TYPE=OTHER;X-NC-SCOPE=v2-federated:support@landingpad.digital\r\nPHOTO;ENCODING=b;TYPE=image/png;0=v2-federated:iVBORw0KGgoAAAANSUhEUgAAAgAA\r\n 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\r\n MW5QAAAABJRU5ErkJggg==\r\nORG;X-NC-SCOPE=v2-local:Landing Pad Digital Co.\\, Ltd.\r\nTITLE;X-NC-SCOPE=v2-local:Website  & Landing Page Builder\r\nNOTE;X-NC-SCOPE=v2-local:Launch stunning websites in minutes. Website & Lan\r\n ding Page creation made simple: no code needed.\r\nBDAY;X-NC-SCOPE=v2-local:20250610\r\nX-SOCIALPROFILE;TYPE=NEXTCLOUD;X-NC-SCOPE=v2-published:https://cloud.landin\r\n gpad.digital/index.php/u/Landing%20Pad%20Digital\r\nCLOUD:Landing Pad Digital@cloud.landingpad.digital\r\nEND:VCARD\r\n','Database:Landing Pad Digital.vcf',1750753800,'8d877d9c33367d6936ccc91239ce3591',19048,'Landing Pad Digital');
/*!40000 ALTER TABLE `oc_cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_cards_properties`
--

DROP TABLE IF EXISTS `oc_cards_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_cards_properties` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `addressbookid` bigint(20) NOT NULL DEFAULT 0,
  `cardid` bigint(20) unsigned NOT NULL DEFAULT 0,
  `name` varchar(64) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `preferred` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `card_contactid_index` (`cardid`),
  KEY `card_name_index` (`name`),
  KEY `card_value_index` (`value`),
  KEY `cards_prop_abid_name_value` (`addressbookid`,`name`,`value`)
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_cards_properties`
--

LOCK TABLES `oc_cards_properties` WRITE;
/*!40000 ALTER TABLE `oc_cards_properties` DISABLE KEYS */;
INSERT INTO `oc_cards_properties` VALUES (241,1,1,'UID','Landing Pad Digital',0),(242,1,1,'FN','Landing Pad Digital',0),(243,1,1,'N','Digital;Landing;Pad;;',0),(244,1,1,'ADR',';;;Thailand;;;',0),(245,1,1,'URL','https://www.landingpad.digital?utm_source=cloud',0),(246,1,1,'EMAIL','support@landingpad.digital',0),(247,1,1,'ORG','Landing Pad Digital Co., Ltd.',0),(248,1,1,'TITLE','Website  & Landing Page Builder',0),(249,1,1,'NOTE','Launch stunning websites in minutes. Website & Landing Page creation made simple: no code needed.',0),(250,1,1,'BDAY','20250610',0),(251,1,1,'X-SOCIALPROFILE','https://cloud.landingpad.digital/index.php/u/Landing%20Pad%20Digital',0),(252,1,1,'CLOUD','Landing Pad Digital@cloud.landingpad.digital',0);
/*!40000 ALTER TABLE `oc_cards_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_circle`
--

DROP TABLE IF EXISTS `oc_circles_circle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_circle` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `unique_id` varchar(31) NOT NULL,
  `name` varchar(127) NOT NULL,
  `display_name` varchar(255) DEFAULT '',
  `sanitized_name` varchar(127) DEFAULT '',
  `instance` varchar(255) DEFAULT '',
  `config` int(10) unsigned DEFAULT NULL,
  `source` int(10) unsigned DEFAULT NULL,
  `settings` longtext DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `contact_addressbook` int(10) unsigned DEFAULT NULL,
  `contact_groupname` varchar(127) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8195F548E3C68343` (`unique_id`),
  KEY `IDX_8195F548D48A2F7C` (`config`),
  KEY `IDX_8195F5484230B1DE` (`instance`),
  KEY `IDX_8195F5485F8A7F73` (`source`),
  KEY `IDX_8195F548C317B362` (`sanitized_name`),
  KEY `dname` (`display_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_circle`
--

LOCK TABLES `oc_circles_circle` WRITE;
/*!40000 ALTER TABLE `oc_circles_circle` DISABLE KEYS */;
INSERT INTO `oc_circles_circle` VALUES (1,'TSgMkRaYmXBbzQ2bEhbRczIwFe5yBkw','user:Landing Pad Digital:TSgMkRaYmXBbzQ2bEhbRczIwFe5yBkw','Landing Pad Digital','','',1,1,'[]','','2025-06-16 07:59:59',0,''),(2,'zFTCTFVsoxY77zGgAWMyBmLryxHhMrf','app:circles:zFTCTFVsoxY77zGgAWMyBmLryxHhMrf','Circles','','',8193,10001,'[]','','2025-06-16 07:59:59',0,'');
/*!40000 ALTER TABLE `oc_circles_circle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_event`
--

DROP TABLE IF EXISTS `oc_circles_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_event` (
  `token` varchar(63) NOT NULL,
  `instance` varchar(255) NOT NULL,
  `event` longtext DEFAULT NULL,
  `result` longtext DEFAULT NULL,
  `interface` int(11) NOT NULL DEFAULT 0,
  `severity` int(11) DEFAULT NULL,
  `retry` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `creation` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`token`,`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_event`
--

LOCK TABLES `oc_circles_event` WRITE;
/*!40000 ALTER TABLE `oc_circles_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_circles_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_member`
--

DROP TABLE IF EXISTS `oc_circles_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `single_id` varchar(31) DEFAULT NULL,
  `circle_id` varchar(31) NOT NULL,
  `member_id` varchar(31) DEFAULT NULL,
  `user_id` varchar(127) NOT NULL,
  `user_type` smallint(6) NOT NULL DEFAULT 1,
  `instance` varchar(255) DEFAULT '',
  `invited_by` varchar(31) DEFAULT NULL,
  `level` smallint(6) NOT NULL,
  `status` varchar(15) DEFAULT NULL,
  `note` longtext DEFAULT NULL,
  `cached_name` varchar(255) DEFAULT '',
  `cached_update` datetime DEFAULT NULL,
  `contact_id` varchar(127) DEFAULT NULL,
  `contact_meta` longtext DEFAULT NULL,
  `joined` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `circles_member_cisiuiutil` (`circle_id`,`single_id`,`user_id`,`user_type`,`instance`,`level`),
  KEY `circles_member_cisi` (`circle_id`,`single_id`),
  KEY `IDX_25C66A49E7A1254A` (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_member`
--

LOCK TABLES `oc_circles_member` WRITE;
/*!40000 ALTER TABLE `oc_circles_member` DISABLE KEYS */;
INSERT INTO `oc_circles_member` VALUES (1,'zFTCTFVsoxY77zGgAWMyBmLryxHhMrf','zFTCTFVsoxY77zGgAWMyBmLryxHhMrf','zFTCTFVsoxY77zGgAWMyBmLryxHhMrf','circles',10000,'',NULL,9,'Member','[]','Circles','2025-06-16 07:59:59','',NULL,'2025-06-16 07:59:59'),(2,'TSgMkRaYmXBbzQ2bEhbRczIwFe5yBkw','TSgMkRaYmXBbzQ2bEhbRczIwFe5yBkw','TSgMkRaYmXBbzQ2bEhbRczIwFe5yBkw','Landing Pad Digital',1,'','zFTCTFVsoxY77zGgAWMyBmLryxHhMrf',9,'Member','[]','Landing Pad Digital','2025-06-24 08:30:00','',NULL,'2025-06-16 07:59:59');
/*!40000 ALTER TABLE `oc_circles_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_membership`
--

DROP TABLE IF EXISTS `oc_circles_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_membership` (
  `circle_id` varchar(31) NOT NULL,
  `single_id` varchar(31) NOT NULL,
  `level` int(10) unsigned NOT NULL,
  `inheritance_first` varchar(31) NOT NULL,
  `inheritance_last` varchar(31) NOT NULL,
  `inheritance_depth` int(10) unsigned NOT NULL,
  `inheritance_path` longtext NOT NULL,
  PRIMARY KEY (`single_id`,`circle_id`),
  KEY `IDX_8FC816EAE7C1D92B` (`single_id`),
  KEY `circles_membership_ifilci` (`inheritance_first`,`inheritance_last`,`circle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_membership`
--

LOCK TABLES `oc_circles_membership` WRITE;
/*!40000 ALTER TABLE `oc_circles_membership` DISABLE KEYS */;
INSERT INTO `oc_circles_membership` VALUES ('TSgMkRaYmXBbzQ2bEhbRczIwFe5yBkw','TSgMkRaYmXBbzQ2bEhbRczIwFe5yBkw',9,'TSgMkRaYmXBbzQ2bEhbRczIwFe5yBkw','TSgMkRaYmXBbzQ2bEhbRczIwFe5yBkw',1,'[\"TSgMkRaYmXBbzQ2bEhbRczIwFe5yBkw\"]'),('zFTCTFVsoxY77zGgAWMyBmLryxHhMrf','zFTCTFVsoxY77zGgAWMyBmLryxHhMrf',9,'zFTCTFVsoxY77zGgAWMyBmLryxHhMrf','zFTCTFVsoxY77zGgAWMyBmLryxHhMrf',1,'[\"zFTCTFVsoxY77zGgAWMyBmLryxHhMrf\"]');
/*!40000 ALTER TABLE `oc_circles_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_mount`
--

DROP TABLE IF EXISTS `oc_circles_mount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_mount` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mount_id` varchar(31) NOT NULL,
  `circle_id` varchar(31) NOT NULL,
  `single_id` varchar(31) NOT NULL,
  `token` varchar(63) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `mountpoint` longtext DEFAULT NULL,
  `mountpoint_hash` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `circles_mount_cimipt` (`circle_id`,`mount_id`,`parent`,`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_mount`
--

LOCK TABLES `oc_circles_mount` WRITE;
/*!40000 ALTER TABLE `oc_circles_mount` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_circles_mount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_mountpoint`
--

DROP TABLE IF EXISTS `oc_circles_mountpoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_mountpoint` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mount_id` varchar(31) NOT NULL,
  `single_id` varchar(31) NOT NULL,
  `mountpoint` longtext DEFAULT NULL,
  `mountpoint_hash` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mp_sid_hash` (`single_id`,`mountpoint_hash`),
  KEY `circles_mountpoint_ms` (`mount_id`,`single_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_mountpoint`
--

LOCK TABLES `oc_circles_mountpoint` WRITE;
/*!40000 ALTER TABLE `oc_circles_mountpoint` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_circles_mountpoint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_remote`
--

DROP TABLE IF EXISTS `oc_circles_remote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_remote` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(15) NOT NULL DEFAULT 'Unknown',
  `interface` int(11) NOT NULL DEFAULT 0,
  `uid` varchar(20) DEFAULT NULL,
  `instance` varchar(127) DEFAULT NULL,
  `href` varchar(254) DEFAULT NULL,
  `item` longtext DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_F94EF834230B1DE` (`instance`),
  KEY `IDX_F94EF83539B0606` (`uid`),
  KEY `IDX_F94EF8334F8E741` (`href`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_remote`
--

LOCK TABLES `oc_circles_remote` WRITE;
/*!40000 ALTER TABLE `oc_circles_remote` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_circles_remote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_share_lock`
--

DROP TABLE IF EXISTS `oc_circles_share_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_share_lock` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` varchar(31) NOT NULL,
  `circle_id` varchar(31) NOT NULL,
  `instance` varchar(127) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_337F52F8126F525E70EE2FF6` (`item_id`,`circle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_share_lock`
--

LOCK TABLES `oc_circles_share_lock` WRITE;
/*!40000 ALTER TABLE `oc_circles_share_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_circles_share_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_circles_token`
--

DROP TABLE IF EXISTS `oc_circles_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_circles_token` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_id` int(11) DEFAULT NULL,
  `circle_id` varchar(31) DEFAULT NULL,
  `single_id` varchar(31) DEFAULT NULL,
  `member_id` varchar(31) DEFAULT NULL,
  `token` varchar(31) DEFAULT NULL,
  `password` varchar(127) DEFAULT NULL,
  `accepted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sicisimit` (`share_id`,`circle_id`,`single_id`,`member_id`,`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_circles_token`
--

LOCK TABLES `oc_circles_token` WRITE;
/*!40000 ALTER TABLE `oc_circles_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_circles_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_collres_accesscache`
--

DROP TABLE IF EXISTS `oc_collres_accesscache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_collres_accesscache` (
  `user_id` varchar(64) NOT NULL,
  `collection_id` bigint(20) NOT NULL DEFAULT 0,
  `resource_type` varchar(64) NOT NULL DEFAULT '',
  `resource_id` varchar(64) NOT NULL DEFAULT '',
  `access` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`user_id`,`collection_id`,`resource_type`,`resource_id`),
  KEY `collres_user_res` (`user_id`,`resource_type`,`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_collres_accesscache`
--

LOCK TABLES `oc_collres_accesscache` WRITE;
/*!40000 ALTER TABLE `oc_collres_accesscache` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_collres_accesscache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_collres_collections`
--

DROP TABLE IF EXISTS `oc_collres_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_collres_collections` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_collres_collections`
--

LOCK TABLES `oc_collres_collections` WRITE;
/*!40000 ALTER TABLE `oc_collres_collections` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_collres_collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_collres_resources`
--

DROP TABLE IF EXISTS `oc_collres_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_collres_resources` (
  `collection_id` bigint(20) NOT NULL,
  `resource_type` varchar(64) NOT NULL,
  `resource_id` varchar(64) NOT NULL,
  PRIMARY KEY (`collection_id`,`resource_type`,`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_collres_resources`
--

LOCK TABLES `oc_collres_resources` WRITE;
/*!40000 ALTER TABLE `oc_collres_resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_collres_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_comments`
--

DROP TABLE IF EXISTS `oc_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `topmost_parent_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `children_count` int(10) unsigned NOT NULL DEFAULT 0,
  `actor_type` varchar(64) NOT NULL DEFAULT '',
  `actor_id` varchar(64) NOT NULL DEFAULT '',
  `message` longtext DEFAULT NULL,
  `verb` varchar(64) DEFAULT NULL,
  `creation_timestamp` datetime DEFAULT NULL,
  `latest_child_timestamp` datetime DEFAULT NULL,
  `object_type` varchar(64) NOT NULL DEFAULT '',
  `object_id` varchar(64) NOT NULL DEFAULT '',
  `reference_id` varchar(64) DEFAULT NULL,
  `reactions` varchar(4000) DEFAULT NULL,
  `expire_date` datetime DEFAULT NULL,
  `meta_data` longtext DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `comments_parent_id_index` (`parent_id`),
  KEY `comments_topmost_parent_id_idx` (`topmost_parent_id`),
  KEY `comments_object_index` (`object_type`,`object_id`,`creation_timestamp`),
  KEY `comments_actor_index` (`actor_type`,`actor_id`),
  KEY `expire_date` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_comments`
--

LOCK TABLES `oc_comments` WRITE;
/*!40000 ALTER TABLE `oc_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_comments_read_markers`
--

DROP TABLE IF EXISTS `oc_comments_read_markers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_comments_read_markers` (
  `user_id` varchar(64) NOT NULL DEFAULT '',
  `object_type` varchar(64) NOT NULL DEFAULT '',
  `object_id` varchar(64) NOT NULL DEFAULT '',
  `marker_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`,`object_type`,`object_id`),
  KEY `comments_marker_object_index` (`object_type`,`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_comments_read_markers`
--

LOCK TABLES `oc_comments_read_markers` WRITE;
/*!40000 ALTER TABLE `oc_comments_read_markers` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_comments_read_markers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_dav_absence`
--

DROP TABLE IF EXISTS `oc_dav_absence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_dav_absence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL,
  `first_day` varchar(10) NOT NULL,
  `last_day` varchar(10) NOT NULL,
  `status` varchar(100) NOT NULL,
  `message` longtext NOT NULL,
  `replacement_user_id` varchar(64) DEFAULT '',
  `replacement_user_display_name` varchar(64) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `dav_absence_uid_idx` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_dav_absence`
--

LOCK TABLES `oc_dav_absence` WRITE;
/*!40000 ALTER TABLE `oc_dav_absence` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_dav_absence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_dav_cal_proxy`
--

DROP TABLE IF EXISTS `oc_dav_cal_proxy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_dav_cal_proxy` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` varchar(64) NOT NULL,
  `proxy_id` varchar(64) NOT NULL,
  `permissions` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dav_cal_proxy_uidx` (`owner_id`,`proxy_id`,`permissions`),
  KEY `dav_cal_proxy_ipid` (`proxy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_dav_cal_proxy`
--

LOCK TABLES `oc_dav_cal_proxy` WRITE;
/*!40000 ALTER TABLE `oc_dav_cal_proxy` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_dav_cal_proxy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_dav_shares`
--

DROP TABLE IF EXISTS `oc_dav_shares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_dav_shares` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `principaluri` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `access` smallint(6) DEFAULT NULL,
  `resourceid` bigint(20) unsigned NOT NULL,
  `publicuri` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dav_shares_index` (`principaluri`,`resourceid`,`type`,`publicuri`),
  KEY `dav_shares_resourceid_type` (`resourceid`,`type`),
  KEY `dav_shares_resourceid_access` (`resourceid`,`access`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_dav_shares`
--

LOCK TABLES `oc_dav_shares` WRITE;
/*!40000 ALTER TABLE `oc_dav_shares` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_dav_shares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_direct_edit`
--

DROP TABLE IF EXISTS `oc_direct_edit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_direct_edit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `editor_id` varchar(64) NOT NULL,
  `token` varchar(64) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  `user_id` varchar(64) DEFAULT NULL,
  `share_id` bigint(20) DEFAULT NULL,
  `timestamp` bigint(20) unsigned NOT NULL,
  `accessed` tinyint(1) DEFAULT 0,
  `file_path` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4D5AFECA5F37A13B` (`token`),
  KEY `direct_edit_timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_direct_edit`
--

LOCK TABLES `oc_direct_edit` WRITE;
/*!40000 ALTER TABLE `oc_direct_edit` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_direct_edit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_directlink`
--

DROP TABLE IF EXISTS `oc_directlink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_directlink` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) DEFAULT NULL,
  `file_id` bigint(20) unsigned NOT NULL,
  `token` varchar(60) DEFAULT NULL,
  `expiration` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `directlink_token_idx` (`token`),
  KEY `directlink_expiration_idx` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_directlink`
--

LOCK TABLES `oc_directlink` WRITE;
/*!40000 ALTER TABLE `oc_directlink` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_directlink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_apps`
--

DROP TABLE IF EXISTS `oc_ex_apps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_apps` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `version` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `daemon_config_name` varchar(64) NOT NULL DEFAULT '0',
  `port` smallint(5) unsigned NOT NULL,
  `secret` varchar(256) NOT NULL,
  `status` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`status`)),
  `enabled` smallint(6) NOT NULL DEFAULT 0,
  `created_time` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ex_apps__appid` (`appid`),
  UNIQUE KEY `ex_apps_c_port__idx` (`daemon_config_name`,`port`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_apps`
--

LOCK TABLES `oc_ex_apps` WRITE;
/*!40000 ALTER TABLE `oc_ex_apps` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_apps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_apps_daemons`
--

DROP TABLE IF EXISTS `oc_ex_apps_daemons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_apps_daemons` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `accepts_deploy_id` varchar(64) NOT NULL,
  `protocol` varchar(32) NOT NULL,
  `host` varchar(255) NOT NULL,
  `deploy_config` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`deploy_config`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ex_apps_daemons__name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_apps_daemons`
--

LOCK TABLES `oc_ex_apps_daemons` WRITE;
/*!40000 ALTER TABLE `oc_ex_apps_daemons` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_apps_daemons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_apps_routes`
--

DROP TABLE IF EXISTS `oc_ex_apps_routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_apps_routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `url` varchar(512) NOT NULL,
  `verb` varchar(64) NOT NULL,
  `access_level` int(11) NOT NULL DEFAULT 0,
  `headers_to_exclude` varchar(512) DEFAULT NULL,
  `bruteforce_protection` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ex_apps_routes_appid` (`appid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_apps_routes`
--

LOCK TABLES `oc_ex_apps_routes` WRITE;
/*!40000 ALTER TABLE `oc_ex_apps_routes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_apps_routes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_deploy_options`
--

DROP TABLE IF EXISTS `oc_ex_deploy_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_deploy_options` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `type` varchar(32) NOT NULL,
  `value` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`value`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `deploy_options__idx` (`appid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_deploy_options`
--

LOCK TABLES `oc_ex_deploy_options` WRITE;
/*!40000 ALTER TABLE `oc_ex_deploy_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_deploy_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_event_handlers`
--

DROP TABLE IF EXISTS `oc_ex_event_handlers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_event_handlers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `event_type` varchar(32) NOT NULL,
  `event_subtypes` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`event_subtypes`)),
  `action_handler` varchar(410) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ex_event_handlers__idx` (`appid`,`event_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_event_handlers`
--

LOCK TABLES `oc_ex_event_handlers` WRITE;
/*!40000 ALTER TABLE `oc_ex_event_handlers` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_event_handlers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_occ_commands`
--

DROP TABLE IF EXISTS `oc_ex_occ_commands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_occ_commands` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `hidden` smallint(6) NOT NULL DEFAULT 0,
  `arguments` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`arguments`)),
  `options` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`options`)),
  `usages` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`usages`)),
  `execute_handler` varchar(410) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ex_occ_commands__idx` (`appid`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_occ_commands`
--

LOCK TABLES `oc_ex_occ_commands` WRITE;
/*!40000 ALTER TABLE `oc_ex_occ_commands` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_occ_commands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_settings_forms`
--

DROP TABLE IF EXISTS `oc_ex_settings_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_settings_forms` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `formid` varchar(64) NOT NULL,
  `scheme` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`scheme`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ex_settings_forms__idx` (`appid`,`formid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_settings_forms`
--

LOCK TABLES `oc_ex_settings_forms` WRITE;
/*!40000 ALTER TABLE `oc_ex_settings_forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_settings_forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_speech_to_text`
--

DROP TABLE IF EXISTS `oc_ex_speech_to_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_speech_to_text` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `display_name` varchar(64) NOT NULL,
  `action_handler` varchar(410) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `speech_to_text__idx` (`appid`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_speech_to_text`
--

LOCK TABLES `oc_ex_speech_to_text` WRITE;
/*!40000 ALTER TABLE `oc_ex_speech_to_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_speech_to_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_speech_to_text_q`
--

DROP TABLE IF EXISTS `oc_ex_speech_to_text_q`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_speech_to_text_q` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `result` longtext NOT NULL DEFAULT '',
  `error` varchar(1024) NOT NULL DEFAULT '',
  `finished` smallint(6) NOT NULL DEFAULT 0,
  `created_time` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C1E06C58A64FAB3C` (`finished`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_speech_to_text_q`
--

LOCK TABLES `oc_ex_speech_to_text_q` WRITE;
/*!40000 ALTER TABLE `oc_ex_speech_to_text_q` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_speech_to_text_q` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_task_processing`
--

DROP TABLE IF EXISTS `oc_ex_task_processing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_task_processing` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(32) NOT NULL,
  `name` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `task_type` varchar(255) NOT NULL,
  `custom_task_type` longtext DEFAULT NULL,
  `provider` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_processing_idx` (`app_id`,`name`,`task_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_task_processing`
--

LOCK TABLES `oc_ex_task_processing` WRITE;
/*!40000 ALTER TABLE `oc_ex_task_processing` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_task_processing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_text_processing`
--

DROP TABLE IF EXISTS `oc_ex_text_processing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_text_processing` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `display_name` varchar(64) NOT NULL,
  `action_handler` varchar(410) NOT NULL,
  `task_type` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `text_processing__idx` (`appid`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_text_processing`
--

LOCK TABLES `oc_ex_text_processing` WRITE;
/*!40000 ALTER TABLE `oc_ex_text_processing` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_text_processing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_text_processing_q`
--

DROP TABLE IF EXISTS `oc_ex_text_processing_q`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_text_processing_q` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `result` longtext NOT NULL DEFAULT '',
  `error` varchar(1024) NOT NULL DEFAULT '',
  `finished` smallint(6) NOT NULL DEFAULT 0,
  `created_time` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CB97986AA64FAB3C` (`finished`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_text_processing_q`
--

LOCK TABLES `oc_ex_text_processing_q` WRITE;
/*!40000 ALTER TABLE `oc_ex_text_processing_q` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_text_processing_q` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_translation`
--

DROP TABLE IF EXISTS `oc_ex_translation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_translation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `display_name` varchar(64) NOT NULL,
  `from_languages` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`from_languages`)),
  `to_languages` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`to_languages`)),
  `action_handler` varchar(410) NOT NULL,
  `action_detect_lang` varchar(410) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ex_translation__idx` (`appid`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_translation`
--

LOCK TABLES `oc_ex_translation` WRITE;
/*!40000 ALTER TABLE `oc_ex_translation` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_translation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_translation_q`
--

DROP TABLE IF EXISTS `oc_ex_translation_q`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_translation_q` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `result` longtext NOT NULL DEFAULT '',
  `error` varchar(1024) NOT NULL DEFAULT '',
  `finished` smallint(6) NOT NULL DEFAULT 0,
  `created_time` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_38CE0470A64FAB3C` (`finished`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_translation_q`
--

LOCK TABLES `oc_ex_translation_q` WRITE;
/*!40000 ALTER TABLE `oc_ex_translation_q` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_translation_q` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_ui_files_actions`
--

DROP TABLE IF EXISTS `oc_ex_ui_files_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_ui_files_actions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `display_name` varchar(64) NOT NULL,
  `mime` longtext NOT NULL DEFAULT 'file',
  `permissions` varchar(255) NOT NULL,
  `order` bigint(20) NOT NULL DEFAULT 0,
  `icon` varchar(255) DEFAULT '',
  `action_handler` varchar(64) NOT NULL,
  `version` varchar(64) NOT NULL DEFAULT '1.0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ex_ui_files_actions__idx` (`appid`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_ui_files_actions`
--

LOCK TABLES `oc_ex_ui_files_actions` WRITE;
/*!40000 ALTER TABLE `oc_ex_ui_files_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_ui_files_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_ui_scripts`
--

DROP TABLE IF EXISTS `oc_ex_ui_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_ui_scripts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `type` varchar(16) NOT NULL,
  `name` varchar(32) NOT NULL,
  `path` varchar(410) NOT NULL,
  `after_app_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ui_script__idx` (`appid`,`type`,`name`,`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_ui_scripts`
--

LOCK TABLES `oc_ex_ui_scripts` WRITE;
/*!40000 ALTER TABLE `oc_ex_ui_scripts` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_ui_scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_ui_states`
--

DROP TABLE IF EXISTS `oc_ex_ui_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_ui_states` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `type` varchar(16) NOT NULL,
  `name` varchar(32) NOT NULL,
  `key` varchar(64) NOT NULL,
  `value` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`value`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ui_state__idx` (`appid`,`type`,`name`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_ui_states`
--

LOCK TABLES `oc_ex_ui_states` WRITE;
/*!40000 ALTER TABLE `oc_ex_ui_states` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_ui_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_ui_styles`
--

DROP TABLE IF EXISTS `oc_ex_ui_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_ui_styles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `type` varchar(16) NOT NULL,
  `name` varchar(32) NOT NULL,
  `path` varchar(410) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ui_style__idx` (`appid`,`type`,`name`,`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_ui_styles`
--

LOCK TABLES `oc_ex_ui_styles` WRITE;
/*!40000 ALTER TABLE `oc_ex_ui_styles` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_ui_styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ex_ui_top_menu`
--

DROP TABLE IF EXISTS `oc_ex_ui_top_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ex_ui_top_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL,
  `display_name` varchar(32) NOT NULL,
  `icon` varchar(255) DEFAULT '',
  `admin_required` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ui_top_menu__idx` (`appid`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ex_ui_top_menu`
--

LOCK TABLES `oc_ex_ui_top_menu` WRITE;
/*!40000 ALTER TABLE `oc_ex_ui_top_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ex_ui_top_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_external_applicable`
--

DROP TABLE IF EXISTS `oc_external_applicable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_external_applicable` (
  `applicable_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mount_id` bigint(20) NOT NULL,
  `type` int(11) NOT NULL,
  `value` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`applicable_id`),
  UNIQUE KEY `applicable_type_value_mount` (`type`,`value`,`mount_id`),
  KEY `applicable_mount` (`mount_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_external_applicable`
--

LOCK TABLES `oc_external_applicable` WRITE;
/*!40000 ALTER TABLE `oc_external_applicable` DISABLE KEYS */;
INSERT INTO `oc_external_applicable` VALUES (1,1,3,'Landing Pad Digital');
/*!40000 ALTER TABLE `oc_external_applicable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_external_config`
--

DROP TABLE IF EXISTS `oc_external_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_external_config` (
  `config_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mount_id` bigint(20) NOT NULL,
  `key` varchar(64) NOT NULL,
  `value` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `config_mount_key` (`mount_id`,`key`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_external_config`
--

LOCK TABLES `oc_external_config` WRITE;
/*!40000 ALTER TABLE `oc_external_config` DISABLE KEYS */;
INSERT INTO `oc_external_config` VALUES (1,1,'bucket','landingpad-digital'),(2,1,'hostname',''),(3,1,'port',''),(4,1,'region','us-east-1'),(5,1,'storageClass',''),(6,1,'use_ssl','1'),(7,1,'use_path_style',''),(8,1,'legacy_auth',''),(9,1,'useMultipartCopy','1'),(10,1,'sse_c_key',''),(11,1,'key','AKIA5G2VGKKHINGMG6MS'),(12,1,'secret','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');
/*!40000 ALTER TABLE `oc_external_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_external_mounts`
--

DROP TABLE IF EXISTS `oc_external_mounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_external_mounts` (
  `mount_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mount_point` varchar(128) NOT NULL,
  `storage_backend` varchar(64) NOT NULL,
  `auth_backend` varchar(64) NOT NULL,
  `priority` int(11) NOT NULL DEFAULT 100,
  `type` int(11) NOT NULL,
  PRIMARY KEY (`mount_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_external_mounts`
--

LOCK TABLES `oc_external_mounts` WRITE;
/*!40000 ALTER TABLE `oc_external_mounts` DISABLE KEYS */;
INSERT INTO `oc_external_mounts` VALUES (1,'/S3 Cloud','amazons3','amazons3::accesskey',100,1);
/*!40000 ALTER TABLE `oc_external_mounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_external_options`
--

DROP TABLE IF EXISTS `oc_external_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_external_options` (
  `option_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mount_id` bigint(20) NOT NULL,
  `key` varchar(64) NOT NULL,
  `value` varchar(256) NOT NULL,
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_mount_key` (`mount_id`,`key`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_external_options`
--

LOCK TABLES `oc_external_options` WRITE;
/*!40000 ALTER TABLE `oc_external_options` DISABLE KEYS */;
INSERT INTO `oc_external_options` VALUES (1,1,'encrypt','true'),(2,1,'previews','true'),(3,1,'enable_sharing','false'),(4,1,'filesystem_check_changes','1'),(5,1,'encoding_compatibility','false'),(6,1,'readonly','false');
/*!40000 ALTER TABLE `oc_external_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_federated_reshares`
--

DROP TABLE IF EXISTS `oc_federated_reshares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_federated_reshares` (
  `share_id` bigint(20) NOT NULL,
  `remote_id` varchar(255) DEFAULT '',
  PRIMARY KEY (`share_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_federated_reshares`
--

LOCK TABLES `oc_federated_reshares` WRITE;
/*!40000 ALTER TABLE `oc_federated_reshares` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_federated_reshares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_file_locks`
--

DROP TABLE IF EXISTS `oc_file_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_file_locks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `lock` int(11) NOT NULL DEFAULT 0,
  `key` varchar(64) NOT NULL,
  `ttl` int(11) NOT NULL DEFAULT -1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lock_key_index` (`key`),
  KEY `lock_ttl_index` (`ttl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_file_locks`
--

LOCK TABLES `oc_file_locks` WRITE;
/*!40000 ALTER TABLE `oc_file_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_file_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_filecache`
--

DROP TABLE IF EXISTS `oc_filecache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_filecache` (
  `fileid` bigint(20) NOT NULL AUTO_INCREMENT,
  `storage` bigint(20) NOT NULL DEFAULT 0,
  `path` varchar(4000) DEFAULT NULL,
  `path_hash` varchar(32) NOT NULL DEFAULT '',
  `parent` bigint(20) NOT NULL DEFAULT 0,
  `name` varchar(250) DEFAULT NULL,
  `mimetype` bigint(20) NOT NULL DEFAULT 0,
  `mimepart` bigint(20) NOT NULL DEFAULT 0,
  `size` bigint(20) NOT NULL DEFAULT 0,
  `mtime` bigint(20) NOT NULL DEFAULT 0,
  `storage_mtime` bigint(20) NOT NULL DEFAULT 0,
  `encrypted` int(11) NOT NULL DEFAULT 0,
  `unencrypted_size` bigint(20) NOT NULL DEFAULT 0,
  `etag` varchar(40) DEFAULT NULL,
  `permissions` int(11) DEFAULT 0,
  `checksum` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`fileid`),
  UNIQUE KEY `fs_storage_path_hash` (`storage`,`path_hash`),
  KEY `fs_parent_name_hash` (`parent`,`name`),
  KEY `fs_storage_mimetype` (`storage`,`mimetype`),
  KEY `fs_storage_mimepart` (`storage`,`mimepart`),
  KEY `fs_storage_size` (`storage`,`size`,`fileid`),
  KEY `fs_parent` (`parent`),
  KEY `fs_name_hash` (`name`),
  KEY `fs_mtime` (`mtime`),
  KEY `fs_size` (`size`),
  KEY `fs_storage_path_prefix` (`storage`,`path`(64))
) ENGINE=InnoDB AUTO_INCREMENT=380 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_filecache`
--

LOCK TABLES `oc_filecache` WRITE;
/*!40000 ALTER TABLE `oc_filecache` DISABLE KEYS */;
INSERT INTO `oc_filecache` VALUES (1,1,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,39820310,1750990154,1750754878,0,0,'685dfd4a89971',23,''),(2,1,'files','45b963397aa40d4a0063e0d85e4fe7a1',1,'files',2,1,26752083,1750755256,1750755256,0,0,'685a67b881f9a',31,''),(3,1,'files_trashbin/files/Readme.md.d1750754878','d2bb7b1a0a537fcc5b82b0eec4a6709f',344,'Readme.md.d1750754878',4,3,197,1750060799,1750060799,0,0,'a362dc02ee0de07474753dcf5dd55b0f',27,''),(4,1,'files_trashbin/files/Reasons to use Nextcloud.pdf.d1750754878','2f5764dee242984ca860709bce63ea9b',344,'Reasons to use Nextcloud.pdf.d1750754878',6,5,976625,1750060799,1750060799,0,0,'112b7d64d855c8d59e79edb439ca72d2',27,''),(5,1,'files_trashbin/files/Templates credits.md.d1750754878','42a4b5e3e5ba26f9c40655741d7fe19d',344,'Templates credits.md.d1750754878',18,5,2403,1750060799,1750060799,0,0,'499058fcc4a220443fd7307be0f1a3ce',27,''),(6,1,'files_trashbin/files/Nextcloud intro.mp4.d1750754878','b65d73d5dbd5640f6c78f257dac2f5c2',344,'Nextcloud intro.mp4.d1750754878',18,5,3963036,1750060800,1750060800,0,0,'0f57e4de85c1bc4842ac0dd79627883d',27,''),(7,1,'files/Photos','d01bb67e7b71dd49fd06bad922f521c9',2,'Photos',2,1,1526055,1750755226,1750755226,0,0,'685a679a20969',31,''),(8,1,'files/Photos/Gorilla.jpg','6d5f5956d8ff76a5f290cebb56402789',7,'Gorilla.jpg',10,9,474653,1750060800,1750060800,0,0,'cfbd0729de14bd051f140fe800fa8dad',27,''),(9,1,'files/Photos/Readme.md','2a4ac36bb841d25d06d164f291ee97db',7,'Readme.md',4,3,150,1750060800,1750060800,0,0,'e0d724ff8c4695fa9ccb5bb64b7eda2d',27,''),(10,1,'files/Photos/Birdie.jpg','cd31c7af3a0ec6e15782b5edd2774549',7,'Birdie.jpg',10,9,593508,1750060800,1750060800,0,0,'631549779358cc08f36b06268943c3fb',27,''),(11,1,'files_trashbin/files/Toucan.jpg.d1750755226','bee9954c4a42f7f76ac0ed75efc3d3ce',344,'Toucan.jpg.d1750755226',10,9,167989,1750060800,1750060800,0,0,'2f5743960097bcf506382cc83e5b5b81',27,''),(12,1,'files_trashbin/files/Library.jpg.d1750755226','b85bac7386f7bfeb17f7d6538057f428',344,'Library.jpg.d1750755226',10,9,2170375,1750060800,1750060800,0,0,'c60156ecaa549ea7540d4281b6456a11',27,''),(13,1,'files_trashbin/files/Vineyard.jpg.d1750755226','3c2316baf85efe2890acf1796a537dd6',344,'Vineyard.jpg.d1750755226',10,9,427030,1750060800,1750060800,0,0,'5bbf8341c6b5a1fc90f12c9aeb00aaad',27,''),(14,1,'files_trashbin/files/Steps.jpg.d1750755226','103a1f181256fbd0803c8bd96b7f4fdd',344,'Steps.jpg.d1750755226',10,9,567689,1750060800,1750060800,0,0,'88900d8a8099e3292f3e927c0a74a43c',27,''),(15,1,'files_trashbin/files/Nextcloud community.jpg.d1750755226','1f47e207e5dce30175e2927d153e07af',344,'Nextcloud community.jpg.d1750755226',10,9,797325,1750060800,1750060800,0,0,'a0a004984298613e4d87da761e5da26d',27,''),(16,1,'files/Photos/Frog.jpg','d6219add1a9129ed0c1513af985e2081',7,'Frog.jpg',10,9,457744,1750060800,1750060800,0,0,'20437064194ab1eaf5663887fa86cc28',27,''),(17,1,'files/Nextcloud Manual.pdf','2bc58a43566a8edde804a4a97a9c7469',2,'Nextcloud Manual.pdf',6,5,13175467,1750060800,1750060800,0,0,'1b424163df9edc6711b9f19a886c69d8',27,''),(18,1,'files_trashbin/files/Nextcloud.png.d1750754878','43935e4680831c3fc98e92bcfe4d5012',344,'Nextcloud.png.d1750754878',11,9,50598,1750060800,1750060800,0,0,'390d435df9ee5eeddda99047278b4b6d',27,''),(19,1,'files/Templates','530b342d0b8164ff3b4754c2273a453e',2,'Templates',2,1,10942115,1750060805,1750060804,0,0,'684fcf05032df',31,''),(20,1,'files/Templates/Mind map.whiteboard','27c7b4d83fd3526a42122bcacf5dfbe9',19,'Mind map.whiteboard',12,5,35657,1750060800,1750060800,0,0,'b000adde0b510d767471cb2fbd9e292a',27,''),(21,1,'files/Templates/Simple.odp','a2c90ff606d31419d699b0b437969c61',19,'Simple.odp',13,5,14810,1750060800,1750060800,0,0,'025fddb11fb64d101601ea2e0b0892d2',27,''),(22,1,'files/Templates/Brainstorming.whiteboard','aa2d36938cf5c1f41813d1e8bbd3ae00',19,'Brainstorming.whiteboard',12,5,30780,1750060800,1750060800,0,0,'51a42f08addf67a2eede82dc29a66372',27,''),(23,1,'files/Templates/Party invitation.odt','439f95f734be87868374b1a5a312c550',19,'Party invitation.odt',14,5,868111,1750060801,1750060801,0,0,'4551c8d409f32950b1ccf9afe20e8a98',27,''),(24,1,'files/Templates/Mindmap.odg','74cff798fc1b9634ee45380599b2a6da',19,'Mindmap.odg',15,5,13653,1750060801,1750060801,0,0,'ab8bc0e524d461ca03f903ba7ab81159',27,''),(25,1,'files/Templates/Readme.md','71fa2e74ab30f39eed525572ccc3bbec',19,'Readme.md',4,3,554,1750060801,1750060801,0,0,'28b54bf85825c89935fdee10fcb59b61',27,''),(26,1,'files/Templates/Elegant.odp','f3ec70ed694c0ca215f094b98eb046a7',19,'Elegant.odp',13,5,14316,1750060801,1750060801,0,0,'9a09ed7edecc0c6bd405bb41259244d3',27,''),(27,1,'files/Templates/Syllabus.odt','03b3147e6dae00674c1d50fe22bb8496',19,'Syllabus.odt',14,5,30354,1750060801,1750060801,0,0,'3f23830a8388d2a0277b4ee8b8f704ef',27,''),(28,1,'files/Templates/Modern company.odp','96ad2c06ebb6a79bcdf2f4030421dee3',19,'Modern company.odp',13,5,317015,1750060801,1750060801,0,0,'2ee7c0dd01f71453052abdc44ba0b2ad',27,''),(29,1,'files/Templates/Expense report.ods','d0a4025621279b95d2f94ff4ec09eab3',19,'Expense report.ods',16,5,13441,1750060801,1750060801,0,0,'c5674c69fe61a5d8f0cea4f81e2d27e5',27,''),(30,1,'files/Templates/Kanban board.whiteboard','174b2766514fef9a88cbb3076e362b4a',19,'Kanban board.whiteboard',12,5,25621,1750060801,1750060801,0,0,'13285fe71b8e99ec00fb745f1607fb65',27,''),(31,1,'files/Templates/Sticky notes.whiteboard','72309dacd55c6de379c738caf18d84c4',19,'Sticky notes.whiteboard',12,5,45778,1750060802,1750060802,0,0,'7f3567aedca773ee271118c32f7f1733',27,''),(32,1,'files/Templates/Meeting agenda.whiteboard','be213da59b99766ceae11e80093803a9',19,'Meeting agenda.whiteboard',12,5,27629,1750060802,1750060802,0,0,'82569420952c524907af52fe2cc4490e',27,''),(33,1,'files/Templates/Mother\'s day.odt','cb66c617dbb4acc9b534ec095c400b53',19,'Mother\'s day.odt',14,5,340061,1750060803,1750060803,0,0,'1110a8712596c8fa781458a72af00bee',27,''),(34,1,'files/Templates/Flowchart.odg','832942849155883ceddc6f3cede21867',19,'Flowchart.odg',15,5,11836,1750060803,1750060803,0,0,'d912f9874d4dbaae2c08c62f81ad805b',27,''),(35,1,'files/Templates/Resume.odt','ace8f81202eadb2f0c15ba6ecc2539f5',19,'Resume.odt',14,5,39404,1750060803,1750060803,0,0,'1e0da39965e39b5e2b256f6ecfee657b',27,''),(36,1,'files/Templates/Impact effort.whiteboard','071dbd5231cfcb493fa2fcc4a763be05',19,'Impact effort.whiteboard',12,5,30671,1750060804,1750060804,0,0,'22cdcc540500b35a429ccea53c2ce0ea',27,''),(37,1,'files/Templates/Photo book.odt','ea35993988e2799424fef3ff4f420c24',19,'Photo book.odt',14,5,5155877,1750060804,1750060804,0,0,'c41addfdb59b5f262b4d942c8916ec71',27,''),(38,1,'files/Templates/Business model canvas.whiteboard','1c4e5432621502fa9a668c49b25b81d9',19,'Business model canvas.whiteboard',12,5,30290,1750060804,1750060804,0,0,'9d2d53f083f8f93252eece2d541c6562',27,''),(39,1,'files/Templates/Meeting notes.md','c0279758bb570afdcdbc2471b2f16285',19,'Meeting notes.md',4,3,326,1750060804,1750060804,0,0,'ea367485bf38f20ea1c38b9462e1db02',27,''),(40,1,'files/Templates/Timeline.whiteboard','a009a1620252b19a9307d35de49311e9',19,'Timeline.whiteboard',12,5,31325,1750060804,1750060804,0,0,'df852c1965c17fa77aa28b69faa972ec',27,''),(41,1,'files/Templates/Invoice.odt','40fdccb51b6c3e3cf20532e06ed5016e',19,'Invoice.odt',14,5,17276,1750060804,1750060804,0,0,'123ab61a7daff0849b7da0fbfdc1c56d',27,''),(42,1,'files/Templates/Business model canvas.ods','86c10a47dedf156bf4431cb75e0f76ec',19,'Business model canvas.ods',16,5,52843,1750060804,1750060804,0,0,'f9f75ade2e3bd55c9bb6135c6b5bfe52',27,''),(43,1,'files/Templates/Venn diagram.whiteboard','71d9f77ebd2c126375fa7170a1c86509',19,'Venn diagram.whiteboard',12,5,23359,1750060804,1750060804,0,0,'00fc1682b3486d2771baefaa0a23a288',27,''),(44,1,'files/Templates/Timesheet.ods','cb79c81e41d3c3c77cd31576dc7f1a3a',19,'Timesheet.ods',16,5,88394,1750060804,1750060804,0,0,'e3560194d56944c2f14713e8d2b92025',27,''),(45,1,'files/Templates/Gotong royong.odp','14b958f5aafb7cfd703090226f3cbd1b',19,'Gotong royong.odp',13,5,3509628,1750060804,1750060804,0,0,'2bb81f002da702add3e561032a7910cb',27,''),(46,1,'files/Templates/Letter.odt','15545ade0e9863c98f3a5cc0fbf2836a',19,'Letter.odt',14,5,15961,1750060804,1750060804,0,0,'4d934c5a3c3c05210a773ba65e268ba1',27,''),(47,1,'files/Templates/Diagram & table.ods','0a89f154655f6d4a0098bc4e6ca87367',19,'Diagram & table.ods',16,5,13378,1750060804,1750060804,0,0,'2f7746c2d76e0b87231e7eb93586979f',27,''),(48,1,'files/Templates/Flowchart.whiteboard','b944a25f1ef13e8e256107178bb28141',19,'Flowchart.whiteboard',12,5,31132,1750060804,1750060804,0,0,'f72c8a1a8eda2d4fa1f2c836727db053',27,''),(49,1,'files/Templates/Product plan.md','a9fbf58bf31cebb8143f7ad3a5205633',19,'Product plan.md',4,3,573,1750060804,1750060804,0,0,'c1c625238703fc60f40f5e28e0caf7d6',27,''),(50,1,'files/Templates/Business model canvas.odg','6a8f3e02bdf45c8b0671967969393bcb',19,'Business model canvas.odg',15,5,16988,1750060804,1750060804,0,0,'844b62dd7d33383c0098f8f0326bca77',27,''),(51,1,'files/Templates/Org chart.odg','fd846bc062b158abb99a75a5b33b53e7',19,'Org chart.odg',15,5,13878,1750060804,1750060804,0,0,'32c5677d70652ac34377a4b97a88fc2c',27,''),(52,1,'files/Templates/Yellow idea.odp','3a57051288d7b81bef3196a2123f4af5',19,'Yellow idea.odp',13,5,81196,1750060805,1750060805,0,0,'ab32c246d904f2be2e3e560114e94cc3',27,''),(53,1,'files/Documents','0ad78ba05b6961d92f7970b2b3922eca',2,'Documents',2,1,1108446,1750060805,1750060805,0,0,'684fcf053b43f',31,''),(54,1,'files/Documents/Readme.md','51ec9e44357d147dd5c212b850f6910f',53,'Readme.md',4,3,136,1750060805,1750060805,0,0,'be2ed883bd6700af9ff11940d072567d',27,''),(55,1,'files/Documents/Nextcloud flyer.pdf','9c5b4dc7182a7435767708ac3e8d126c',53,'Nextcloud flyer.pdf',6,5,1083339,1750060805,1750060805,0,0,'e0d179d87abbfa99a5828e1617b2feb9',27,''),(56,1,'files/Documents/Welcome to Nextcloud Hub.docx','b44cb84f22ceddc4ca2826e026038091',53,'Welcome to Nextcloud Hub.docx',17,5,23876,1750060805,1750060805,0,0,'ac1fb40785d19a5bb204126c978e5364',27,''),(57,1,'files/Documents/Example.md','efe0853470dd0663db34818b444328dd',53,'Example.md',4,3,1095,1750060805,1750060805,0,0,'6105e1333f4b53d2decbf6a58aec3975',27,''),(58,2,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,0,1750756203,1750060949,0,0,'685a6b6b89415',23,''),(59,2,'appdata_oc96sqf3by0w','a78f246f92903906b3e68ce0d5647181',58,'appdata_oc96sqf3by0w',2,1,0,1750752883,1750752883,0,0,'684fcf955923e',31,''),(60,2,'appdata_oc96sqf3by0w/appstore','42674255c7b817b6434ae35e767bbf5c',59,'appstore',2,1,0,1750754092,1750754092,0,0,'684fcf955b767',31,''),(61,2,'appdata_oc96sqf3by0w/preview','0a0a8991d2e10f74229ac8f85ef2cd89',59,'preview',2,1,0,1750061023,1750061023,0,0,'684fcfdf1d23b',31,''),(62,2,'appdata_oc96sqf3by0w/preview/c','797b63455f8fd7d7d353269169ff61c4',61,'c',2,1,0,1750061024,1750061024,0,0,'685a6b6b7e9d6',31,''),(63,2,'appdata_oc96sqf3by0w/preview/c/9','9ce15f6c032af97ce3985c213fe345c0',62,'9',2,1,0,1750061023,1750061023,0,0,'685a6b6b7abc4',31,''),(64,2,'appdata_oc96sqf3by0w/preview/c/9/f','d284022b49d7974f9592fae2b665cddc',63,'f',2,1,0,1750061023,1750061023,0,0,'685a6b6b76ca0',31,''),(65,2,'appdata_oc96sqf3by0w/preview/c/9/f/0','0edba697a4b6d166733921f81bf7fc81',64,'0',2,1,0,1750061023,1750061023,0,0,'685a6b6b738e1',31,''),(66,2,'appdata_oc96sqf3by0w/preview/c/9/f/0/f','3333d211ccb4110b469a8d02dfc1346d',65,'f',2,1,0,1750061023,1750061023,0,0,'685a6b6b70df2',31,''),(67,2,'appdata_oc96sqf3by0w/preview/c/9/f/0/f/8','70937eb73fe8a7633914303205d246c2',66,'8',2,1,0,1750061023,1750061023,0,0,'685a6b6b6d3eb',31,''),(68,2,'appdata_oc96sqf3by0w/preview/c/9/f/0/f/8/9','2d5087d8990cbdaa776726385d24cf23',67,'9',2,1,0,1750061023,1750061023,0,0,'685a6b6b6a647',31,''),(69,2,'appdata_oc96sqf3by0w/preview/c/9/f/0/f/8/9/8','b1bd35b16ebc4acd59913679d80c7153',68,'8',2,1,0,1750755236,1750755236,0,0,'684fcfdf32670',31,''),(70,2,'appdata_oc96sqf3by0w/preview/c/9/f/0/f/8/9/8/1600-1067-max.jpg','beca157f9f6505ec2a666f3161563c09',69,'1600-1067-max.jpg',10,9,232378,1750061023,1750061023,0,0,'a8948d5f3001da8580bd8a2c6454dbf8',27,''),(71,2,'appdata_oc96sqf3by0w/preview/d','50409def03168e826ce83490d3cacc43',61,'d',2,1,0,1750752699,1750752699,0,0,'685a6b6b6717c',31,''),(72,2,'appdata_oc96sqf3by0w/preview/d/3','61acfe87bc91b7d18d9c40d6aefbe511',71,'3',2,1,0,1750061023,1750061023,0,0,'685a6b6b641cc',31,''),(73,2,'appdata_oc96sqf3by0w/preview/d/3/d','9c653b437eeda06a986b30a0dae275c0',72,'d',2,1,0,1750061023,1750061023,0,0,'685a6b6b60b9c',31,''),(74,2,'appdata_oc96sqf3by0w/preview/d/3/d/9','cedb984655b795c1aec41c4d28423e48',73,'9',2,1,0,1750061023,1750061023,0,0,'685a6b6b5d44d',31,''),(75,2,'appdata_oc96sqf3by0w/preview/d/3/d/9/4','275eeae5b413cb310504a8b4c357e4f8',74,'4',2,1,0,1750061023,1750061023,0,0,'685a6b6b58ce1',31,''),(76,2,'appdata_oc96sqf3by0w/preview/d/3/d/9/4/4','0d2e6cb5c55610778a141199dcb1ae55',75,'4',2,1,0,1750061023,1750061023,0,0,'685a6b6b54b4f',31,''),(77,2,'appdata_oc96sqf3by0w/preview/d/3/d/9/4/4/6','cade28c9f99198df68ed100db1731b56',76,'6',2,1,0,1750061023,1750061023,0,0,'685a6b6b4fa1c',31,''),(78,2,'appdata_oc96sqf3by0w/preview/d/3/d/9/4/4/6/10','1c9d2f2bc7514f78a1622f15f44b4f78',77,'10',2,1,0,1750061023,1750061023,0,0,'684fcfdf60343',31,''),(79,2,'appdata_oc96sqf3by0w/preview/d/3/d/9/4/4/6/10/1600-1067-max.jpg','91bec50a6213b28d280505095c7a1ae1',78,'1600-1067-max.jpg',10,9,165982,1750061023,1750061023,0,0,'0a762caba27015aed3d3db4e1034f3f4',27,''),(80,2,'appdata_oc96sqf3by0w/preview/6','81cd4b48dfdb2c00aa9b704516d078b8',61,'6',2,1,0,1750752699,1750752699,0,0,'685a6b6b4bf07',31,''),(81,2,'appdata_oc96sqf3by0w/preview/6/5','4e0dce34dbecbd4f9250f4e037368bbd',80,'5',2,1,0,1750061023,1750061023,0,0,'685a6b6b491dd',31,''),(82,2,'appdata_oc96sqf3by0w/preview/6/5/1','2f22eb01dfac7602c00a5104b0b6852a',81,'1',2,1,0,1750061023,1750061023,0,0,'685a6b6b44e50',31,''),(83,2,'appdata_oc96sqf3by0w/preview/6/5/1/2','ec6991a661ea4ad72e78d421205f37eb',82,'2',2,1,0,1750061023,1750061023,0,0,'685a6b6b40862',31,''),(84,2,'appdata_oc96sqf3by0w/preview/6/5/1/2/b','369cad1207d07791dd7c6ad029871bd4',83,'b',2,1,0,1750061023,1750061023,0,0,'685a6b6b3c50c',31,''),(85,2,'appdata_oc96sqf3by0w/preview/6/5/1/2/b/d','b055012f447a1a2324a3166a87b331d0',84,'d',2,1,0,1750061023,1750061023,0,0,'685a6b6b39195',31,''),(86,2,'appdata_oc96sqf3by0w/preview/6/5/1/2/b/d/4','ea999d757f140e0912311b61417d01ec',85,'4',2,1,0,1750061023,1750061023,0,0,'685a6b6b347ee',31,''),(87,2,'appdata_oc96sqf3by0w/preview/6/5/1/2/b/d/4/11','1d05e91129d04193e4dc7fce5c600a53',86,'11',2,1,0,1750061023,1750061023,0,0,'684fcfdf7dea1',31,''),(88,2,'appdata_oc96sqf3by0w/preview/6/5/1/2/b/d/4/11/1600-1067-max.jpg','1479b863aee8a25dd2b7b414980f53bf',87,'1600-1067-max.jpg',10,9,137923,1750061023,1750061023,0,0,'06f63806e3613809434122d8d43752fc',27,''),(89,2,'appdata_oc96sqf3by0w/preview/c/2','97b3ae1f14f68926ccc9b909309e1308',62,'2',2,1,0,1750061023,1750061023,0,0,'685a6b6b30a07',31,''),(90,2,'appdata_oc96sqf3by0w/preview/c/2/0','ecbf156bdc704f6a93ced1a428a29bff',89,'0',2,1,0,1750061023,1750061023,0,0,'685a6b6b2d3c6',31,''),(91,2,'appdata_oc96sqf3by0w/preview/c/2/0/a','f955dd62a9e4ac0fd680da283a26212d',90,'a',2,1,0,1750061023,1750061023,0,0,'685a6b6b28c4c',31,''),(92,2,'appdata_oc96sqf3by0w/preview/c/2/0/a/d','9f1e9eb2c681464cc3d2676d8d2098b7',91,'d',2,1,0,1750061023,1750061023,0,0,'685a6b6b25141',31,''),(93,2,'appdata_oc96sqf3by0w/preview/c/2/0/a/d/4','0db6cd86c9bea0436d3ad21a191e3b7f',92,'4',2,1,0,1750061023,1750061023,0,0,'685a6b6b2141c',31,''),(94,2,'appdata_oc96sqf3by0w/preview/c/2/0/a/d/4/d','7550fa7212699edcd8ce5e8e1303c127',93,'d',2,1,0,1750061023,1750061023,0,0,'685a6b6b1dc9f',31,''),(95,2,'appdata_oc96sqf3by0w/preview/c/2/0/a/d/4/d/12','5f944afeb29054a866e8ee426aef103c',94,'12',2,1,0,1750061023,1750061023,0,0,'684fcfdf99265',31,''),(96,2,'appdata_oc96sqf3by0w/preview/c/2/0/a/d/4/d/12/1600-1066-max.jpg','6522d9194780c9be83f649ded4bb0da3',95,'1600-1066-max.jpg',10,9,351167,1750061023,1750061023,0,0,'30ed6c17985d7a3bea1c541944e08539',27,''),(97,2,'appdata_oc96sqf3by0w/preview/c/5','e09591d4988bb47cefb2b9f449d2d666',62,'5',2,1,0,1750061023,1750061023,0,0,'685a6b6b1a87c',31,''),(98,2,'appdata_oc96sqf3by0w/preview/c/5/1','6c14b537a15755b3a0634ddcc8ca54bb',97,'1',2,1,0,1750061023,1750061023,0,0,'685a6b6b1764f',31,''),(99,2,'appdata_oc96sqf3by0w/preview/c/5/1/c','371259f71104f3bf07384b7f7f8b22ed',98,'c',2,1,0,1750061023,1750061023,0,0,'685a6b6b14b00',31,''),(100,2,'appdata_oc96sqf3by0w/preview/c/5/1/c/e','6f34e25d3edf1492c216a2f71e60c0a7',99,'e',2,1,0,1750061023,1750061023,0,0,'685a6b6b0e7a8',31,''),(101,2,'appdata_oc96sqf3by0w/preview/c/5/1/c/e/4','61b308a91390ad1789f52fff2fd181f5',100,'4',2,1,0,1750061023,1750061023,0,0,'685a6b6b076a6',31,''),(102,2,'appdata_oc96sqf3by0w/preview/c/5/1/c/e/4/1','c6f79c4010a3d665080f37a02933c1a3',101,'1',2,1,0,1750061023,1750061023,0,0,'685a6b6b042ca',31,''),(103,2,'appdata_oc96sqf3by0w/preview/c/5/1/c/e/4/1/13','90d1152a5a4e8980495d3c94876ad4c1',102,'13',2,1,0,1750061023,1750061023,0,0,'684fcfdfcb183',31,''),(104,2,'appdata_oc96sqf3by0w/preview/c/5/1/c/e/4/1/13/1920-1281-max.jpg','2636c6daf085ad9c0ca662557a6c8eec',103,'1920-1281-max.jpg',10,9,294390,1750061023,1750061023,0,0,'b4da8dbc31096e7fffbd295848693913',27,''),(105,2,'appdata_oc96sqf3by0w/preview/a','699fba61528923264c88ede89291a984',61,'a',2,1,0,1750752698,1750752698,0,0,'685a6b6b00b35',31,''),(106,2,'appdata_oc96sqf3by0w/preview/a/a','5fa25250d596452769d59fa4942e0a91',105,'a',2,1,0,1750061024,1750061024,0,0,'685a6b6af0ef0',31,''),(107,2,'appdata_oc96sqf3by0w/preview/a/a/b','9178b476787aae6076c1873f66a56e13',106,'b',2,1,0,1750061024,1750061024,0,0,'685a6b6aeda2b',31,''),(108,2,'appdata_oc96sqf3by0w/preview/a/a/b/3','99eaa42f7e138e950b2532ff375c6dcb',107,'3',2,1,0,1750061024,1750061024,0,0,'685a6b6ae829c',31,''),(109,2,'appdata_oc96sqf3by0w/preview/a/a/b/3/2','272317ebaccfc039ce927b1825e7d31d',108,'2',2,1,0,1750061024,1750061024,0,0,'685a6b6ae59a4',31,''),(110,2,'appdata_oc96sqf3by0w/preview/a/a/b/3/2/3','a1573e685446d0d8f84be5eaf5597d12',109,'3',2,1,0,1750061024,1750061024,0,0,'685a6b6ae313d',31,''),(111,2,'appdata_oc96sqf3by0w/preview/a/a/b/3/2/3/8','7089f5b22cb30d7e06a0696ca07e13d2',110,'8',2,1,0,1750061024,1750061024,0,0,'685a6b6ae0467',31,''),(112,2,'appdata_oc96sqf3by0w/preview/a/a/b/3/2/3/8/14','0ed9f4c50a1b2b58b51d41d3304f5338',111,'14',2,1,0,1750061024,1750061024,0,0,'684fcfe002561',31,''),(113,2,'appdata_oc96sqf3by0w/preview/a/a/b/3/2/3/8/14/1200-1800-max.jpg','9353fe27de20d7e6a151d55d234c5c60',112,'1200-1800-max.jpg',10,9,207095,1750061024,1750061024,0,0,'bca18a742179647df6f0c3480d93d638',27,''),(114,2,'appdata_oc96sqf3by0w/preview/9','7e42edf6aba51877cf00891f81470e1d',61,'9',2,1,0,1750752047,1750752047,0,0,'685a6b6adbfbe',31,''),(115,2,'appdata_oc96sqf3by0w/preview/9/b','cc2fb8e9a0731afdf7b05ad1130c4d20',114,'b',2,1,0,1750061024,1750061024,0,0,'685a6b6ad902a',31,''),(116,2,'appdata_oc96sqf3by0w/preview/9/b/f','a9374e398576bf53a8758059696f3598',115,'f',2,1,0,1750061024,1750061024,0,0,'685a6b6ad5a5e',31,''),(117,2,'appdata_oc96sqf3by0w/preview/9/b/f/3','ae3e7420c59f58abc86c1e1d1f8623ec',116,'3',2,1,0,1750061024,1750061024,0,0,'685a6b6ad1128',31,''),(118,2,'appdata_oc96sqf3by0w/preview/9/b/f/3/1','5e31b4219484278ac48013ccc4a7c6f7',117,'1',2,1,0,1750061024,1750061024,0,0,'685a6b6acd68f',31,''),(119,2,'appdata_oc96sqf3by0w/preview/9/b/f/3/1/c','b9bdad28d0008e2e1fe7076196da5f37',118,'c',2,1,0,1750061024,1750061024,0,0,'685a6b6aca4b4',31,''),(120,2,'appdata_oc96sqf3by0w/preview/9/b/f/3/1/c/7','08cbc75640f66546718501cf61da77df',119,'7',2,1,0,1750061024,1750061024,0,0,'685a6b6ac6658',31,''),(121,2,'appdata_oc96sqf3by0w/preview/9/b/f/3/1/c/7/15','79632a3a6e5ef7229c27745a39443968',120,'15',2,1,0,1750061024,1750061024,0,0,'684fcfe029412',31,''),(122,2,'appdata_oc96sqf3by0w/preview/9/b/f/3/1/c/7/15/3000-2000-max.jpg','5d7f2c5d6ca144fab40b781bab7b4fca',121,'3000-2000-max.jpg',10,9,808212,1750061024,1750061024,0,0,'49027add134f87afbb6a8a12fd65ec83',27,''),(123,2,'appdata_oc96sqf3by0w/preview/c/7','bc0378ebc6b2c3e719b53162fd1a5ec1',62,'7',2,1,0,1750061024,1750061024,0,0,'685a6b6ac190a',31,''),(124,2,'appdata_oc96sqf3by0w/preview/c/7/4','1c554060180d99e7577c3963bbecc1f4',123,'4',2,1,0,1750061024,1750061024,0,0,'685a6b6abda79',31,''),(125,2,'appdata_oc96sqf3by0w/preview/c/7/4/d','031c096cd3e71f06d398d0878bbf1c16',124,'d',2,1,0,1750061024,1750061024,0,0,'685a6b6ab83ad',31,''),(126,2,'appdata_oc96sqf3by0w/preview/c/7/4/d/9','cae3fe06aa6c9a635a6fea19115eae93',125,'9',2,1,0,1750061024,1750061024,0,0,'685a6b6ab4d28',31,''),(127,2,'appdata_oc96sqf3by0w/preview/c/7/4/d/9/7','dd218f369a7c7d59c0563f797a6e6605',126,'7',2,1,0,1750061024,1750061024,0,0,'685a6b6ab1477',31,''),(128,2,'appdata_oc96sqf3by0w/preview/c/7/4/d/9/7/b','8ce74c3ccd6bf6666e6b9ffa605b017d',127,'b',2,1,0,1750061024,1750061024,0,0,'685a6b6aac1c4',31,''),(129,2,'appdata_oc96sqf3by0w/preview/c/7/4/d/9/7/b/16','9e1ac9e45de83a26a08fbd5d70a02571',128,'16',2,1,0,1750061024,1750061024,0,0,'684fcfe086a8b',31,''),(130,2,'appdata_oc96sqf3by0w/preview/c/7/4/d/9/7/b/16/1600-1067-max.jpg','075b0d8530aafc3f4457a17ab612c05f',129,'1600-1067-max.jpg',10,9,147631,1750061024,1750061024,0,0,'9d0f74ec60d0c37b2d2a656e87aaf325',27,''),(131,2,'appdata_oc96sqf3by0w/preview/6/f','0a7f4964ca1d3f09bc88b80d12312d35',80,'f',2,1,0,1750061024,1750061024,0,0,'685a6b6aa73e7',31,''),(132,2,'appdata_oc96sqf3by0w/preview/6/f/4','e2367d6098a6ab613599c87b315488d5',131,'4',2,1,0,1750061024,1750061024,0,0,'685a6b6aa201a',31,''),(133,2,'appdata_oc96sqf3by0w/preview/6/f/4/9','2d37b4be411026611cb21db892317fb8',132,'9',2,1,0,1750061024,1750061024,0,0,'685a6b6a9c583',31,''),(134,2,'appdata_oc96sqf3by0w/preview/6/f/4/9/2','0276ad27f15bf0db92636a0061171312',133,'2',2,1,0,1750061024,1750061024,0,0,'685a6b6a9750c',31,''),(135,2,'appdata_oc96sqf3by0w/preview/6/f/4/9/2/2','b689b63c2963f6ffbc06af06d9a14453',134,'2',2,1,0,1750061024,1750061024,0,0,'685a6b6a91eff',31,''),(136,2,'appdata_oc96sqf3by0w/preview/6/f/4/9/2/2/f','c1341af7ddf9d1e6dcd884878e45092e',135,'f',2,1,0,1750061024,1750061024,0,0,'685a6b6a89b9c',31,''),(137,2,'appdata_oc96sqf3by0w/preview/6/f/4/9/2/2/f/18','9901449738a18aeb8a7d52cb877beae4',136,'18',2,1,0,1750752239,1750752239,0,0,'684fcfe0a2258',31,''),(138,2,'appdata_oc96sqf3by0w/preview/6/f/4/9/2/2/f/18/500-500-max.png','c3de40e885566797fd81a9f77e110d76',137,'500-500-max.png',11,9,50545,1750061024,1750061024,0,0,'64a84ca3035a3fa16949338b2c9e62bf',27,''),(139,2,'appdata_oc96sqf3by0w/theming','ffc3a80e0eaf898e40854c8696697e0e',59,'theming',2,1,0,1750063764,1750063764,0,0,'684fda942ce57',31,''),(140,2,'appdata_oc96sqf3by0w/theming/global','54c45e9ed375efb3d6801c79b031cdc9',139,'global',2,1,0,1750752016,1750752016,0,0,'684fda942f925',31,''),(141,2,'appdata_oc96sqf3by0w/theming/global/0','db07ef1545e4a485ebb362da0a75fd69',140,'0',2,1,0,1750750494,1750750494,0,0,'684fda94323c6',31,''),(142,2,'appdata_oc96sqf3by0w/theming/global/0/favIcon-core#00679e','91b0cc47a66b507eb9c6acf2deb8d65b',141,'favIcon-core#00679e',18,5,90022,1750063764,1750063764,0,0,'a33ce45b49840d14194372c73b7b1300',27,''),(143,2,'appdata_oc96sqf3by0w/theming/global/0/touchIcon-core#00679e','c6124e938f1891fc07549c38720458a0',141,'touchIcon-core#00679e',18,5,22560,1750195209,1750195209,0,0,'69b810e6680a86dbd560d0aef7229cae',27,''),(144,2,'appdata_oc96sqf3by0w/js','e9bab18846f0e6e0a338022ce3b9c786',59,'js',2,1,0,1750743652,1750743652,0,0,'685a3a64b5ec4',31,''),(145,2,'appdata_oc96sqf3by0w/js/core','8bcfc693ef56dcff28879f4197142658',144,'core',2,1,0,1750743652,1750743652,0,0,'685a3a64b81bd',31,''),(146,2,'appdata_oc96sqf3by0w/js/core/merged-template-prepend.js','e8f199fb243bd017492bd7d78be00971',145,'merged-template-prepend.js',19,5,11773,1750743652,1750743652,0,0,'e6f57567b79837bf1c5c543c13c5df3a',27,''),(147,2,'appdata_oc96sqf3by0w/js/core/merged-template-prepend.js.deps','f2bb7728b295b3968dac0734e251c4f2',145,'merged-template-prepend.js.deps',18,5,246,1750743652,1750743652,0,0,'6515a93d5f3f4ec75e76d4bbd534552b',27,''),(148,2,'appdata_oc96sqf3by0w/js/core/merged-template-prepend.js.gzip','03a11ba0bd2409d7b407a3c25d2abda3',145,'merged-template-prepend.js.gzip',20,5,2812,1750743652,1750743652,0,0,'ed75110227b566092ccdfb7eeaf9c0f4',27,''),(149,1,'cache','0fea6a13c52b4d4725368f24b045ca84',1,'cache',2,1,0,1750990154,1750990154,0,0,'685dfd4a89971',31,''),(150,2,'appdata_oc96sqf3by0w/theming/global/0/favIcon-settings#00679e','087c1cc53e4d9b72bf08d5af006fd446',141,'favIcon-settings#00679e',18,5,90022,1750750043,1750750043,0,0,'f185fff9fa8e559f94f3a86d2d8c71dc',27,''),(151,2,'appdata_oc96sqf3by0w/avatar','06e568b71dd07dd7a60d7e0446988a0b',59,'avatar',2,1,0,1750750043,1750750043,0,0,'685a535bae0c0',31,''),(152,2,'appdata_oc96sqf3by0w/avatar/Landing Pad Digital','f7f68c1ad15f5a97b9e4be3544c40326',151,'Landing Pad Digital',2,1,0,1750750221,1750750221,0,0,'685a535bb020c',31,''),(156,2,'appdata_oc96sqf3by0w/theming/global/0/touchIcon-settings#00679e','7819290aaac9e72d27c8986ec378cf89',141,'touchIcon-settings#00679e',18,5,6424,1750750044,1750750044,0,0,'bb5d2737ec0c50971bf81528ccf27bd6',27,''),(159,2,'appdata_oc96sqf3by0w/avatar/Landing Pad Digital/avatar.png','d53d0a613e6ed28579b4cf2b6b08c251',152,'avatar.png',11,9,13078,1750750082,1750750082,0,0,'bf33dbed55b3a8234b8106526bd223a6',27,''),(160,2,'appdata_oc96sqf3by0w/avatar/Landing Pad Digital/avatar.512.png','abb86ebaad76e5b00bb452b3a27cdc48',152,'avatar.512.png',11,9,13078,1750750082,1750750082,0,0,'9cd459e215bbbbea5fdb11a147998511',27,''),(161,2,'appdata_oc96sqf3by0w/avatar/Landing Pad Digital/avatar.64.png','05c040b32f0041e04e78bb75253575a0',152,'avatar.64.png',11,9,1055,1750750082,1750750082,0,0,'c7703b2bbf7b19acaf6fedf6beee0337',27,''),(162,2,'appdata_oc96sqf3by0w/avatar/Landing Pad Digital/avatar.32.png','1bd56969fb80bb5cfefa2c2acac66c0a',152,'avatar.32.png',11,9,556,1750750221,1750750221,0,0,'64fc91370a504b12223a9b403c814c27',27,''),(163,2,'appdata_oc96sqf3by0w/theming/global/0/favIcon-profile#00679e','b317206b9eb9f5ca547a4a0278fdba63',141,'favIcon-profile#00679e',18,5,90022,1750750494,1750750494,0,0,'55d1da11679030a4d1f25dfd45747079',27,''),(164,2,'appdata_oc96sqf3by0w/theming/global/0/touchIcon-profile#00679e','d68c8abebf1879e142ff909440860bd4',141,'touchIcon-profile#00679e',18,5,22560,1750750494,1750750494,0,0,'01940a45f27041aaa4f4ca772bea47a7',27,''),(165,2,'appdata_oc96sqf3by0w/theming/global/images','14b5f9ac059a4976bbcef99d672ca8e5',140,'images',2,1,0,1750752745,1750752745,0,0,'685a557aa0b96',31,''),(166,2,'appdata_oc96sqf3by0w/theming/global/images/logo','fb930ec44db977ddc42753ba380eba5a',165,'logo',18,5,90922,1750750586,1750750586,0,0,'d2deec2d71a977ac56363b9873d348d1',27,''),(167,2,'appdata_oc96sqf3by0w/theming/global/images/background','66a8912ee71b5dfbbc9169190d58897d',165,'background',18,5,20432,1750750615,1750750615,0,0,'6a3b12c64e6f8ddae392a83df9a70ac5',27,''),(168,2,'appdata_oc96sqf3by0w/theming/global/images/favicon','1de50e343e06eba71ad396d332b83651',165,'favicon',18,5,2781,1750750627,1750750627,0,0,'8fa7ff7e0f707d51ed84ce77bf3300e1',27,''),(169,2,'appdata_oc96sqf3by0w/appstore/appapi_apps.json','f1910bbcc5fc1fdaa6ba7805ddd0fa1b',60,'appapi_apps.json',21,5,82572,1750754581,1750754581,0,0,'b4d05653e971c531322b1faf70f480f0',27,''),(170,2,'appdata_oc96sqf3by0w/appstore/discover.json','8dc86cbd1bdddde15709fa7d49120746',60,'discover.json',21,5,7272,1750755356,1750755356,0,0,'eafb65f39bd60efbe47817fab192932a',27,''),(171,2,'appdata_oc96sqf3by0w/appstore/app-discover-cache','0370f2ce24409346bff49b10417e0401',60,'app-discover-cache',2,1,0,1750751187,1750751187,0,0,'685a57d304926',31,''),(172,2,'appdata_oc96sqf3by0w/appstore/app-discover-cache/685a577d-92a','f1c28a9a7a677e956f1dcf42d702c276',171,'685a577d-92a',2,1,0,1750753293,1750753293,0,0,'685a57d3079cb',31,''),(173,2,'appdata_oc96sqf3by0w/appstore/app-discover-cache/685a577d-92a/a65457f45bd7facd2a91f6927e8dce6c.YXVkaW8vd2VibQ==.webm','b9ff950f94e1ec621d1833cd7fc79fde',172,'a65457f45bd7facd2a91f6927e8dce6c.YXVkaW8vd2VibQ==.webm',22,7,821961,1750751191,1750751191,0,0,'8dc36bf809ddecafcf5ec023f93bf2ec',27,''),(174,2,'appdata_oc96sqf3by0w/appstore/app-discover-cache/685a577d-92a/3289725285460e73018ab98c443beb37.aW1hZ2UvcG5n.png','13654deb08f673fe0b88b909011d89ab',172,'3289725285460e73018ab98c443beb37.aW1hZ2UvcG5n.png',11,9,314506,1750751199,1750751199,0,0,'1599ec362a059c797b2bfd4ec5ee91b5',27,''),(175,2,'appdata_oc96sqf3by0w/appstore/app-discover-cache/685a577d-92a/acffabdbe5148794e282887781da1988.aW1hZ2UvcG5n.png','9d4aaf5bd57b2ffc95b3f406ae04d26f',172,'acffabdbe5148794e282887781da1988.aW1hZ2UvcG5n.png',11,9,1150887,1750751206,1750751206,0,0,'b1be0f39aa4fa911467a161dd43866e3',27,''),(176,2,'appdata_oc96sqf3by0w/theming/global/images/favicon.png','9404c71dd4f636b7e303f839f3f89efb',165,'favicon.png',11,9,2500,1750752016,1750752016,0,0,'4fc0d4c5d9cc3ae982eb53995d2c131e',27,''),(177,2,'appdata_oc96sqf3by0w/theming/global/7','d6120a7db321168a5952eebf28a2d78d',140,'7',2,1,0,1750756174,1750756174,0,0,'685a5b1045291',31,''),(178,2,'appdata_oc96sqf3by0w/theming/global/7/icon-core-#783CB2filetypes_whiteboard.svg','12e163a7d417f4237231717ffffdcbf1',177,'icon-core-#783CB2filetypes_whiteboard.svg',23,9,281,1750752016,1750752016,0,0,'f2cbb01680cb023e6d027642ae016ce2',27,''),(179,2,'appdata_oc96sqf3by0w/theming/global/7/icon-core-#783CB2filetypes_x-office-document.svg','662c418544f4fbe5e489f0d266b3a093',177,'icon-core-#783CB2filetypes_x-office-document.svg',23,9,304,1750752016,1750752016,0,0,'812b67e861838251913c04cf69c9a18b',27,''),(180,2,'appdata_oc96sqf3by0w/theming/global/7/icon-core-#783CB2filetypes_x-office-presentation.svg','bcb220ed3b67699864ad35716ec3135a',177,'icon-core-#783CB2filetypes_x-office-presentation.svg',23,9,221,1750752016,1750752016,0,0,'75a2794e18bac492c5a94f017e01483e',27,''),(181,2,'appdata_oc96sqf3by0w/theming/global/7/icon-core-#783CB2filetypes_application-pdf.svg','a4164b5e494eadd986d4afc1039f973b',177,'icon-core-#783CB2filetypes_application-pdf.svg',23,9,468,1750752016,1750752016,0,0,'f5a891d86517293d214363ad7db5659b',27,''),(182,2,'appdata_oc96sqf3by0w/theming/global/7/touchIcon-dashboard#783CB2','eae2e399aa1f18c4ea281ee627d5a9de',177,'touchIcon-dashboard#783CB2',18,5,9546,1750752016,1750752016,0,0,'050704dccaad41d1e78437d55b8430e5',27,''),(183,2,'appdata_oc96sqf3by0w/preview/9/a','7f421946805c91b1a43e5455da11fbba',114,'a',2,1,0,1750752047,1750752047,0,0,'685a6b6a82178',31,''),(184,2,'appdata_oc96sqf3by0w/preview/a/5','b522041184929ed4ad2e243b83115c53',105,'5',2,1,0,1750752047,1750752047,0,0,'685a6b6a7c506',31,''),(185,2,'appdata_oc96sqf3by0w/preview/9/a/1','a1cb6d0e38d4ab171624d7d11f273b99',183,'1',2,1,0,1750752047,1750752047,0,0,'685a6b6a78011',31,''),(186,2,'appdata_oc96sqf3by0w/preview/7','e2fb87673b9b1c06972a58832ee35be7',61,'7',2,1,0,1750752047,1750752047,0,0,'685a6b6a6ab91',31,''),(187,2,'appdata_oc96sqf3by0w/preview/9/a/1/1','56b06a89ac991154061ff31c835ae66e',185,'1',2,1,0,1750752047,1750752047,0,0,'685a6b6a6257e',31,''),(188,2,'appdata_oc96sqf3by0w/preview/a/5/b','be22bc91d85ae3ea4b6e895cbaf67570',184,'b',2,1,0,1750752047,1750752047,0,0,'685a6b6a56eb1',31,''),(189,2,'appdata_oc96sqf3by0w/preview/7/2','a3ae61b8d13ed50aa1a1e39724a55810',186,'2',2,1,0,1750752047,1750752047,0,0,'685a6b6a4e765',31,''),(190,2,'appdata_oc96sqf3by0w/preview/9/a/1/1/5','9962ae0ce2ecddd5e020b97aa8708261',187,'5',2,1,0,1750752047,1750752047,0,0,'685a6b6a47297',31,''),(191,2,'appdata_oc96sqf3by0w/preview/a/5/b/f','58d75cf363acad1f553ce9a58ad18a84',188,'f',2,1,0,1750752047,1750752047,0,0,'685a6b6a2f14e',31,''),(192,2,'appdata_oc96sqf3by0w/preview/7/2/b','705ee91443d4ea6f8d3446a761cc88eb',189,'b',2,1,0,1750752047,1750752047,0,0,'685a6b6a1f01c',31,''),(193,2,'appdata_oc96sqf3by0w/preview/9/a/1/1/5/8','5e6a2984255eec92ff63c68904212941',190,'8',2,1,0,1750752047,1750752047,0,0,'685a6b6a0cdc0',31,''),(194,2,'appdata_oc96sqf3by0w/preview/a/5/b/f/c','374d25deaa0f9c6c4dc7b25a685be139',191,'c',2,1,0,1750752047,1750752047,0,0,'685a6b6a05e7a',31,''),(195,2,'appdata_oc96sqf3by0w/preview/7/2/b/3','3802f9e597713e517fd51aea96ec25db',192,'3',2,1,0,1750752047,1750752047,0,0,'685a6b69ef3ab',31,''),(196,2,'appdata_oc96sqf3by0w/preview/a/5/b/f/c/9','05210d4000f131e06309acc819ed3d1e',194,'9',2,1,0,1750752047,1750752047,0,0,'685a6b69e78fd',31,''),(197,2,'appdata_oc96sqf3by0w/preview/9/a/1/1/5/8/1','6c966d12eaa0019ad514b6fdea75dc45',193,'1',2,1,0,1750752047,1750752047,0,0,'685a6b69ddea5',31,''),(198,2,'appdata_oc96sqf3by0w/preview/a/5/b/f/c/9/e','25b233875b1cf81df668f284a9719bc3',196,'e',2,1,0,1750752047,1750752047,0,0,'685a6b69d6060',31,''),(199,2,'appdata_oc96sqf3by0w/preview/a/6','18110004853cb754b21fd8ca28a354cb',105,'6',2,1,0,1750752047,1750752047,0,0,'685a6b69ccc66',31,''),(200,2,'appdata_oc96sqf3by0w/preview/7/2/b/3/2','060bcec94eddab76e29b027d82078577',195,'2',2,1,0,1750752047,1750752047,0,0,'685a6b69c5add',31,''),(201,2,'appdata_oc96sqf3by0w/preview/9/a/1/1/5/8/1/52','fec5599caed0e08dd72329ca42cbed21',197,'52',2,1,0,1750752048,1750752048,0,0,'685a5b2fe0dd8',31,''),(202,2,'appdata_oc96sqf3by0w/preview/a/6/8','5ba2aeb80edda3f285b288bbb3d68704',199,'8',2,1,0,1750752047,1750752047,0,0,'685a6b69be8f6',31,''),(203,2,'appdata_oc96sqf3by0w/preview/a/5/b/f/c/9/e/37','c69c144f5495a55ddb2b094a494bef96',198,'37',2,1,0,1750752048,1750752048,0,0,'685a5b2fe0abb',31,''),(204,2,'appdata_oc96sqf3by0w/preview/7/2/b/3/2/a','8f32bf631200073caa60fc29f6850874',200,'a',2,1,0,1750752047,1750752047,0,0,'685a6b69b8852',31,''),(205,2,'appdata_oc96sqf3by0w/preview/a/6/8/4','24b9bb46829f52b1c111567085c600f2',202,'4',2,1,0,1750752047,1750752047,0,0,'685a6b69b1be3',31,''),(206,2,'appdata_oc96sqf3by0w/preview/7/2/b/3/2/a/1','06c80032b83c5c7c63b5fb0478602834',204,'1',2,1,0,1750752047,1750752047,0,0,'685a6b69ac1db',31,''),(207,2,'appdata_oc96sqf3by0w/preview/a/6/8/4/e','4c00a3b1c86e59baed45d856e85bc6bf',205,'e',2,1,0,1750752047,1750752047,0,0,'685a6b69a6b29',31,''),(208,2,'appdata_oc96sqf3by0w/preview/a/6/8/4/e/c','529a32ef72596e8153d68b2ee45bfb8c',207,'c',2,1,0,1750752047,1750752047,0,0,'685a6b699fa96',31,''),(209,2,'appdata_oc96sqf3by0w/preview/7/2/b/3/2/a/1/57','4c7cacdebecac0c48cf6d6b501e76bae',206,'57',2,1,0,1750752048,1750752048,0,0,'685a5b2fe0b86',31,''),(210,2,'appdata_oc96sqf3by0w/preview/a/6/8/4/e/c/e','e7dc80a4282977e306987ee30f46d75e',208,'e',2,1,0,1750752047,1750752047,0,0,'685a6b699983e',31,''),(211,2,'appdata_oc96sqf3by0w/preview/a/6/8/4/e/c/e/54','7ab725a779ec101c5cc9e49daa2288ae',210,'54',2,1,0,1750752048,1750752048,0,0,'685a5b2fe5b90',31,''),(212,2,'appdata_oc96sqf3by0w/theming/global/7/icon-core-#783CB2filetypes_text.svg','28b4f7ba2a73641e42aee72a1bd01526',177,'icon-core-#783CB2filetypes_text.svg',23,9,299,1750752048,1750752048,0,0,'da3c3b8d438c474ff9260855bd05e495',27,''),(213,2,'appdata_oc96sqf3by0w/preview/9/a/1/1/5/8/1/52/512-288-max.png','60a4ae4c4cd20ddd13f16c2157e4d54e',201,'512-288-max.png',11,9,13279,1750752048,1750752048,0,0,'a43f593d416b5360e40691871c11743f',27,''),(214,2,'appdata_oc96sqf3by0w/preview/a/5/b/f/c/9/e/37/362-512-max.png','9f01535f4aa56817843362e4c4b9ce87',203,'362-512-max.png',11,9,88877,1750752048,1750752048,0,0,'c27a6d68b2bad4b06e569fac1f106ef1',27,''),(215,2,'appdata_oc96sqf3by0w/preview/9/a/1/1/5/8/1/52/256-256-crop.png','ad19c07247f4445626eca8228cad9605',201,'256-256-crop.png',11,9,25540,1750752048,1750752048,0,0,'583aa4f6b47e8086a9d531282ef8ac1e',27,''),(216,2,'appdata_oc96sqf3by0w/preview/a/5/b/f/c/9/e/37/256-256-crop.png','c103c518d8bde9388d591a53eaa876cb',203,'256-256-crop.png',11,9,131611,1750752048,1750752048,0,0,'010ba6b4bddc5edf65289e1156f7a381',27,''),(217,2,'appdata_oc96sqf3by0w/preview/7/2/b/3/2/a/1/57/4096-4096-max.png','e1692e0ab90e8c65fbde9fa89b8c8b6c',209,'4096-4096-max.png',11,9,192888,1750752048,1750752048,0,0,'85415d4a994e538751767690124ff8e2',27,''),(218,2,'appdata_oc96sqf3by0w/preview/a/6/8/4/e/c/e/54/4096-4096-max.png','e10304208ca403d6a45b1edd1f0860b9',211,'4096-4096-max.png',11,9,36693,1750752048,1750752048,0,0,'176317c5bfb1501a937854ccc41390b9',27,''),(219,2,'appdata_oc96sqf3by0w/preview/a/6/8/4/e/c/e/54/256-256-crop.png','877660c9a7941bd52e516f2ad45ead57',211,'256-256-crop.png',11,9,6398,1750752048,1750752048,0,0,'9e7eaaad67ca30b5dbacbf6a702da79b',27,''),(220,2,'appdata_oc96sqf3by0w/preview/7/2/b/3/2/a/1/57/256-256-crop.png','8c7d5f7ab730eb8147e58858298154e8',209,'256-256-crop.png',11,9,34096,1750752048,1750752048,0,0,'a692a8907273e55a15b48c9dd8e7c16a',27,''),(221,2,'appdata_oc96sqf3by0w/preview/e','558e53289289a9da2374e582e046a38d',61,'e',2,1,0,1750752699,1750752699,0,0,'685a6b6995c38',31,''),(222,2,'appdata_oc96sqf3by0w/preview/e/4','d2234d8ebe6848b0263f0f3d3d840c2a',221,'4',2,1,0,1750752239,1750752239,0,0,'685a6b698f5d7',31,''),(223,2,'appdata_oc96sqf3by0w/preview/e/4/d','b79ea205d001b3160e8851ea2223844b',222,'d',2,1,0,1750752239,1750752239,0,0,'685a6b698a553',31,''),(224,2,'appdata_oc96sqf3by0w/preview/e/4/d/a','c848b9c0384f265eaf6ad6fb4ab39ed8',223,'a',2,1,0,1750752239,1750752239,0,0,'685a6b6984e70',31,''),(225,2,'appdata_oc96sqf3by0w/preview/e/4/d/a/3','3f709837104215534efc17035beb658e',224,'3',2,1,0,1750752239,1750752239,0,0,'685a6b69807f6',31,''),(226,2,'appdata_oc96sqf3by0w/preview/e/4/d/a/3/b','7309c0c145b8c64c476877d9612d5fb7',225,'b',2,1,0,1750752239,1750752239,0,0,'685a6b697bbaa',31,''),(227,2,'appdata_oc96sqf3by0w/preview/e/4/d/a/3/b/7','4b7744ef9864f9050908174265e100a7',226,'7',2,1,0,1750752239,1750752239,0,0,'685a6b697784d',31,''),(228,2,'appdata_oc96sqf3by0w/preview/e/4/d/a/3/b/7/5','c78475ae9cd1b48b10d7a884f7ba7db4',227,'5',2,1,0,1750752240,1750752240,0,0,'685a5befb9be1',31,''),(229,2,'appdata_oc96sqf3by0w/preview/6/f/4/9/2/2/f/18/64-64-crop.png','8edbf7c3bc1ee35b29aee04b8c992adb',137,'64-64-crop.png',11,9,3895,1750752239,1750752239,0,0,'63fcf932dbe21773828ae66c16dd39fc',27,''),(230,2,'appdata_oc96sqf3by0w/preview/e/c','5bf7aeacccdb017cae897ae32c1b31d6',221,'c',2,1,0,1750752239,1750752239,0,0,'685a6b69734b0',31,''),(231,2,'appdata_oc96sqf3by0w/preview/e/c/c','5f46bf5a84198cbd5eb7e085f10de8dc',230,'c',2,1,0,1750752239,1750752239,0,0,'685a6b696fa51',31,''),(232,2,'appdata_oc96sqf3by0w/preview/e/c/c/b','4e48e61e004dc111cec2441eb890a851',231,'b',2,1,0,1750752239,1750752239,0,0,'685a6b696c2c5',31,''),(233,2,'appdata_oc96sqf3by0w/preview/e/c/c/b/c','b4ccb579c33c93cd1d2289765f09029c',232,'c',2,1,0,1750752239,1750752239,0,0,'685a6b6968c44',31,''),(234,2,'appdata_oc96sqf3by0w/preview/e/c/c/b/c/8','4e158615b7d2b4d8f4d7f971203b8ae2',233,'8',2,1,0,1750752239,1750752239,0,0,'685a6b69640df',31,''),(235,2,'appdata_oc96sqf3by0w/preview/e/c/c/b/c/8/7','12c44121790949e102e007dbb42ea2b3',234,'7',2,1,0,1750752239,1750752239,0,0,'685a6b6960ed9',31,''),(236,2,'appdata_oc96sqf3by0w/preview/e/c/c/b/c/8/7/3','bb2b46c55201809072c640cfc5f8e366',235,'3',2,1,0,1750752240,1750752240,0,0,'685a5befbf9d2',31,''),(237,2,'appdata_oc96sqf3by0w/preview/e/4/d/a/3/b/7/5/4096-4096-max.png','99c009f395740fe567e191f8acd32479',228,'4096-4096-max.png',11,9,185668,1750752239,1750752239,0,0,'3fae0cd8edecfd48cee771eddc93f7be',27,''),(238,2,'appdata_oc96sqf3by0w/preview/e/c/c/b/c/8/7/3/4096-4096-max.png','bb03b84cf1e6e18884c3dadf95d8d852',236,'4096-4096-max.png',11,9,49132,1750752239,1750752239,0,0,'4b4610bdb2454b89b4dd06be8c4296a3',27,''),(239,2,'appdata_oc96sqf3by0w/preview/e/c/c/b/c/8/7/3/64-64-crop.png','6eea8cdb54ff1b9a76bef5b6d02bee2f',236,'64-64-crop.png',11,9,1243,1750752240,1750752240,0,0,'8d2493287ea4b88955bb000f179b6b32',27,''),(240,2,'appdata_oc96sqf3by0w/preview/e/4/d/a/3/b/7/5/64-64-crop.png','a3ec777d7a4e7b28d4fbc7ae74db1d2b',228,'64-64-crop.png',11,9,3102,1750752240,1750752240,0,0,'07b068ab6b42fde233148d8c8f40d27d',27,''),(241,2,'appdata_oc96sqf3by0w/text','39ca9fe4b1bb7828f2854eae675bfb45',59,'text',2,1,0,1750752241,1750752241,0,0,'685a5bf11145d',31,''),(242,2,'appdata_oc96sqf3by0w/text/documents','166876b1268c6946d8244a0f78834dff',241,'documents',2,1,0,1750752241,1750752241,0,0,'685a5bf113308',31,''),(243,2,'appdata_oc96sqf3by0w/theming/global/7/touchIcon-settings#783CB2','eb30f9257df4b5efe6c9552139826ddc',177,'touchIcon-settings#783CB2',18,5,6531,1750752293,1750752293,0,0,'208539c5d7d9075aae55d0cbe77f7cb2',27,''),(244,2,'appdata_oc96sqf3by0w/theming/global/7/icon-core-#783CB2filetypes_folder.svg','4dc68a8d669e137a63b7486b3e45ec6e',177,'icon-core-#783CB2filetypes_folder.svg',23,9,507,1750752698,1750752698,0,0,'7c17fa593db71d9ba82634e8d865fbe0',27,''),(245,2,'appdata_oc96sqf3by0w/preview/6/7','3b96a8e0ceca14bef5dd311f6905b3e0',80,'7',2,1,0,1750752698,1750752698,0,0,'685a6b695cb6e',31,''),(246,2,'appdata_oc96sqf3by0w/preview/a/1','87118d71cfc0c4f5485a4f22545dda12',105,'1',2,1,0,1750752698,1750752698,0,0,'685a6b69581da',31,''),(247,2,'appdata_oc96sqf3by0w/preview/6/7/c','381a339c29f0959b05e0cca8cc9a322d',245,'c',2,1,0,1750752698,1750752698,0,0,'685a6b695495e',31,''),(248,2,'appdata_oc96sqf3by0w/preview/6/7/c/6','1025f75578a690dd885c647f1ae6b804',247,'6',2,1,0,1750752698,1750752698,0,0,'685a6b694f08d',31,''),(249,2,'appdata_oc96sqf3by0w/preview/a/1/d','2d0c36d752eefc0b6809312d924103cc',246,'d',2,1,0,1750752698,1750752698,0,0,'685a6b694b7b5',31,''),(250,2,'appdata_oc96sqf3by0w/preview/6/7/c/6/a','061cfab125dd214e0673ccbb8ffdd19e',248,'a',2,1,0,1750752698,1750752698,0,0,'685a6b694799f',31,''),(251,2,'appdata_oc96sqf3by0w/preview/a/1/d/0','1bd0b1c9dbea5e27510e59903eab38a8',249,'0',2,1,0,1750752698,1750752698,0,0,'685a6b694506f',31,''),(252,2,'appdata_oc96sqf3by0w/preview/a/1/d/0/c','313a22bc63e03eebf76aebe3bc8587a6',251,'c',2,1,0,1750752698,1750752698,0,0,'685a6b6940eb5',31,''),(253,2,'appdata_oc96sqf3by0w/preview/6/7/c/6/a/1','ea8be4ffc75462ba49fb978b6d52133d',250,'1',2,1,0,1750752698,1750752698,0,0,'685a6b693dbab',31,''),(254,2,'appdata_oc96sqf3by0w/preview/6/c','fc93befc10f29e264f9c816842428117',80,'c',2,1,0,1750752699,1750752699,0,0,'685a6b693a8ff',31,''),(255,2,'appdata_oc96sqf3by0w/preview/a/1/d/0/c/6','aa5fd807971a65fd35a1d2cf29e03b17',252,'6',2,1,0,1750752698,1750752698,0,0,'685a6b69373ab',31,''),(256,2,'appdata_oc96sqf3by0w/preview/6/c/8','dc9e1b17d26470ebf9f7ba34e0916ab4',254,'8',2,1,0,1750752699,1750752699,0,0,'685a6b6934f99',31,''),(257,2,'appdata_oc96sqf3by0w/preview/6/7/c/6/a/1/e','0e7c193ae47ddf5067ca6e93640eaac7',253,'e',2,1,0,1750752698,1750752698,0,0,'685a6b69317ca',31,''),(258,2,'appdata_oc96sqf3by0w/preview/a/1/d/0/c/6/e','bbb8df2613aa5da85bf303381b8ac00e',255,'e',2,1,0,1750752698,1750752698,0,0,'685a6b692d974',31,''),(259,2,'appdata_oc96sqf3by0w/preview/6/7/c/6/a/1/e/47','1cf2e4acc593f79dfef14cb95271895c',257,'47',2,1,0,1750752699,1750752699,0,0,'685a5dbaf2c4b',31,''),(260,2,'appdata_oc96sqf3by0w/preview/6/c/8/3','119118caf3ee2ab0c43f68bbbdbadb4e',256,'3',2,1,0,1750752699,1750752699,0,0,'685a6b6929039',31,''),(261,2,'appdata_oc96sqf3by0w/preview/e/3','1bf05be8528869a5483501095a481184',221,'3',2,1,0,1750752699,1750752699,0,0,'685a6b6924b98',31,''),(262,2,'appdata_oc96sqf3by0w/preview/a/1/d/0/c/6/e/42','445f4cfdcccc74f86ca37f123e2d2804',258,'42',2,1,0,1750752699,1750752699,0,0,'685a5dbaf23f1',31,''),(263,2,'appdata_oc96sqf3by0w/preview/6/c/8/3/4','de48fa20e2cf8a6fba919c97f2542c31',260,'4',2,1,0,1750752699,1750752699,0,0,'685a6b6921dee',31,''),(264,2,'appdata_oc96sqf3by0w/preview/e/3/6','49b72bf852414b9d0972847e068be3e8',261,'6',2,1,0,1750752699,1750752699,0,0,'685a6b691edc0',31,''),(265,2,'appdata_oc96sqf3by0w/preview/6/c/8/3/4/9','b1b9584ad35d8f25a21d1829ea1ee008',263,'9',2,1,0,1750752699,1750752699,0,0,'685a6b691ae12',31,''),(266,2,'appdata_oc96sqf3by0w/preview/e/3/6/9','02364e714339712c66bdf54b655a4073',264,'9',2,1,0,1750752699,1750752699,0,0,'685a6b6917f6e',31,''),(267,2,'appdata_oc96sqf3by0w/preview/6/c/8/3/4/9/c','792ce675204835677131867affafa963',265,'c',2,1,0,1750752699,1750752699,0,0,'685a6b6913e7d',31,''),(268,2,'appdata_oc96sqf3by0w/preview/e/3/6/9/8','a6044c9f318f4df805eb4cf34badb6c1',266,'8',2,1,0,1750752699,1750752699,0,0,'685a6b690f1cb',31,''),(269,2,'appdata_oc96sqf3by0w/preview/6/c/8/3/4/9/c/45','6be70d7ecf861e34b884386c284b80d7',267,'45',2,1,0,1750752699,1750752699,0,0,'685a5dbb03a5f',31,''),(270,2,'appdata_oc96sqf3by0w/preview/e/3/6/9/8/5','ea38da1d41e7f5c83e81b4d8b377eab5',268,'5',2,1,0,1750752699,1750752699,0,0,'685a6b690ae9f',31,''),(271,2,'appdata_oc96sqf3by0w/preview/e/3/6/9/8/5/3','10b5ce7ae5ca8a2668e5ee623749bad9',270,'3',2,1,0,1750752699,1750752699,0,0,'685a6b6907545',31,''),(272,2,'appdata_oc96sqf3by0w/preview/e/3/6/9/8/5/3/34','c5c6ad6ca8882bb324f534c8a6b8c02f',271,'34',2,1,0,1750752699,1750752699,0,0,'685a5dbb04dae',31,''),(273,2,'appdata_oc96sqf3by0w/preview/6/7/c/6/a/1/e/47/201-255-max.png','990aaca8ae899499ea10dd66e4872469',259,'201-255-max.png',11,9,2090,1750752699,1750752699,0,0,'75d9904054f5cd2fa874c916948b8553',27,''),(274,2,'appdata_oc96sqf3by0w/preview/a/1/d/0/c/6/e/42/512-376-max.png','417668ef14ffa83fb08482bb19fb3310',262,'512-376-max.png',11,9,13892,1750752699,1750752699,0,0,'d746b6c9e3b4c4a7a2e7bd4c12293a1d',27,''),(275,2,'appdata_oc96sqf3by0w/preview/e/3/6/9/8/5/3/34/181-256-max.png','64769def9e621202a7be66a9681ec86b',272,'181-256-max.png',11,9,2564,1750752699,1750752699,0,0,'633bd1eeef112e4a1b59920144c7c911',27,''),(276,2,'appdata_oc96sqf3by0w/preview/6/7/c/6/a/1/e/47/201-201-crop.png','7ab99e08d3cfb4731ecd167e275cf98a',259,'201-201-crop.png',11,9,1639,1750752699,1750752699,0,0,'4de9ef569018bebbb7bd5658f8d1ae65',27,''),(277,2,'appdata_oc96sqf3by0w/preview/6/c/8/3/4/9/c/45/512-288-max.png','c3d73769e44c23d11cd22490a3aeeef7',269,'512-288-max.png',11,9,23378,1750752699,1750752699,0,0,'19297b34f6f982236d17f7e28f6488d6',27,''),(278,2,'appdata_oc96sqf3by0w/preview/e/3/6/9/8/5/3/34/181-181-crop.png','166078648dcea9e7106af408dec64bb5',272,'181-181-crop.png',11,9,5219,1750752699,1750752699,0,0,'59db75cd1590e53b716b2e31f9513778',27,''),(279,2,'appdata_oc96sqf3by0w/preview/d/6','824c0fa1fd8066524e8532b48e45d90f',71,'6',2,1,0,1750752699,1750752699,0,0,'685a6b690349f',31,''),(280,2,'appdata_oc96sqf3by0w/preview/d/6/7','f5fc92ed6a15b4c492d3cc0ba20c5983',279,'7',2,1,0,1750752699,1750752699,0,0,'685a6b68f3ef3',31,''),(281,2,'appdata_oc96sqf3by0w/preview/d/6/7/d','bba753dacd5294e0a24715bb469e23f3',280,'d',2,1,0,1750752699,1750752699,0,0,'685a6b68f0720',31,''),(282,2,'appdata_oc96sqf3by0w/preview/a/1/d/0/c/6/e/42/256-256-crop.png','cf3f783f01013f5ef9530241d3a944e9',262,'256-256-crop.png',11,9,27896,1750752699,1750752699,0,0,'fcd03d7c44cfcbec06fac1b22f2c3b58',27,''),(283,2,'appdata_oc96sqf3by0w/preview/d/6/7/d/8','4fe34ece48b33e6703a2351f0b3c1db1',281,'8',2,1,0,1750752699,1750752699,0,0,'685a6b68eb9b5',31,''),(284,2,'appdata_oc96sqf3by0w/preview/d/6/7/d/8/a','5ff180e8a1e48986969aafd17eb10d74',283,'a',2,1,0,1750752699,1750752699,0,0,'685a6b68e7161',31,''),(285,2,'appdata_oc96sqf3by0w/preview/d/6/7/d/8/a/b','143d0a5a55ac783bf70f9d6c438151e8',284,'b',2,1,0,1750752699,1750752699,0,0,'685a6b68e44aa',31,''),(286,2,'appdata_oc96sqf3by0w/preview/d/6/7/d/8/a/b/39','10f13bd3c3f9ffe971413380397b0ec4',285,'39',2,1,0,1750752699,1750752699,0,0,'685a5dbb1b2eb',31,''),(287,2,'appdata_oc96sqf3by0w/preview/1','2c8842051bef077925c881c9acede955',61,'1',2,1,0,1750752699,1750752699,0,0,'685a6b68e06e8',31,''),(288,2,'appdata_oc96sqf3by0w/preview/1/c','345249d66ea83160f555b5fae50529f0',287,'c',2,1,0,1750752699,1750752699,0,0,'685a6b68dd2e7',31,''),(289,2,'appdata_oc96sqf3by0w/preview/1/c/3','59b33b2e074679400679b7978cf442d3',288,'3',2,1,0,1750752699,1750752699,0,0,'685a6b68d9772',31,''),(290,2,'appdata_oc96sqf3by0w/preview/1/c/3/8','2d5ebd3040a9fccaa7adca972cb1f8a3',289,'8',2,1,0,1750752699,1750752699,0,0,'685a6b68d5b40',31,''),(291,2,'appdata_oc96sqf3by0w/preview/1/c/3/8/3','01fa0516210f8bd106863b1e630e4d91',290,'3',2,1,0,1750752699,1750752699,0,0,'685a6b68d1226',31,''),(292,2,'appdata_oc96sqf3by0w/preview/6/c/8/3/4/9/c/45/256-256-crop.png','807e4198fd09c18b396b8e4b089cae93',269,'256-256-crop.png',11,9,50566,1750752699,1750752699,0,0,'2b377d64124035621891c2320e8eb67e',27,''),(293,2,'appdata_oc96sqf3by0w/preview/1/c/3/8/3/c','24aa48dc2854fb5daa8d95a4597b2527',291,'c',2,1,0,1750752699,1750752699,0,0,'685a6b68cbe14',31,''),(294,2,'appdata_oc96sqf3by0w/preview/1/c/3/8/3/c/d','2c727ae58a46b1bb562b388963cec8b1',293,'d',2,1,0,1750752699,1750752699,0,0,'685a6b68c81a8',31,''),(295,2,'appdata_oc96sqf3by0w/preview/1/c/3/8/3/c/d/35','496234f675dcc172c44f4d59e1d77720',294,'35',2,1,0,1750752699,1750752699,0,0,'685a5dbb233a0',31,''),(296,2,'appdata_oc96sqf3by0w/preview/f','bded7f2d87aed93357773e8543b7e40f',61,'f',2,1,0,1750752699,1750752699,0,0,'685a6b68c4d51',31,''),(297,2,'appdata_oc96sqf3by0w/preview/f/7','80669105d499af5644bfc2759aafb756',296,'7',2,1,0,1750752699,1750752699,0,0,'685a6b68c0f17',31,''),(298,2,'appdata_oc96sqf3by0w/preview/f/7/1','88b58c98f586991ee8d68a5cd54deacb',297,'1',2,1,0,1750752699,1750752699,0,0,'685a6b68beb2a',31,''),(299,2,'appdata_oc96sqf3by0w/preview/f/7/1/7','e53e13b0363f3e1baa8fa6db933fd088',298,'7',2,1,0,1750752699,1750752699,0,0,'685a6b68baac0',31,''),(300,2,'appdata_oc96sqf3by0w/preview/f/7/1/7/7','3608f603c1ff3e976e08ff88d5da4024',299,'7',2,1,0,1750752699,1750752699,0,0,'685a6b68b5a86',31,''),(301,2,'appdata_oc96sqf3by0w/preview/f/7/1/7/7/1','7defb2dbfbf3a0aed23eec06264cc993',300,'1',2,1,0,1750752699,1750752699,0,0,'685a6b68b1967',31,''),(302,2,'appdata_oc96sqf3by0w/preview/f/7/1/7/7/1/6','749329357a9b97510b18b343021cf538',301,'6',2,1,0,1750752699,1750752699,0,0,'685a6b68ad9f8',31,''),(303,2,'appdata_oc96sqf3by0w/preview/d/9','5398f1ab719560c033fccb1129bf2332',71,'9',2,1,0,1750752699,1750752699,0,0,'685a6b68aa4bc',31,''),(304,2,'appdata_oc96sqf3by0w/preview/f/7/1/7/7/1/6/44','f80dc43f0415ee9500652066ca371b24',302,'44',2,1,0,1750752699,1750752699,0,0,'685a5dbb34b6e',31,''),(305,2,'appdata_oc96sqf3by0w/preview/d/9/d','32da76b6c5e9bc2cee80d8324be8ea3d',303,'d',2,1,0,1750752699,1750752699,0,0,'685a6b68a77de',31,''),(306,2,'appdata_oc96sqf3by0w/preview/1/c/3/8/3/c/d/35/396-512-max.png','f44a7a45e3a0dc2cf9bffee3634ef53d',295,'396-512-max.png',11,9,23262,1750752699,1750752699,0,0,'b6d2c4abaf537d7cd2837839369adccc',27,''),(307,2,'appdata_oc96sqf3by0w/preview/d/9/d/4','d3bb3faba77aabc339c71a92a65957b3',305,'4',2,1,0,1750752699,1750752699,0,0,'685a6b68a4023',31,''),(308,2,'appdata_oc96sqf3by0w/preview/d/9/d/4/f','eb239c506e6a208b3f0c890588b8b38d',307,'f',2,1,0,1750752699,1750752699,0,0,'685a6b689ebac',31,''),(309,2,'appdata_oc96sqf3by0w/preview/d/9/d/4/f/4','a83ea992e153ae4ed8c78f29b88f7679',308,'4',2,1,0,1750752699,1750752699,0,0,'685a6b689a95b',31,''),(310,2,'appdata_oc96sqf3by0w/preview/d/9/d/4/f/4/9','a0cc2e40170e061dc5654dc5992d502e',309,'9',2,1,0,1750752699,1750752699,0,0,'685a6b6897eb9',31,''),(311,2,'appdata_oc96sqf3by0w/preview/d/9/d/4/f/4/9/46','3710c250ed0af147254b56d490024dfe',310,'46',2,1,0,1750752699,1750752699,0,0,'685a5dbb3857e',31,''),(312,2,'appdata_oc96sqf3by0w/preview/f/7/1/7/7/1/6/44/328-441-max.png','2ae92a95bf0d51e2189928d4e3758e50',304,'328-441-max.png',11,9,21466,1750752699,1750752699,0,0,'cb389b0aef52c65353f911925ef5ce91',27,''),(313,2,'appdata_oc96sqf3by0w/preview/1/c/3/8/3/c/d/35/256-256-crop.png','55e4af94983c5f63aba5198df7c9f473',295,'256-256-crop.png',11,9,47583,1750752699,1750752699,0,0,'7797134cd3999987a277058ee016e8d7',27,''),(314,2,'appdata_oc96sqf3by0w/preview/d/9/d/4/f/4/9/46/181-256-max.png','555a42eebb4f61152419325fd9958ba2',311,'181-256-max.png',11,9,4052,1750752699,1750752699,0,0,'2ad17281bd38b0fcec67af073101fcf3',27,''),(315,2,'appdata_oc96sqf3by0w/preview/3','2f31a1b34f009aa0c643b6d9bdf5c727',61,'3',2,1,0,1750752699,1750752699,0,0,'685a6b6894e7d',31,''),(316,2,'appdata_oc96sqf3by0w/preview/f/7/1/7/7/1/6/44/256-256-crop.png','b07452e2f224b4ccc2836cbc28fc1c9d',304,'256-256-crop.png',11,9,49463,1750752699,1750752699,0,0,'3656cef8244d7fe58a49b0b0197bb455',27,''),(317,2,'appdata_oc96sqf3by0w/preview/3/4','6edb9411cae9bc0948c8276ad1765787',315,'4',2,1,0,1750752699,1750752699,0,0,'685a6b6892daf',31,''),(318,2,'appdata_oc96sqf3by0w/preview/d/9/d/4/f/4/9/46/181-181-crop.png','decfd0f72b7f382dc091b70308ac0899',311,'181-181-crop.png',11,9,8626,1750752699,1750752699,0,0,'0f6f85b4cfe4da4fb1958481da81aea6',27,''),(319,2,'appdata_oc96sqf3by0w/preview/3/4/1','c6b5268a50f3386bcb3469a9fbe3e529',317,'1',2,1,0,1750752699,1750752699,0,0,'685a6b688fd2b',31,''),(320,2,'appdata_oc96sqf3by0w/preview/3/4/1/6','e739ae80833b56a394a6c48de84a6897',319,'6',2,1,0,1750752699,1750752699,0,0,'685a6b688c26f',31,''),(321,2,'appdata_oc96sqf3by0w/preview/3/4/1/6/a','97e1ea1af8ca9465f11f936a5c2f2359',320,'a',2,1,0,1750752699,1750752699,0,0,'685a6b6888272',31,''),(322,2,'appdata_oc96sqf3by0w/preview/3/4/1/6/a/7','a708736844c77e106fd94b6d6fc0d5a5',321,'7',2,1,0,1750752699,1750752699,0,0,'685a6b6884435',31,''),(323,2,'appdata_oc96sqf3by0w/preview/3/4/1/6/a/7/5','596bc87bbc16bf13ba26c271b784754f',322,'5',2,1,0,1750752699,1750752699,0,0,'685a6b687f50f',31,''),(324,2,'appdata_oc96sqf3by0w/preview/3/4/1/6/a/7/5/41','3285946cd3e0653fda1dcd8b761bbfe6',323,'41',2,1,0,1750752699,1750752699,0,0,'685a5dbb4f3b1',31,''),(325,2,'appdata_oc96sqf3by0w/preview/3/4/1/6/a/7/5/41/181-256-max.png','d8823cc289b4b3ad148a724b22e66764',324,'181-256-max.png',11,9,3547,1750752699,1750752699,0,0,'3e8665fd96405fd0c3a8978e5108d3a1',27,''),(326,2,'appdata_oc96sqf3by0w/preview/d/6/7/d/8/a/b/39/4096-4096-max.png','7ff3dfc20016ef58feeb7dcff550a12a',286,'4096-4096-max.png',11,9,69471,1750752699,1750752699,0,0,'e6ed8037628a951e4fc417874d882c4f',27,''),(327,2,'appdata_oc96sqf3by0w/preview/3/4/1/6/a/7/5/41/181-181-crop.png','ff471635649c098aff84cafff9b85e6b',324,'181-181-crop.png',11,9,7478,1750752699,1750752699,0,0,'40ccc99d70e6513c8b784e3782cef5ad',27,''),(328,2,'appdata_oc96sqf3by0w/preview/d/6/7/d/8/a/b/39/256-256-crop.png','5c2f6c3fd795bc5eb75d9fffc8a34e0c',286,'256-256-crop.png',11,9,12240,1750752699,1750752699,0,0,'fa68125908b64c54a3452b28fd793264',27,''),(329,2,'appdata_oc96sqf3by0w/theming/global/7/touchIcon-activity#783CB2','d6c0f92ac9939a1eaf1fc8d2fad8e4e0',177,'touchIcon-activity#783CB2',18,5,12515,1750752699,1750752699,0,0,'0f3f8bffdb229378a9482de20fc04f9e',27,''),(330,2,'appdata_oc96sqf3by0w/theming/global/7/icon-core-#783CB2favicon.png','0c92102c6812c82f99e3a0a565bb7a7a',177,'icon-core-#783CB2favicon.png',11,9,469,1750752704,1750752704,0,0,'d7c02f4139b49cb4c8699e9f35fb1960',27,''),(331,2,'appdata_oc96sqf3by0w/theming/global/images/logo.png','6e4d38e7f967350bc9f3c2c5d87ef4c3',165,'logo.png',11,9,89786,1750752745,1750752745,0,0,'8df30c53cdf203747827b5e5c054ce39',27,''),(332,2,'appdata_oc96sqf3by0w/identityproof','72c41f9de7d74ce992c14a6079b2abdc',59,'identityproof',2,1,0,1750752883,1750752883,0,0,'685a5e739baa7',31,''),(333,2,'appdata_oc96sqf3by0w/identityproof/app-core-ocm_external','c7874f681a1888177cb1952ac3a1cdf4',332,'app-core-ocm_external',2,1,0,1750752883,1750752883,0,0,'685a5e739dbbd',31,''),(334,2,'appdata_oc96sqf3by0w/identityproof/app-core-ocm_external/private','72b0eab2abfa0ad4fca9bbd7e72dda5b',333,'private',18,5,3588,1750752883,1750752883,0,0,'154f581015dc850d8d7f8e026e344fb3',27,''),(335,2,'appdata_oc96sqf3by0w/identityproof/app-core-ocm_external/public','2910ac32b3521eb86f831354d382474c',333,'public',18,5,451,1750752883,1750752883,0,0,'abbdca836f7992f543f8b33aaff13dd7',27,''),(336,2,'appdata_oc96sqf3by0w/appstore/app-discover-cache/685a577d-92a/a0807a3f14c88ea22d78f152ba2daf26.YXBwbGljYXRpb24vb2N0ZXQtc3RyZWFt.mp4','c64d0314316a6829bab67d1b63878339',172,'a0807a3f14c88ea22d78f152ba2daf26.YXBwbGljYXRpb24vb2N0ZXQtc3RyZWFt.mp4',8,7,2560101,1750753301,1750753301,0,0,'17fdefce2a52dda3904d5c4a891a8158',27,''),(337,2,'appdata_oc96sqf3by0w/appstore/apps.json','2bff3f22889352f3ebfa0a3cf86302b6',60,'apps.json',21,5,2787685,1750754081,1750754081,0,0,'f233e96b13351b51f64884640bab81a0',27,''),(338,2,'appdata_oc96sqf3by0w/appstore/categories.json','a4d8cad788dfd43182542c6ef420843c',60,'categories.json',21,5,170863,1750754092,1750754092,0,0,'40480f13fb8b56dc093af4a8bc446fb5',27,''),(339,1,'files_trashbin','fb66dca5f27af6f15c1d1d81e6f8d28b',1,'files_trashbin',2,1,9123267,1750755226,1750754878,0,0,'685a679a1e990',31,''),(343,1,'files_trashbin/versions','c639d144d3f1014051e14a98beac5705',339,'versions',2,1,0,1750754878,1750754878,0,0,'685a663ea700c',31,''),(344,1,'files_trashbin/files','3014a771cbe30761f2e9ff3272110dbf',339,'files',2,1,9123267,1750755226,1750755226,0,0,'685a679a1e990',31,''),(345,1,'files_trashbin/keys','9195c7cfc1b867f229ac78cc1b6a0be3',339,'keys',2,1,0,1750754878,1750754878,0,0,'685a663ea71a6',31,''),(347,2,'appdata_oc96sqf3by0w/theming/global/7/touchIcon-calendar#783CB2','0405ba723a8f760daa52ee99da1bfb7b',177,'touchIcon-calendar#783CB2',18,5,7654,1750754987,1750754987,0,0,'6b4d419274f7350683954f35be4f824e',27,''),(348,2,'appdata_oc96sqf3by0w/theming/global/7/touchIcon-photos#783CB2','6820e3d259a24908a131a0ecf9d0a20e',177,'touchIcon-photos#783CB2',18,5,11938,1750755212,1750755212,0,0,'fa3f5b6ef5e6ace0c9a3767846ac71e9',27,''),(349,2,'appdata_oc96sqf3by0w/preview/c/9/f/0/f/8/9/8/256-256-crop.jpg','c89b3d2fb56ba6c65965a95dfd198968',69,'256-256-crop.jpg',10,9,13880,1750755236,1750755236,0,0,'84bb7ac21ace08f89908abe1294f4747',27,''),(350,1,'files/S3 Cloud','89edae3276e161ca450bbf48cb37e821',2,'S3 Cloud',2,1,0,1750755256,1750755256,0,0,'685a67b880c65',31,''),(351,4,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,367118456,1750756209,1750756208,0,0,'685a6b71ccc26',31,''),(353,4,'assets','32bb636196f91ed59d7a49190e26b42c',351,'assets',2,1,0,1750755753,1750755753,0,0,'685a6b700c03d',31,''),(355,4,'data-nocoDB','8d4a2d25fb25369422eb80e49d8eb75f',351,'data-nocoDB',2,1,0,1750755753,1750755753,0,0,'685a6b6e4dba2',31,''),(356,4,'email','0c83f57c786a0b4a39efab23731c7ebc',351,'email',2,1,154117,1750756205,1750755754,0,0,'685a6b71ccc26',31,''),(357,4,'builder-delay.mp4','0afdb37a9a37cb94979daee6922acd39',351,'builder-delay.mp4',8,7,19784387,1750573796,1750573796,0,0,'038ec89a1029ca202c0bad94142d6a4f',27,''),(358,4,'nc-test-file.txt','308c09e6e1b53989ceda64fd589f51f4',351,'nc-test-file.txt',27,3,0,1750660077,1750660077,0,0,'d41d8cd98f00b204e9800998ecf8427e',27,''),(359,2,'appdata_oc96sqf3by0w/theming/global/7/touchIcon-core#783CB2','45f22d4ae12f0d49c0849f205d201c92',177,'touchIcon-core#783CB2',18,5,26254,1750756174,1750756174,0,0,'66cb1eca013b94415f748ee73f8974d2',27,''),(360,4,'email/icon-max.png','b775eafe79d7ea13f1e9b9c192446e18',356,'icon-max.png',11,9,90922,1750501480,1750501480,0,0,'6e522a76ed37688d82ad99b501874396',27,''),(361,4,'email/icon.svg','49d85448a46e96e9ffc9ce84e7d28001',356,'icon.svg',23,9,25141,1750501479,1750501479,0,0,'6c1d13456dc5a6a2319cc33df869750a',27,''),(362,4,'email/logo-full.png','6bed02425aafe4007959cc5d43fafca2',356,'logo-full.png',11,9,8151,1750501479,1750501479,0,0,'f5421f4740cc7231afa07b03b26f50bb',27,''),(363,4,'email/logo-full.svg','fd785ec0d6c894284f8b6e6a3af1f2fd',356,'logo-full.svg',23,9,10821,1750501479,1750501479,0,0,'6f474c02d722f53198f43e8f8408c442',27,''),(364,4,'email/thumb_icon-max.png','981628a265b31eccd94d64dd978c8ede',356,'thumb_icon-max.png',11,9,10527,1750501480,1750501480,0,0,'598c3f2d9b47bf97ae1e42b33d187b92',27,''),(365,4,'email/thumb_logo-full.png','d62c938dfb7957e8da095cc3ce393b86',356,'thumb_logo-full.png',11,9,8555,1750501480,1750501480,0,0,'9f8facaff75484db3a5495d16ad68f84',27,''),(366,4,'UI KIT Figma','13a4c30370d3bf7f8858b0c680dae5b9',351,'UI KIT Figma',2,1,347179952,1750756209,1750756208,0,0,'685a6b71ccc26',31,''),(367,4,'UI KIT Figma/Figma files','ab9ed3a21544c5951fc117d5c12d2a63',366,'Figma files',2,1,344804109,1750756209,1750756209,0,0,'685a6b71ccc26',31,''),(368,4,'UI KIT Figma/How to use this UI Kit to create a website.mp4','69e012ab630e24ac1c025a57eb8170cf',366,'How to use this UI Kit to create a website.mp4',8,7,2373237,1750755882,1750755882,0,0,'a22911e418dd00809429944b960d712d',27,''),(369,4,'UI KIT Figma/Terms of Use.rtf','856db2af9bb37b3a60bd0b963b16fbb4',366,'Terms of Use.rtf',28,3,2354,1750755883,1750755883,0,0,'6822d29d8f6138d0042a83d970d41742',27,''),(370,4,'UI KIT Figma/Use Blocks to create a website for FREE.webloc','8cce9204b620bd4e6f95b7a210faad6f',366,'Use Blocks to create a website for FREE.webloc',29,5,252,1750755884,1750755884,0,0,'0cfa4e330a59df0f0f1dac73856c527c',27,''),(371,4,'UI KIT Figma/Figma files/01 Hero.fig','147563b9747c052e50ba39df798e6212',367,'01 Hero.fig',18,5,161422842,1750755872,1750755872,0,0,'de6eb7c0b7c6c85a21d828722fad53f7',27,''),(372,4,'UI KIT Figma/Figma files/02 Features.fig','4d6b13e5e76d4d717261b0ea377ccb52',367,'02 Features.fig',18,5,62481077,1750755872,1750755872,0,0,'992c136f532063d85b76ff80325d0da1',27,''),(373,4,'UI KIT Figma/Figma files/03 Contact.fig','a90a749c6c5a26353142f68fd462865d',367,'03 Contact.fig',18,5,20214765,1750755873,1750755873,0,0,'30abb19f11d3b2761ef3daecb7a45111',27,''),(374,4,'UI KIT Figma/Figma files/04 Gallery.fig','da59bd8bd246a51a9a06c688cedc29ea',367,'04 Gallery.fig',18,5,31561703,1750755877,1750755877,0,0,'de3e3db9afb02a6dc1737dead0545d84',27,''),(375,4,'UI KIT Figma/Figma files/05 CTA.fig','6db1a667e81d2d926ac250afe819922c',367,'05 CTA.fig',18,5,19613496,1750755877,1750755877,0,0,'f7377f7701c80685c86c53fff2d9c935',27,''),(376,4,'UI KIT Figma/Figma files/06 Text.fig','84c6ddf17d54ba195cb8ac4e60d81bf6',367,'06 Text.fig',18,5,4369804,1750755878,1750755878,0,0,'796ae71544d45b3f40b6fdaadddc4c05',27,''),(377,4,'UI KIT Figma/Figma files/07 Team.fig','c07e2f1d1be94b31e71190ab94c77ca6',367,'07 Team.fig',18,5,32112802,1750755879,1750755879,0,0,'918272f1fdf16806b90bf8c46d3470d0',27,''),(378,4,'UI KIT Figma/Figma files/08 Pricing.fig','84654a1466dfa16a308656561cfd8285',367,'08 Pricing.fig',18,5,6932398,1750755879,1750755879,0,0,'45b3642defb9a6ed6cf3d4d29386f93b',27,''),(379,4,'UI KIT Figma/Figma files/09 Testimonials.fig','99556b93098199c2ea743adeeecbb1cb',367,'09 Testimonials.fig',18,5,6095222,1750755882,1750755882,0,0,'6ac989f307c5c5163aea747aa3fb95a3',27,'');
/*!40000 ALTER TABLE `oc_filecache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_filecache_extended`
--

DROP TABLE IF EXISTS `oc_filecache_extended`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_filecache_extended` (
  `fileid` bigint(20) unsigned NOT NULL,
  `metadata_etag` varchar(40) DEFAULT NULL,
  `creation_time` bigint(20) NOT NULL DEFAULT 0,
  `upload_time` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`fileid`),
  KEY `fce_ctime_idx` (`creation_time`),
  KEY `fce_utime_idx` (`upload_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_filecache_extended`
--

LOCK TABLES `oc_filecache_extended` WRITE;
/*!40000 ALTER TABLE `oc_filecache_extended` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_filecache_extended` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_files_metadata`
--

DROP TABLE IF EXISTS `oc_files_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_files_metadata` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_id` bigint(20) NOT NULL,
  `json` longtext NOT NULL,
  `sync_token` varchar(15) NOT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `files_meta_fileid` (`file_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_files_metadata`
--

LOCK TABLES `oc_files_metadata` WRITE;
/*!40000 ALTER TABLE `oc_files_metadata` DISABLE KEYS */;
INSERT INTO `oc_files_metadata` VALUES (1,6,'{\"photos-original_date_time\":{\"value\":1750060800,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0}}','ajc6vnC','2025-06-16 08:00:00'),(2,8,'{\"photos-original_date_time\":{\"value\":1341064060,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"photos-exif\":{\"value\":{\"ExposureTime\":\"1\\/640\",\"FNumber\":\"28\\/5\",\"ExposureProgram\":1,\"ISOSpeedRatings\":12800,\"ExifVersion\":\"0230\",\"DateTimeOriginal\":\"2012:06:30 13:47:40\",\"DateTimeDigitized\":\"2012:06:30 13:47:40\",\"ComponentsConfiguration\":\"\",\"ShutterSpeedValue\":\"75\\/8\",\"ApertureValue\":\"5\\/1\",\"ExposureBiasValue\":\"0\\/1\",\"MaxApertureValue\":\"6149\\/1087\",\"MeteringMode\":5,\"Flash\":16,\"FocalLength\":\"235\\/1\",\"SubSecTime\":\"00\",\"SubSecTimeOriginal\":\"00\",\"SubSecTimeDigitized\":\"00\",\"FlashPixVersion\":\"0100\",\"ExifImageWidth\":1600,\"ExifImageLength\":1067,\"FocalPlaneXResolution\":\"382423\\/97\",\"FocalPlaneYResolution\":\"134321\\/34\",\"FocalPlaneResolutionUnit\":2,\"CustomRendered\":0,\"ExposureMode\":1,\"WhiteBalance\":0,\"SceneCaptureType\":0},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"Make\":\"Canon\",\"Model\":\"Canon EOS 5D Mark III\",\"Orientation\":1,\"XResolution\":\"72\\/1\",\"YResolution\":\"72\\/1\",\"ResolutionUnit\":2,\"Software\":\"Aperture 3.3.1\",\"DateTime\":\"2012:06:30 13:47:40\",\"Exif_IFD_Pointer\":202},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1600,\"height\":1067},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"blurhash\":{\"value\":\"L87_1d~qM|Io%gt7oMxuE1M{%M?b\",\"type\":\"string\",\"etag\":\"cfbd0729de14bd051f140fe800fa8dad\",\"indexed\":false,\"editPermission\":0}}','TUXxzXK','2025-06-16 08:03:43'),(3,10,'{\"photos-original_date_time\":{\"value\":1341059531,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"photos-exif\":{\"value\":{\"ExposureTime\":\"1\\/125\",\"FNumber\":\"28\\/5\",\"ExposureProgram\":3,\"ISOSpeedRatings\":320,\"UndefinedTag__x____\":320,\"ExifVersion\":\"0230\",\"DateTimeOriginal\":\"2012:06:30 12:32:11\",\"DateTimeDigitized\":\"2012:06:30 12:32:11\",\"ComponentsConfiguration\":\"\",\"ShutterSpeedValue\":\"7\\/1\",\"ApertureValue\":\"5\\/1\",\"ExposureBiasValue\":\"0\\/1\",\"MaxApertureValue\":\"189284\\/33461\",\"MeteringMode\":5,\"Flash\":16,\"FocalLength\":\"280\\/1\",\"SubSecTime\":\"83\",\"SubSecTimeOriginal\":\"83\",\"SubSecTimeDigitized\":\"83\",\"FlashPixVersion\":\"0100\",\"ColorSpace\":1,\"ExifImageWidth\":1600,\"ExifImageLength\":1067,\"FocalPlaneXResolution\":\"1920000\\/487\",\"FocalPlaneYResolution\":\"320000\\/81\",\"FocalPlaneResolutionUnit\":2,\"CustomRendered\":0,\"ExposureMode\":0,\"WhiteBalance\":0,\"SceneCaptureType\":0,\"UndefinedTag__xA___\":\"0000000000\"},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"Make\":\"Canon\",\"Model\":\"Canon EOS 5D Mark III\",\"Orientation\":1,\"XResolution\":\"72\\/1\",\"YResolution\":\"72\\/1\",\"ResolutionUnit\":2,\"DateTime\":\"2012:06:30 12:32:11\",\"Exif_IFD_Pointer\":174},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1600,\"height\":1067},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"blurhash\":{\"value\":\"LKINpnRO4:RP_NnNIoV[%zRPNH%1\",\"type\":\"string\",\"etag\":\"631549779358cc08f36b06268943c3fb\",\"indexed\":false,\"editPermission\":0}}','WGH4OCw','2025-06-16 08:03:43'),(4,11,'{\"photos-original_date_time\":{\"value\":1444907264,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"photos-exif\":{\"value\":{\"ExposureTime\":\"1\\/320\",\"FNumber\":\"4\\/1\",\"ExposureProgram\":3,\"ISOSpeedRatings\":640,\"UndefinedTag__x____\":640,\"ExifVersion\":\"0230\",\"DateTimeOriginal\":\"2015:10:15 11:07:44\",\"DateTimeDigitized\":\"2015:10:15 11:07:44\",\"ShutterSpeedValue\":\"27970\\/3361\",\"ApertureValue\":\"4\\/1\",\"ExposureBiasValue\":\"1\\/3\",\"MaxApertureValue\":\"4\\/1\",\"MeteringMode\":5,\"Flash\":16,\"FocalLength\":\"200\\/1\",\"SubSecTimeOriginal\":\"63\",\"SubSecTimeDigitized\":\"63\",\"ColorSpace\":1,\"ExifImageWidth\":1600,\"ExifImageLength\":1067,\"FocalPlaneXResolution\":\"1600\\/1\",\"FocalPlaneYResolution\":\"1600\\/1\",\"FocalPlaneResolutionUnit\":3,\"CustomRendered\":0,\"ExposureMode\":0,\"WhiteBalance\":0,\"SceneCaptureType\":0,\"UndefinedTag__xA___\":\"000084121f\"},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"Make\":\"Canon\",\"Model\":\"Canon EOS 5D Mark III\",\"Orientation\":1,\"XResolution\":\"240\\/1\",\"YResolution\":\"240\\/1\",\"ResolutionUnit\":2,\"Software\":\"Adobe Photoshop Lightroom 6.2.1 (Macintosh)\",\"DateTime\":\"2015:10:16 14:40:21\",\"Exif_IFD_Pointer\":230},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1600,\"height\":1067},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"blurhash\":{\"value\":\"L6CQO}~V4?B,~jQp4XTc00EMi6vo\",\"type\":\"string\",\"etag\":\"2f5743960097bcf506382cc83e5b5b81\",\"indexed\":false,\"editPermission\":0}}','ySBZqBw','2025-06-16 08:03:43'),(5,12,'{\"photos-original_date_time\":{\"value\":1341258636,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"photos-exif\":{\"value\":{\"ExposureTime\":\"1\\/80\",\"FNumber\":\"4\\/1\",\"ExposureProgram\":3,\"ISOSpeedRatings\":400,\"ExifVersion\":\"0230\",\"DateTimeOriginal\":\"2012:07:02 19:50:36\",\"DateTimeDigitized\":\"2012:07:02 19:50:36\",\"ComponentsConfiguration\":\"\",\"ShutterSpeedValue\":\"51\\/8\",\"ApertureValue\":\"4\\/1\",\"ExposureBiasValue\":\"0\\/1\",\"MaxApertureValue\":\"4\\/1\",\"MeteringMode\":5,\"Flash\":16,\"FocalLength\":\"32\\/1\",\"SubSecTime\":\"00\",\"SubSecTimeOriginal\":\"00\",\"SubSecTimeDigitized\":\"00\",\"FlashPixVersion\":\"0100\",\"ColorSpace\":1,\"ExifImageWidth\":1600,\"ExifImageLength\":1066,\"FocalPlaneXResolution\":\"382423\\/97\",\"FocalPlaneYResolution\":\"185679\\/47\",\"FocalPlaneResolutionUnit\":2,\"CustomRendered\":0,\"ExposureMode\":0,\"WhiteBalance\":0,\"SceneCaptureType\":0},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"Make\":\"Canon\",\"Model\":\"Canon EOS 5D Mark III\",\"Orientation\":1,\"XResolution\":\"72\\/1\",\"YResolution\":\"72\\/1\",\"ResolutionUnit\":2,\"Software\":\"GIMP 2.8.0\",\"DateTime\":\"2012:07:02 22:06:14\",\"Exif_IFD_Pointer\":198},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1600,\"height\":1066},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"blurhash\":{\"value\":\"L4J*xMx]00~qnfoM%Mof9XjFoMD*\",\"type\":\"string\",\"etag\":\"c60156ecaa549ea7540d4281b6456a11\",\"indexed\":false,\"editPermission\":0}}','2hpqpuL','2025-06-16 08:03:43'),(6,13,'{\"photos-original_date_time\":{\"value\":1526500980,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"photos-exif\":{\"value\":{\"ExposureTime\":\"10\\/12500\",\"FNumber\":\"35\\/10\",\"ExposureProgram\":3,\"ISOSpeedRatings\":100,\"DateTimeOriginal\":\"2018:05:16 20:03:00\",\"DateTimeDigitized\":\"2018:05:16 20:03:00\",\"ExposureBiasValue\":\"0\\/6\",\"MaxApertureValue\":\"30\\/10\",\"MeteringMode\":5,\"LightSource\":0,\"Flash\":16,\"FocalLength\":\"700\\/10\",\"MakerNote\":\"Nikon\",\"UserComment\":\"Christoph WurstCC-SA 4.0\",\"SubSecTime\":\"30\",\"SubSecTimeOriginal\":\"30\",\"SubSecTimeDigitized\":\"30\",\"ColorSpace\":1,\"SensingMethod\":2,\"FileSource\":\"\",\"SceneType\":\"\",\"CustomRendered\":0,\"ExposureMode\":0,\"WhiteBalance\":0,\"DigitalZoomRatio\":\"1\\/1\",\"FocalLengthIn__mmFilm\":70,\"SceneCaptureType\":0,\"GainControl\":0,\"Contrast\":1,\"Saturation\":0,\"Sharpness\":1,\"SubjectDistanceRange\":0},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"ImageDescription\":\"Christoph WurstCC-SA 4.0\",\"Make\":\"NIKON CORPORATION\",\"Model\":\"NIKON D610\",\"Orientation\":1,\"XResolution\":\"72\\/1\",\"YResolution\":\"72\\/1\",\"ResolutionUnit\":2,\"Software\":\"GIMP 2.10.14\",\"DateTime\":\"2019:12:10 08:51:16\",\"Artist\":\"Christoph Wurst                     \",\"Copyright\":\"Christoph Wurst                                       \",\"Exif_IFD_Pointer\":402,\"GPS_IFD_Pointer\":13738,\"DateTimeOriginal\":\"2018:05:16 20:03:00\"},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1920,\"height\":1281},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"blurhash\":{\"value\":\"LXCigUWB0ft6~VWB9Gs:-;WBMxof\",\"type\":\"string\",\"etag\":\"5bbf8341c6b5a1fc90f12c9aeb00aaad\",\"indexed\":false,\"editPermission\":0}}','D7V71aP','2025-06-16 08:03:43'),(7,14,'{\"photos-original_date_time\":{\"value\":1372319469,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"photos-exif\":{\"value\":{\"ExposureTime\":\"1\\/160\",\"FNumber\":\"4\\/1\",\"ExposureProgram\":3,\"ISOSpeedRatings\":100,\"ExifVersion\":\"0230\",\"DateTimeOriginal\":\"2013:06:27 07:51:09\",\"DateTimeDigitized\":\"2013:06:27 07:51:09\",\"ComponentsConfiguration\":\"\",\"ShutterSpeedValue\":\"59\\/8\",\"ApertureValue\":\"4\\/1\",\"ExposureBiasValue\":\"2\\/3\",\"MaxApertureValue\":\"4\\/1\",\"MeteringMode\":5,\"Flash\":16,\"FocalLength\":\"45\\/1\",\"SubSecTime\":\"00\",\"SubSecTimeOriginal\":\"00\",\"SubSecTimeDigitized\":\"00\",\"FlashPixVersion\":\"0100\",\"ColorSpace\":1,\"ExifImageWidth\":1200,\"ExifImageLength\":1800,\"FocalPlaneXResolution\":\"382423\\/97\",\"FocalPlaneYResolution\":\"185679\\/47\",\"FocalPlaneResolutionUnit\":2,\"CustomRendered\":0,\"ExposureMode\":0,\"WhiteBalance\":0,\"SceneCaptureType\":0,\"UndefinedTag__xA___\":\"000052602c\"},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"Make\":\"Canon\",\"Model\":\"Canon EOS 5D Mark III\",\"Orientation\":1,\"XResolution\":\"72\\/1\",\"YResolution\":\"72\\/1\",\"ResolutionUnit\":2,\"Software\":\"Aperture 3.4.5\",\"DateTime\":\"2013:06:27 07:51:09\",\"Exif_IFD_Pointer\":202},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1200,\"height\":1800},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"blurhash\":{\"value\":\"LZJ$~jNyIqj]u6SPWBoM76s:oJj]\",\"type\":\"string\",\"etag\":\"88900d8a8099e3292f3e927c0a74a43c\",\"indexed\":false,\"editPermission\":0}}','JSQMG8Z','2025-06-16 08:03:44'),(8,15,'{\"photos-original_date_time\":{\"value\":1750060800,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":3000,\"height\":2000},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"blurhash\":{\"value\":\"LKECzlxa8_s..8t6Mwt7~qWAadxu\",\"type\":\"string\",\"etag\":\"a0a004984298613e4d87da761e5da26d\",\"indexed\":false,\"editPermission\":0}}','XVBhpG3','2025-06-16 08:03:44'),(9,16,'{\"photos-original_date_time\":{\"value\":1341072915,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"photos-exif\":{\"value\":{\"ExposureTime\":\"1\\/500\",\"FNumber\":\"28\\/5\",\"ExposureProgram\":1,\"ISOSpeedRatings\":8000,\"ExifVersion\":\"0230\",\"DateTimeOriginal\":\"2012:06:30 16:15:15\",\"DateTimeDigitized\":\"2012:06:30 16:15:15\",\"ComponentsConfiguration\":\"\",\"ShutterSpeedValue\":\"9\\/1\",\"ApertureValue\":\"5\\/1\",\"ExposureBiasValue\":\"0\\/1\",\"MaxApertureValue\":\"6149\\/1087\",\"MeteringMode\":5,\"Flash\":16,\"FocalLength\":\"280\\/1\",\"SubSecTime\":\"00\",\"SubSecTimeOriginal\":\"00\",\"SubSecTimeDigitized\":\"00\",\"FlashPixVersion\":\"0100\",\"ColorSpace\":1,\"ExifImageWidth\":1600,\"ExifImageLength\":1067,\"FocalPlaneXResolution\":\"382423\\/97\",\"FocalPlaneYResolution\":\"134321\\/34\",\"FocalPlaneResolutionUnit\":2,\"CustomRendered\":0,\"ExposureMode\":1,\"WhiteBalance\":0,\"SceneCaptureType\":0},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-ifd0\":{\"value\":{\"Make\":\"Canon\",\"Model\":\"Canon EOS 5D Mark III\",\"Orientation\":1,\"XResolution\":\"72\\/1\",\"YResolution\":\"72\\/1\",\"ResolutionUnit\":2,\"Software\":\"Aperture 3.3.1\",\"DateTime\":\"2012:06:30 16:15:15\",\"Exif_IFD_Pointer\":202},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":1600,\"height\":1067},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"blurhash\":{\"value\":\"LRFEu.MxI[Ip~AR*WDj@Iqj[xZxY\",\"type\":\"string\",\"etag\":\"20437064194ab1eaf5663887fa86cc28\",\"indexed\":false,\"editPermission\":0}}','sY7k8UW','2025-06-16 08:03:44'),(10,18,'{\"photos-original_date_time\":{\"value\":1750060800,\"type\":\"int\",\"etag\":\"\",\"indexed\":true,\"editPermission\":0},\"photos-size\":{\"value\":{\"width\":500,\"height\":500},\"type\":\"array\",\"etag\":\"\",\"indexed\":false,\"editPermission\":0},\"blurhash\":{\"value\":\"LKBPq}iu9bfm.TayRlj[04ae-nbI\",\"type\":\"string\",\"etag\":\"390d435df9ee5eeddda99047278b4b6d\",\"indexed\":false,\"editPermission\":0}}','Ah7uD4T','2025-06-16 08:03:44');
/*!40000 ALTER TABLE `oc_files_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_files_metadata_index`
--

DROP TABLE IF EXISTS `oc_files_metadata_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_files_metadata_index` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_id` bigint(20) NOT NULL,
  `meta_key` varchar(31) DEFAULT NULL,
  `meta_value_string` varchar(63) DEFAULT NULL,
  `meta_value_int` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `f_meta_index` (`file_id`,`meta_key`,`meta_value_string`),
  KEY `f_meta_index_i` (`file_id`,`meta_key`,`meta_value_int`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_files_metadata_index`
--

LOCK TABLES `oc_files_metadata_index` WRITE;
/*!40000 ALTER TABLE `oc_files_metadata_index` DISABLE KEYS */;
INSERT INTO `oc_files_metadata_index` VALUES (1,6,'photos-original_date_time',NULL,1750060800),(20,8,'photos-original_date_time',NULL,1341064060),(21,10,'photos-original_date_time',NULL,1341059531),(22,11,'photos-original_date_time',NULL,1444907264),(23,12,'photos-original_date_time',NULL,1341258636),(24,13,'photos-original_date_time',NULL,1526500980),(25,14,'photos-original_date_time',NULL,1372319469),(26,15,'photos-original_date_time',NULL,1750060800),(27,16,'photos-original_date_time',NULL,1341072915),(28,18,'photos-original_date_time',NULL,1750060800);
/*!40000 ALTER TABLE `oc_files_metadata_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_files_reminders`
--

DROP TABLE IF EXISTS `oc_files_reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_files_reminders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL,
  `file_id` bigint(20) unsigned NOT NULL,
  `due_date` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `notified` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reminders_uniq_idx` (`user_id`,`file_id`,`due_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_files_reminders`
--

LOCK TABLES `oc_files_reminders` WRITE;
/*!40000 ALTER TABLE `oc_files_reminders` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_files_reminders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_files_swarm`
--

DROP TABLE IF EXISTS `oc_files_swarm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_files_swarm` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `storage` bigint(20) NOT NULL,
  `name` varchar(250) DEFAULT NULL,
  `swarm_reference` varchar(250) DEFAULT NULL,
  `mimetype` bigint(20) NOT NULL DEFAULT 0,
  `size` bigint(20) NOT NULL DEFAULT 0,
  `storage_mtime` bigint(20) NOT NULL DEFAULT 0,
  `visibility` bigint(20) NOT NULL DEFAULT 1,
  `token` varchar(64) NOT NULL DEFAULT 'none',
  PRIMARY KEY (`id`),
  KEY `storage_index` (`storage`),
  KEY `hejbit_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_files_swarm`
--

LOCK TABLES `oc_files_swarm` WRITE;
/*!40000 ALTER TABLE `oc_files_swarm` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_files_swarm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_files_trash`
--

DROP TABLE IF EXISTS `oc_files_trash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_files_trash` (
  `auto_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id` varchar(250) NOT NULL DEFAULT '',
  `user` varchar(64) NOT NULL DEFAULT '',
  `timestamp` varchar(12) NOT NULL DEFAULT '',
  `location` varchar(512) NOT NULL DEFAULT '',
  `type` varchar(4) DEFAULT NULL,
  `mime` varchar(255) DEFAULT NULL,
  `deleted_by` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`auto_id`),
  KEY `id_index` (`id`),
  KEY `timestamp_index` (`timestamp`),
  KEY `user_index` (`user`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_files_trash`
--

LOCK TABLES `oc_files_trash` WRITE;
/*!40000 ALTER TABLE `oc_files_trash` DISABLE KEYS */;
INSERT INTO `oc_files_trash` VALUES (1,'Nextcloud intro.mp4','Landing Pad Digital','1750754878','.',NULL,NULL,'Landing Pad Digital'),(2,'Templates credits.md','Landing Pad Digital','1750754878','.',NULL,NULL,'Landing Pad Digital'),(3,'Readme.md','Landing Pad Digital','1750754878','.',NULL,NULL,'Landing Pad Digital'),(4,'Nextcloud.png','Landing Pad Digital','1750754878','.',NULL,NULL,'Landing Pad Digital'),(5,'Reasons to use Nextcloud.pdf','Landing Pad Digital','1750754878','.',NULL,NULL,'Landing Pad Digital'),(6,'Steps.jpg','Landing Pad Digital','1750755226','Photos',NULL,NULL,'Landing Pad Digital'),(7,'Toucan.jpg','Landing Pad Digital','1750755226','Photos',NULL,NULL,'Landing Pad Digital'),(8,'Library.jpg','Landing Pad Digital','1750755226','Photos',NULL,NULL,'Landing Pad Digital'),(9,'Nextcloud community.jpg','Landing Pad Digital','1750755226','Photos',NULL,NULL,'Landing Pad Digital'),(10,'Vineyard.jpg','Landing Pad Digital','1750755226','Photos',NULL,NULL,'Landing Pad Digital');
/*!40000 ALTER TABLE `oc_files_trash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_files_versions`
--

DROP TABLE IF EXISTS `oc_files_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_files_versions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_id` bigint(20) NOT NULL,
  `timestamp` bigint(20) NOT NULL,
  `size` bigint(20) NOT NULL,
  `mimetype` bigint(20) NOT NULL,
  `metadata` longtext NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`metadata`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `files_versions_uniq_index` (`file_id`,`timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_files_versions`
--

LOCK TABLES `oc_files_versions` WRITE;
/*!40000 ALTER TABLE `oc_files_versions` DISABLE KEYS */;
INSERT INTO `oc_files_versions` VALUES (5,8,1750060800,474653,10,'{\"author\":\"Landing Pad Digital\"}'),(6,9,1750060800,150,4,'{\"author\":\"Landing Pad Digital\"}'),(7,10,1750060800,593508,10,'{\"author\":\"Landing Pad Digital\"}'),(13,16,1750060800,457744,10,'{\"author\":\"Landing Pad Digital\"}'),(14,17,1750060800,13175467,6,'{\"author\":\"Landing Pad Digital\"}'),(16,20,1750060800,35657,12,'{\"author\":\"Landing Pad Digital\"}'),(17,21,1750060800,14810,13,'{\"author\":\"Landing Pad Digital\"}'),(18,22,1750060800,30780,12,'{\"author\":\"Landing Pad Digital\"}'),(19,23,1750060801,868111,14,'{\"author\":\"Landing Pad Digital\"}'),(20,24,1750060801,13653,15,'{\"author\":\"Landing Pad Digital\"}'),(21,25,1750060801,554,4,'{\"author\":\"Landing Pad Digital\"}'),(22,26,1750060801,14316,13,'{\"author\":\"Landing Pad Digital\"}'),(23,27,1750060801,30354,14,'{\"author\":\"Landing Pad Digital\"}'),(24,28,1750060801,317015,13,'{\"author\":\"Landing Pad Digital\"}'),(25,29,1750060801,13441,16,'{\"author\":\"Landing Pad Digital\"}'),(26,30,1750060801,25621,12,'{\"author\":\"Landing Pad Digital\"}'),(27,31,1750060802,45778,12,'{\"author\":\"Landing Pad Digital\"}'),(28,32,1750060802,27629,12,'{\"author\":\"Landing Pad Digital\"}'),(29,33,1750060803,340061,14,'{\"author\":\"Landing Pad Digital\"}'),(30,34,1750060803,11836,15,'{\"author\":\"Landing Pad Digital\"}'),(31,35,1750060803,39404,14,'{\"author\":\"Landing Pad Digital\"}'),(32,36,1750060804,30671,12,'{\"author\":\"Landing Pad Digital\"}'),(33,37,1750060804,5155877,14,'{\"author\":\"Landing Pad Digital\"}'),(34,38,1750060804,30290,12,'{\"author\":\"Landing Pad Digital\"}'),(35,39,1750060804,326,4,'{\"author\":\"Landing Pad Digital\"}'),(36,40,1750060804,31325,12,'{\"author\":\"Landing Pad Digital\"}'),(37,41,1750060804,17276,14,'{\"author\":\"Landing Pad Digital\"}'),(38,42,1750060804,52843,16,'{\"author\":\"Landing Pad Digital\"}'),(39,43,1750060804,23359,12,'{\"author\":\"Landing Pad Digital\"}'),(40,44,1750060804,88394,16,'{\"author\":\"Landing Pad Digital\"}'),(41,45,1750060804,3509628,13,'{\"author\":\"Landing Pad Digital\"}'),(42,46,1750060804,15961,14,'{\"author\":\"Landing Pad Digital\"}'),(43,47,1750060804,13378,16,'{\"author\":\"Landing Pad Digital\"}'),(44,48,1750060804,31132,12,'{\"author\":\"Landing Pad Digital\"}'),(45,49,1750060804,573,4,'{\"author\":\"Landing Pad Digital\"}'),(46,50,1750060804,16988,15,'{\"author\":\"Landing Pad Digital\"}'),(47,51,1750060804,13878,15,'{\"author\":\"Landing Pad Digital\"}'),(48,52,1750060805,81196,13,'{\"author\":\"Landing Pad Digital\"}'),(49,54,1750060805,136,4,'{\"author\":\"Landing Pad Digital\"}'),(50,55,1750060805,1083339,6,'{\"author\":\"Landing Pad Digital\"}'),(51,56,1750060805,23876,17,'{\"author\":\"Landing Pad Digital\"}'),(52,57,1750060805,1095,4,'{\"author\":\"Landing Pad Digital\"}');
/*!40000 ALTER TABLE `oc_files_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_flow_checks`
--

DROP TABLE IF EXISTS `oc_flow_checks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_flow_checks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(256) NOT NULL DEFAULT '',
  `operator` varchar(16) NOT NULL DEFAULT '',
  `value` longtext DEFAULT NULL,
  `hash` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `flow_unique_hash` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_flow_checks`
--

LOCK TABLES `oc_flow_checks` WRITE;
/*!40000 ALTER TABLE `oc_flow_checks` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_flow_checks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_flow_operations`
--

DROP TABLE IF EXISTS `oc_flow_operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_flow_operations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(256) NOT NULL DEFAULT '',
  `name` varchar(256) DEFAULT '',
  `checks` longtext DEFAULT NULL,
  `operation` longtext DEFAULT NULL,
  `entity` varchar(256) NOT NULL DEFAULT 'OCA\\WorkflowEngine\\Entity\\File',
  `events` longtext NOT NULL DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_flow_operations`
--

LOCK TABLES `oc_flow_operations` WRITE;
/*!40000 ALTER TABLE `oc_flow_operations` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_flow_operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_flow_operations_scope`
--

DROP TABLE IF EXISTS `oc_flow_operations_scope`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_flow_operations_scope` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `operation_id` int(11) NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `value` varchar(64) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `flow_unique_scope` (`operation_id`,`type`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_flow_operations_scope`
--

LOCK TABLES `oc_flow_operations_scope` WRITE;
/*!40000 ALTER TABLE `oc_flow_operations_scope` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_flow_operations_scope` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_group_admin`
--

DROP TABLE IF EXISTS `oc_group_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_group_admin` (
  `gid` varchar(64) NOT NULL DEFAULT '',
  `uid` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`,`uid`),
  KEY `group_admin_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_group_admin`
--

LOCK TABLES `oc_group_admin` WRITE;
/*!40000 ALTER TABLE `oc_group_admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_group_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_group_user`
--

DROP TABLE IF EXISTS `oc_group_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_group_user` (
  `gid` varchar(64) NOT NULL DEFAULT '',
  `uid` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`,`uid`),
  KEY `gu_uid_index` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_group_user`
--

LOCK TABLES `oc_group_user` WRITE;
/*!40000 ALTER TABLE `oc_group_user` DISABLE KEYS */;
INSERT INTO `oc_group_user` VALUES ('admin','Landing Pad Digital');
/*!40000 ALTER TABLE `oc_group_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_groups`
--

DROP TABLE IF EXISTS `oc_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_groups` (
  `gid` varchar(64) NOT NULL DEFAULT '',
  `displayname` varchar(255) NOT NULL DEFAULT 'name',
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_groups`
--

LOCK TABLES `oc_groups` WRITE;
/*!40000 ALTER TABLE `oc_groups` DISABLE KEYS */;
INSERT INTO `oc_groups` VALUES ('admin','admin');
/*!40000 ALTER TABLE `oc_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_jobs`
--

DROP TABLE IF EXISTS `oc_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(255) NOT NULL DEFAULT '',
  `argument` varchar(4000) NOT NULL DEFAULT '',
  `last_run` int(11) DEFAULT 0,
  `last_checked` int(11) DEFAULT 0,
  `reserved_at` int(11) DEFAULT 0,
  `execution_duration` int(11) DEFAULT 0,
  `argument_hash` varchar(64) DEFAULT NULL,
  `time_sensitive` smallint(6) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `job_class_index` (`class`),
  KEY `job_lastcheck_reserved` (`last_checked`,`reserved_at`),
  KEY `job_argument_hash` (`class`,`argument_hash`),
  KEY `jobs_time_sensitive` (`time_sensitive`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_jobs`
--

LOCK TABLES `oc_jobs` WRITE;
/*!40000 ALTER TABLE `oc_jobs` DISABLE KEYS */;
INSERT INTO `oc_jobs` VALUES (1,'OCA\\ServerInfo\\Jobs\\UpdateStorageStats','null',1750986601,1750997401,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(2,'OCA\\UpdateNotification\\BackgroundJob\\UpdateAvailableNotifications','null',1750916400,1751002800,0,218,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(3,'OCA\\AppAPI\\BackgroundJob\\ExAppInitStatusCheckJob','null',1750997101,1750997161,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(4,'OCA\\AppAPI\\BackgroundJob\\ProvidersAICleanUpJob','null',1750916618,1751003018,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(5,'OCA\\Activity\\BackgroundJob\\EmailNotification','null',1750997101,1750997102,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(6,'OCA\\Activity\\BackgroundJob\\ExpireActivities','null',1750916618,1751003018,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(7,'OCA\\Activity\\BackgroundJob\\DigestMail','null',1750995301,1750998901,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(8,'OCA\\Activity\\BackgroundJob\\RemoveFormerActivitySettings','null',1750916618,1751003018,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(9,'OCA\\Circles\\Cron\\Maintenance','null',1750997101,1750997111,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(10,'OCA\\Text\\Cron\\Cleanup','null',1750997101,1750997401,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(11,'OCA\\WorkflowEngine\\BackgroundJobs\\Rotate','null',1750986900,1750997700,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(12,'OCA\\UserStatus\\BackgroundJob\\ClearOldStatusesBackgroundJob','null',1750997101,1750997101,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(13,'OCA\\NextcloudAnnouncements\\Cron\\Crawler','null',1750921800,1751010120,0,18,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(14,'OCA\\Files\\BackgroundJob\\ScanFiles','null',1750996501,1750997101,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(15,'OCA\\Files\\BackgroundJob\\DeleteOrphanedItems','null',1750996201,1750999801,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(16,'OCA\\Files\\BackgroundJob\\CleanupFileLocks','null',1750996801,1750997101,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(17,'OCA\\Files\\BackgroundJob\\CleanupDirectEditingTokens','null',1750996801,1750997701,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(18,'OCA\\Files\\BackgroundJob\\DeleteExpiredOpenLocalEditor','null',1750960500,1751003700,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(19,'OCA\\DAV\\BackgroundJob\\CleanupDirectLinksJob','null',1750916618,1751003018,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(20,'OCA\\DAV\\BackgroundJob\\UpdateCalendarResourcesRoomsBackgroundJob','null',1750996201,1750999801,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(21,'OCA\\DAV\\BackgroundJob\\CleanupInvitationTokenJob','null',1750916618,1751003018,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(22,'OCA\\DAV\\BackgroundJob\\EventReminderJob','null',1750996801,1750997101,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(23,'OCA\\DAV\\BackgroundJob\\CalendarRetentionJob','null',1750983600,1751005200,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(24,'OCA\\DAV\\BackgroundJob\\PruneOutdatedSyncTokensJob','null',1750916618,1751003018,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(25,'OCA\\Photos\\Jobs\\AutomaticPlaceMapperJob','null',1750916618,1751003018,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(26,'OCA\\Files_Trashbin\\BackgroundJob\\ExpireTrash','null',1750996501,1750998301,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(27,'OCA\\Notifications\\BackgroundJob\\GenerateUserSettings','null',1750916618,1751003018,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(28,'OCA\\Notifications\\BackgroundJob\\SendNotificationMails','null',1750997101,1750997101,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(29,'OCA\\Federation\\SyncJob','null',1750916618,1751003018,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(30,'OCA\\OAuth2\\BackgroundJob\\CleanupExpiredAuthorizationCode','null',1750061023,1751088900,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(31,'OCA\\Files_Versions\\BackgroundJob\\ExpireVersions','null',1750996501,1750998301,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(32,'OCA\\Files_Sharing\\DeleteOrphanedSharesJob','null',1750916618,1751003018,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(33,'OCA\\Files_Sharing\\ExpireSharesJob','null',1750916618,1751003018,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(34,'OCA\\Files_Sharing\\SharesReminderJob','null',1750996201,1750999801,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(35,'OCA\\Files_Sharing\\BackgroundJob\\FederatedSharesDiscoverJob','null',1750916618,1751003018,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(36,'OCA\\Support\\BackgroundJobs\\CheckSubscription','null',1750996801,1750997101,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(37,'OCA\\ContactsInteraction\\BackgroundJob\\CleanupJob','null',1750916618,1751003018,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(38,'OCA\\FilesReminders\\BackgroundJob\\CleanUpReminders','null',1750916618,1751003018,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(39,'OCA\\FilesReminders\\BackgroundJob\\ScheduledNotifications','null',1750997101,1750997101,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(40,'OC\\Authentication\\Token\\TokenCleanupJob','null',1750916618,1751003018,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(41,'OC\\Log\\Rotate','null',1750997101,1750997101,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(42,'OC\\Preview\\BackgroundCleanupJob','null',1750996201,1750999801,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(43,'OC\\TextProcessing\\RemoveOldTasksBackgroundJob','null',1750916618,1751003018,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(44,'OC\\User\\BackgroundJobs\\CleanupDeletedUsers','null',1750916618,1751003018,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(45,'OC\\Core\\BackgroundJobs\\GenerateMetadataJob','null',1750916618,1751003018,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(100,'OCA\\Appointments\\Cron\\Reminders','null',1750996201,1750997101,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',1),(101,'OCA\\Calendar\\BackgroundJob\\CleanUpOutdatedBookingsJob','null',1750928100,1751014500,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(102,'OCA\\Contacts\\Cron\\SocialUpdateRegistration','null',1750755000,1751101200,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0),(105,'OCA\\Files_External\\BackgroundJob\\CredentialsCleanup','null',1750928700,1751015100,0,0,'74234e98afe7498fb5daf1f36ac2d78acc339464f950703b8c019892f982b90b',0);
/*!40000 ALTER TABLE `oc_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_known_users`
--

DROP TABLE IF EXISTS `oc_known_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_known_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `known_to` varchar(255) NOT NULL,
  `known_user` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ku_known_to` (`known_to`),
  KEY `ku_known_user` (`known_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_known_users`
--

LOCK TABLES `oc_known_users` WRITE;
/*!40000 ALTER TABLE `oc_known_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_known_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_login_flow_v2`
--

DROP TABLE IF EXISTS `oc_login_flow_v2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_login_flow_v2` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` bigint(20) unsigned NOT NULL,
  `started` smallint(5) unsigned NOT NULL DEFAULT 0,
  `poll_token` varchar(255) NOT NULL,
  `login_token` varchar(255) NOT NULL,
  `public_key` text NOT NULL,
  `private_key` text NOT NULL,
  `client_name` varchar(255) NOT NULL,
  `login_name` varchar(255) DEFAULT NULL,
  `server` varchar(255) DEFAULT NULL,
  `app_password` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `poll_token` (`poll_token`),
  UNIQUE KEY `login_token` (`login_token`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_login_flow_v2`
--

LOCK TABLES `oc_login_flow_v2` WRITE;
/*!40000 ALTER TABLE `oc_login_flow_v2` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_login_flow_v2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_migrations`
--

DROP TABLE IF EXISTS `oc_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_migrations` (
  `app` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`app`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_migrations`
--

LOCK TABLES `oc_migrations` WRITE;
/*!40000 ALTER TABLE `oc_migrations` DISABLE KEYS */;
INSERT INTO `oc_migrations` VALUES ('activity','2006Date20170808154933'),('activity','2006Date20170808155040'),('activity','2006Date20170919095939'),('activity','2007Date20181107114613'),('activity','2008Date20181011095117'),('activity','2010Date20190416112817'),('activity','2011Date20201006132544'),('activity','2011Date20201006132545'),('activity','2011Date20201006132546'),('activity','2011Date20201006132547'),('activity','2011Date20201207091915'),('app_api','032001Date20250115164140'),('app_api','1000Date202305221555'),('app_api','1004Date202311061844'),('app_api','1005Date202312271744'),('app_api','1006Date202401011308'),('app_api','1007Date202401111030'),('app_api','1008Date202401121205'),('app_api','2000Date20240120094952'),('app_api','2005Date20240209094951'),('app_api','2200Date20240216164351'),('app_api','2201Date20240221124152'),('app_api','2203Date20240325124149'),('app_api','2204Date20240401104001'),('app_api','2204Date20240403125002'),('app_api','2205Date20240411124836'),('app_api','2206Date20240502145029'),('app_api','2207Date20240502145029'),('app_api','2700Date20240515092246'),('app_api','2800Date20240710220000'),('app_api','2800Date20240711080316'),('app_api','3000Date20240715170800'),('app_api','3000Date20240807085759'),('app_api','3100Date20240822080316'),('app_api','3200Date20240905080316'),('app_api','5000Date20241120135411'),('app_api','5000Date20250109163201'),('appointments','010201Date20200404181716'),('appointments','010201Date20201227000005'),('appointments','010201Date20201227000006'),('appointments','010201Date20210919000001'),('appointments','010201Date20211126000001'),('appointments','010201Date20211211000004'),('appointments','010201Date20220102000001'),('appointments','020000Date20240221T001'),('appointments','020008Date20240424T001'),('appointments','020200Date20241110T001'),('calendar','2040Date20210908101001'),('calendar','3000Date20211109132439'),('calendar','3010Date20220111090252'),('calendar','4050Date20230614163505'),('circles','0022Date20220526111723'),('circles','0022Date20220526113601'),('circles','0022Date20220703115023'),('circles','0023Date20211216113101'),('circles','0024Date20220203123901'),('circles','0024Date20220203123902'),('circles','0024Date20220317190331'),('circles','0028Date20230705222601'),('circles','0031Date20241105133904'),('contactsinteraction','010000Date20200304152605'),('core','13000Date20170705121758'),('core','13000Date20170718121200'),('core','13000Date20170814074715'),('core','13000Date20170919121250'),('core','13000Date20170926101637'),('core','14000Date20180129121024'),('core','14000Date20180404140050'),('core','14000Date20180516101403'),('core','14000Date20180518120534'),('core','14000Date20180522074438'),('core','14000Date20180626223656'),('core','14000Date20180710092004'),('core','14000Date20180712153140'),('core','15000Date20180926101451'),('core','15000Date20181015062942'),('core','15000Date20181029084625'),('core','16000Date20190207141427'),('core','16000Date20190212081545'),('core','16000Date20190427105638'),('core','16000Date20190428150708'),('core','17000Date20190514105811'),('core','18000Date20190920085628'),('core','18000Date20191014105105'),('core','18000Date20191204114856'),('core','19000Date20200211083441'),('core','20000Date20201109081915'),('core','20000Date20201109081918'),('core','20000Date20201109081919'),('core','20000Date20201111081915'),('core','21000Date20201120141228'),('core','21000Date20201202095923'),('core','21000Date20210119195004'),('core','21000Date20210309185126'),('core','21000Date20210309185127'),('core','22000Date20210216080825'),('core','23000Date20210721100600'),('core','23000Date20210906132259'),('core','23000Date20210930122352'),('core','23000Date20211203110726'),('core','23000Date20211213203940'),('core','24000Date20211210141942'),('core','24000Date20211213081506'),('core','24000Date20211213081604'),('core','24000Date20211222112246'),('core','24000Date20211230140012'),('core','24000Date20220131153041'),('core','24000Date20220202150027'),('core','24000Date20220404230027'),('core','24000Date20220425072957'),('core','25000Date20220515204012'),('core','25000Date20220602190540'),('core','25000Date20220905140840'),('core','25000Date20221007010957'),('core','27000Date20220613163520'),('core','27000Date20230309104325'),('core','27000Date20230309104802'),('core','28000Date20230616104802'),('core','28000Date20230728104802'),('core','28000Date20230803221055'),('core','28000Date20230906104802'),('core','28000Date20231004103301'),('core','28000Date20231103104802'),('core','28000Date20231126110901'),('core','28000Date20240828142927'),('core','29000Date20231126110901'),('core','29000Date20231213104850'),('core','29000Date20240124132201'),('core','29000Date20240124132202'),('core','29000Date20240131122720'),('core','30000Date20240429122720'),('core','30000Date20240708160048'),('core','30000Date20240717111406'),('core','30000Date20240814180800'),('core','30000Date20240815080800'),('core','30000Date20240906095113'),('core','31000Date20240101084401'),('core','31000Date20240814184402'),('core','31000Date20250213102442'),('dav','1004Date20170825134824'),('dav','1004Date20170919104507'),('dav','1004Date20170924124212'),('dav','1004Date20170926103422'),('dav','1005Date20180413093149'),('dav','1005Date20180530124431'),('dav','1006Date20180619154313'),('dav','1006Date20180628111625'),('dav','1008Date20181030113700'),('dav','1008Date20181105104826'),('dav','1008Date20181105104833'),('dav','1008Date20181105110300'),('dav','1008Date20181105112049'),('dav','1008Date20181114084440'),('dav','1011Date20190725113607'),('dav','1011Date20190806104428'),('dav','1012Date20190808122342'),('dav','1016Date20201109085907'),('dav','1017Date20210216083742'),('dav','1018Date20210312100735'),('dav','1024Date20211221144219'),('dav','1025Date20240308063933'),('dav','1027Date20230504122946'),('dav','1029Date20221114151721'),('dav','1029Date20231004091403'),('dav','1030Date20240205103243'),('dav','1031Date20240610134258'),('federatedfilesharing','1010Date20200630191755'),('federatedfilesharing','1011Date20201120125158'),('federation','1010Date20200630191302'),('files','11301Date20191205150729'),('files','12101Date20221011153334'),('files','2003Date20241021095629'),('files_downloadlimit','000000Date20210910094923'),('files_external','1011Date20200630192246'),('files_external','1015Date20211104103506'),('files_external','1016Date20220324154536'),('files_external','22000Date20210216084416'),('files_external_ethswarm','0001Date202204071430'),('files_external_ethswarm','0002Date202409251430'),('files_external_ethswarm','0003Date202401101430'),('files_external_ethswarm','0004Date202410131430'),('files_external_ethswarm','0005Date202411081430'),('files_reminders','10000Date20230725162149'),('files_sharing','11300Date20201120141438'),('files_sharing','21000Date20201223143245'),('files_sharing','22000Date20210216084241'),('files_sharing','24000Date20220208195521'),('files_sharing','24000Date20220404142216'),('files_sharing','31000Date20240821142813'),('files_trashbin','1010Date20200630192639'),('files_trashbin','1020Date20240403003535'),('files_versions','1020Date20221114144058'),('notifications','2004Date20190107135757'),('notifications','2010Date20210218082811'),('notifications','2010Date20210218082855'),('notifications','2011Date20210930134607'),('notifications','2011Date20220826074907'),('oauth2','010401Date20181207190718'),('oauth2','010402Date20190107124745'),('oauth2','011601Date20230522143227'),('oauth2','011602Date20230613160650'),('oauth2','011603Date20230620111039'),('oauth2','011901Date20240829164356'),('photos','20000Date20220727125801'),('photos','20001Date20220830131446'),('photos','20003Date20221102170153'),('photos','20003Date20221103094628'),('photos','30000Date20240417075405'),('privacy','100Date20190217131943'),('systemtags','31000Date20241018063111'),('systemtags','31000Date20241114171300'),('text','010000Date20190617184535'),('text','030001Date20200402075029'),('text','030201Date20201116110353'),('text','030201Date20201116123153'),('text','030501Date20220202101853'),('text','030701Date20230207131313'),('text','030901Date20231114150437'),('text','040100Date20240611165300'),('theming','2006Date20240905111627'),('twofactor_backupcodes','1002Date20170607104347'),('twofactor_backupcodes','1002Date20170607113030'),('twofactor_backupcodes','1002Date20170919123342'),('twofactor_backupcodes','1002Date20170926101419'),('twofactor_backupcodes','1002Date20180821043638'),('updatenotification','011901Date20240305120000'),('user_status','0001Date20200602134824'),('user_status','0002Date20200902144824'),('user_status','1000Date20201111130204'),('user_status','1003Date20210809144824'),('user_status','1008Date20230921144701'),('webhook_listeners','1000Date20240527153425'),('webhook_listeners','1001Date20240716184935'),('workflowengine','2000Date20190808074233'),('workflowengine','2200Date20210805101925');
/*!40000 ALTER TABLE `oc_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_mimetypes`
--

DROP TABLE IF EXISTS `oc_mimetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_mimetypes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mimetype` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mimetype_id_index` (`mimetype`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_mimetypes`
--

LOCK TABLES `oc_mimetypes` WRITE;
/*!40000 ALTER TABLE `oc_mimetypes` DISABLE KEYS */;
INSERT INTO `oc_mimetypes` VALUES (5,'application'),(20,'application/gzip'),(29,'application/internet-shortcut'),(19,'application/javascript'),(21,'application/json'),(18,'application/octet-stream'),(6,'application/pdf'),(12,'application/vnd.excalidraw+json'),(15,'application/vnd.oasis.opendocument.graphics'),(13,'application/vnd.oasis.opendocument.presentation'),(16,'application/vnd.oasis.opendocument.spreadsheet'),(14,'application/vnd.oasis.opendocument.text'),(17,'application/vnd.openxmlformats-officedocument.wordprocessingml.document'),(1,'httpd'),(2,'httpd/unix-directory'),(9,'image'),(24,'image/heic'),(10,'image/jpeg'),(11,'image/png'),(23,'image/svg+xml'),(25,'image/webp'),(3,'text'),(4,'text/markdown'),(27,'text/plain'),(28,'text/rtf'),(7,'video'),(8,'video/mp4'),(26,'video/quicktime'),(22,'video/webm');
/*!40000 ALTER TABLE `oc_mimetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_mounts`
--

DROP TABLE IF EXISTS `oc_mounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_mounts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `storage_id` bigint(20) NOT NULL,
  `root_id` bigint(20) NOT NULL,
  `user_id` varchar(64) NOT NULL,
  `mount_point` varchar(4000) NOT NULL,
  `mount_id` bigint(20) DEFAULT NULL,
  `mount_provider_class` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mounts_storage_index` (`storage_id`),
  KEY `mounts_root_index` (`root_id`),
  KEY `mounts_mount_id_index` (`mount_id`),
  KEY `mounts_user_root_path_index` (`user_id`,`root_id`,`mount_point`(128)),
  KEY `mounts_class_index` (`mount_provider_class`),
  KEY `mount_user_storage` (`storage_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_mounts`
--

LOCK TABLES `oc_mounts` WRITE;
/*!40000 ALTER TABLE `oc_mounts` DISABLE KEYS */;
INSERT INTO `oc_mounts` VALUES (1,1,1,'Landing Pad Digital','/Landing Pad Digital/',NULL,'OC\\Files\\Mount\\LocalHomeMountProvider'),(2,4,351,'Landing Pad Digital','/Landing Pad Digital/files/S3 Cloud/',1,'OCA\\Files_External\\Config\\ConfigAdapter');
/*!40000 ALTER TABLE `oc_mounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_notifications`
--

DROP TABLE IF EXISTS `oc_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_notifications` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(32) NOT NULL,
  `user` varchar(64) NOT NULL,
  `timestamp` int(11) NOT NULL DEFAULT 0,
  `object_type` varchar(64) NOT NULL,
  `object_id` varchar(64) NOT NULL,
  `subject` varchar(64) NOT NULL,
  `subject_parameters` longtext DEFAULT NULL,
  `message` varchar(64) DEFAULT NULL,
  `message_parameters` longtext DEFAULT NULL,
  `link` varchar(4000) DEFAULT NULL,
  `icon` varchar(4000) DEFAULT NULL,
  `actions` longtext DEFAULT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `oc_notifications_app` (`app`),
  KEY `oc_notifications_user` (`user`),
  KEY `oc_notifications_timestamp` (`timestamp`),
  KEY `oc_notifications_object` (`object_type`,`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_notifications`
--

LOCK TABLES `oc_notifications` WRITE;
/*!40000 ALTER TABLE `oc_notifications` DISABLE KEYS */;
INSERT INTO `oc_notifications` VALUES (1,'firstrunwizard','Landing Pad Digital',1750750042,'app','recognize','apphint-recognize','[]','','[]','','','[]'),(2,'firstrunwizard','Landing Pad Digital',1750750042,'app','groupfolders','apphint-groupfolders','[]','','[]','','','[]'),(3,'firstrunwizard','Landing Pad Digital',1750750042,'app','forms','apphint-forms','[]','','[]','','','[]'),(4,'firstrunwizard','Landing Pad Digital',1750750042,'app','deck','apphint-deck','[]','','[]','','','[]'),(5,'firstrunwizard','Landing Pad Digital',1750750042,'app','tasks','apphint-tasks','[]','','[]','','','[]'),(6,'firstrunwizard','Landing Pad Digital',1750750042,'app','whiteboard','apphint-whiteboard','[]','','[]','','','[]'),(7,'firstrunwizard','Landing Pad Digital',1750750201,'user','Landing Pad Digital','profile','[]','','[]','','','[]');
/*!40000 ALTER TABLE `oc_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_notifications_pushhash`
--

DROP TABLE IF EXISTS `oc_notifications_pushhash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_notifications_pushhash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) NOT NULL,
  `token` int(11) NOT NULL DEFAULT 0,
  `deviceidentifier` varchar(128) NOT NULL,
  `devicepublickey` varchar(512) NOT NULL,
  `devicepublickeyhash` varchar(128) NOT NULL,
  `pushtokenhash` varchar(128) NOT NULL,
  `proxyserver` varchar(256) NOT NULL,
  `apptype` varchar(32) NOT NULL DEFAULT 'unknown',
  PRIMARY KEY (`id`),
  UNIQUE KEY `oc_npushhash_uid` (`uid`,`token`),
  KEY `oc_npushhash_di` (`deviceidentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_notifications_pushhash`
--

LOCK TABLES `oc_notifications_pushhash` WRITE;
/*!40000 ALTER TABLE `oc_notifications_pushhash` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_notifications_pushhash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_notifications_settings`
--

DROP TABLE IF EXISTS `oc_notifications_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_notifications_settings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL,
  `batch_time` int(11) NOT NULL DEFAULT 0,
  `last_send_id` bigint(20) NOT NULL DEFAULT 0,
  `next_send_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notset_user` (`user_id`),
  KEY `notset_nextsend` (`next_send_time`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_notifications_settings`
--

LOCK TABLES `oc_notifications_settings` WRITE;
/*!40000 ALTER TABLE `oc_notifications_settings` DISABLE KEYS */;
INSERT INTO `oc_notifications_settings` VALUES (1,'Landing Pad Digital',0,0,0);
/*!40000 ALTER TABLE `oc_notifications_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_oauth2_access_tokens`
--

DROP TABLE IF EXISTS `oc_oauth2_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_oauth2_access_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `token_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `hashed_code` varchar(128) NOT NULL,
  `encrypted_token` varchar(786) NOT NULL,
  `code_created_at` bigint(20) unsigned NOT NULL DEFAULT 0,
  `token_count` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth2_access_hash_idx` (`hashed_code`),
  KEY `oauth2_access_client_id_idx` (`client_id`),
  KEY `oauth2_tk_c_created_idx` (`token_count`,`code_created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_oauth2_access_tokens`
--

LOCK TABLES `oc_oauth2_access_tokens` WRITE;
/*!40000 ALTER TABLE `oc_oauth2_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_oauth2_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_oauth2_clients`
--

DROP TABLE IF EXISTS `oc_oauth2_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_oauth2_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `redirect_uri` varchar(2000) NOT NULL,
  `client_identifier` varchar(64) NOT NULL,
  `secret` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth2_client_id_idx` (`client_identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_oauth2_clients`
--

LOCK TABLES `oc_oauth2_clients` WRITE;
/*!40000 ALTER TABLE `oc_oauth2_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_oauth2_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_open_local_editor`
--

DROP TABLE IF EXISTS `oc_open_local_editor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_open_local_editor` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL,
  `path_hash` varchar(64) NOT NULL,
  `expiration_time` bigint(20) unsigned NOT NULL,
  `token` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `openlocal_user_path_token` (`user_id`,`path_hash`,`token`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_open_local_editor`
--

LOCK TABLES `oc_open_local_editor` WRITE;
/*!40000 ALTER TABLE `oc_open_local_editor` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_open_local_editor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_photos_albums`
--

DROP TABLE IF EXISTS `oc_photos_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_photos_albums` (
  `album_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `user` varchar(255) NOT NULL,
  `created` bigint(20) NOT NULL,
  `location` varchar(255) NOT NULL,
  `last_added_photo` bigint(20) NOT NULL,
  PRIMARY KEY (`album_id`),
  KEY `pa_user` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_photos_albums`
--

LOCK TABLES `oc_photos_albums` WRITE;
/*!40000 ALTER TABLE `oc_photos_albums` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_photos_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_photos_albums_collabs`
--

DROP TABLE IF EXISTS `oc_photos_albums_collabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_photos_albums_collabs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) NOT NULL,
  `collaborator_id` varchar(64) NOT NULL,
  `collaborator_type` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `album_collabs_uniq_collab` (`album_id`,`collaborator_id`,`collaborator_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_photos_albums_collabs`
--

LOCK TABLES `oc_photos_albums_collabs` WRITE;
/*!40000 ALTER TABLE `oc_photos_albums_collabs` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_photos_albums_collabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_photos_albums_files`
--

DROP TABLE IF EXISTS `oc_photos_albums_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_photos_albums_files` (
  `album_file_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  `added` bigint(20) NOT NULL,
  `owner` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`album_file_id`),
  UNIQUE KEY `paf_album_file` (`album_id`,`file_id`),
  KEY `paf_folder` (`album_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_photos_albums_files`
--

LOCK TABLES `oc_photos_albums_files` WRITE;
/*!40000 ALTER TABLE `oc_photos_albums_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_photos_albums_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_preferences`
--

DROP TABLE IF EXISTS `oc_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_preferences` (
  `userid` varchar(64) NOT NULL DEFAULT '',
  `appid` varchar(32) NOT NULL DEFAULT '',
  `configkey` varchar(64) NOT NULL DEFAULT '',
  `configvalue` longtext DEFAULT NULL,
  `lazy` smallint(5) unsigned NOT NULL DEFAULT 0,
  `type` smallint(5) unsigned NOT NULL DEFAULT 0,
  `flags` int(10) unsigned NOT NULL DEFAULT 0,
  `indexed` varchar(64) DEFAULT '',
  PRIMARY KEY (`userid`,`appid`,`configkey`),
  KEY `prefs_uid_lazy_i` (`userid`,`lazy`),
  KEY `prefs_app_key_ind_fl_i` (`appid`,`configkey`,`indexed`,`flags`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_preferences`
--

LOCK TABLES `oc_preferences` WRITE;
/*!40000 ALTER TABLE `oc_preferences` DISABLE KEYS */;
INSERT INTO `oc_preferences` VALUES ('Landing Pad Digital','activity','configured','yes',0,0,0,''),('Landing Pad Digital','avatar','generated','false',0,0,0,''),('Landing Pad Digital','avatar','version','1',0,0,0,''),('Landing Pad Digital','core','lang','en_GB',0,1,0,''),('Landing Pad Digital','core','templateDirectory','Templates/',0,0,0,''),('Landing Pad Digital','core','timezone','Asia/Bangkok',0,0,0,''),('Landing Pad Digital','dashboard','firstRun','0',0,0,0,''),('Landing Pad Digital','dav','generateBirthdayCalendar','yes',0,0,0,''),('Landing Pad Digital','files','lastSeenQuotaUsage','0.03',0,0,0,''),('Landing Pad Digital','files','show_hidden','1',0,0,0,''),('Landing Pad Digital','firstrunwizard','apphint','19',0,0,0,''),('Landing Pad Digital','firstrunwizard','show','31.0.6',0,0,0,''),('Landing Pad Digital','login','firstLogin','1750060799',0,0,0,''),('Landing Pad Digital','login','lastLogin','1750990154',0,0,0,''),('Landing Pad Digital','login_token','KBP/rTBJnQ8TexYLjuRVL3RudbjUUCva','1750753271',0,0,0,''),('Landing Pad Digital','login_token','MmDFeLzyUrVyzNzhKf/unRkbFHjdNWU2','1750752046',0,0,0,''),('Landing Pad Digital','login_token','PA9jURK/o0Z+8yjDwZUkCkWnRIgiGJnC','1750752312',0,0,0,''),('Landing Pad Digital','login_token','REvyJdcnMAeM2+CEVxA8c0Cg+UkJKiXG','1750752227',0,0,0,''),('Landing Pad Digital','login_token','wmuhUvGymnbXZTqLmnnoGxX5sFIjonTV','1750750042',0,0,0,''),('Landing Pad Digital','notifications','sound_notification','no',0,0,0,''),('Landing Pad Digital','notifications','sound_talk','no',0,0,0,''),('Landing Pad Digital','password_policy','failedLoginAttempts','0',0,0,0,''),('Landing Pad Digital','settings','email','support@landingpad.digital',0,0,0,'');
/*!40000 ALTER TABLE `oc_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_preferences_ex`
--

DROP TABLE IF EXISTS `oc_preferences_ex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_preferences_ex` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` varchar(64) NOT NULL,
  `appid` varchar(32) NOT NULL,
  `configkey` varchar(64) NOT NULL,
  `configvalue` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `preferences_ex__idx` (`userid`,`appid`,`configkey`),
  KEY `preferences_ex__configkey` (`configkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_preferences_ex`
--

LOCK TABLES `oc_preferences_ex` WRITE;
/*!40000 ALTER TABLE `oc_preferences_ex` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_preferences_ex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_privacy_admins`
--

DROP TABLE IF EXISTS `oc_privacy_admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_privacy_admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `displayname` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_privacy_admins`
--

LOCK TABLES `oc_privacy_admins` WRITE;
/*!40000 ALTER TABLE `oc_privacy_admins` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_privacy_admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_profile_config`
--

DROP TABLE IF EXISTS `oc_profile_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_profile_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL,
  `config` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile_config_user_id_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_profile_config`
--

LOCK TABLES `oc_profile_config` WRITE;
/*!40000 ALTER TABLE `oc_profile_config` DISABLE KEYS */;
INSERT INTO `oc_profile_config` VALUES (1,'Landing Pad Digital','{\"email\":{\"visibility\":\"show_users_only\"},\"website\":{\"visibility\":\"show\"},\"address\":{\"visibility\":\"show_users_only\"},\"avatar\":{\"visibility\":\"show\"},\"biography\":{\"visibility\":\"show\"},\"displayname\":{\"visibility\":\"show\"},\"headline\":{\"visibility\":\"show\"},\"organisation\":{\"visibility\":\"show\"},\"role\":{\"visibility\":\"show\"},\"phone\":{\"visibility\":\"show_users_only\"},\"twitter\":{\"visibility\":\"show\"},\"pronouns\":{\"visibility\":\"show\"}}');
/*!40000 ALTER TABLE `oc_profile_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_properties`
--

DROP TABLE IF EXISTS `oc_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_properties` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` varchar(64) NOT NULL DEFAULT '',
  `propertypath` varchar(255) NOT NULL DEFAULT '',
  `propertyname` varchar(255) NOT NULL DEFAULT '',
  `propertyvalue` longtext NOT NULL,
  `valuetype` smallint(6) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `properties_path_index` (`userid`,`propertypath`),
  KEY `properties_pathonly_index` (`propertypath`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_properties`
--

LOCK TABLES `oc_properties` WRITE;
/*!40000 ALTER TABLE `oc_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_ratelimit_entries`
--

DROP TABLE IF EXISTS `oc_ratelimit_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_ratelimit_entries` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hash` varchar(128) NOT NULL,
  `delete_after` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ratelimit_hash` (`hash`),
  KEY `ratelimit_delete_after` (`delete_after`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_ratelimit_entries`
--

LOCK TABLES `oc_ratelimit_entries` WRITE;
/*!40000 ALTER TABLE `oc_ratelimit_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_ratelimit_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_reactions`
--

DROP TABLE IF EXISTS `oc_reactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_reactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL,
  `message_id` bigint(20) unsigned NOT NULL,
  `actor_type` varchar(64) NOT NULL DEFAULT '',
  `actor_id` varchar(64) NOT NULL DEFAULT '',
  `reaction` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `comment_reaction_unique` (`parent_id`,`actor_type`,`actor_id`,`reaction`),
  KEY `comment_reaction` (`reaction`),
  KEY `comment_reaction_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_reactions`
--

LOCK TABLES `oc_reactions` WRITE;
/*!40000 ALTER TABLE `oc_reactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_reactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_recent_contact`
--

DROP TABLE IF EXISTS `oc_recent_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_recent_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `actor_uid` varchar(64) NOT NULL,
  `uid` varchar(64) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `federated_cloud_id` varchar(255) DEFAULT NULL,
  `card` longblob NOT NULL,
  `last_contact` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `recent_contact_actor_uid` (`actor_uid`),
  KEY `recent_contact_id_uid` (`id`,`actor_uid`),
  KEY `recent_contact_uid` (`uid`),
  KEY `recent_contact_email` (`email`),
  KEY `recent_contact_fed_id` (`federated_cloud_id`),
  KEY `recent_contact_last_contact` (`last_contact`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_recent_contact`
--

LOCK TABLES `oc_recent_contact` WRITE;
/*!40000 ALTER TABLE `oc_recent_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_recent_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_schedulingobjects`
--

DROP TABLE IF EXISTS `oc_schedulingobjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_schedulingobjects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `principaluri` varchar(255) DEFAULT NULL,
  `calendardata` longblob DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `lastmodified` int(10) unsigned DEFAULT NULL,
  `etag` varchar(32) DEFAULT NULL,
  `size` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `schedulobj_principuri_index` (`principaluri`),
  KEY `schedulobj_lastmodified_idx` (`lastmodified`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_schedulingobjects`
--

LOCK TABLES `oc_schedulingobjects` WRITE;
/*!40000 ALTER TABLE `oc_schedulingobjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_schedulingobjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_sec_signatory`
--

DROP TABLE IF EXISTS `oc_sec_signatory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_sec_signatory` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key_id_sum` varchar(127) NOT NULL,
  `key_id` varchar(512) NOT NULL,
  `host` varchar(512) NOT NULL,
  `provider_id` varchar(31) NOT NULL,
  `account` varchar(127) DEFAULT '',
  `public_key` longtext NOT NULL DEFAULT '',
  `metadata` longtext NOT NULL DEFAULT '[]',
  `type` smallint(6) NOT NULL DEFAULT 9,
  `status` smallint(6) NOT NULL DEFAULT 0,
  `creation` int(10) unsigned DEFAULT 0,
  `last_updated` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sec_sig_unic` (`provider_id`,`host`,`account`),
  KEY `sec_sig_key` (`key_id_sum`,`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_sec_signatory`
--

LOCK TABLES `oc_sec_signatory` WRITE;
/*!40000 ALTER TABLE `oc_sec_signatory` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_sec_signatory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_share`
--

DROP TABLE IF EXISTS `oc_share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_share` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `share_type` smallint(6) NOT NULL DEFAULT 0,
  `share_with` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `uid_owner` varchar(64) NOT NULL DEFAULT '',
  `uid_initiator` varchar(64) DEFAULT NULL,
  `parent` bigint(20) DEFAULT NULL,
  `item_type` varchar(64) NOT NULL DEFAULT '',
  `item_source` varchar(255) DEFAULT NULL,
  `item_target` varchar(255) DEFAULT NULL,
  `file_source` bigint(20) DEFAULT NULL,
  `file_target` varchar(512) DEFAULT NULL,
  `permissions` smallint(6) NOT NULL DEFAULT 0,
  `stime` bigint(20) NOT NULL DEFAULT 0,
  `accepted` smallint(6) NOT NULL DEFAULT 0,
  `expiration` datetime DEFAULT NULL,
  `token` varchar(32) DEFAULT NULL,
  `mail_send` smallint(6) NOT NULL DEFAULT 0,
  `share_name` varchar(64) DEFAULT NULL,
  `password_by_talk` tinyint(1) DEFAULT 0,
  `note` longtext DEFAULT NULL,
  `hide_download` smallint(6) DEFAULT 0,
  `label` varchar(255) DEFAULT NULL,
  `attributes` longtext DEFAULT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`attributes`)),
  `password_expiration_time` datetime DEFAULT NULL,
  `reminder_sent` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `item_share_type_index` (`item_type`,`share_type`),
  KEY `file_source_index` (`file_source`),
  KEY `token_index` (`token`),
  KEY `share_with_index` (`share_with`),
  KEY `parent_index` (`parent`),
  KEY `owner_index` (`uid_owner`),
  KEY `initiator_index` (`uid_initiator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_share`
--

LOCK TABLES `oc_share` WRITE;
/*!40000 ALTER TABLE `oc_share` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_share` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_share_external`
--

DROP TABLE IF EXISTS `oc_share_external`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_share_external` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent` bigint(20) DEFAULT -1,
  `share_type` int(11) DEFAULT NULL,
  `remote` varchar(512) NOT NULL,
  `remote_id` varchar(255) DEFAULT '',
  `share_token` varchar(64) NOT NULL,
  `password` varchar(64) DEFAULT NULL,
  `name` varchar(4000) NOT NULL,
  `owner` varchar(64) NOT NULL,
  `user` varchar(64) NOT NULL,
  `mountpoint` varchar(4000) NOT NULL,
  `mountpoint_hash` varchar(32) NOT NULL,
  `accepted` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sh_external_mp` (`user`,`mountpoint_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_share_external`
--

LOCK TABLES `oc_share_external` WRITE;
/*!40000 ALTER TABLE `oc_share_external` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_share_external` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_shares_limits`
--

DROP TABLE IF EXISTS `oc_shares_limits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_shares_limits` (
  `id` varchar(32) NOT NULL,
  `limit` bigint(20) NOT NULL,
  `downloads` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_shares_limits`
--

LOCK TABLES `oc_shares_limits` WRITE;
/*!40000 ALTER TABLE `oc_shares_limits` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_shares_limits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_storages`
--

DROP TABLE IF EXISTS `oc_storages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_storages` (
  `numeric_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id` varchar(64) DEFAULT NULL,
  `available` int(11) NOT NULL DEFAULT 1,
  `last_checked` int(11) DEFAULT NULL,
  PRIMARY KEY (`numeric_id`),
  UNIQUE KEY `storages_id_index` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_storages`
--

LOCK TABLES `oc_storages` WRITE;
/*!40000 ALTER TABLE `oc_storages` DISABLE KEYS */;
INSERT INTO `oc_storages` VALUES (1,'home::Landing Pad Digital',1,NULL),(2,'local::/var/www/html/data/',1,NULL),(3,'amazon::external::357ce5ee4651790ff3927bbe70afc6be',0,1750755695),(4,'amazon::external::f588ccce64092bf43ef3dc9de1c32213',1,1750755717);
/*!40000 ALTER TABLE `oc_storages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_storages_credentials`
--

DROP TABLE IF EXISTS `oc_storages_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_storages_credentials` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user` varchar(64) DEFAULT NULL,
  `identifier` varchar(64) NOT NULL,
  `credentials` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stocred_ui` (`user`,`identifier`),
  KEY `stocred_user` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_storages_credentials`
--

LOCK TABLES `oc_storages_credentials` WRITE;
/*!40000 ALTER TABLE `oc_storages_credentials` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_storages_credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_systemtag`
--

DROP TABLE IF EXISTS `oc_systemtag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_systemtag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `visibility` smallint(6) NOT NULL DEFAULT 1,
  `editable` smallint(6) NOT NULL DEFAULT 1,
  `etag` varchar(32) DEFAULT NULL,
  `color` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag_ident` (`name`,`visibility`,`editable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_systemtag`
--

LOCK TABLES `oc_systemtag` WRITE;
/*!40000 ALTER TABLE `oc_systemtag` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_systemtag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_systemtag_group`
--

DROP TABLE IF EXISTS `oc_systemtag_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_systemtag_group` (
  `systemtagid` bigint(20) unsigned NOT NULL DEFAULT 0,
  `gid` varchar(255) NOT NULL,
  PRIMARY KEY (`gid`,`systemtagid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_systemtag_group`
--

LOCK TABLES `oc_systemtag_group` WRITE;
/*!40000 ALTER TABLE `oc_systemtag_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_systemtag_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_systemtag_object_mapping`
--

DROP TABLE IF EXISTS `oc_systemtag_object_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_systemtag_object_mapping` (
  `objectid` varchar(64) NOT NULL DEFAULT '',
  `objecttype` varchar(64) NOT NULL DEFAULT '',
  `systemtagid` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`objecttype`,`objectid`,`systemtagid`),
  KEY `systag_by_tagid` (`systemtagid`,`objecttype`),
  KEY `systag_by_objectid` (`objectid`),
  KEY `systag_objecttype` (`objecttype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_systemtag_object_mapping`
--

LOCK TABLES `oc_systemtag_object_mapping` WRITE;
/*!40000 ALTER TABLE `oc_systemtag_object_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_systemtag_object_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_taskprocessing_tasks`
--

DROP TABLE IF EXISTS `oc_taskprocessing_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_taskprocessing_tasks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `input` longtext NOT NULL,
  `output` longtext DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `user_id` varchar(64) DEFAULT NULL,
  `app_id` varchar(32) NOT NULL DEFAULT '',
  `custom_id` varchar(255) DEFAULT '',
  `last_updated` int(10) unsigned DEFAULT 0,
  `completion_expected_at` datetime DEFAULT NULL,
  `progress` double DEFAULT 0,
  `error_message` varchar(4000) DEFAULT NULL,
  `scheduled_at` int(10) unsigned DEFAULT NULL,
  `started_at` int(10) unsigned DEFAULT NULL,
  `ended_at` int(10) unsigned DEFAULT NULL,
  `webhook_uri` varchar(4000) DEFAULT NULL,
  `webhook_method` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `taskp_tasks_status_type` (`status`,`type`),
  KEY `taskp_tasks_updated` (`last_updated`),
  KEY `taskp_tasks_uid_appid_cid` (`user_id`,`app_id`,`custom_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_taskprocessing_tasks`
--

LOCK TABLES `oc_taskprocessing_tasks` WRITE;
/*!40000 ALTER TABLE `oc_taskprocessing_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_taskprocessing_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_text2image_tasks`
--

DROP TABLE IF EXISTS `oc_text2image_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_text2image_tasks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `input` longtext NOT NULL,
  `status` int(11) DEFAULT 0,
  `number_of_images` int(11) NOT NULL DEFAULT 1,
  `user_id` varchar(64) DEFAULT NULL,
  `app_id` varchar(32) NOT NULL DEFAULT '',
  `identifier` varchar(255) DEFAULT '',
  `last_updated` datetime DEFAULT NULL,
  `completion_expected_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `t2i_tasks_updated` (`last_updated`),
  KEY `t2i_tasks_status` (`status`),
  KEY `t2i_tasks_uid_appid_ident` (`user_id`,`app_id`,`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_text2image_tasks`
--

LOCK TABLES `oc_text2image_tasks` WRITE;
/*!40000 ALTER TABLE `oc_text2image_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_text2image_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_text_documents`
--

DROP TABLE IF EXISTS `oc_text_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_text_documents` (
  `id` bigint(20) unsigned NOT NULL,
  `current_version` bigint(20) unsigned DEFAULT 0,
  `last_saved_version` bigint(20) unsigned DEFAULT 0,
  `last_saved_version_time` bigint(20) unsigned NOT NULL,
  `last_saved_version_etag` varchar(64) DEFAULT '',
  `base_version_etag` varchar(64) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_text_documents`
--

LOCK TABLES `oc_text_documents` WRITE;
/*!40000 ALTER TABLE `oc_text_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_text_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_text_sessions`
--

DROP TABLE IF EXISTS `oc_text_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_text_sessions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) DEFAULT NULL,
  `guest_name` varchar(64) DEFAULT NULL,
  `color` varchar(7) DEFAULT NULL,
  `token` varchar(64) NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `last_contact` bigint(20) unsigned NOT NULL,
  `last_awareness_message` longtext DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `rd_session_token_idx` (`token`),
  KEY `ts_lastcontact` (`last_contact`),
  KEY `ts_docid_lastcontact` (`document_id`,`last_contact`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_text_sessions`
--

LOCK TABLES `oc_text_sessions` WRITE;
/*!40000 ALTER TABLE `oc_text_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_text_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_text_steps`
--

DROP TABLE IF EXISTS `oc_text_steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_text_steps` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `document_id` bigint(20) unsigned NOT NULL,
  `session_id` bigint(20) unsigned NOT NULL,
  `data` longtext NOT NULL,
  `version` bigint(20) unsigned DEFAULT 0,
  `timestamp` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `rd_steps_did_idx` (`document_id`),
  KEY `rd_steps_version_idx` (`version`),
  KEY `textstep_session` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_text_steps`
--

LOCK TABLES `oc_text_steps` WRITE;
/*!40000 ALTER TABLE `oc_text_steps` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_text_steps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_textprocessing_tasks`
--

DROP TABLE IF EXISTS `oc_textprocessing_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_textprocessing_tasks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `input` longtext NOT NULL,
  `output` longtext DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `user_id` varchar(64) DEFAULT NULL,
  `app_id` varchar(32) NOT NULL DEFAULT '',
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `last_updated` int(10) unsigned DEFAULT 0,
  `completion_expected_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tp_tasks_updated` (`last_updated`),
  KEY `tp_tasks_status_type_nonunique` (`status`,`type`),
  KEY `tp_tasks_uid_appid_ident` (`user_id`,`app_id`,`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_textprocessing_tasks`
--

LOCK TABLES `oc_textprocessing_tasks` WRITE;
/*!40000 ALTER TABLE `oc_textprocessing_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_textprocessing_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_trusted_servers`
--

DROP TABLE IF EXISTS `oc_trusted_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_trusted_servers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(512) NOT NULL,
  `url_hash` varchar(255) NOT NULL DEFAULT '',
  `token` varchar(128) DEFAULT NULL,
  `shared_secret` varchar(256) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 2,
  `sync_token` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `url_hash` (`url_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_trusted_servers`
--

LOCK TABLES `oc_trusted_servers` WRITE;
/*!40000 ALTER TABLE `oc_trusted_servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_trusted_servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_twofactor_backupcodes`
--

DROP TABLE IF EXISTS `oc_twofactor_backupcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_twofactor_backupcodes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) NOT NULL DEFAULT '',
  `code` varchar(128) NOT NULL,
  `used` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `twofactor_backupcodes_uid` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_twofactor_backupcodes`
--

LOCK TABLES `oc_twofactor_backupcodes` WRITE;
/*!40000 ALTER TABLE `oc_twofactor_backupcodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_twofactor_backupcodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_twofactor_providers`
--

DROP TABLE IF EXISTS `oc_twofactor_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_twofactor_providers` (
  `provider_id` varchar(32) NOT NULL,
  `uid` varchar(64) NOT NULL,
  `enabled` smallint(6) NOT NULL,
  PRIMARY KEY (`provider_id`,`uid`),
  KEY `twofactor_providers_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_twofactor_providers`
--

LOCK TABLES `oc_twofactor_providers` WRITE;
/*!40000 ALTER TABLE `oc_twofactor_providers` DISABLE KEYS */;
INSERT INTO `oc_twofactor_providers` VALUES ('backup_codes','Landing Pad Digital',0);
/*!40000 ALTER TABLE `oc_twofactor_providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_user_status`
--

DROP TABLE IF EXISTS `oc_user_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_user_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `status_timestamp` int(10) unsigned NOT NULL,
  `is_user_defined` tinyint(1) DEFAULT NULL,
  `message_id` varchar(255) DEFAULT NULL,
  `custom_icon` varchar(255) DEFAULT NULL,
  `custom_message` longtext DEFAULT NULL,
  `clear_at` int(10) unsigned DEFAULT NULL,
  `is_backup` tinyint(1) DEFAULT 0,
  `status_message_timestamp` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_status_uid_ix` (`user_id`),
  KEY `user_status_clr_ix` (`clear_at`),
  KEY `user_status_tstmp_ix` (`status_timestamp`),
  KEY `user_status_iud_ix` (`is_user_defined`,`status`),
  KEY `user_status_mtstmp_ix` (`status_message_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_user_status`
--

LOCK TABLES `oc_user_status` WRITE;
/*!40000 ALTER TABLE `oc_user_status` DISABLE KEYS */;
INSERT INTO `oc_user_status` VALUES (1,'Landing Pad Digital','offline',1750757100,0,NULL,NULL,NULL,NULL,0,0);
/*!40000 ALTER TABLE `oc_user_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_user_transfer_owner`
--

DROP TABLE IF EXISTS `oc_user_transfer_owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_user_transfer_owner` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `source_user` varchar(64) NOT NULL,
  `target_user` varchar(64) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  `node_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_user_transfer_owner`
--

LOCK TABLES `oc_user_transfer_owner` WRITE;
/*!40000 ALTER TABLE `oc_user_transfer_owner` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_user_transfer_owner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_users`
--

DROP TABLE IF EXISTS `oc_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_users` (
  `uid` varchar(64) NOT NULL DEFAULT '',
  `displayname` varchar(64) DEFAULT NULL,
  `password` varchar(255) NOT NULL DEFAULT '',
  `uid_lower` varchar(64) DEFAULT '',
  PRIMARY KEY (`uid`),
  KEY `user_uid_lower` (`uid_lower`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_users`
--

LOCK TABLES `oc_users` WRITE;
/*!40000 ALTER TABLE `oc_users` DISABLE KEYS */;
INSERT INTO `oc_users` VALUES ('Landing Pad Digital',NULL,'3|$argon2id$v=19$m=65536,t=4,p=1$MXVJWC9VWXdLemdPYjhhSg$uHffh4xo0mVfU7uSqBW+4qcQkSPNkgvLNvnUHhs7zaM','landing pad digital');
/*!40000 ALTER TABLE `oc_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_vcategory`
--

DROP TABLE IF EXISTS `oc_vcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_vcategory` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) NOT NULL DEFAULT '',
  `type` varchar(64) NOT NULL DEFAULT '',
  `category` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `uid_index` (`uid`),
  KEY `type_index` (`type`),
  KEY `category_index` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_vcategory`
--

LOCK TABLES `oc_vcategory` WRITE;
/*!40000 ALTER TABLE `oc_vcategory` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_vcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_vcategory_to_object`
--

DROP TABLE IF EXISTS `oc_vcategory_to_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_vcategory_to_object` (
  `objid` bigint(20) unsigned NOT NULL DEFAULT 0,
  `categoryid` bigint(20) unsigned NOT NULL DEFAULT 0,
  `type` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`categoryid`,`objid`,`type`),
  KEY `vcategory_objectd_index` (`objid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_vcategory_to_object`
--

LOCK TABLES `oc_vcategory_to_object` WRITE;
/*!40000 ALTER TABLE `oc_vcategory_to_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_vcategory_to_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_webauthn`
--

DROP TABLE IF EXISTS `oc_webauthn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_webauthn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `public_key_credential_id` varchar(512) NOT NULL,
  `data` longtext NOT NULL,
  `user_verification` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `webauthn_uid` (`uid`),
  KEY `webauthn_publicKeyCredentialId` (`public_key_credential_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_webauthn`
--

LOCK TABLES `oc_webauthn` WRITE;
/*!40000 ALTER TABLE `oc_webauthn` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_webauthn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_webhook_listeners`
--

DROP TABLE IF EXISTS `oc_webhook_listeners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_webhook_listeners` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(64) DEFAULT NULL,
  `user_id` varchar(64) DEFAULT NULL,
  `http_method` varchar(32) NOT NULL,
  `uri` varchar(4000) NOT NULL,
  `event` varchar(4000) NOT NULL,
  `event_filter` longtext DEFAULT NULL,
  `user_id_filter` varchar(64) DEFAULT NULL,
  `headers` longtext DEFAULT NULL,
  `auth_method` varchar(16) NOT NULL DEFAULT '',
  `auth_data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_webhook_listeners`
--

LOCK TABLES `oc_webhook_listeners` WRITE;
/*!40000 ALTER TABLE `oc_webhook_listeners` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_webhook_listeners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_whats_new`
--

DROP TABLE IF EXISTS `oc_whats_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oc_whats_new` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `version` varchar(64) NOT NULL DEFAULT '11',
  `etag` varchar(64) NOT NULL DEFAULT '',
  `last_check` int(10) unsigned NOT NULL DEFAULT 0,
  `data` longtext NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `version` (`version`),
  KEY `version_etag_idx` (`version`,`etag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_whats_new`
--

LOCK TABLES `oc_whats_new` WRITE;
/*!40000 ALTER TABLE `oc_whats_new` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_whats_new` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-27  4:07:46
