-- MySQL dump 10.14  Distrib 5.5.64-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: zabbix
-- ------------------------------------------------------
-- Server version	5.5.64-MariaDB

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
-- Current Database: `zabbix`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `zabbix` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;

USE `zabbix`;

--
-- Table structure for table `acknowledges`
--

DROP TABLE IF EXISTS `acknowledges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acknowledges` (
  `acknowledgeid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `action` int(11) NOT NULL DEFAULT '0',
  `old_severity` int(11) NOT NULL DEFAULT '0',
  `new_severity` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`acknowledgeid`),
  KEY `acknowledges_1` (`userid`),
  KEY `acknowledges_2` (`eventid`),
  KEY `acknowledges_3` (`clock`),
  CONSTRAINT `c_acknowledges_2` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_acknowledges_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acknowledges`
--

LOCK TABLES `acknowledges` WRITE;
/*!40000 ALTER TABLE `acknowledges` DISABLE KEYS */;
/*!40000 ALTER TABLE `acknowledges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `actionid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `eventsource` int(11) NOT NULL DEFAULT '0',
  `evaltype` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `esc_period` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '1h',
  `def_shortdata` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `def_longdata` text COLLATE utf8_bin NOT NULL,
  `r_shortdata` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `r_longdata` text COLLATE utf8_bin NOT NULL,
  `formula` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `pause_suppressed` int(11) NOT NULL DEFAULT '1',
  `ack_shortdata` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ack_longdata` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`actionid`),
  UNIQUE KEY `actions_2` (`name`),
  KEY `actions_1` (`eventsource`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
INSERT INTO `actions` VALUES (2,'Auto discovery. Linux servers.',1,0,1,'0','','','','','',1,'',''),(3,'Report problems to Zabbix administrators',0,0,1,'1h','Problem: {EVENT.NAME}','Problem started at {EVENT.TIME} on {EVENT.DATE}\r\nProblem name: {EVENT.NAME}\r\nHost: {HOST.NAME}\r\nSeverity: {EVENT.SEVERITY}\r\n\r\nOriginal problem ID: {EVENT.ID}\r\n{TRIGGER.URL}','Resolved: {EVENT.NAME}','Problem has been resolved at {EVENT.RECOVERY.TIME} on {EVENT.RECOVERY.DATE}\r\nProblem name: {EVENT.NAME}\r\nHost: {HOST.NAME}\r\nSeverity: {EVENT.SEVERITY}\r\n\r\nOriginal problem ID: {EVENT.ID}\r\n{TRIGGER.URL}','',1,'Updated problem: {EVENT.NAME}','{USER.FULLNAME} {EVENT.UPDATE.ACTION} problem at {EVENT.UPDATE.DATE} {EVENT.UPDATE.TIME}.\r\n{EVENT.UPDATE.MESSAGE}\r\n\r\nCurrent problem status is {EVENT.STATUS}, acknowledged: {EVENT.ACK.STATUS}.'),(4,'Report not supported items',3,0,1,'1h','{ITEM.STATE}: {HOST.NAME}:{ITEM.NAME}','Host: {HOST.NAME}\r\nItem: {ITEM.NAME}\r\nKey: {ITEM.KEY}\r\nState: {ITEM.STATE}','{ITEM.STATE}: {HOST.NAME}:{ITEM.NAME}','Host: {HOST.NAME}\r\nItem: {ITEM.NAME}\r\nKey: {ITEM.KEY}\r\nState: {ITEM.STATE}','',1,'',''),(5,'Report not supported low level discovery rules',3,0,1,'1h','{LLDRULE.STATE}: {HOST.NAME}:{LLDRULE.NAME}','Host: {HOST.NAME}\r\nLow level discovery rule: {LLDRULE.NAME}\r\nKey: {LLDRULE.KEY}\r\nState: {LLDRULE.STATE}','{LLDRULE.STATE}: {HOST.NAME}:{LLDRULE.NAME}','Host: {HOST.NAME}\r\nLow level discovery rule: {LLDRULE.NAME}\r\nKey: {LLDRULE.KEY}\r\nState: {LLDRULE.STATE}','',1,'',''),(6,'Report unknown triggers',3,0,1,'1h','{TRIGGER.STATE}: {TRIGGER.NAME}','Trigger name: {TRIGGER.NAME}\r\nExpression: {TRIGGER.EXPRESSION}\r\nState: {TRIGGER.STATE}','{TRIGGER.STATE}: {TRIGGER.NAME}','Trigger name: {TRIGGER.NAME}\r\nExpression: {TRIGGER.EXPRESSION}\r\nState: {TRIGGER.STATE}','',1,'','');
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alerts` (
  `alertid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `mediatypeid` bigint(20) unsigned DEFAULT NULL,
  `sendto` varchar(1024) COLLATE utf8_bin NOT NULL DEFAULT '',
  `subject` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `message` text COLLATE utf8_bin NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `retries` int(11) NOT NULL DEFAULT '0',
  `error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `esc_step` int(11) NOT NULL DEFAULT '0',
  `alerttype` int(11) NOT NULL DEFAULT '0',
  `p_eventid` bigint(20) unsigned DEFAULT NULL,
  `acknowledgeid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`alertid`),
  KEY `alerts_1` (`actionid`),
  KEY `alerts_2` (`clock`),
  KEY `alerts_3` (`eventid`),
  KEY `alerts_4` (`status`),
  KEY `alerts_5` (`mediatypeid`),
  KEY `alerts_6` (`userid`),
  KEY `alerts_7` (`p_eventid`),
  KEY `c_alerts_6` (`acknowledgeid`),
  CONSTRAINT `c_alerts_6` FOREIGN KEY (`acknowledgeid`) REFERENCES `acknowledges` (`acknowledgeid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_2` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_4` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_5` FOREIGN KEY (`p_eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_discovery`
--

DROP TABLE IF EXISTS `application_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_discovery` (
  `application_discoveryid` bigint(20) unsigned NOT NULL,
  `applicationid` bigint(20) unsigned NOT NULL,
  `application_prototypeid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`application_discoveryid`),
  KEY `application_discovery_1` (`applicationid`),
  KEY `application_discovery_2` (`application_prototypeid`),
  CONSTRAINT `c_application_discovery_2` FOREIGN KEY (`application_prototypeid`) REFERENCES `application_prototype` (`application_prototypeid`) ON DELETE CASCADE,
  CONSTRAINT `c_application_discovery_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_discovery`
--

LOCK TABLES `application_discovery` WRITE;
/*!40000 ALTER TABLE `application_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `application_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_prototype`
--

DROP TABLE IF EXISTS `application_prototype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_prototype` (
  `application_prototypeid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`application_prototypeid`),
  KEY `application_prototype_1` (`itemid`),
  KEY `application_prototype_2` (`templateid`),
  CONSTRAINT `c_application_prototype_2` FOREIGN KEY (`templateid`) REFERENCES `application_prototype` (`application_prototypeid`) ON DELETE CASCADE,
  CONSTRAINT `c_application_prototype_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_prototype`
--

LOCK TABLES `application_prototype` WRITE;
/*!40000 ALTER TABLE `application_prototype` DISABLE KEYS */;
INSERT INTO `application_prototype` VALUES (1,23665,NULL,'Startup {#SERVICE.STARTUPNAME} services'),(2,28661,NULL,'Filesystem {#FSNAME}'),(3,28663,2,'Filesystem {#FSNAME}'),(4,28665,3,'Filesystem {#FSNAME}'),(5,28667,3,'Filesystem {#FSNAME}'),(6,28669,3,'Filesystem {#FSNAME}'),(7,28671,3,'Filesystem {#FSNAME}'),(8,27118,NULL,'Interface {#IFNAME}({#IFALIAS})'),(9,28097,8,'Interface {#IFNAME}({#IFALIAS})'),(10,28711,NULL,'Filesystem {#FSNAME}'),(11,28713,10,'Filesystem {#FSNAME}');
/*!40000 ALTER TABLE `application_prototype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_template`
--

DROP TABLE IF EXISTS `application_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_template` (
  `application_templateid` bigint(20) unsigned NOT NULL,
  `applicationid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`application_templateid`),
  UNIQUE KEY `application_template_1` (`applicationid`,`templateid`),
  KEY `application_template_2` (`templateid`),
  CONSTRAINT `c_application_template_2` FOREIGN KEY (`templateid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE,
  CONSTRAINT `c_application_template_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_template`
--

LOCK TABLES `application_template` WRITE;
/*!40000 ALTER TABLE `application_template` DISABLE KEYS */;
INSERT INTO `application_template` VALUES (1,207,206),(12,252,206),(13,262,206),(14,272,206),(15,282,206),(16,292,206),(17,302,206),(18,329,206),(19,345,179),(20,346,13),(21,347,5),(22,348,21),(23,349,15),(24,350,7),(25,351,1),(26,352,17),(27,353,9),(28,354,23),(29,355,207),(165,797,780),(166,799,780),(168,803,771),(167,803,784),(169,804,800),(170,805,799),(171,811,784),(172,812,800),(173,813,799),(174,820,784),(175,821,800),(176,822,799),(177,823,784),(178,824,800),(179,825,799),(180,836,826),(181,837,827),(182,838,826),(183,839,827),(185,840,771),(184,840,784),(186,841,800),(187,842,799),(191,846,800),(192,847,799),(193,856,848),(194,857,849),(195,858,852),(196,859,853),(197,860,854),(198,861,855),(205,868,848),(206,869,851),(207,870,852),(208,871,853),(209,872,854),(210,873,855),(212,874,771),(211,874,784),(213,875,800),(214,876,799),(215,883,784),(216,884,800),(217,885,799),(219,892,771),(218,892,784),(220,893,800),(221,894,799),(223,901,771),(222,901,784),(224,902,800),(225,903,799),(227,910,770),(226,910,781),(228,911,798),(229,912,797),(231,913,771),(230,913,782),(232,914,800),(233,915,799),(235,916,771),(234,916,784),(236,917,800),(237,918,799),(244,934,771),(243,934,784),(245,935,800),(246,936,799),(247,942,784),(248,943,800),(249,944,799),(251,949,771),(250,949,784),(252,950,800),(253,951,799),(263,969,784),(264,970,800),(265,971,799),(266,977,784),(267,978,800),(268,979,799),(270,986,771),(269,986,784),(271,987,800),(272,988,799),(273,992,782),(274,993,800),(275,994,799),(276,998,781),(277,999,798),(278,1000,797),(284,1018,771),(283,1018,784),(285,1019,800),(286,1020,799),(291,1025,786),(292,1026,800),(293,1027,799),(295,1028,771),(294,1028,784),(296,1029,800),(297,1030,799),(302,1041,784),(303,1042,800),(304,1043,799),(305,1048,852),(306,1049,855),(307,1050,854),(308,1051,853),(309,1052,848),(310,1053,784),(311,1054,800),(312,1055,799),(313,1057,1056),(314,1058,771),(317,1058,784),(315,1059,800),(316,1060,799),(318,1069,800),(319,1070,799),(320,1078,800),(321,1079,799),(322,1087,798),(323,1088,797),(324,1094,800),(325,1095,799),(326,1101,800),(327,1102,799),(328,1113,800),(329,1114,799),(334,1125,1122),(335,1126,1123),(336,1127,1124),(337,1128,1125),(338,1129,1126),(339,1130,1127),(340,1131,1125),(341,1132,1126),(342,1133,1127),(343,1134,1125),(344,1135,1126),(345,1136,1127),(346,1137,1125),(347,1138,1126),(348,1139,1127),(349,1143,1140),(350,1144,1141),(351,1145,1142);
/*!40000 ALTER TABLE `application_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `applications` (
  `applicationid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`applicationid`),
  UNIQUE KEY `applications_2` (`hostid`,`name`),
  CONSTRAINT `c_applications_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applications`
--

LOCK TABLES `applications` WRITE;
/*!40000 ALTER TABLE `applications` DISABLE KEYS */;
INSERT INTO `applications` VALUES (1,10001,'OS',0),(5,10001,'Filesystems',0),(7,10001,'Network interfaces',0),(9,10001,'Processes',0),(13,10001,'CPU',0),(15,10001,'Memory',0),(17,10001,'Performance',0),(21,10001,'General',0),(23,10001,'Security',0),(179,10047,'Zabbix server',0),(206,10050,'Zabbix agent',0),(207,10001,'Zabbix agent',0),(252,10074,'Zabbix agent',0),(253,10074,'CPU',0),(254,10074,'Filesystems',0),(255,10074,'General',0),(256,10074,'Memory',0),(257,10074,'Network interfaces',0),(258,10074,'OS',0),(259,10074,'Performance',0),(260,10074,'Processes',0),(261,10074,'Security',0),(262,10075,'Zabbix agent',0),(263,10075,'CPU',0),(264,10075,'Filesystems',0),(265,10075,'General',0),(266,10075,'Memory',0),(267,10075,'Network interfaces',0),(268,10075,'OS',0),(269,10075,'Performance',0),(270,10075,'Processes',0),(271,10075,'Security',0),(272,10076,'Zabbix agent',0),(273,10076,'CPU',0),(274,10076,'Filesystems',0),(275,10076,'General',0),(276,10076,'Memory',0),(277,10076,'Network interfaces',0),(278,10076,'OS',0),(279,10076,'Performance',0),(280,10076,'Processes',0),(281,10076,'Security',0),(282,10077,'Zabbix agent',0),(283,10077,'CPU',0),(284,10077,'Filesystems',0),(285,10077,'General',0),(286,10077,'Memory',0),(287,10077,'Network interfaces',0),(288,10077,'OS',0),(289,10077,'Performance',0),(290,10077,'Processes',0),(291,10077,'Security',0),(292,10078,'Zabbix agent',0),(293,10078,'CPU',0),(294,10078,'Filesystems',0),(295,10078,'General',0),(296,10078,'Memory',0),(297,10078,'Network interfaces',0),(298,10078,'OS',0),(299,10078,'Performance',0),(300,10078,'Processes',0),(301,10078,'Security',0),(302,10079,'Zabbix agent',0),(303,10079,'CPU',0),(304,10079,'Filesystems',0),(305,10079,'General',0),(306,10079,'Memory',0),(307,10079,'Network interfaces',0),(308,10079,'OS',0),(309,10079,'Performance',0),(310,10079,'Processes',0),(311,10079,'Security',0),(319,10081,'General',0),(320,10081,'Performance',0),(321,10081,'Services',0),(322,10081,'Filesystems',0),(323,10081,'OS',0),(324,10081,'Processes',0),(325,10081,'CPU',0),(328,10081,'Memory',0),(329,10081,'Zabbix agent',0),(330,10081,'Network interfaces',0),(331,10076,'Logical partitions',0),(345,10084,'Zabbix server',0),(346,10084,'CPU',0),(347,10084,'Filesystems',0),(348,10084,'General',0),(349,10084,'Memory',0),(350,10084,'Network interfaces',0),(351,10084,'OS',0),(352,10084,'Performance',0),(353,10084,'Processes',0),(354,10084,'Security',0),(355,10084,'Zabbix agent',0),(356,10048,'Zabbix proxy',0),(446,10093,'FTP service',0),(447,10094,'HTTP service',0),(448,10095,'HTTPS service',0),(449,10096,'IMAP service',0),(450,10097,'LDAP service',0),(451,10098,'NNTP service',0),(452,10099,'NTP service',0),(453,10100,'POP service',0),(454,10101,'SMTP service',0),(455,10102,'SSH service',0),(456,10103,'Telnet service',0),(732,10169,'Classes',0),(733,10169,'Compilation',0),(734,10169,'Garbage collector',0),(735,10169,'Memory',0),(736,10169,'Memory pool',0),(737,10169,'Operating system',0),(738,10169,'Runtime',0),(739,10169,'Threads',0),(740,10170,'MySQL',0),(741,10171,'Fans',0),(742,10171,'Temperature',0),(743,10171,'Voltage',0),(744,10172,'Fans',0),(745,10172,'Temperature',0),(746,10172,'Voltage',0),(747,10173,'Clusters',0),(748,10173,'General',0),(749,10173,'Log',0),(750,10174,'CPU',0),(751,10174,'Disks',0),(752,10174,'Filesystems',0),(753,10174,'General',0),(754,10174,'Interfaces',0),(755,10174,'Memory',0),(756,10174,'Network',0),(757,10174,'Storage',0),(758,10175,'CPU',0),(759,10175,'Datastore',0),(760,10175,'General',0),(761,10175,'Hardware',0),(762,10175,'Memory',0),(763,10175,'Network',0),(770,10182,'Network interfaces',0),(771,10183,'Network interfaces',0),(780,10186,'Status',0),(781,10187,'Network interfaces',0),(782,10188,'Network interfaces',0),(783,10189,'Network interfaces',0),(784,10190,'Network interfaces',0),(786,10192,'Network interfaces',0),(797,10203,'Status',0),(798,10203,'General',0),(799,10204,'Status',0),(800,10204,'General',0),(803,10207,'Network interfaces',0),(804,10207,'General',0),(805,10207,'Status',0),(806,10207,'CPU',0),(807,10207,'Memory',0),(808,10207,'Temperature',0),(809,10207,'Fans',0),(810,10207,'Inventory',0),(811,10208,'Network interfaces',0),(812,10208,'General',0),(813,10208,'Status',0),(814,10208,'CPU',0),(815,10208,'Memory',0),(816,10208,'Temperature',0),(817,10208,'Power supply',0),(818,10208,'Fans',0),(819,10208,'Inventory',0),(820,10210,'Network interfaces',0),(821,10210,'General',0),(822,10210,'Status',0),(823,10211,'Network interfaces',0),(824,10211,'General',0),(825,10211,'Status',0),(826,10209,'CPU',0),(827,10209,'Memory',0),(828,10210,'Temperature',0),(829,10210,'Power supply',0),(830,10210,'Fans',0),(831,10210,'Inventory',0),(832,10211,'Temperature',0),(833,10211,'Power supply',0),(834,10211,'Fans',0),(835,10211,'Inventory',0),(836,10210,'CPU',0),(837,10210,'Memory',0),(838,10211,'CPU',0),(839,10211,'Memory',0),(840,10218,'Network interfaces',0),(841,10218,'General',0),(842,10218,'Status',0),(846,10220,'General',0),(847,10220,'Status',0),(848,10212,'Memory',0),(849,10213,'CPU',0),(851,10215,'CPU',0),(852,10216,'Inventory',0),(853,10217,'Temperature',0),(854,10217,'Power supply',0),(855,10217,'Fans',0),(856,10218,'Memory',0),(857,10218,'CPU',0),(858,10218,'Inventory',0),(859,10218,'Temperature',0),(860,10218,'Power supply',0),(861,10218,'Fans',0),(868,10220,'Memory',0),(869,10220,'CPU',0),(870,10220,'Inventory',0),(871,10220,'Temperature',0),(872,10220,'Power supply',0),(873,10220,'Fans',0),(874,10221,'Network interfaces',0),(875,10221,'General',0),(876,10221,'Status',0),(877,10221,'CPU',0),(878,10221,'Memory',0),(879,10221,'Temperature',0),(880,10221,'Power supply',0),(881,10221,'Fans',0),(882,10221,'Inventory',0),(883,10222,'Network interfaces',0),(884,10222,'General',0),(885,10222,'Status',0),(886,10222,'CPU',0),(887,10222,'Memory',0),(888,10222,'Temperature',0),(889,10222,'Fans',0),(890,10222,'Power supply',0),(891,10222,'Inventory',0),(892,10223,'Network interfaces',0),(893,10223,'General',0),(894,10223,'Status',0),(895,10223,'CPU',0),(896,10223,'Memory',0),(897,10223,'Temperature',0),(898,10223,'Fans',0),(899,10223,'Power supply',0),(900,10223,'Inventory',0),(901,10224,'Network interfaces',0),(902,10224,'General',0),(903,10224,'Status',0),(904,10224,'CPU',0),(905,10224,'Memory',0),(906,10224,'Temperature',0),(907,10224,'Power supply',0),(908,10224,'Fans',0),(909,10224,'Inventory',0),(910,10225,'Network interfaces',0),(911,10225,'General',0),(912,10225,'Status',0),(913,10226,'Network interfaces',0),(914,10226,'General',0),(915,10226,'Status',0),(916,10227,'Network interfaces',0),(917,10227,'General',0),(918,10227,'Status',0),(919,10227,'CPU',0),(920,10227,'Memory',0),(921,10227,'Temperature',0),(922,10227,'Fans',0),(923,10227,'Power supply',0),(924,10227,'Inventory',0),(934,10229,'Network interfaces',0),(935,10229,'General',0),(936,10229,'Status',0),(937,10229,'CPU',0),(938,10229,'Memory',0),(939,10229,'Temperature',0),(940,10229,'Fans',0),(941,10229,'Inventory',0),(942,10230,'Network interfaces',0),(943,10230,'General',0),(944,10230,'Status',0),(945,10230,'Temperature',0),(946,10230,'Power supply',0),(947,10230,'Fans',0),(948,10230,'Inventory',0),(949,10231,'Network interfaces',0),(950,10231,'General',0),(951,10231,'Status',0),(952,10231,'CPU',0),(953,10231,'Memory',0),(954,10231,'Temperature',0),(955,10231,'Power supply',0),(956,10231,'Fans',0),(957,10231,'Inventory',0),(969,10233,'Network interfaces',0),(970,10233,'General',0),(971,10233,'Status',0),(972,10233,'CPU',0),(973,10233,'Memory',0),(974,10233,'Temperature',0),(975,10233,'Storage',0),(976,10233,'Inventory',0),(977,10234,'Network interfaces',0),(978,10234,'General',0),(979,10234,'Status',0),(980,10234,'CPU',0),(981,10234,'Memory',0),(982,10234,'Temperature',0),(983,10234,'Power supply',0),(984,10234,'Fans',0),(985,10234,'Inventory',0),(986,10235,'Network interfaces',0),(987,10235,'General',0),(988,10235,'Status',0),(989,10235,'CPU',0),(990,10235,'Memory',0),(991,10235,'Inventory',0),(992,10236,'Network interfaces',0),(993,10236,'General',0),(994,10236,'Status',0),(995,10236,'CPU',0),(996,10236,'Memory',0),(997,10236,'Inventory',0),(998,10237,'Network interfaces',0),(999,10237,'General',0),(1000,10237,'Status',0),(1001,10237,'CPU',0),(1002,10237,'Memory',0),(1003,10237,'Inventory',0),(1018,10248,'Network interfaces',0),(1019,10248,'General',0),(1020,10248,'Status',0),(1025,10249,'Network interfaces',0),(1026,10249,'General',0),(1027,10249,'Status',0),(1028,10250,'Network interfaces',0),(1029,10250,'General',0),(1030,10250,'Status',0),(1031,10250,'CPU',0),(1032,10250,'Memory',0),(1033,10250,'Temperature',0),(1034,10250,'Fans',0),(1035,10250,'Power supply',0),(1036,10250,'Inventory',0),(1041,10251,'Network interfaces',0),(1042,10251,'General',0),(1043,10251,'Status',0),(1044,10251,'Temperature',0),(1045,10251,'Fans',0),(1046,10251,'Power supply',0),(1047,10251,'Inventory',0),(1048,10253,'Inventory',0),(1049,10253,'Fans',0),(1050,10253,'Power supply',0),(1051,10253,'Temperature',0),(1052,10253,'Memory',0),(1053,10253,'Network interfaces',0),(1054,10253,'General',0),(1055,10253,'Status',0),(1056,10252,'CPU',0),(1057,10253,'CPU',0),(1058,10254,'Network interfaces',0),(1059,10254,'General',0),(1060,10254,'Status',0),(1062,10254,'Fans',0),(1064,10254,'Inventory',0),(1066,10254,'Power supply',0),(1068,10254,'Temperature',0),(1069,10255,'General',0),(1070,10255,'Status',0),(1071,10255,'Disk arrays',0),(1072,10255,'Fans',0),(1073,10255,'Inventory',0),(1074,10255,'Physical disks',0),(1075,10255,'Power supply',0),(1076,10255,'Temperature',0),(1077,10255,'Virtual disks',0),(1078,10256,'General',0),(1079,10256,'Status',0),(1080,10256,'Disk arrays',0),(1081,10256,'Fans',0),(1082,10256,'Inventory',0),(1083,10256,'Physical disks',0),(1084,10256,'Power supply',0),(1085,10256,'Temperature',0),(1086,10256,'Virtual disks',0),(1087,10257,'General',0),(1088,10257,'Status',0),(1089,10257,'Fans',0),(1090,10257,'Inventory',0),(1091,10257,'Physical disks',0),(1092,10257,'Power supply',0),(1093,10257,'Temperature',0),(1094,10258,'General',0),(1095,10258,'Status',0),(1096,10258,'Fans',0),(1097,10258,'Inventory',0),(1098,10258,'Physical disks',0),(1099,10258,'Power supply',0),(1100,10258,'Temperature',0),(1101,10259,'General',0),(1102,10259,'Status',0),(1103,10259,'Fans',0),(1104,10259,'Temperature',0),(1105,10260,'http-8080',0),(1106,10260,'http-8443',0),(1107,10260,'jk-8009',0),(1108,10260,'Sessions',0),(1109,10260,'Tomcat',0),(1110,10261,'Zabbix server',0),(1111,10262,'Zabbix proxy',0),(1112,10173,'Datastore',0),(1113,10263,'General',0),(1114,10263,'Status',0),(1115,10263,'Disk arrays',0),(1116,10263,'Fans',0),(1117,10263,'Inventory',0),(1118,10263,'Physical disks',0),(1119,10263,'Power supply',0),(1120,10263,'Temperature',0),(1121,10263,'Virtual disks',0),(1122,10264,'Storage',0),(1123,10265,'Memory',0),(1124,10266,'CPU',0),(1125,10185,'Storage',0),(1126,10185,'Memory',0),(1127,10185,'CPU',0),(1128,10248,'Storage',0),(1129,10248,'Memory',0),(1130,10248,'CPU',0),(1131,10249,'Storage',0),(1132,10249,'Memory',0),(1133,10249,'CPU',0),(1134,10251,'Storage',0),(1135,10251,'Memory',0),(1136,10251,'CPU',0),(1137,10254,'Storage',0),(1138,10254,'Memory',0),(1139,10254,'CPU',0),(1140,10267,'Storage',0),(1141,10268,'Memory',0),(1142,10269,'CPU',0),(1143,10184,'Storage',0),(1144,10184,'Memory',0),(1145,10184,'CPU',0);
/*!40000 ALTER TABLE `applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditlog`
--

DROP TABLE IF EXISTS `auditlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditlog` (
  `auditid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `action` int(11) NOT NULL DEFAULT '0',
  `resourcetype` int(11) NOT NULL DEFAULT '0',
  `details` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `resourceid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `resourcename` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`auditid`),
  KEY `auditlog_1` (`userid`,`clock`),
  KEY `auditlog_2` (`clock`),
  CONSTRAINT `c_auditlog_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditlog`
--

LOCK TABLES `auditlog` WRITE;
/*!40000 ALTER TABLE `auditlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditlog_details`
--

DROP TABLE IF EXISTS `auditlog_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditlog_details` (
  `auditdetailid` bigint(20) unsigned NOT NULL,
  `auditid` bigint(20) unsigned NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `field_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `oldvalue` text COLLATE utf8_bin NOT NULL,
  `newvalue` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`auditdetailid`),
  KEY `auditlog_details_1` (`auditid`),
  CONSTRAINT `c_auditlog_details_1` FOREIGN KEY (`auditid`) REFERENCES `auditlog` (`auditid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditlog_details`
--

LOCK TABLES `auditlog_details` WRITE;
/*!40000 ALTER TABLE `auditlog_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditlog_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autoreg_host`
--

DROP TABLE IF EXISTS `autoreg_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autoreg_host` (
  `autoreg_hostid` bigint(20) unsigned NOT NULL,
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `listen_ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `listen_port` int(11) NOT NULL DEFAULT '0',
  `listen_dns` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `host_metadata` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`autoreg_hostid`),
  KEY `autoreg_host_1` (`host`),
  KEY `autoreg_host_2` (`proxy_hostid`),
  CONSTRAINT `c_autoreg_host_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoreg_host`
--

LOCK TABLES `autoreg_host` WRITE;
/*!40000 ALTER TABLE `autoreg_host` DISABLE KEYS */;
/*!40000 ALTER TABLE `autoreg_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conditions` (
  `conditionid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `conditiontype` int(11) NOT NULL DEFAULT '0',
  `operator` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value2` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`conditionid`),
  KEY `conditions_1` (`actionid`),
  CONSTRAINT `c_conditions_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conditions`
--

LOCK TABLES `conditions` WRITE;
/*!40000 ALTER TABLE `conditions` DISABLE KEYS */;
INSERT INTO `conditions` VALUES (2,2,10,0,'0',''),(3,2,8,0,'9',''),(4,2,12,2,'Linux',''),(6,4,23,0,'0',''),(7,5,23,0,'2',''),(8,6,23,0,'4','');
/*!40000 ALTER TABLE `conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `configid` bigint(20) unsigned NOT NULL,
  `refresh_unsupported` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '10m',
  `work_period` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '1-5,09:00-18:00',
  `alert_usrgrpid` bigint(20) unsigned DEFAULT NULL,
  `default_theme` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT 'blue-theme',
  `authentication_type` int(11) NOT NULL DEFAULT '0',
  `ldap_host` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ldap_port` int(11) NOT NULL DEFAULT '389',
  `ldap_base_dn` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ldap_bind_dn` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ldap_bind_password` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ldap_search_attribute` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `dropdown_first_entry` int(11) NOT NULL DEFAULT '1',
  `dropdown_first_remember` int(11) NOT NULL DEFAULT '1',
  `discovery_groupid` bigint(20) unsigned NOT NULL,
  `max_in_table` int(11) NOT NULL DEFAULT '50',
  `search_limit` int(11) NOT NULL DEFAULT '1000',
  `severity_color_0` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '97AAB3',
  `severity_color_1` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '7499FF',
  `severity_color_2` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT 'FFC859',
  `severity_color_3` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT 'FFA059',
  `severity_color_4` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT 'E97659',
  `severity_color_5` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT 'E45959',
  `severity_name_0` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'Not classified',
  `severity_name_1` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'Information',
  `severity_name_2` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'Warning',
  `severity_name_3` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'Average',
  `severity_name_4` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'High',
  `severity_name_5` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'Disaster',
  `ok_period` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '5m',
  `blink_period` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '2m',
  `problem_unack_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT 'CC0000',
  `problem_ack_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT 'CC0000',
  `ok_unack_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '009900',
  `ok_ack_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '009900',
  `problem_unack_style` int(11) NOT NULL DEFAULT '1',
  `problem_ack_style` int(11) NOT NULL DEFAULT '1',
  `ok_unack_style` int(11) NOT NULL DEFAULT '1',
  `ok_ack_style` int(11) NOT NULL DEFAULT '1',
  `snmptrap_logging` int(11) NOT NULL DEFAULT '1',
  `server_check_interval` int(11) NOT NULL DEFAULT '10',
  `hk_events_mode` int(11) NOT NULL DEFAULT '1',
  `hk_events_trigger` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '365d',
  `hk_events_internal` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '1d',
  `hk_events_discovery` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '1d',
  `hk_events_autoreg` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '1d',
  `hk_services_mode` int(11) NOT NULL DEFAULT '1',
  `hk_services` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '365d',
  `hk_audit_mode` int(11) NOT NULL DEFAULT '1',
  `hk_audit` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '365d',
  `hk_sessions_mode` int(11) NOT NULL DEFAULT '1',
  `hk_sessions` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '365d',
  `hk_history_mode` int(11) NOT NULL DEFAULT '1',
  `hk_history_global` int(11) NOT NULL DEFAULT '0',
  `hk_history` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '90d',
  `hk_trends_mode` int(11) NOT NULL DEFAULT '1',
  `hk_trends_global` int(11) NOT NULL DEFAULT '0',
  `hk_trends` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '365d',
  `default_inventory_mode` int(11) NOT NULL DEFAULT '-1',
  `custom_color` int(11) NOT NULL DEFAULT '0',
  `http_auth_enabled` int(11) NOT NULL DEFAULT '0',
  `http_login_form` int(11) NOT NULL DEFAULT '0',
  `http_strip_domains` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `http_case_sensitive` int(11) NOT NULL DEFAULT '1',
  `ldap_configured` int(11) NOT NULL DEFAULT '0',
  `ldap_case_sensitive` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`configid`),
  KEY `config_1` (`alert_usrgrpid`),
  KEY `config_2` (`discovery_groupid`),
  CONSTRAINT `c_config_2` FOREIGN KEY (`discovery_groupid`) REFERENCES `hstgrp` (`groupid`),
  CONSTRAINT `c_config_1` FOREIGN KEY (`alert_usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'10m','1-5,09:00-18:00',7,'blue-theme',0,'',389,'','','','',1,1,5,50,1000,'97AAB3','7499FF','FFC859','FFA059','E97659','E45959','Not classified','Information','Warning','Average','High','Disaster','5m','2m','CC0000','CC0000','009900','009900',1,1,1,1,1,10,1,'365d','1d','1d','1d',1,'365d',1,'365d',1,'365d',1,0,'90d',1,0,'365d',-1,0,0,0,'',1,0,1);
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition`
--

DROP TABLE IF EXISTS `corr_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `correlationid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`corr_conditionid`),
  KEY `corr_condition_1` (`correlationid`),
  CONSTRAINT `c_corr_condition_1` FOREIGN KEY (`correlationid`) REFERENCES `correlation` (`correlationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition`
--

LOCK TABLES `corr_condition` WRITE;
/*!40000 ALTER TABLE `corr_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_group`
--

DROP TABLE IF EXISTS `corr_condition_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition_group` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `operator` int(11) NOT NULL DEFAULT '0',
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`corr_conditionid`),
  KEY `corr_condition_group_1` (`groupid`),
  CONSTRAINT `c_corr_condition_group_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`),
  CONSTRAINT `c_corr_condition_group_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_group`
--

LOCK TABLES `corr_condition_group` WRITE;
/*!40000 ALTER TABLE `corr_condition_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_tag`
--

DROP TABLE IF EXISTS `corr_condition_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition_tag` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`corr_conditionid`),
  CONSTRAINT `c_corr_condition_tag_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_tag`
--

LOCK TABLES `corr_condition_tag` WRITE;
/*!40000 ALTER TABLE `corr_condition_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_tagpair`
--

DROP TABLE IF EXISTS `corr_condition_tagpair`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition_tagpair` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `oldtag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `newtag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`corr_conditionid`),
  CONSTRAINT `c_corr_condition_tagpair_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_tagpair`
--

LOCK TABLES `corr_condition_tagpair` WRITE;
/*!40000 ALTER TABLE `corr_condition_tagpair` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_tagpair` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_tagvalue`
--

DROP TABLE IF EXISTS `corr_condition_tagvalue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition_tagvalue` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `operator` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`corr_conditionid`),
  CONSTRAINT `c_corr_condition_tagvalue_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_tagvalue`
--

LOCK TABLES `corr_condition_tagvalue` WRITE;
/*!40000 ALTER TABLE `corr_condition_tagvalue` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_tagvalue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_operation`
--

DROP TABLE IF EXISTS `corr_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_operation` (
  `corr_operationid` bigint(20) unsigned NOT NULL,
  `correlationid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`corr_operationid`),
  KEY `corr_operation_1` (`correlationid`),
  CONSTRAINT `c_corr_operation_1` FOREIGN KEY (`correlationid`) REFERENCES `correlation` (`correlationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_operation`
--

LOCK TABLES `corr_operation` WRITE;
/*!40000 ALTER TABLE `corr_operation` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `correlation`
--

DROP TABLE IF EXISTS `correlation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `correlation` (
  `correlationid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` text COLLATE utf8_bin NOT NULL,
  `evaltype` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `formula` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`correlationid`),
  UNIQUE KEY `correlation_2` (`name`),
  KEY `correlation_1` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `correlation`
--

LOCK TABLES `correlation` WRITE;
/*!40000 ALTER TABLE `correlation` DISABLE KEYS */;
/*!40000 ALTER TABLE `correlation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard`
--

DROP TABLE IF EXISTS `dashboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard` (
  `dashboardid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `private` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`dashboardid`),
  KEY `c_dashboard_1` (`userid`),
  CONSTRAINT `c_dashboard_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard`
--

LOCK TABLES `dashboard` WRITE;
/*!40000 ALTER TABLE `dashboard` DISABLE KEYS */;
INSERT INTO `dashboard` VALUES (1,'Global view',1,0),(2,'Zabbix server health',1,1);
/*!40000 ALTER TABLE `dashboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_user`
--

DROP TABLE IF EXISTS `dashboard_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_user` (
  `dashboard_userid` bigint(20) unsigned NOT NULL,
  `dashboardid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`dashboard_userid`),
  UNIQUE KEY `dashboard_user_1` (`dashboardid`,`userid`),
  KEY `c_dashboard_user_2` (`userid`),
  CONSTRAINT `c_dashboard_user_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_dashboard_user_1` FOREIGN KEY (`dashboardid`) REFERENCES `dashboard` (`dashboardid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_user`
--

LOCK TABLES `dashboard_user` WRITE;
/*!40000 ALTER TABLE `dashboard_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_usrgrp`
--

DROP TABLE IF EXISTS `dashboard_usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_usrgrp` (
  `dashboard_usrgrpid` bigint(20) unsigned NOT NULL,
  `dashboardid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`dashboard_usrgrpid`),
  UNIQUE KEY `dashboard_usrgrp_1` (`dashboardid`,`usrgrpid`),
  KEY `c_dashboard_usrgrp_2` (`usrgrpid`),
  CONSTRAINT `c_dashboard_usrgrp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE,
  CONSTRAINT `c_dashboard_usrgrp_1` FOREIGN KEY (`dashboardid`) REFERENCES `dashboard` (`dashboardid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_usrgrp`
--

LOCK TABLES `dashboard_usrgrp` WRITE;
/*!40000 ALTER TABLE `dashboard_usrgrp` DISABLE KEYS */;
INSERT INTO `dashboard_usrgrp` VALUES (1,2,7,3);
/*!40000 ALTER TABLE `dashboard_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dbversion`
--

DROP TABLE IF EXISTS `dbversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbversion` (
  `mandatory` int(11) NOT NULL DEFAULT '0',
  `optional` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dbversion`
--

LOCK TABLES `dbversion` WRITE;
/*!40000 ALTER TABLE `dbversion` DISABLE KEYS */;
INSERT INTO `dbversion` VALUES (4000000,4000005);
/*!40000 ALTER TABLE `dbversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dchecks`
--

DROP TABLE IF EXISTS `dchecks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dchecks` (
  `dcheckid` bigint(20) unsigned NOT NULL,
  `druleid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `key_` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmp_community` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ports` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `snmpv3_securityname` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmpv3_securitylevel` int(11) NOT NULL DEFAULT '0',
  `snmpv3_authpassphrase` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmpv3_privpassphrase` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `uniq` int(11) NOT NULL DEFAULT '0',
  `snmpv3_authprotocol` int(11) NOT NULL DEFAULT '0',
  `snmpv3_privprotocol` int(11) NOT NULL DEFAULT '0',
  `snmpv3_contextname` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`dcheckid`),
  KEY `dchecks_1` (`druleid`),
  CONSTRAINT `c_dchecks_1` FOREIGN KEY (`druleid`) REFERENCES `drules` (`druleid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dchecks`
--

LOCK TABLES `dchecks` WRITE;
/*!40000 ALTER TABLE `dchecks` DISABLE KEYS */;
INSERT INTO `dchecks` VALUES (2,2,9,'system.uname','','10050','',0,'','',0,0,0,'');
/*!40000 ALTER TABLE `dchecks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dhosts`
--

DROP TABLE IF EXISTS `dhosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dhosts` (
  `dhostid` bigint(20) unsigned NOT NULL,
  `druleid` bigint(20) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `lastup` int(11) NOT NULL DEFAULT '0',
  `lastdown` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dhostid`),
  KEY `dhosts_1` (`druleid`),
  CONSTRAINT `c_dhosts_1` FOREIGN KEY (`druleid`) REFERENCES `drules` (`druleid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dhosts`
--

LOCK TABLES `dhosts` WRITE;
/*!40000 ALTER TABLE `dhosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `dhosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drules`
--

DROP TABLE IF EXISTS `drules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drules` (
  `druleid` bigint(20) unsigned NOT NULL,
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `iprange` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `delay` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '1h',
  `nextcheck` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`druleid`),
  UNIQUE KEY `drules_2` (`name`),
  KEY `drules_1` (`proxy_hostid`),
  CONSTRAINT `c_drules_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drules`
--

LOCK TABLES `drules` WRITE;
/*!40000 ALTER TABLE `drules` DISABLE KEYS */;
INSERT INTO `drules` VALUES (2,NULL,'Local network','192.168.0.1-254','1h',0,1);
/*!40000 ALTER TABLE `drules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dservices`
--

DROP TABLE IF EXISTS `dservices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dservices` (
  `dserviceid` bigint(20) unsigned NOT NULL,
  `dhostid` bigint(20) unsigned NOT NULL,
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `lastup` int(11) NOT NULL DEFAULT '0',
  `lastdown` int(11) NOT NULL DEFAULT '0',
  `dcheckid` bigint(20) unsigned NOT NULL,
  `ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `dns` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`dserviceid`),
  UNIQUE KEY `dservices_1` (`dcheckid`,`ip`,`port`),
  KEY `dservices_2` (`dhostid`),
  CONSTRAINT `c_dservices_2` FOREIGN KEY (`dcheckid`) REFERENCES `dchecks` (`dcheckid`) ON DELETE CASCADE,
  CONSTRAINT `c_dservices_1` FOREIGN KEY (`dhostid`) REFERENCES `dhosts` (`dhostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dservices`
--

LOCK TABLES `dservices` WRITE;
/*!40000 ALTER TABLE `dservices` DISABLE KEYS */;
/*!40000 ALTER TABLE `dservices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `escalations`
--

DROP TABLE IF EXISTS `escalations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `escalations` (
  `escalationid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned DEFAULT NULL,
  `eventid` bigint(20) unsigned DEFAULT NULL,
  `r_eventid` bigint(20) unsigned DEFAULT NULL,
  `nextcheck` int(11) NOT NULL DEFAULT '0',
  `esc_step` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `itemid` bigint(20) unsigned DEFAULT NULL,
  `acknowledgeid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`escalationid`),
  UNIQUE KEY `escalations_1` (`triggerid`,`itemid`,`escalationid`),
  KEY `escalations_2` (`eventid`),
  KEY `escalations_3` (`nextcheck`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `escalations`
--

LOCK TABLES `escalations` WRITE;
/*!40000 ALTER TABLE `escalations` DISABLE KEYS */;
/*!40000 ALTER TABLE `escalations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_recovery`
--

DROP TABLE IF EXISTS `event_recovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_recovery` (
  `eventid` bigint(20) unsigned NOT NULL,
  `r_eventid` bigint(20) unsigned NOT NULL,
  `c_eventid` bigint(20) unsigned DEFAULT NULL,
  `correlationid` bigint(20) unsigned DEFAULT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`eventid`),
  KEY `event_recovery_1` (`r_eventid`),
  KEY `event_recovery_2` (`c_eventid`),
  CONSTRAINT `c_event_recovery_3` FOREIGN KEY (`c_eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_event_recovery_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_event_recovery_2` FOREIGN KEY (`r_eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_recovery`
--

LOCK TABLES `event_recovery` WRITE;
/*!40000 ALTER TABLE `event_recovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_recovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_suppress`
--

DROP TABLE IF EXISTS `event_suppress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_suppress` (
  `event_suppressid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned DEFAULT NULL,
  `suppress_until` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`event_suppressid`),
  UNIQUE KEY `event_suppress_1` (`eventid`,`maintenanceid`),
  KEY `event_suppress_2` (`suppress_until`),
  KEY `event_suppress_3` (`maintenanceid`),
  CONSTRAINT `c_event_suppress_2` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE,
  CONSTRAINT `c_event_suppress_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_suppress`
--

LOCK TABLES `event_suppress` WRITE;
/*!40000 ALTER TABLE `event_suppress` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_suppress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_tag`
--

DROP TABLE IF EXISTS `event_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_tag` (
  `eventtagid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`eventtagid`),
  KEY `event_tag_1` (`eventid`),
  CONSTRAINT `c_event_tag_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_tag`
--

LOCK TABLES `event_tag` WRITE;
/*!40000 ALTER TABLE `event_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `eventid` bigint(20) unsigned NOT NULL,
  `source` int(11) NOT NULL DEFAULT '0',
  `object` int(11) NOT NULL DEFAULT '0',
  `objectid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  `acknowledged` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  `name` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `severity` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`eventid`),
  KEY `events_1` (`source`,`object`,`objectid`,`clock`),
  KEY `events_2` (`source`,`object`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expressions`
--

DROP TABLE IF EXISTS `expressions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expressions` (
  `expressionid` bigint(20) unsigned NOT NULL,
  `regexpid` bigint(20) unsigned NOT NULL,
  `expression` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `expression_type` int(11) NOT NULL DEFAULT '0',
  `exp_delimiter` varchar(1) COLLATE utf8_bin NOT NULL DEFAULT '',
  `case_sensitive` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`expressionid`),
  KEY `expressions_1` (`regexpid`),
  CONSTRAINT `c_expressions_1` FOREIGN KEY (`regexpid`) REFERENCES `regexps` (`regexpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expressions`
--

LOCK TABLES `expressions` WRITE;
/*!40000 ALTER TABLE `expressions` DISABLE KEYS */;
INSERT INTO `expressions` VALUES (1,1,'^(btrfs|ext2|ext3|ext4|reiser|xfs|ffs|ufs|jfs|jfs2|vxfs|hfs|apfs|refs|ntfs|fat32|zfs)$',3,',',0),(3,3,'^(Physical memory|Virtual memory|Memory buffers|Cached memory|Swap space)$',4,',',1),(5,4,'^(MMCSS|gupdate|SysmonLog|clr_optimization_v2.0.50727_32|clr_optimization_v4.0.30319_32)$',4,',',1),(6,5,'^(automatic|automatic delayed)$',3,',',1),(7,2,'^Software Loopback Interface',4,',',1),(8,2,'^(In)?[Ll]oop[Bb]ack[0-9._]*$',4,',',1),(9,2,'^NULL[0-9.]*$',4,',',1),(10,2,'^[Ll]o[0-9.]*$',4,',',1),(11,2,'^[Ss]ystem$',4,',',1),(12,2,'^Nu[0-9.]*$',4,',',1);
/*!40000 ALTER TABLE `expressions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `functions`
--

DROP TABLE IF EXISTS `functions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `functions` (
  `functionid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `name` varchar(12) COLLATE utf8_bin NOT NULL DEFAULT '',
  `parameter` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '0',
  PRIMARY KEY (`functionid`),
  KEY `functions_1` (`triggerid`),
  KEY `functions_2` (`itemid`,`name`,`parameter`),
  CONSTRAINT `c_functions_2` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_functions_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `functions`
--

LOCK TABLES `functions` WRITE;
/*!40000 ALTER TABLE `functions` DISABLE KEYS */;
INSERT INTO `functions` VALUES (10199,10019,10016,'diff','0'),(10204,10055,10041,'last','0'),(10207,10058,10044,'diff','0'),(10208,10057,10043,'diff','0'),(12144,22181,13000,'last','0'),(12549,22232,13025,'nodata','5m'),(12550,10020,10047,'nodata','5m'),(12553,10056,10042,'last','0'),(12580,17350,10012,'last','0'),(12583,10025,10021,'change','0'),(12592,22686,13266,'last','0'),(12598,22454,13272,'last','0'),(12641,22189,13015,'max','10m'),(12645,22183,13073,'max','10m'),(12646,22191,13074,'max','10m'),(12648,23620,13075,'max','10m'),(12649,22185,13019,'max','10m'),(12651,22396,13017,'max','10m'),(12653,22219,13023,'min','10m'),(12715,22833,13328,'nodata','5m'),(12717,22835,13330,'last','0'),(12718,22836,13331,'last','0'),(12723,22853,13336,'diff','0'),(12724,22856,13337,'last','0'),(12725,22858,13338,'diff','0'),(12726,22859,13339,'change','0'),(12727,22861,13340,'diff','0'),(12728,22862,13341,'last','0'),(12729,22869,13342,'last','0'),(12730,22872,13343,'last','0'),(12731,22873,13344,'nodata','5m'),(12733,22875,13346,'last','0'),(12734,22876,13347,'last','0'),(12739,22893,13352,'diff','0'),(12740,22896,13353,'last','0'),(12741,22898,13354,'diff','0'),(12742,22899,13355,'change','0'),(12743,22901,13356,'diff','0'),(12744,22902,13357,'last','0'),(12745,22909,13358,'last','0'),(12746,22912,13359,'last','0'),(12747,22913,13360,'nodata','5m'),(12755,22933,13368,'diff','0'),(12757,22938,13370,'diff','0'),(12758,22939,13371,'change','0'),(12759,22941,13372,'diff','0'),(12760,22942,13373,'last','0'),(12761,22949,13374,'last','0'),(12762,22952,13375,'last','0'),(12763,22953,13376,'nodata','5m'),(12771,22973,13384,'diff','0'),(12773,22978,13386,'diff','0'),(12775,22981,13388,'diff','0'),(12776,22982,13389,'last','0'),(12777,22989,13390,'last','0'),(12778,22992,13391,'last','0'),(12779,22993,13392,'nodata','5m'),(12782,22996,13395,'last','0'),(12787,23013,13400,'diff','0'),(12788,23016,13401,'last','0'),(12789,23018,13402,'diff','0'),(12790,23019,13403,'change','0'),(12791,23021,13404,'diff','0'),(12792,23022,13405,'last','0'),(12793,23029,13406,'last','0'),(12794,23032,13407,'last','0'),(12795,23033,13408,'nodata','5m'),(12797,23035,13410,'last','0'),(12798,23036,13411,'last','0'),(12803,23053,13416,'diff','0'),(12805,23058,13418,'diff','0'),(12806,23059,13419,'change','0'),(12807,23061,13420,'diff','0'),(12808,23062,13421,'last','0'),(12809,23069,13422,'last','0'),(12810,23072,13423,'last','0'),(12812,23149,13425,'diff','0'),(12815,23150,13428,'change','0'),(12818,23668,13431,'min','10m'),(12820,23158,13433,'last','0'),(12824,23160,13437,'nodata','5m'),(12826,23165,13439,'last','0'),(12895,23271,13486,'min','10m'),(12896,23273,13487,'max','10m'),(12897,23274,13488,'max','10m'),(12898,23275,13489,'max','10m'),(12899,23276,13490,'max','10m'),(12900,23287,13491,'nodata','5m'),(12902,23289,13493,'last','0'),(12903,23290,13494,'last','0'),(12908,23307,13499,'diff','0'),(12909,23310,13500,'last','0'),(12910,23312,13501,'diff','0'),(12911,23313,13502,'change','0'),(12912,23315,13503,'diff','0'),(12913,23316,13504,'last','0'),(12914,23282,13505,'last','0'),(12915,23284,13506,'last','0'),(12926,22231,13026,'diff','0'),(12927,10059,10045,'diff','0'),(12928,23288,13492,'diff','0'),(12929,22834,13329,'diff','0'),(12930,22874,13345,'diff','0'),(12931,22914,13361,'diff','0'),(12932,22954,13377,'diff','0'),(12933,22994,13393,'diff','0'),(12934,23034,13409,'diff','0'),(12935,23161,13438,'diff','0'),(12936,23318,13507,'diff','0'),(12937,23319,13508,'diff','0'),(12938,23327,13509,'diff','0'),(12939,23320,13510,'diff','0'),(12940,23321,13511,'diff','0'),(12941,23322,13512,'diff','0'),(12942,23323,13513,'diff','0'),(12943,23324,13514,'diff','0'),(12944,23325,13515,'diff','0'),(12945,23326,13516,'diff','0'),(12946,23357,13517,'max','10m'),(12947,23342,13518,'max','10m'),(12948,23341,13519,'max','10m'),(12949,23359,13520,'min','10m'),(12965,23634,13536,'max','10m'),(12966,23635,13537,'max','10m'),(12994,23644,13544,'max','#3'),(12995,23645,13545,'max','#3'),(12996,23646,13546,'max','#3'),(12997,23647,13547,'max','#3'),(12998,23648,13548,'max','#3'),(13068,23115,13367,'avg','5m'),(13069,22922,13366,'avg','5m'),(13070,22918,13365,'avg','5m'),(13071,22917,13364,'avg','5m'),(13072,22882,13350,'avg','5m'),(13073,22878,13349,'avg','5m'),(13074,22877,13348,'avg','5m'),(13075,22962,13382,'avg','5m'),(13078,10010,10010,'avg','5m'),(13079,23296,13497,'avg','5m'),(13080,17362,13243,'avg','5m'),(13081,23301,13498,'avg','5m'),(13082,10009,10190,'avg','5m'),(13083,23292,13496,'avg','5m'),(13084,10013,10011,'avg','5m'),(13085,23291,13495,'avg','5m'),(13086,23042,13414,'avg','5m'),(13087,22842,13334,'avg','5m'),(13088,22838,13333,'avg','5m'),(13089,22837,13332,'avg','5m'),(13090,23007,13399,'avg','5m'),(13091,23002,13398,'avg','5m'),(13092,22998,13397,'avg','5m'),(13093,22997,13396,'avg','5m'),(13094,23143,13435,'avg','5m'),(13095,23140,13430,'avg','5m'),(13152,23651,13551,'max','#3'),(13154,23649,13549,'max','#3'),(13156,23650,13550,'max','#3'),(13157,23652,13552,'max','#3'),(13158,23653,13553,'max','#3'),(13159,23654,13285,'max','#3'),(13160,23661,13557,'last',''),(13161,23662,13558,'last',''),(13164,22424,13080,'avg','10m'),(13165,23252,13467,'avg','10m'),(13170,22412,13081,'avg','10m'),(13171,23253,13468,'avg','10m'),(13172,22430,13083,'avg','10m'),(13173,23255,13470,'avg','10m'),(13174,22422,13084,'avg','10m'),(13175,23256,13471,'avg','10m'),(13176,22406,13085,'avg','10m'),(13177,23257,13472,'avg','10m'),(13178,22408,13086,'avg','30m'),(13179,23258,13473,'avg','30m'),(13180,22402,13087,'avg','10m'),(13181,23259,13474,'avg','10m'),(13182,22418,13088,'avg','10m'),(13183,23260,13475,'avg','10m'),(13184,22416,13089,'avg','10m'),(13185,23261,13476,'avg','10m'),(13186,22689,13275,'avg','10m'),(13187,23262,13477,'avg','10m'),(13188,22399,13091,'avg','10m'),(13189,23264,13479,'avg','10m'),(13190,22420,13092,'avg','10m'),(13191,23265,13480,'avg','10m'),(13192,22414,13093,'min','10m'),(13193,23266,13481,'min','10m'),(13194,23171,13441,'avg','10m'),(13195,23267,13482,'avg','10m'),(13196,23663,13559,'avg','10m'),(13197,23664,13560,'avg','10m'),(13198,22426,13094,'avg','10m'),(13199,23268,13483,'avg','10m'),(13200,22404,13095,'avg','10m'),(13201,23269,13484,'avg','10m'),(13202,22400,13096,'avg','10m'),(13203,23270,13485,'avg','10m'),(13204,22401,13097,'avg','10m'),(13205,23328,13436,'avg','10m'),(13206,23347,13521,'avg','10m'),(13207,23360,13534,'avg','10m'),(13208,23352,13522,'avg','10m'),(13209,23351,13535,'avg','10m'),(13210,23350,13523,'avg','10m'),(13211,23353,13524,'avg','30m'),(13212,23354,13525,'avg','10m'),(13213,23356,13526,'avg','10m'),(13214,23355,13527,'avg','10m'),(13215,23349,13528,'avg','10m'),(13216,23348,13529,'avg','10m'),(13217,23343,13530,'avg','10m'),(13218,23344,13531,'avg','10m'),(13219,23345,13532,'avg','10m'),(13220,23346,13533,'avg','10m'),(13221,23666,13561,'min','#3'),(13222,25366,13562,'avg','10m'),(13223,25367,13563,'avg','10m'),(13224,25368,13564,'avg','10m'),(13225,25369,13565,'avg','10m'),(13226,25370,13566,'avg','10m'),(13227,25371,13567,'avg','10m'),(13228,25665,13568,'avg','10m'),(13229,25666,13569,'avg','10m'),(13230,25667,13570,'avg','10m'),(13231,25668,13571,'avg','10m'),(14257,26909,14168,'last','0'),(14258,26908,14168,'last','0'),(14259,26899,14169,'last','0'),(14260,26903,14169,'last','0'),(14261,26902,14170,'last','0'),(14262,26901,14170,'last','0'),(14263,26864,14171,'last','0'),(14264,26882,14171,'last','0'),(14265,26866,14172,'last','0'),(14266,26865,14172,'last','0'),(14267,26861,14173,'last','0'),(14268,26862,14173,'last','0'),(14269,26858,14174,'last','0'),(14270,26856,14174,'last','0'),(14271,26868,14175,'last','0'),(14272,26860,14175,'last','0'),(14273,26877,14176,'last','0'),(14274,26878,14176,'last','0'),(14275,26880,14177,'last','0'),(14276,26879,14177,'last','0'),(14277,26881,14178,'last','0'),(14278,26887,14179,'last','0'),(14279,26895,14179,'last','0'),(14280,26889,14180,'last','0'),(14281,26884,14180,'last','0'),(14282,26906,14181,'last','0'),(14283,26896,14181,'last','0'),(14284,26907,14182,'last','0'),(14285,26908,14182,'last','0'),(14286,26904,14183,'last','0'),(14287,26903,14183,'last','0'),(14288,26900,14184,'last','0'),(14289,26901,14184,'last','0'),(14290,26883,14185,'last','0'),(14291,26882,14185,'last','0'),(14292,26863,14186,'last','0'),(14293,26865,14186,'last','0'),(14294,26867,14187,'last','0'),(14295,26862,14187,'last','0'),(14296,26857,14188,'last','0'),(14297,26856,14188,'last','0'),(14298,26859,14189,'last','0'),(14299,26860,14189,'last','0'),(14300,26869,14190,'last','0'),(14301,26878,14190,'last','0'),(14302,26876,14191,'nodata','5m'),(14303,26875,14192,'str','Server'),(14304,26893,14193,'str','Client'),(14305,26924,14194,'last','0'),(14306,26932,14195,'last','0'),(14307,26932,14196,'last','0'),(14308,26930,14197,'last','0'),(14309,26930,14198,'last','0'),(14310,26931,14199,'last','0'),(14311,26931,14200,'last','0'),(14312,26929,14201,'last','0'),(14313,26929,14202,'last','0'),(14314,26928,14203,'last','0'),(14315,26928,14204,'last','0'),(14316,26925,14205,'last','0'),(14317,26943,14206,'last','0'),(14318,26943,14207,'last','0'),(14319,26939,14208,'last','0'),(14320,26939,14209,'last','0'),(14321,26940,14210,'last','0'),(14322,26940,14211,'last','0'),(14323,26941,14212,'last','0'),(14324,26941,14213,'last','0'),(14325,26942,14214,'last','0'),(14326,26942,14215,'last','0'),(14327,26938,14216,'last','0'),(14328,26938,14217,'last','0'),(14329,26937,14218,'last','0'),(14330,26937,14219,'last','0'),(14331,26933,14220,'last','0'),(14332,26933,14221,'last','0'),(14333,26934,14222,'last','0'),(14334,26935,14223,'last','0'),(14335,26935,14224,'last','0'),(14336,26936,14225,'last','0'),(14337,26936,14226,'last','0'),(14378,27067,14251,'max','#3'),(14379,27066,14252,'min','5m'),(14380,27065,14253,'avg','5m'),(14463,27138,14288,'max','#3'),(14464,27139,14289,'min','5m'),(14465,27140,14290,'avg','5m'),(14468,27149,14293,'max','#3'),(14469,27150,14294,'min','5m'),(14470,27151,14295,'avg','5m'),(14508,27192,14311,'max','#3'),(14509,27193,14312,'min','5m'),(14510,27194,14313,'avg','5m'),(14513,27208,14316,'avg','5m'),(14514,27205,14317,'avg','5m'),(14515,27212,14318,'avg','5m'),(14516,27212,14318,'max','5m'),(14517,27212,14319,'avg','5m'),(14518,27212,14319,'max','5m'),(14519,27212,14320,'avg','5m'),(14520,27212,14320,'min','5m'),(14522,27214,14322,'diff',''),(14523,27214,14322,'strlen',''),(14536,27225,14327,'max','#3'),(14537,27226,14328,'min','5m'),(14538,27227,14329,'avg','5m'),(14541,27240,14332,'avg','5m'),(14542,27239,14333,'avg','5m'),(14545,27237,14336,'diff',''),(14546,27237,14336,'strlen',''),(14547,27236,14337,'diff',''),(14548,27236,14337,'strlen',''),(14552,27247,14339,'avg','5m'),(14553,27247,14339,'max','5m'),(14554,27247,14340,'avg','5m'),(14555,27247,14340,'min','5m'),(14570,27261,14347,'max','#3'),(14571,27262,14348,'min','5m'),(14572,27263,14349,'avg','5m'),(14587,27282,14356,'max','#3'),(14588,27283,14357,'min','5m'),(14589,27284,14358,'avg','5m'),(14592,27294,14361,'avg','5m'),(14593,27293,14362,'avg','5m'),(14594,27296,14363,'diff',''),(14595,27296,14363,'strlen',''),(14596,27295,14364,'diff',''),(14597,27295,14364,'strlen',''),(14598,27297,14365,'diff',''),(14599,27297,14365,'strlen',''),(14600,27299,14366,'avg','5m'),(14601,27301,14367,'avg','5m'),(14602,27298,14368,'avg','5m'),(14603,27300,14369,'avg','5m'),(14606,27314,14372,'avg','5m'),(14607,27314,14372,'max','5m'),(14608,27314,14373,'avg','5m'),(14609,27314,14373,'max','5m'),(14610,27314,14374,'avg','5m'),(14611,27314,14374,'min','5m'),(14612,27315,14375,'avg','5m'),(14613,27315,14375,'max','5m'),(14614,27315,14376,'avg','5m'),(14615,27315,14376,'max','5m'),(14616,27315,14377,'avg','5m'),(14617,27315,14377,'min','5m'),(14620,27318,14380,'avg','5m'),(14621,27318,14380,'max','5m'),(14622,27318,14381,'avg','5m'),(14623,27318,14381,'max','5m'),(14624,27318,14382,'avg','5m'),(14625,27318,14382,'min','5m'),(14626,27320,14383,'diff',''),(14627,27320,14383,'strlen',''),(14641,27333,14389,'max','#3'),(14642,27334,14390,'min','5m'),(14643,27335,14391,'avg','5m'),(14663,27365,14403,'max','#3'),(14664,27366,14404,'min','5m'),(14665,27367,14405,'avg','5m'),(14668,27376,14408,'avg','5m'),(14669,27378,14409,'diff',''),(14670,27378,14409,'strlen',''),(14671,27380,14410,'avg','5m'),(14672,27385,14411,'diff',''),(14673,27385,14411,'strlen',''),(14676,27382,14413,'diff',''),(14677,27382,14413,'strlen',''),(14678,27414,14414,'avg','5m'),(14679,27417,14415,'avg','5m'),(14681,27419,14417,'diff',''),(14682,27419,14417,'strlen',''),(14689,27421,14420,'avg','5m'),(14690,27421,14420,'min','5m'),(14693,27424,14423,'avg','5m'),(14695,27442,14425,'avg','5m'),(14696,27427,14426,'avg','5m'),(14698,27428,14428,'diff',''),(14699,27428,14428,'strlen',''),(14702,27445,14430,'diff',''),(14703,27445,14430,'strlen',''),(14722,27430,14437,'avg','5m'),(14723,27430,14437,'min','5m'),(14726,27447,14439,'avg','5m'),(14727,27447,14439,'min','5m'),(14747,27462,14451,'max','#3'),(14748,27463,14452,'min','5m'),(14749,27464,14453,'avg','5m'),(14752,27478,14456,'avg','5m'),(14753,27477,14457,'avg','5m'),(14756,27485,14460,'avg','5m'),(14757,27485,14460,'max','5m'),(14758,27485,14461,'avg','5m'),(14759,27485,14461,'max','5m'),(14760,27485,14462,'avg','5m'),(14761,27485,14462,'min','5m'),(14762,27483,14463,'diff',''),(14763,27483,14463,'strlen',''),(14776,27496,14468,'max','#3'),(14777,27497,14469,'min','5m'),(14778,27498,14470,'avg','5m'),(14781,27511,14473,'avg','5m'),(14782,27509,14474,'diff',''),(14783,27509,14474,'strlen',''),(14784,27516,14475,'avg','5m'),(14785,27517,14476,'avg','5m'),(14786,27517,14476,'max','5m'),(14787,27517,14477,'avg','5m'),(14788,27517,14477,'max','5m'),(14789,27517,14478,'avg','5m'),(14790,27517,14478,'min','5m'),(14806,27532,14486,'max','#3'),(14807,27533,14487,'min','5m'),(14808,27534,14488,'avg','5m'),(14811,27547,14491,'avg','5m'),(14812,27545,14492,'diff',''),(14813,27545,14492,'strlen',''),(14814,27544,14493,'diff',''),(14815,27544,14493,'strlen',''),(14816,27552,14494,'avg','5m'),(14817,27553,14495,'avg','5m'),(14818,27553,14495,'max','5m'),(14819,27553,14496,'avg','5m'),(14820,27553,14496,'max','5m'),(14821,27553,14497,'avg','5m'),(14822,27553,14497,'min','5m'),(14838,27568,14505,'max','#3'),(14839,27569,14506,'min','5m'),(14840,27570,14507,'avg','5m'),(14843,27586,14510,'avg','5m'),(14844,27584,14511,'avg','5m'),(14845,27584,14511,'max','5m'),(14849,27584,14513,'avg','5m'),(14850,27584,14513,'min','5m'),(14851,27582,14514,'diff',''),(14852,27582,14514,'strlen',''),(14853,27579,14515,'diff',''),(14854,27579,14515,'strlen',''),(14855,27590,14516,'avg','5m'),(14871,27608,14524,'max','#3'),(14872,27609,14525,'min','5m'),(14873,27610,14526,'avg','5m'),(14889,27631,14534,'max','#3'),(14890,27632,14535,'min','5m'),(14891,27633,14536,'avg','5m'),(14907,27654,14544,'max','#3'),(14908,27655,14545,'min','5m'),(14909,27656,14546,'avg','5m'),(14912,27671,14549,'avg','5m'),(14913,27670,14550,'avg','5m'),(14914,27672,14551,'avg','5m'),(14915,27672,14551,'max','5m'),(14916,27672,14552,'avg','5m'),(14917,27672,14552,'max','5m'),(14918,27672,14553,'avg','5m'),(14919,27672,14553,'min','5m'),(14922,27678,14556,'diff',''),(14923,27678,14556,'strlen',''),(14924,27677,14557,'diff',''),(14925,27677,14557,'strlen',''),(14972,27734,14582,'max','#3'),(14973,27735,14583,'min','5m'),(14974,27736,14584,'avg','5m'),(14977,27753,14587,'avg','5m'),(14978,27752,14588,'avg','5m'),(14979,27751,14589,'avg','5m'),(14980,27751,14589,'max','5m'),(14981,27751,14590,'avg','5m'),(14982,27751,14590,'max','5m'),(14983,27751,14591,'avg','5m'),(14984,27751,14591,'min','5m'),(14985,27750,14592,'diff',''),(14986,27750,14592,'strlen',''),(15000,27766,14598,'max','#3'),(15001,27767,14599,'min','5m'),(15002,27768,14600,'avg','5m'),(15005,27777,14603,'diff',''),(15006,27777,14603,'strlen',''),(15013,27784,14606,'avg','5m'),(15014,27784,14606,'min','5m'),(15015,27785,14607,'diff',''),(15016,27785,14607,'strlen',''),(15032,27800,14615,'max','#3'),(15033,27801,14616,'min','5m'),(15034,27802,14617,'avg','5m'),(15038,27813,14621,'diff',''),(15039,27813,14621,'strlen',''),(15041,27819,14623,'avg','5m'),(15042,27821,14624,'avg','5m'),(15043,27821,14624,'max','5m'),(15044,27821,14625,'avg','5m'),(15045,27821,14625,'max','5m'),(15046,27821,14626,'avg','5m'),(15047,27821,14626,'min','5m'),(15094,27882,14652,'max','#3'),(15095,27883,14653,'min','5m'),(15096,27884,14654,'avg','5m'),(15099,27899,14657,'avg','5m'),(15100,27897,14658,'avg','5m'),(15101,27897,14658,'max','5m'),(15102,27897,14659,'avg','5m'),(15103,27897,14659,'max','5m'),(15104,27897,14660,'avg','5m'),(15105,27897,14660,'min','5m'),(15106,27894,14661,'diff',''),(15107,27894,14661,'strlen',''),(15108,27895,14662,'diff',''),(15109,27895,14662,'strlen',''),(15110,27904,14663,'avg','5m'),(15111,27905,14664,'avg','5m'),(15112,27905,14664,'max','5m'),(15113,27905,14665,'avg','5m'),(15114,27905,14665,'max','5m'),(15115,27905,14666,'avg','5m'),(15116,27905,14666,'min','5m'),(15117,27906,14667,'avg','5m'),(15118,27906,14668,'avg','5m'),(15131,27919,14673,'max','#3'),(15132,27920,14674,'min','5m'),(15133,27921,14675,'avg','5m'),(15136,27936,14678,'avg','5m'),(15137,27933,14679,'avg','5m'),(15138,27931,14680,'diff',''),(15139,27931,14680,'strlen',''),(15146,27941,14683,'avg','5m'),(15147,27941,14683,'min','5m'),(15163,27956,14691,'max','#3'),(15164,27957,14692,'min','5m'),(15165,27958,14693,'avg','5m'),(15168,27975,14696,'avg','5m'),(15169,27974,14697,'avg','5m'),(15170,27970,14698,'diff',''),(15171,27970,14698,'strlen',''),(15172,27967,14699,'diff',''),(15173,27967,14699,'strlen',''),(15186,27986,14704,'max','#3'),(15187,27987,14705,'min','5m'),(15188,27988,14706,'avg','5m'),(15191,27999,14709,'diff',''),(15192,27999,14709,'strlen',''),(15193,27998,14710,'diff',''),(15194,27998,14710,'strlen',''),(15195,28003,14711,'avg','5m'),(15196,28004,14712,'avg','5m'),(15209,28015,14717,'max','#3'),(15210,28016,14718,'min','5m'),(15211,28017,14719,'avg','5m'),(15214,28031,14722,'avg','5m'),(15215,28028,14723,'avg','5m'),(15216,28027,14724,'diff',''),(15217,28027,14724,'strlen',''),(15597,28070,14869,'max','#3'),(15598,28071,14870,'min','5m'),(15599,28072,14871,'avg','5m'),(15618,28107,14882,'max','#3'),(15619,28108,14883,'min','5m'),(15620,28109,14884,'avg','5m'),(15678,28130,14906,'max','#3'),(15679,28131,14907,'min','5m'),(15680,28132,14908,'avg','5m'),(15683,28143,14911,'avg','5m'),(15684,28142,14912,'diff',''),(15685,28142,14912,'strlen',''),(15686,28141,14913,'diff',''),(15687,28141,14913,'strlen',''),(15688,28150,14914,'avg','5m'),(15689,28150,14914,'max','5m'),(15690,28150,14915,'avg','5m'),(15691,28150,14915,'max','5m'),(15692,28150,14916,'avg','5m'),(15693,28150,14916,'min','5m'),(15694,28151,14917,'avg','5m'),(15713,28185,14928,'max','#3'),(15714,28186,14929,'min','5m'),(15715,28187,14930,'avg','5m'),(15721,28201,14934,'avg','5m'),(15722,28201,14934,'max','5m'),(15723,28201,14935,'avg','5m'),(15724,28201,14935,'min','5m'),(15726,28204,14937,'diff',''),(15727,28204,14937,'strlen',''),(15729,27030,14939,'last',''),(15730,27607,14940,'last',''),(15731,27032,14941,'last',''),(15732,27191,14942,'last',''),(15733,27332,14943,'last',''),(15734,27461,14944,'last',''),(15735,27531,14945,'last',''),(15736,27567,14946,'last',''),(15737,27630,14947,'last',''),(15738,27653,14948,'last',''),(15739,27733,14949,'last',''),(15740,27799,14950,'last',''),(15741,27955,14951,'last',''),(15742,28069,14952,'last',''),(15743,28129,14953,'last',''),(16352,27143,15161,'max','{$SNMP_TIMEOUT}'),(16353,27618,15162,'max','{$SNMP_TIMEOUT}'),(16354,28025,15163,'max','{$SNMP_TIMEOUT}'),(16375,27154,15170,'max','{$SNMP_TIMEOUT}'),(16376,27202,15171,'max','{$SNMP_TIMEOUT}'),(16377,27235,15172,'max','{$SNMP_TIMEOUT}'),(16378,27271,15173,'max','{$SNMP_TIMEOUT}'),(16379,27292,15174,'max','{$SNMP_TIMEOUT}'),(16380,27343,15175,'max','{$SNMP_TIMEOUT}'),(16381,27375,15176,'max','{$SNMP_TIMEOUT}'),(16382,27472,15177,'max','{$SNMP_TIMEOUT}'),(16383,27506,15178,'max','{$SNMP_TIMEOUT}'),(16384,27542,15179,'max','{$SNMP_TIMEOUT}'),(16385,27578,15180,'max','{$SNMP_TIMEOUT}'),(16386,27641,15181,'max','{$SNMP_TIMEOUT}'),(16387,27664,15182,'max','{$SNMP_TIMEOUT}'),(16388,27744,15183,'max','{$SNMP_TIMEOUT}'),(16389,27776,15184,'max','{$SNMP_TIMEOUT}'),(16390,27810,15185,'max','{$SNMP_TIMEOUT}'),(16391,27892,15186,'max','{$SNMP_TIMEOUT}'),(16392,27929,15187,'max','{$SNMP_TIMEOUT}'),(16393,27966,15188,'max','{$SNMP_TIMEOUT}'),(16394,27996,15189,'max','{$SNMP_TIMEOUT}'),(16395,28080,15190,'max','{$SNMP_TIMEOUT}'),(16396,28117,15191,'max','{$SNMP_TIMEOUT}'),(16397,28140,15192,'max','{$SNMP_TIMEOUT}'),(16398,28195,15193,'max','{$SNMP_TIMEOUT}'),(16445,28210,15208,'diff',''),(16446,28210,15208,'strlen',''),(16447,28208,15209,'diff',''),(16448,28208,15209,'strlen',''),(16457,28218,15214,'avg','5m'),(16458,28218,15214,'min','5m'),(16459,28221,15215,'avg','5m'),(16472,28233,15220,'max','#3'),(16473,28234,15221,'min','5m'),(16474,28235,15222,'avg','5m'),(16476,28243,15224,'max','{$SNMP_TIMEOUT}'),(16477,28246,15225,'avg','5m'),(16484,28247,15228,'avg','5m'),(16818,27213,15330,'count','#1,{$FAN_CRIT_STATUS},eq'),(16819,27479,15331,'count','#1,{$PSU_CRIT_STATUS},eq'),(16820,27479,15332,'count','#1,{$PSU_OK_STATUS},ne'),(16821,27480,15333,'count','#1,{$FAN_CRIT_STATUS},eq'),(16822,27480,15334,'count','#1,{$FAN_OK_STATUS},ne'),(16823,27784,15335,'avg','5m'),(16824,27783,15335,'last','0'),(16825,27784,15335,'max','5m'),(16826,27784,15336,'avg','5m'),(16827,27783,15336,'last','0'),(16828,27784,15336,'max','5m'),(16829,27786,15337,'count','#1,{$PSU_CRIT_STATUS},eq'),(16830,27786,15338,'count','#1,{$PSU_WARN_STATUS},eq'),(16831,27787,15339,'count','#1,{$FAN_CRIT_STATUS},eq'),(16832,27554,15340,'count','#1,{$PSU_CRIT_STATUS},eq'),(16833,27555,15341,'count','#1,{$FAN_CRIT_STATUS},eq'),(16834,27421,15342,'avg','5m'),(16835,27420,15342,'last','0'),(16836,27421,15342,'max','5m'),(16837,27421,15343,'avg','5m'),(16838,27420,15343,'last','0'),(16839,27421,15343,'max','5m'),(16840,27422,15344,'count','#1,{$PSU_CRIT_STATUS:\"critical\"},eq'),(16841,27422,15344,'count','#1,{$PSU_CRIT_STATUS:\"shutdown\"},eq'),(16842,27422,15345,'count','#1,{$PSU_WARN_STATUS:\"warning\"},eq'),(16843,27422,15345,'count','#1,{$PSU_WARN_STATUS:\"notFunctioning\"},eq'),(16844,27423,15346,'count','#1,{$FAN_CRIT_STATUS:\"critical\"},eq'),(16845,27423,15346,'count','#1,{$FAN_CRIT_STATUS:\"shutdown\"},eq'),(16846,27423,15347,'count','#1,{$FAN_WARN_STATUS:\"warning\"},eq'),(16847,27423,15347,'count','#1,{$FAN_WARN_STATUS:\"notFunctioning\"},eq'),(16848,27430,15348,'avg','5m'),(16849,27429,15348,'last','0'),(16850,27430,15348,'max','5m'),(16851,27447,15349,'avg','5m'),(16852,27446,15349,'last','0'),(16853,27447,15349,'max','5m'),(16854,28218,15350,'avg','5m'),(16855,28217,15350,'last','0'),(16856,28218,15350,'max','5m'),(16857,27430,15351,'avg','5m'),(16858,27429,15351,'last','0'),(16859,27430,15351,'max','5m'),(16860,27447,15352,'avg','5m'),(16861,27446,15352,'last','0'),(16862,27447,15352,'max','5m'),(16863,28218,15353,'avg','5m'),(16864,28217,15353,'last','0'),(16865,28218,15353,'max','5m'),(16866,27431,15354,'count','#1,{$PSU_CRIT_STATUS:\"critical\"},eq'),(16867,27431,15354,'count','#1,{$PSU_CRIT_STATUS:\"shutdown\"},eq'),(16868,27448,15355,'count','#1,{$PSU_CRIT_STATUS:\"critical\"},eq'),(16869,27448,15355,'count','#1,{$PSU_CRIT_STATUS:\"shutdown\"},eq'),(16870,28216,15356,'count','#1,{$PSU_CRIT_STATUS:\"critical\"},eq'),(16871,28216,15356,'count','#1,{$PSU_CRIT_STATUS:\"shutdown\"},eq'),(16872,27431,15357,'count','#1,{$PSU_WARN_STATUS:\"warning\"},eq'),(16873,27431,15357,'count','#1,{$PSU_WARN_STATUS:\"notFunctioning\"},eq'),(16874,27448,15358,'count','#1,{$PSU_WARN_STATUS:\"warning\"},eq'),(16875,27448,15358,'count','#1,{$PSU_WARN_STATUS:\"notFunctioning\"},eq'),(16876,28216,15359,'count','#1,{$PSU_WARN_STATUS:\"warning\"},eq'),(16877,28216,15359,'count','#1,{$PSU_WARN_STATUS:\"notFunctioning\"},eq'),(16878,27432,15360,'count','#1,{$FAN_CRIT_STATUS:\"critical\"},eq'),(16879,27432,15360,'count','#1,{$FAN_CRIT_STATUS:\"shutdown\"},eq'),(16880,27449,15361,'count','#1,{$FAN_CRIT_STATUS:\"critical\"},eq'),(16881,27449,15361,'count','#1,{$FAN_CRIT_STATUS:\"shutdown\"},eq'),(16882,28215,15362,'count','#1,{$FAN_CRIT_STATUS:\"critical\"},eq'),(16883,28215,15362,'count','#1,{$FAN_CRIT_STATUS:\"shutdown\"},eq'),(16884,27432,15363,'count','#1,{$FAN_WARN_STATUS:\"warning\"},eq'),(16885,27432,15363,'count','#1,{$FAN_WARN_STATUS:\"notFunctioning\"},eq'),(16886,27449,15364,'count','#1,{$FAN_WARN_STATUS:\"warning\"},eq'),(16887,27449,15364,'count','#1,{$FAN_WARN_STATUS:\"notFunctioning\"},eq'),(16888,28215,15365,'count','#1,{$FAN_WARN_STATUS:\"warning\"},eq'),(16889,28215,15365,'count','#1,{$FAN_WARN_STATUS:\"notFunctioning\"},eq'),(16890,27518,15366,'count','#1,{$PSU_CRIT_STATUS},eq'),(16891,27519,15367,'count','#1,{$FAN_CRIT_STATUS},eq'),(16892,27584,15368,'avg','5m'),(16893,27585,15368,'last','0'),(16894,27584,15368,'max','5m'),(16895,27593,15369,'count','#1,{$PSU_CRIT_STATUS},eq'),(16896,27595,15370,'count','#1,{$FAN_CRIT_STATUS},eq'),(16897,27673,15371,'count','#1,{$FAN_CRIT_STATUS:\"fanError\"},eq'),(16898,27673,15371,'count','#1,{$FAN_CRIT_STATUS:\"hardwareFaulty\"},eq'),(16899,27674,15372,'count','#1,{$PSU_CRIT_STATUS:\"psuError\"},eq'),(16900,27674,15372,'count','#1,{$PSU_CRIT_STATUS:\"rpsError\"},eq'),(16901,27674,15372,'count','#1,{$PSU_CRIT_STATUS:\"hardwareFaulty\"},eq'),(16902,28154,15373,'count','#1,{$FAN_CRIT_STATUS:\"bad\"},eq'),(16903,28154,15374,'count','#1,{$FAN_WARN_STATUS:\"warning\"},eq'),(16904,28155,15375,'count','#1,{$PSU_CRIT_STATUS:\"bad\"},eq'),(16905,28155,15376,'count','#1,{$PSU_WARN_STATUS:\"warning\"},eq'),(16906,27822,15377,'count','#1,{$FAN_CRIT_STATUS},eq'),(16907,27823,15378,'count','#1,{$PSU_CRIT_STATUS},eq'),(16908,27312,15379,'count','#1,{$PSU_CRIT_STATUS},eq'),(16909,27312,15380,'count','#1,{$PSU_OK_STATUS},ne'),(16910,27313,15381,'count','#1,{$FAN_CRIT_STATUS},eq'),(16911,27313,15382,'count','#1,{$FAN_OK_STATUS},ne'),(16912,27316,15383,'count','#1,{$PSU_CRIT_STATUS},eq'),(16913,27316,15384,'count','#1,{$PSU_OK_STATUS},ne'),(16914,27317,15385,'count','#1,{$FAN_CRIT_STATUS},eq'),(16915,27317,15386,'count','#1,{$FAN_OK_STATUS},ne'),(16916,28201,15387,'avg','5m'),(16917,28200,15387,'last','0'),(16918,28201,15387,'max','5m'),(16919,28202,15388,'count','#1,{$FAN_CRIT_STATUS},eq'),(16920,28206,15389,'count','#1,{$PSU_CRIT_STATUS},eq'),(16921,27247,15390,'avg','5m'),(16922,27246,15390,'last','0'),(16923,27247,15390,'max','5m'),(16924,27248,15391,'count','#1,{$PSU_CRIT_STATUS},eq'),(16925,27248,15392,'count','#1,{$PSU_OK_STATUS},ne'),(16926,27250,15393,'count','#1,{$FAN_CRIT_STATUS},eq'),(16927,27250,15394,'count','#1,{$FAN_OK_STATUS},ne'),(16928,27755,15395,'count','#1,{$FAN_CRIT_STATUS},eq'),(16929,27941,15396,'avg','5m'),(16930,27940,15396,'last','0'),(16931,27941,15396,'max','5m'),(16932,27941,15397,'avg','5m'),(16933,27940,15397,'last','0'),(16934,27941,15397,'max','5m'),(16935,27942,15398,'count','#1,{$FAN_CRIT_STATUS:\"failed\"},eq'),(16936,27943,15399,'count','#1,{$PSU_CRIT_STATUS:\"failed\"},eq'),(17237,27077,15490,'last',''),(17238,27077,15490,'diff',''),(17241,27604,15492,'last',''),(17242,27604,15492,'diff',''),(17243,28013,15493,'last',''),(17244,28013,15493,'diff',''),(17249,27087,15496,'last',''),(17250,27087,15496,'diff',''),(17253,27627,15498,'last',''),(17254,27627,15498,'diff',''),(17255,27984,15499,'last',''),(17256,27984,15499,'diff',''),(17261,27127,15502,'last',''),(17262,27127,15502,'diff',''),(17265,28105,15504,'last',''),(17266,28105,15504,'diff',''),(17269,27097,15506,'last',''),(17270,27097,15506,'diff',''),(17273,27107,15508,'last',''),(17274,27107,15508,'diff',''),(17277,27188,15510,'last',''),(17278,27188,15510,'diff',''),(17279,27223,15511,'last',''),(17280,27223,15511,'diff',''),(17281,27259,15512,'last',''),(17282,27259,15512,'diff',''),(17283,27280,15513,'last',''),(17284,27280,15513,'diff',''),(17285,27329,15514,'last',''),(17286,27329,15514,'diff',''),(17287,27458,15515,'last',''),(17288,27458,15515,'diff',''),(17289,27494,15516,'last',''),(17290,27494,15516,'diff',''),(17291,27528,15517,'last',''),(17292,27528,15517,'diff',''),(17293,27564,15518,'last',''),(17294,27564,15518,'diff',''),(17295,27650,15519,'last',''),(17296,27650,15519,'diff',''),(17297,27730,15520,'last',''),(17298,27730,15520,'diff',''),(17299,27764,15521,'last',''),(17300,27764,15521,'diff',''),(17301,27796,15522,'last',''),(17302,27796,15522,'diff',''),(17303,27880,15523,'last',''),(17304,27880,15523,'diff',''),(17305,27917,15524,'last',''),(17306,27917,15524,'diff',''),(17307,27952,15525,'last',''),(17308,27952,15525,'diff',''),(17309,28066,15526,'last',''),(17310,28066,15526,'diff',''),(17311,28126,15527,'last',''),(17312,28126,15527,'diff',''),(17313,28183,15528,'last',''),(17314,28183,15528,'diff',''),(17315,28231,15529,'last',''),(17316,28231,15529,'diff',''),(17357,27074,15550,'avg','15m'),(17358,27071,15550,'last',''),(17359,27075,15550,'avg','15m'),(17360,27076,15551,'avg','5m'),(17361,27073,15551,'avg','5m'),(17367,27599,15553,'avg','15m'),(17368,27603,15553,'last',''),(17369,27602,15553,'avg','15m'),(17370,28008,15554,'avg','15m'),(17371,28012,15554,'last',''),(17372,28011,15554,'avg','15m'),(17373,27598,15555,'avg','5m'),(17374,27601,15555,'avg','5m'),(17375,28007,15556,'avg','5m'),(17376,28010,15556,'avg','5m'),(17387,27084,15559,'avg','15m'),(17388,27081,15559,'last',''),(17389,27085,15559,'avg','15m'),(17390,27086,15560,'avg','5m'),(17391,27083,15560,'avg','5m'),(17397,27622,15562,'avg','15m'),(17398,27626,15562,'last',''),(17399,27625,15562,'avg','15m'),(17400,27979,15563,'avg','15m'),(17401,27983,15563,'last',''),(17402,27982,15563,'avg','15m'),(17403,27621,15564,'avg','5m'),(17404,27624,15564,'avg','5m'),(17405,27978,15565,'avg','5m'),(17406,27981,15565,'avg','5m'),(17437,27094,15574,'avg','15m'),(17438,27091,15574,'last',''),(17439,27095,15574,'avg','15m'),(17440,27096,15575,'avg','5m'),(17441,27093,15575,'avg','5m'),(17447,27104,15577,'avg','15m'),(17448,27101,15577,'last',''),(17449,27105,15577,'avg','15m'),(17450,27106,15578,'avg','5m'),(17451,27103,15578,'avg','5m'),(17457,27183,15580,'avg','15m'),(17458,27187,15580,'last',''),(17459,27186,15580,'avg','15m'),(17460,27218,15581,'avg','15m'),(17461,27222,15581,'last',''),(17462,27221,15581,'avg','15m'),(17463,27254,15582,'avg','15m'),(17464,27258,15582,'last',''),(17465,27257,15582,'avg','15m'),(17466,27275,15583,'avg','15m'),(17467,27279,15583,'last',''),(17468,27278,15583,'avg','15m'),(17469,27324,15584,'avg','15m'),(17470,27328,15584,'last',''),(17471,27327,15584,'avg','15m'),(17472,27453,15585,'avg','15m'),(17473,27457,15585,'last',''),(17474,27456,15585,'avg','15m'),(17475,27489,15586,'avg','15m'),(17476,27493,15586,'last',''),(17477,27492,15586,'avg','15m'),(17478,27523,15587,'avg','15m'),(17479,27527,15587,'last',''),(17480,27526,15587,'avg','15m'),(17481,27559,15588,'avg','15m'),(17482,27563,15588,'last',''),(17483,27562,15588,'avg','15m'),(17484,27645,15589,'avg','15m'),(17485,27649,15589,'last',''),(17486,27648,15589,'avg','15m'),(17487,27725,15590,'avg','15m'),(17488,27729,15590,'last',''),(17489,27728,15590,'avg','15m'),(17490,27759,15591,'avg','15m'),(17491,27763,15591,'last',''),(17492,27762,15591,'avg','15m'),(17493,27791,15592,'avg','15m'),(17494,27795,15592,'last',''),(17495,27794,15592,'avg','15m'),(17496,27875,15593,'avg','15m'),(17497,27879,15593,'last',''),(17498,27878,15593,'avg','15m'),(17499,27912,15594,'avg','15m'),(17500,27916,15594,'last',''),(17501,27915,15594,'avg','15m'),(17502,27947,15595,'avg','15m'),(17503,27951,15595,'last',''),(17504,27950,15595,'avg','15m'),(17505,28061,15596,'avg','15m'),(17506,28065,15596,'last',''),(17507,28064,15596,'avg','15m'),(17508,28121,15597,'avg','15m'),(17509,28125,15597,'last',''),(17510,28124,15597,'avg','15m'),(17511,28178,15598,'avg','15m'),(17512,28182,15598,'last',''),(17513,28181,15598,'avg','15m'),(17514,28226,15599,'avg','15m'),(17515,28230,15599,'last',''),(17516,28229,15599,'avg','15m'),(17517,27182,15600,'avg','5m'),(17518,27185,15600,'avg','5m'),(17519,27217,15601,'avg','5m'),(17520,27220,15601,'avg','5m'),(17521,27253,15602,'avg','5m'),(17522,27256,15602,'avg','5m'),(17523,27274,15603,'avg','5m'),(17524,27277,15603,'avg','5m'),(17525,27323,15604,'avg','5m'),(17526,27326,15604,'avg','5m'),(17527,27452,15605,'avg','5m'),(17528,27455,15605,'avg','5m'),(17529,27488,15606,'avg','5m'),(17530,27491,15606,'avg','5m'),(17531,27522,15607,'avg','5m'),(17532,27525,15607,'avg','5m'),(17533,27558,15608,'avg','5m'),(17534,27561,15608,'avg','5m'),(17535,27644,15609,'avg','5m'),(17536,27647,15609,'avg','5m'),(17537,27724,15610,'avg','5m'),(17538,27727,15610,'avg','5m'),(17539,27758,15611,'avg','5m'),(17540,27761,15611,'avg','5m'),(17541,27790,15612,'avg','5m'),(17542,27793,15612,'avg','5m'),(17543,27874,15613,'avg','5m'),(17544,27877,15613,'avg','5m'),(17545,27911,15614,'avg','5m'),(17546,27914,15614,'avg','5m'),(17547,27946,15615,'avg','5m'),(17548,27949,15615,'avg','5m'),(17549,28060,15616,'avg','5m'),(17550,28063,15616,'avg','5m'),(17551,28120,15617,'avg','5m'),(17552,28123,15617,'avg','5m'),(17553,28177,15618,'avg','5m'),(17554,28180,15618,'avg','5m'),(17555,28225,15619,'avg','5m'),(17556,28228,15619,'avg','5m'),(17657,28251,15640,'max','10m'),(17658,28250,15641,'avg','10m'),(17659,28252,15642,'last',''),(17660,28253,15643,'last',''),(17661,28254,15644,'last',''),(17662,28255,15645,'last',''),(17663,28256,15646,'last',''),(17664,28257,15647,'last',''),(17665,28258,15648,'last',''),(17666,28259,15649,'last',''),(17667,28260,15650,'last',''),(17668,28261,15651,'last',''),(17669,28262,15652,'last',''),(17670,28263,15653,'last',''),(17671,28264,15654,'last',''),(17672,28265,15655,'last',''),(17673,28266,15656,'last',''),(17674,28267,15657,'last',''),(17675,28268,15658,'last',''),(17676,28269,15659,'last',''),(17677,28270,15660,'last',''),(17678,28271,15661,'last',''),(17679,28272,15662,'last',''),(17680,28273,15663,'last',''),(17681,28274,15664,'last',''),(17682,28275,15665,'last',''),(17683,28276,15666,'last',''),(17684,28277,15667,'last',''),(17685,28278,15668,'last',''),(17686,28279,15669,'last',''),(17687,27091,15670,'change',''),(17688,27091,15670,'last',''),(17689,27090,15670,'last',''),(17690,27097,15670,'last',''),(17691,27091,15670,'prev',''),(17692,27101,15671,'change',''),(17693,27101,15671,'last',''),(17694,27100,15671,'last',''),(17695,27107,15671,'last',''),(17696,27101,15671,'prev',''),(17697,27187,15672,'change',''),(17698,27187,15672,'last',''),(17699,27189,15672,'last',''),(17700,27188,15672,'last',''),(17701,27187,15672,'prev',''),(17702,27222,15673,'change',''),(17703,27222,15673,'last',''),(17704,27224,15673,'last',''),(17705,27223,15673,'last',''),(17706,27222,15673,'prev',''),(17707,27258,15674,'change',''),(17708,27258,15674,'last',''),(17709,27260,15674,'last',''),(17710,27259,15674,'last',''),(17711,27258,15674,'prev',''),(17712,27279,15675,'change',''),(17713,27279,15675,'last',''),(17714,27281,15675,'last',''),(17715,27280,15675,'last',''),(17716,27279,15675,'prev',''),(17717,27328,15676,'change',''),(17718,27328,15676,'last',''),(17719,27330,15676,'last',''),(17720,27329,15676,'last',''),(17721,27328,15676,'prev',''),(17722,27457,15677,'change',''),(17723,27457,15677,'last',''),(17724,27459,15677,'last',''),(17725,27458,15677,'last',''),(17726,27457,15677,'prev',''),(17727,27493,15678,'change',''),(17728,27493,15678,'last',''),(17729,27495,15678,'last',''),(17730,27494,15678,'last',''),(17731,27493,15678,'prev',''),(17732,27527,15679,'change',''),(17733,27527,15679,'last',''),(17734,27529,15679,'last',''),(17735,27528,15679,'last',''),(17736,27527,15679,'prev',''),(17737,27563,15680,'change',''),(17738,27563,15680,'last',''),(17739,27565,15680,'last',''),(17740,27564,15680,'last',''),(17741,27563,15680,'prev',''),(17742,27649,15681,'change',''),(17743,27649,15681,'last',''),(17744,27651,15681,'last',''),(17745,27650,15681,'last',''),(17746,27649,15681,'prev',''),(17747,27729,15682,'change',''),(17748,27729,15682,'last',''),(17749,27731,15682,'last',''),(17750,27730,15682,'last',''),(17751,27729,15682,'prev',''),(17752,27763,15683,'change',''),(17753,27763,15683,'last',''),(17754,27765,15683,'last',''),(17755,27764,15683,'last',''),(17756,27763,15683,'prev',''),(17757,27795,15684,'change',''),(17758,27795,15684,'last',''),(17759,27797,15684,'last',''),(17760,27796,15684,'last',''),(17761,27795,15684,'prev',''),(17762,27879,15685,'change',''),(17763,27879,15685,'last',''),(17764,27881,15685,'last',''),(17765,27880,15685,'last',''),(17766,27879,15685,'prev',''),(17767,27916,15686,'change',''),(17768,27916,15686,'last',''),(17769,27918,15686,'last',''),(17770,27917,15686,'last',''),(17771,27916,15686,'prev',''),(17772,27951,15687,'change',''),(17773,27951,15687,'last',''),(17774,27953,15687,'last',''),(17775,27952,15687,'last',''),(17776,27951,15687,'prev',''),(17777,28065,15688,'change',''),(17778,28065,15688,'last',''),(17779,28067,15688,'last',''),(17780,28066,15688,'last',''),(17781,28065,15688,'prev',''),(17782,28125,15689,'change',''),(17783,28125,15689,'last',''),(17784,28127,15689,'last',''),(17785,28126,15689,'last',''),(17786,28125,15689,'prev',''),(17787,28182,15690,'change',''),(17788,28182,15690,'last',''),(17789,28184,15690,'last',''),(17790,28183,15690,'last',''),(17791,28182,15690,'prev',''),(17792,28230,15691,'change',''),(17793,28230,15691,'last',''),(17794,28232,15691,'last',''),(17795,28231,15691,'last',''),(17796,28230,15691,'prev',''),(17797,27071,15692,'change',''),(17798,27071,15692,'last',''),(17799,27070,15692,'last',''),(17800,27077,15692,'last',''),(17801,27071,15692,'prev',''),(17802,27603,15693,'change',''),(17803,27603,15693,'last',''),(17804,27605,15693,'last',''),(17805,27604,15693,'last',''),(17806,27603,15693,'prev',''),(17807,28012,15694,'change',''),(17808,28012,15694,'last',''),(17809,28014,15694,'last',''),(17810,28013,15694,'last',''),(17811,28012,15694,'prev',''),(17812,27081,15695,'change',''),(17813,27081,15695,'last',''),(17814,27080,15695,'last',''),(17815,27087,15695,'last',''),(17816,27081,15695,'prev',''),(17817,27626,15696,'change',''),(17818,27626,15696,'last',''),(17819,27628,15696,'last',''),(17820,27627,15696,'last',''),(17821,27626,15696,'prev',''),(17822,27983,15697,'change',''),(17823,27983,15697,'last',''),(17824,27985,15697,'last',''),(17825,27984,15697,'last',''),(17826,27983,15697,'prev',''),(17827,27121,15698,'change',''),(17828,27121,15698,'last',''),(17829,27120,15698,'last',''),(17830,27127,15698,'last',''),(17831,27121,15698,'prev',''),(17832,28104,15699,'change',''),(17833,28104,15699,'last',''),(17834,28106,15699,'last',''),(17835,28105,15699,'last',''),(17836,28104,15699,'prev',''),(17837,28281,15700,'last',''),(17838,28282,15701,'max','#3'),(17839,28283,15702,'min','5m'),(17840,28284,15703,'avg','5m'),(17841,28291,15704,'last',''),(17842,28292,15705,'max','{$SNMP_TIMEOUT}'),(17843,28295,15706,'avg','5m'),(17844,28298,15706,'avg','5m'),(17845,28296,15707,'avg','15m'),(17846,28300,15707,'last',''),(17847,28299,15707,'avg','15m'),(17848,28300,15708,'change',''),(17849,28300,15708,'last',''),(17850,28302,15708,'last',''),(17851,28301,15708,'last',''),(17852,28300,15708,'prev',''),(17853,28301,15709,'last',''),(17854,28301,15709,'diff',''),(17859,28323,15714,'avg','5m'),(17860,28324,15714,'last','0'),(17861,28323,15714,'max','5m'),(17862,28323,15715,'avg','5m'),(17863,28323,15715,'max','5m'),(17864,28323,15716,'avg','5m'),(17865,28323,15716,'min','5m'),(17866,28326,15717,'count','#1,{$FAN_CRIT_STATUS},eq'),(17867,28328,15718,'diff',''),(17868,28328,15718,'strlen',''),(17869,28329,15719,'count','#1,{$PSU_CRIT_STATUS},eq'),(17870,27238,15720,'count','#1,{$HEALTH_CRIT_STATUS},eq'),(17871,27238,15721,'count','#1,{$HEALTH_WARN_STATUS:\"offline\"},eq'),(17872,27238,15721,'count','#1,{$HEALTH_WARN_STATUS:\"testing\"},eq'),(17873,27814,15722,'count','#1,{$HEALTH_CRIT_STATUS},eq'),(17874,28330,15723,'max','#3'),(17875,28331,15724,'min','5m'),(17876,28332,15725,'avg','5m'),(17877,28339,15726,'last',''),(17878,28340,15727,'max','{$SNMP_TIMEOUT}'),(17879,28341,15728,'count','#1,{$HEALTH_DISASTER_STATUS},eq'),(17880,28341,15729,'count','#1,{$HEALTH_CRIT_STATUS},eq'),(17881,28341,15730,'count','#1,{$HEALTH_WARN_STATUS},eq'),(17882,28344,15731,'diff',''),(17883,28344,15731,'strlen',''),(17884,28345,15732,'diff',''),(17885,28345,15732,'strlen',''),(17886,28354,15733,'avg','5m'),(17887,28355,15733,'last','0'),(17888,28354,15733,'max','5m'),(17889,28354,15734,'avg','5m'),(17890,28355,15734,'last','0'),(17891,28354,15734,'max','5m'),(17892,28354,15735,'avg','5m'),(17893,28354,15735,'min','5m'),(17894,28356,15736,'avg','5m'),(17895,28357,15736,'last','0'),(17896,28356,15736,'max','5m'),(17897,28356,15737,'avg','5m'),(17898,28357,15737,'last','0'),(17899,28356,15737,'max','5m'),(17900,28356,15738,'avg','5m'),(17901,28356,15738,'min','5m'),(17902,28358,15739,'count','#1,{$PSU_CRIT_STATUS:\"critical\"},eq'),(17903,28358,15739,'count','#1,{$PSU_CRIT_STATUS:\"nonRecoverable\"},eq'),(17904,28358,15740,'count','#1,{$PSU_WARN_STATUS:\"nonCritical\"},eq'),(17905,28359,15741,'count','#1,{$FAN_CRIT_STATUS:\"criticalUpper\"},eq'),(17906,28359,15741,'count','#1,{$FAN_CRIT_STATUS:\"nonRecoverableUpper\"},eq'),(17907,28359,15741,'count','#1,{$FAN_CRIT_STATUS:\"criticalLower\"},eq'),(17908,28359,15741,'count','#1,{$FAN_CRIT_STATUS:\"nonRecoverableLower\"},eq'),(17909,28359,15741,'count','#1,{$FAN_CRIT_STATUS:\"failed\"},eq'),(17910,28359,15742,'count','#1,{$FAN_WARN_STATUS:\"nonCriticalUpper\"},eq'),(17911,28359,15742,'count','#1,{$FAN_WARN_STATUS:\"nonCriticalLower\"},eq'),(17912,28361,15743,'count','#1,{$DISK_FAIL_STATUS:\"critical\"},eq'),(17913,28361,15743,'count','#1,{$DISK_FAIL_STATUS:\"nonRecoverable\"},eq'),(17914,28361,15744,'count','#1,{$DISK_WARN_STATUS:\"nonCritical\"},eq'),(17915,28362,15745,'diff',''),(17916,28362,15745,'strlen',''),(17917,28363,15746,'count','#1,{$DISK_SMART_FAIL_STATUS},eq'),(17918,28373,15747,'count','#1,{$VDISK_CRIT_STATUS:\"failed\"},eq'),(17919,28373,15748,'count','#1,{$VDISK_WARN_STATUS:\"degraded\"},eq'),(17920,28374,15749,'count','#1,{$DISK_ARRAY_FAIL_STATUS:\"nonRecoverable\"},eq'),(17921,28374,15750,'count','#1,{$DISK_ARRAY_CRIT_STATUS:\"critical\"},eq'),(17922,28374,15751,'count','#1,{$DISK_ARRAY_WARN_STATUS:\"nonCritical\"},eq'),(17923,28376,15752,'count','#1,{$DISK_ARRAY_CACHE_BATTERY_WARN_STATUS},eq'),(17924,28376,15753,'count','#1,{$DISK_ARRAY_CACHE_BATTERY_OK_STATUS},ne'),(17925,28376,15754,'count','#1,{$DISK_ARRAY_CACHE_BATTERY_CRIT_STATUS},eq'),(17926,28377,15755,'max','#3'),(17927,28378,15756,'min','5m'),(17928,28379,15757,'avg','5m'),(17929,28386,15758,'last',''),(17930,28387,15759,'max','{$SNMP_TIMEOUT}'),(17933,28391,15762,'diff',''),(17934,28391,15762,'strlen',''),(17935,28404,15763,'avg','5m'),(17936,28404,15763,'max','5m'),(17937,28404,15764,'avg','5m'),(17938,28404,15764,'max','5m'),(17939,28404,15765,'avg','5m'),(17940,28404,15765,'min','5m'),(17941,28406,15766,'avg','5m'),(17942,28406,15766,'max','5m'),(17943,28406,15767,'avg','5m'),(17944,28406,15767,'max','5m'),(17945,28406,15768,'avg','5m'),(17946,28406,15768,'min','5m'),(17947,28407,15769,'avg','5m'),(17948,28407,15769,'max','5m'),(17949,28407,15770,'avg','5m'),(17950,28407,15770,'max','5m'),(17951,28407,15771,'avg','5m'),(17952,28407,15771,'min','5m'),(17953,28408,15772,'avg','5m'),(17954,28408,15772,'max','5m'),(17955,28408,15773,'avg','5m'),(17956,28408,15773,'max','5m'),(17957,28408,15774,'avg','5m'),(17958,28408,15774,'min','5m'),(17959,28409,15775,'avg','5m'),(17960,28409,15775,'max','5m'),(17961,28409,15776,'avg','5m'),(17962,28409,15776,'max','5m'),(17963,28409,15777,'avg','5m'),(17964,28409,15777,'min','5m'),(17965,28410,15778,'avg','5m'),(17966,28410,15778,'max','5m'),(17967,28410,15779,'avg','5m'),(17968,28410,15779,'max','5m'),(17969,28410,15780,'avg','5m'),(17970,28410,15780,'min','5m'),(17971,28411,15781,'count','#1,{$PSU_CRIT_STATUS},eq'),(17972,28411,15782,'count','#1,{$PSU_WARN_STATUS},eq'),(17973,28412,15783,'count','#1,{$FAN_CRIT_STATUS},eq'),(17974,28412,15784,'count','#1,{$FAN_WARN_STATUS},eq'),(17975,28413,15785,'count','#1,{$DISK_ARRAY_CRIT_STATUS},eq'),(17976,28413,15786,'count','#1,{$DISK_ARRAY_WARN_STATUS},eq'),(17977,28415,15787,'count','#1,{$DISK_ARRAY_CACHE_CRIT_STATUS:\"cacheModCriticalFailure\"},eq'),(17978,28415,15788,'count','#1,{$DISK_ARRAY_CACHE_WARN_STATUS:\"invalid\"},eq'),(17979,28415,15788,'count','#1,{$DISK_ARRAY_CACHE_WARN_STATUS:\"cacheModDegradedFailsafeSpeed\"},eq'),(17980,28415,15788,'count','#1,{$DISK_ARRAY_CACHE_WARN_STATUS:\"cacheReadCacheNotMapped\"},eq'),(17981,28415,15788,'count','#1,{$DISK_ARRAY_CACHE_WARN_STATUS:\"cacheModFlashMemNotAttached\"},eq'),(17982,28415,15789,'count','#1,{$DISK_ARRAY_CACHE_OK_STATUS:\"enabled\"},ne'),(17983,28416,15790,'count','#1,{$DISK_ARRAY_CACHE_BATTERY_CRIT_STATUS:\"failed\"},eq'),(17984,28416,15790,'count','#1,{$DISK_ARRAY_CACHE_BATTERY_CRIT_STATUS:\"capacitorFailed\"},eq'),(17985,28416,15791,'count','#1,{$DISK_ARRAY_CACHE_BATTERY_WARN_STATUS:\"degraded\"},eq'),(17986,28416,15791,'count','#1,{$DISK_ARRAY_CACHE_BATTERY_WARN_STATUS:\"notPresent\"},eq'),(17987,28417,15792,'count','#1,{$DISK_FAIL_STATUS},eq'),(17988,28417,15793,'count','#1,{$DISK_WARN_STATUS},eq'),(17989,28418,15794,'count','#1,{$DISK_SMART_FAIL_STATUS:\"replaceDrive\"},eq'),(17990,28418,15794,'count','#1,{$DISK_SMART_FAIL_STATUS:\"replaceDriveSSDWearOut\"},eq'),(17991,28419,15795,'diff',''),(17992,28419,15795,'strlen',''),(17993,28423,15796,'count','#1,{$VDISK_CRIT_STATUS},eq'),(17994,28423,15797,'count','#1,{$VDISK_OK_STATUS},ne'),(17995,28426,15798,'max','#3'),(17996,28427,15799,'min','5m'),(17997,28428,15800,'avg','5m'),(17998,28435,15801,'last',''),(17999,28436,15802,'max','{$SNMP_TIMEOUT}'),(18000,28437,15803,'count','#1,{$HEALTH_DISASTER_STATUS},eq'),(18001,28437,15804,'count','#1,{$HEALTH_CRIT_STATUS},eq'),(18002,28437,15805,'count','#1,{$HEALTH_WARN_STATUS},eq'),(18003,28439,15806,'diff',''),(18004,28439,15806,'strlen',''),(18005,28446,15807,'avg','5m'),(18006,28446,15807,'max','5m'),(18007,28446,15808,'avg','5m'),(18008,28446,15808,'max','5m'),(18009,28446,15809,'avg','5m'),(18010,28446,15809,'min','5m'),(18011,28447,15810,'avg','5m'),(18012,28447,15810,'max','5m'),(18013,28447,15811,'avg','5m'),(18014,28447,15811,'max','5m'),(18015,28447,15812,'avg','5m'),(18016,28447,15812,'min','5m'),(18017,28448,15813,'avg','5m'),(18018,28448,15813,'max','5m'),(18019,28448,15814,'avg','5m'),(18020,28448,15814,'max','5m'),(18021,28448,15815,'avg','5m'),(18022,28448,15815,'min','5m'),(18023,28449,15816,'count','#1,{$PSU_OK_STATUS},ne'),(18024,28450,15817,'count','#1,{$FAN_OK_STATUS},ne'),(18025,28452,15818,'count','#1,{$DISK_OK_STATUS},ne'),(18026,28454,15819,'max','#3'),(18027,28455,15820,'min','5m'),(18028,28456,15821,'avg','5m'),(18029,28463,15822,'last',''),(18030,28464,15823,'max','{$SNMP_TIMEOUT}'),(18031,28465,15824,'count','#1,{$HEALTH_DISASTER_STATUS},eq'),(18032,28465,15825,'count','#1,{$HEALTH_CRIT_STATUS},eq'),(18033,28465,15826,'count','#1,{$HEALTH_WARN_STATUS},eq'),(18034,28467,15827,'diff',''),(18035,28467,15827,'strlen',''),(18036,28474,15828,'avg','5m'),(18037,28474,15828,'max','5m'),(18038,28474,15829,'avg','5m'),(18039,28474,15829,'max','5m'),(18040,28474,15830,'avg','5m'),(18041,28474,15830,'min','5m'),(18042,28475,15831,'avg','5m'),(18043,28475,15831,'max','5m'),(18044,28475,15832,'avg','5m'),(18045,28475,15832,'max','5m'),(18046,28475,15833,'avg','5m'),(18047,28475,15833,'min','5m'),(18048,28476,15834,'avg','5m'),(18049,28476,15834,'max','5m'),(18050,28476,15835,'avg','5m'),(18051,28476,15835,'max','5m'),(18052,28476,15836,'avg','5m'),(18053,28476,15836,'min','5m'),(18054,28477,15837,'count','#1,{$PSU_OK_STATUS},ne'),(18055,28478,15838,'count','#1,{$FAN_OK_STATUS},ne'),(18056,28480,15839,'count','#1,{$DISK_OK_STATUS},ne'),(18057,28482,15840,'max','#3'),(18058,28483,15841,'min','5m'),(18059,28484,15842,'avg','5m'),(18060,28491,15843,'last',''),(18061,28492,15844,'max','{$SNMP_TIMEOUT}'),(18062,28495,15845,'avg','5m'),(18063,28495,15845,'max','5m'),(18064,28495,15846,'avg','5m'),(18065,28495,15846,'max','5m'),(18066,28495,15847,'avg','5m'),(18067,28495,15847,'min','5m'),(18068,28503,15848,'last','0'),(18069,28532,15848,'last','0'),(18070,28506,15849,'last','0'),(18071,28505,15849,'last','0'),(18072,28509,15850,'last','0'),(18073,28508,15850,'last','0'),(18074,28513,15851,'str','off'),(18075,28512,15852,'str','off'),(18076,28537,15853,'max','10m'),(18077,28543,15854,'max','10m'),(18078,28536,15855,'max','10m'),(18079,28545,15856,'max','10m'),(18080,28542,15857,'max','10m'),(18081,28538,15858,'max','10m'),(18082,28535,15859,'min','10m'),(18083,28555,15860,'avg','10m'),(18084,28557,15861,'avg','10m'),(18085,28558,15862,'avg','10m'),(18086,28559,15863,'avg','10m'),(18087,28560,15864,'avg','10m'),(18088,28561,15865,'avg','10m'),(18089,28562,15866,'avg','30m'),(18090,28563,15867,'avg','10m'),(18091,28564,15868,'avg','10m'),(18092,28556,15869,'avg','10m'),(18093,28565,15870,'avg','10m'),(18094,28567,15871,'avg','10m'),(18095,28568,15872,'avg','10m'),(18096,28569,15873,'avg','10m'),(18097,28570,15874,'avg','10m'),(18098,28571,15875,'avg','10m'),(18099,28572,15876,'avg','10m'),(18100,28573,15877,'avg','10m'),(18101,28574,15878,'avg','10m'),(18102,28566,15879,'avg','10m'),(18103,28575,15880,'avg','10m'),(18104,28546,15881,'avg','10m'),(18105,28541,15882,'last',''),(18106,28553,15883,'avg','10m'),(18107,28590,15884,'max','10m'),(18108,28588,15885,'max','10m'),(18109,28587,15886,'max','10m'),(18110,28589,15887,'max','10m'),(18111,28578,15888,'min','10m'),(18112,28591,15889,'avg','10m'),(18113,28592,15890,'avg','10m'),(18114,28606,15891,'avg','10m'),(18115,28605,15892,'avg','10m'),(18116,28604,15893,'avg','10m'),(18117,28603,15894,'avg','30m'),(18118,28602,15895,'avg','10m'),(18119,28601,15896,'avg','10m'),(18120,28600,15897,'avg','10m'),(18121,28599,15898,'avg','10m'),(18122,28598,15899,'avg','10m'),(18123,28597,15900,'avg','10m'),(18124,28596,15901,'avg','10m'),(18125,28595,15902,'avg','10m'),(18126,28594,15903,'avg','10m'),(18127,28593,15904,'avg','10m'),(18128,28607,15905,'avg','10m'),(18129,28579,15906,'avg','10m'),(18130,28613,15907,'avg','5m'),(18131,28614,15908,'max','#3'),(18132,28615,15909,'min','5m'),(18133,28616,15910,'avg','5m'),(18134,28623,15911,'last',''),(18135,28624,15912,'max','{$SNMP_TIMEOUT}'),(18136,28634,15913,'avg','5m'),(18137,28634,15913,'max','5m'),(18138,28634,15914,'avg','5m'),(18139,28634,15914,'max','5m'),(18140,28634,15915,'avg','5m'),(18141,28634,15915,'min','5m'),(18142,28635,15916,'avg','5m'),(18143,28635,15916,'max','5m'),(18144,28635,15917,'avg','5m'),(18145,28635,15917,'max','5m'),(18146,28635,15918,'avg','5m'),(18147,28635,15918,'min','5m'),(18148,28636,15919,'avg','5m'),(18149,28636,15919,'max','5m'),(18150,28636,15920,'avg','5m'),(18151,28636,15920,'max','5m'),(18152,28636,15921,'avg','5m'),(18153,28636,15921,'min','5m'),(18154,28637,15922,'avg','5m'),(18155,28637,15922,'max','5m'),(18156,28637,15923,'avg','5m'),(18157,28637,15923,'max','5m'),(18158,28637,15924,'avg','5m'),(18159,28637,15924,'min','5m'),(18160,28638,15925,'avg','5m'),(18161,28638,15925,'max','5m'),(18162,28638,15926,'avg','5m'),(18163,28638,15926,'max','5m'),(18164,28638,15927,'avg','5m'),(18165,28638,15927,'min','5m'),(18166,28639,15928,'count','#1,{$PSU_CRIT_STATUS:\"inoperable\"},eq'),(18167,28639,15929,'count','#1,{$PSU_WARN_STATUS:\"degraded\"},eq'),(18168,28640,15930,'count','#1,{$HEALTH_CRIT_STATUS:\"computeFailed\"},eq'),(18169,28640,15930,'count','#1,{$HEALTH_CRIT_STATUS:\"configFailure\"},eq'),(18170,28640,15930,'count','#1,{$HEALTH_CRIT_STATUS:\"unconfigFailure\"},eq'),(18171,28640,15930,'count','#1,{$HEALTH_CRIT_STATUS:\"inoperable\"},eq'),(18172,28640,15931,'count','#1,{$HEALTH_WARN_STATUS:\"testFailed\"},eq'),(18173,28640,15931,'count','#1,{$HEALTH_WARN_STATUS:\"thermalProblem\"},eq'),(18174,28640,15931,'count','#1,{$HEALTH_WARN_STATUS:\"powerProblem\"},eq'),(18175,28640,15931,'count','#1,{$HEALTH_WARN_STATUS:\"voltageProblem\"},eq'),(18176,28640,15931,'count','#1,{$HEALTH_WARN_STATUS:\"diagnosticsFailed\"},eq'),(18177,28642,15932,'diff',''),(18178,28642,15932,'strlen',''),(18179,28643,15933,'count','#1,{$FAN_CRIT_STATUS:\"inoperable\"},eq'),(18180,28643,15934,'count','#1,{$FAN_WARN_STATUS:\"degraded\"},eq'),(18181,28644,15935,'count','#1,{$DISK_FAIL_STATUS:\"failed\"},eq'),(18182,28644,15936,'count','#1,{$DISK_CRIT_STATUS:\"bad\"},eq'),(18183,28644,15936,'count','#1,{$DISK_CRIT_STATUS:\"predictiveFailure\"},eq'),(18184,28648,15937,'count','#1,{$VDISK_OK_STATUS:\"equipped\"},ne'),(18185,28651,15938,'count','#1,{$DISK_ARRAY_CRIT_STATUS:\"inoperable\"},eq'),(18186,28651,15939,'count','#1,{$DISK_ARRAY_WARN_STATUS:\"degraded\"},eq'),(18187,28651,15940,'count','#1,{$DISK_ARRAY_OK_STATUS:\"operable\"},ne'),(18188,28653,15941,'count','#1,{$DISK_ARRAY_CACHE_BATTERY_CRIT_STATUS},eq'),(18189,28653,15942,'count','#1,{$DISK_ARRAY_CACHE_BATTERY_OK_STATUS},ne'),(18190,28654,15943,'count','#1,{$HEALTH_CRIT_STATUS},eq'),(18191,28654,15944,'count','#1,{$HEALTH_WARN_STATUS},eq'),(18193,28655,15946,'min','5m'),(18194,28656,15947,'min','5m'),(18195,28657,15948,'min','5m'),(18196,28658,15949,'min','5m'),(18197,28659,15950,'min','5m'),(18198,28660,15951,'min','5m'),(18199,28675,15952,'last',''),(18200,28674,15952,'last',''),(18201,28673,15952,'last',''),(18202,28675,15952,'timeleft','1h,,100'),(18203,28675,15953,'last',''),(18204,28674,15953,'last',''),(18205,28673,15953,'last',''),(18206,28675,15953,'timeleft','1h,,100'),(18207,28678,15954,'min','5m'),(18208,28681,15955,'last',''),(18209,28680,15955,'last',''),(18210,28679,15955,'last',''),(18211,28681,15955,'timeleft','1h,,100'),(18212,28687,15956,'last',''),(18213,28686,15956,'last',''),(18214,28685,15956,'last',''),(18215,28687,15956,'timeleft','1h,,100'),(18216,28693,15957,'last',''),(18217,28692,15957,'last',''),(18218,28691,15957,'last',''),(18219,28693,15957,'timeleft','1h,,100'),(18220,28699,15958,'last',''),(18221,28698,15958,'last',''),(18222,28697,15958,'last',''),(18223,28699,15958,'timeleft','1h,,100'),(18224,28705,15959,'last',''),(18225,28704,15959,'last',''),(18226,28703,15959,'last',''),(18227,28705,15959,'timeleft','1h,,100'),(18228,28681,15960,'last',''),(18229,28680,15960,'last',''),(18230,28679,15960,'last',''),(18231,28681,15960,'timeleft','1h,,100'),(18232,28687,15961,'last',''),(18233,28686,15961,'last',''),(18234,28685,15961,'last',''),(18235,28687,15961,'timeleft','1h,,100'),(18236,28693,15962,'last',''),(18237,28692,15962,'last',''),(18238,28691,15962,'last',''),(18239,28693,15962,'timeleft','1h,,100'),(18240,28699,15963,'last',''),(18241,28698,15963,'last',''),(18242,28697,15963,'last',''),(18243,28699,15963,'timeleft','1h,,100'),(18244,28705,15964,'last',''),(18245,28704,15964,'last',''),(18246,28703,15964,'last',''),(18247,28705,15964,'timeleft','1h,,100'),(18248,28684,15965,'min','5m'),(18249,28690,15966,'min','5m'),(18250,28696,15967,'min','5m'),(18251,28702,15968,'min','5m'),(18252,28708,15969,'min','5m'),(18253,27124,15970,'avg','15m'),(18254,27121,15970,'last',''),(18255,27125,15970,'avg','15m'),(18256,27126,15971,'min','5m'),(18257,27123,15971,'min','5m'),(18258,27126,15971,'max','5m'),(18259,27123,15971,'max','5m'),(18260,28100,15972,'avg','15m'),(18261,28104,15972,'last',''),(18262,28103,15972,'avg','15m'),(18263,28099,15973,'min','5m'),(18264,28102,15973,'min','5m'),(18265,28099,15973,'max','5m'),(18266,28102,15973,'max','5m'),(18267,28709,15974,'min','5m'),(18268,28710,15975,'min','5m'),(18269,28717,15976,'last',''),(18270,28716,15976,'last',''),(18271,28715,15976,'last',''),(18272,28717,15976,'timeleft','1h,,100'),(18273,28717,15977,'last',''),(18274,28716,15977,'last',''),(18275,28715,15977,'last',''),(18276,28717,15977,'timeleft','1h,,100'),(18277,28720,15978,'min','5m'),(18278,28723,15979,'last',''),(18279,28722,15979,'last',''),(18280,28721,15979,'last',''),(18281,28723,15979,'timeleft','1h,,100'),(18282,28723,15980,'last',''),(18283,28722,15980,'last',''),(18284,28721,15980,'last',''),(18285,28723,15980,'timeleft','1h,,100'),(18286,28726,15981,'min','5m');
/*!40000 ALTER TABLE `functions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalmacro`
--

DROP TABLE IF EXISTS `globalmacro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalmacro` (
  `globalmacroid` bigint(20) unsigned NOT NULL,
  `macro` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`globalmacroid`),
  UNIQUE KEY `globalmacro_1` (`macro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalmacro`
--

LOCK TABLES `globalmacro` WRITE;
/*!40000 ALTER TABLE `globalmacro` DISABLE KEYS */;
INSERT INTO `globalmacro` VALUES (2,'{$SNMP_COMMUNITY}','public');
/*!40000 ALTER TABLE `globalmacro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalvars`
--

DROP TABLE IF EXISTS `globalvars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalvars` (
  `globalvarid` bigint(20) unsigned NOT NULL,
  `snmp_lastsize` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`globalvarid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalvars`
--

LOCK TABLES `globalvars` WRITE;
/*!40000 ALTER TABLE `globalvars` DISABLE KEYS */;
/*!40000 ALTER TABLE `globalvars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graph_discovery`
--

DROP TABLE IF EXISTS `graph_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graph_discovery` (
  `graphid` bigint(20) unsigned NOT NULL,
  `parent_graphid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`graphid`),
  KEY `graph_discovery_1` (`parent_graphid`),
  CONSTRAINT `c_graph_discovery_2` FOREIGN KEY (`parent_graphid`) REFERENCES `graphs` (`graphid`),
  CONSTRAINT `c_graph_discovery_1` FOREIGN KEY (`graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graph_discovery`
--

LOCK TABLES `graph_discovery` WRITE;
/*!40000 ALTER TABLE `graph_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `graph_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graph_theme`
--

DROP TABLE IF EXISTS `graph_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graph_theme` (
  `graphthemeid` bigint(20) unsigned NOT NULL,
  `theme` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `backgroundcolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `graphcolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `gridcolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `maingridcolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `gridbordercolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `textcolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `highlightcolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `leftpercentilecolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `rightpercentilecolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `nonworktimecolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `colorpalette` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`graphthemeid`),
  UNIQUE KEY `graph_theme_1` (`theme`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graph_theme`
--

LOCK TABLES `graph_theme` WRITE;
/*!40000 ALTER TABLE `graph_theme` DISABLE KEYS */;
INSERT INTO `graph_theme` VALUES (1,'blue-theme','FFFFFF','FFFFFF','CCD5D9','ACBBC2','ACBBC2','1F2C33','E33734','429E47','E33734','EBEBEB','1A7C11,F63100,2774A4,A54F10,FC6EA3,6C59DC,AC8C14,611F27,F230E0,5CCD18,BB2A02,5A2B57,89ABF8,7EC25C,274482,2B5429,8048B4,FD5434,790E1F,87AC4D,E89DF4'),(2,'dark-theme','2B2B2B','2B2B2B','454545','4F4F4F','4F4F4F','F2F2F2','E45959','59DB8F','E45959','333333','199C0D,F63100,2774A4,F7941D,FC6EA3,6C59DC,C7A72D,BA2A5D,F230E0,5CCD18,BB2A02,AC41A5,89ABF8,7EC25C,3165D5,79A277,AA73DE,FD5434,F21C3E,87AC4D,E89DF4'),(3,'hc-light','FFFFFF','FFFFFF','555555','000000','333333','000000','333333','000000','000000','EBEBEB','1A7C11,F63100,2774A4,A54F10,FC6EA3,6C59DC,AC8C14,611F27,F230E0,5CCD18,BB2A02,5A2B57,89ABF8,7EC25C,274482,2B5429,8048B4,FD5434,790E1F,87AC4D,E89DF4'),(4,'hc-dark','000000','000000','666666','888888','4F4F4F','FFFFFF','FFFFFF','FFFFFF','FFFFFF','333333','199C0D,F63100,2774A4,F7941D,FC6EA3,6C59DC,C7A72D,BA2A5D,F230E0,5CCD18,BB2A02,AC41A5,89ABF8,7EC25C,3165D5,79A277,AA73DE,FD5434,F21C3E,87AC4D,E89DF4');
/*!40000 ALTER TABLE `graph_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graphs`
--

DROP TABLE IF EXISTS `graphs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graphs` (
  `graphid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `width` int(11) NOT NULL DEFAULT '900',
  `height` int(11) NOT NULL DEFAULT '200',
  `yaxismin` double(16,4) NOT NULL DEFAULT '0.0000',
  `yaxismax` double(16,4) NOT NULL DEFAULT '100.0000',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `show_work_period` int(11) NOT NULL DEFAULT '1',
  `show_triggers` int(11) NOT NULL DEFAULT '1',
  `graphtype` int(11) NOT NULL DEFAULT '0',
  `show_legend` int(11) NOT NULL DEFAULT '1',
  `show_3d` int(11) NOT NULL DEFAULT '0',
  `percent_left` double(16,4) NOT NULL DEFAULT '0.0000',
  `percent_right` double(16,4) NOT NULL DEFAULT '0.0000',
  `ymin_type` int(11) NOT NULL DEFAULT '0',
  `ymax_type` int(11) NOT NULL DEFAULT '0',
  `ymin_itemid` bigint(20) unsigned DEFAULT NULL,
  `ymax_itemid` bigint(20) unsigned DEFAULT NULL,
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`graphid`),
  KEY `graphs_1` (`name`),
  KEY `graphs_2` (`templateid`),
  KEY `graphs_3` (`ymin_itemid`),
  KEY `graphs_4` (`ymax_itemid`),
  CONSTRAINT `c_graphs_3` FOREIGN KEY (`ymax_itemid`) REFERENCES `items` (`itemid`),
  CONSTRAINT `c_graphs_1` FOREIGN KEY (`templateid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_graphs_2` FOREIGN KEY (`ymin_itemid`) REFERENCES `items` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graphs`
--

LOCK TABLES `graphs` WRITE;
/*!40000 ALTER TABLE `graphs` DISABLE KEYS */;
INSERT INTO `graphs` VALUES (387,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(392,'Zabbix server performance',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(404,'Zabbix data gathering process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(406,'Zabbix internal process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(410,'Zabbix cache usage, % used',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(420,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(433,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(436,'Swap usage',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(439,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(442,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(456,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(457,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(458,'Swap usage',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(459,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(461,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(462,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(463,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(464,'Swap usage',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(465,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(467,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(469,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(471,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(472,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(473,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(474,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(475,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(478,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(479,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(480,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(481,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(482,'Swap usage',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(483,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(484,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(485,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(487,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(491,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(492,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(493,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(494,'Network traffic on en0',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(495,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(496,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(497,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(498,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(517,'Zabbix internal process busy %',900,200,0.0000,100.0000,406,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(518,'Zabbix data gathering process busy %',900,200,0.0000,100.0000,404,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(519,'Zabbix server performance',900,200,0.0000,100.0000,392,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(520,'Zabbix cache usage, % used',900,200,0.0000,100.0000,410,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(521,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,420,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(522,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,442,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(523,'CPU jumps',900,200,0.0000,100.0000,439,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(524,'CPU load',900,200,0.0000,100.0000,433,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(525,'CPU utilization',900,200,0.0000,100.0000,387,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(526,'Swap usage',600,340,0.0000,100.0000,436,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(527,'Value cache effectiveness',900,200,0.0000,100.0000,NULL,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(528,'Value cache effectiveness',900,200,0.0000,100.0000,527,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(529,'Zabbix cache usage, % used',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(530,'Zabbix data gathering process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(531,'Zabbix internal process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(532,'Zabbix proxy performance',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(533,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,10026,0),(534,'Memory usage',900,200,0.0000,100.0000,533,1,1,0,1,0,0.0000,0.0000,1,2,NULL,23317,0),(540,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,22943,0),(541,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,22903,0),(542,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,22983,0),(543,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,23063,0),(544,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,22863,0),(545,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,23023,0),(546,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,23159,0),(638,'Class Loader',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(639,'File Descriptors',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(640,'Garbage Collector collections per second',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(641,'Memory Pool CMS Old Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(642,'Memory Pool CMS Perm Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(643,'Memory Pool Code Cache',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(644,'Memory Pool Perm Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(645,'Memory Pool PS Old Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(646,'Memory Pool PS Perm Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(647,'Memory Pool Tenured Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(648,'Threads',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(649,'MySQL bandwidth',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(650,'MySQL operations',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(651,'Fan speed and ambient temperature',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(652,'Voltage',900,200,0.0000,5.5000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(653,'Fan speed and temperature',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(654,'Voltage',900,200,0.0000,5.5000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(668,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(669,'Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(671,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(672,'Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(675,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(676,'CPU utilization',900,200,0.0000,100.0000,675,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(677,'CPU utilization',900,200,0.0000,100.0000,675,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(678,'Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(679,'Memory utilization',900,200,0.0000,100.0000,678,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(680,'Memory utilization',900,200,0.0000,100.0000,678,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(683,'{#SNMPVALUE}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(684,'{#SNMPVALUE}: Memory utilization',900,200,0.0000,100.0000,683,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(686,'{#SNMPVALUE}: Memory utilization',900,200,0.0000,100.0000,683,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(687,'#{#SNMPINDEX}: CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(688,'#{#SNMPINDEX}: CPU utilization',900,200,0.0000,100.0000,687,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(691,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(692,'CPU utilization',900,200,0.0000,100.0000,691,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(694,'#{#SNMPINDEX}: CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(695,'#{#SNMPINDEX}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(697,'Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(698,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(700,'#{#SNMPVALUE}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(701,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(703,'#{#SNMPVALUE}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(704,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(708,'{#MODULE_NAME}: CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(709,'{#MODULE_NAME}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(714,'{#ENT_NAME}: CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(715,'{#ENT_NAME}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(719,'{#SNMPVALUE}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(724,'#{#SNMPINDEX}: CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(725,'Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(727,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(728,'Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(730,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(731,'Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(733,'#{#SNMPVALUE}: CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(734,'#{#SNMPVALUE}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(736,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(737,'Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(738,'Interface {#IFDESCR}: Network traffic',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(739,'Interface {#IFDESCR}: Network traffic',900,200,0.0000,100.0000,738,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(740,'Interface {#IFDESCR}: Network traffic',900,200,0.0000,100.0000,738,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(741,'Interface {#IFDESCR}: Network traffic',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(742,'Interface {#IFDESCR}: Network traffic',900,200,0.0000,100.0000,741,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(743,'Interface {#IFDESCR}: Network traffic',900,200,0.0000,100.0000,741,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(744,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(745,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(746,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(747,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(748,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(749,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(750,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(752,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(753,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(754,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(755,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(756,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(758,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(759,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(760,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(762,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(763,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(764,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(766,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(769,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(772,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,766,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(773,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(774,'#{#SNMPVALUE}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(775,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(778,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(784,'{#SNMPVALUE}: Memory utilization',900,200,0.0000,100.0000,683,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(785,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(786,'{#SNMPVALUE}: CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(787,'{#SNMPVALUE}: CPU utilization',900,200,0.0000,100.0000,786,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(788,'Zabbix preprocessing queue',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(789,'Zabbix preprocessing queue',900,200,0.0000,100.0000,788,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(790,'Interface {#IFNAME}({#IFALIAS}): Network traffic',900,200,0.0000,100.0000,745,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(793,'http-8080 worker threads',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(794,'http-8443 worker threads',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(795,'jk-8009 worker threads',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(796,'sessions /',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(797,'Value cache effectiveness',900,200,0.0000,100.0000,NULL,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(798,'Zabbix cache usage, % free',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(799,'Zabbix data gathering process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(800,'Zabbix internal process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(801,'Zabbix preprocessing queue',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(802,'Zabbix server performance',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(803,'Zabbix cache usage, % free',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(804,'Zabbix data gathering process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(805,'Zabbix internal process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(806,'Zabbix proxy performance',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(807,'{#SNMPVALUE}: CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(809,'{#FSNAME}: Disk space usage',600,340,0.0000,100.0000,NULL,1,1,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(810,'{#FSNAME}: Disk space usage',600,340,0.0000,100.0000,809,1,1,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(811,'{#FSNAME}: Disk space usage',600,340,0.0000,100.0000,810,1,1,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(812,'{#FSNAME}: Disk space usage',600,340,0.0000,100.0000,810,1,1,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(813,'{#FSNAME}: Disk space usage',600,340,0.0000,100.0000,810,1,1,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(814,'{#FSNAME}: Disk space usage',600,340,0.0000,100.0000,810,1,1,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(815,'{#MEMNAME}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(816,'{#MEMNAME}: Memory utilization',900,200,0.0000,100.0000,815,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(817,'{#MEMNAME}: Memory utilization',900,200,0.0000,100.0000,816,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(818,'{#MEMNAME}: Memory utilization',900,200,0.0000,100.0000,816,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(819,'{#MEMNAME}: Memory utilization',900,200,0.0000,100.0000,816,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(820,'{#MEMNAME}: Memory utilization',900,200,0.0000,100.0000,816,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(821,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(822,'CPU utilization',900,200,0.0000,100.0000,821,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(823,'CPU utilization',900,200,0.0000,100.0000,822,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(824,'CPU utilization',900,200,0.0000,100.0000,822,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(825,'CPU utilization',900,200,0.0000,100.0000,822,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(826,'CPU utilization',900,200,0.0000,100.0000,822,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(827,'{#FSNAME}: Disk space usage',600,340,0.0000,100.0000,NULL,1,1,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(828,'{#FSNAME}: Disk space usage',600,340,0.0000,100.0000,827,1,1,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(829,'{#MEMNAME}: Memory utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(830,'{#MEMNAME}: Memory utilization',900,200,0.0000,100.0000,829,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,2),(831,'CPU utilization',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(832,'CPU utilization',900,200,0.0000,100.0000,831,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0);
/*!40000 ALTER TABLE `graphs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graphs_items`
--

DROP TABLE IF EXISTS `graphs_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graphs_items` (
  `gitemid` bigint(20) unsigned NOT NULL,
  `graphid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT '0',
  `sortorder` int(11) NOT NULL DEFAULT '0',
  `color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '009600',
  `yaxisside` int(11) NOT NULL DEFAULT '0',
  `calc_fnc` int(11) NOT NULL DEFAULT '2',
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`gitemid`),
  KEY `graphs_items_1` (`itemid`),
  KEY `graphs_items_2` (`graphid`),
  CONSTRAINT `c_graphs_items_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_graphs_items_1` FOREIGN KEY (`graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graphs_items`
--

LOCK TABLES `graphs_items` WRITE;
/*!40000 ALTER TABLE `graphs_items` DISABLE KEYS */;
INSERT INTO `graphs_items` VALUES (11952,793,28532,0,0,'C80000',0,2,0),(11953,793,28503,0,1,'00C800',0,2,0),(11954,793,28504,0,2,'0000C8',0,2,0),(11955,794,28505,0,0,'C80000',0,2,0),(11956,794,28506,0,1,'00C800',0,2,0),(11957,794,28507,0,2,'0000C8',0,2,0),(11958,795,28508,0,0,'C80000',0,2,0),(11959,795,28509,0,1,'00C800',0,2,0),(11960,795,28510,0,2,'0000C8',0,2,0),(11961,796,28515,0,0,'C80000',0,2,0),(11962,796,28518,0,1,'00C800',0,2,0),(11963,796,28516,0,2,'0000C8',0,2,0),(11964,638,26892,0,0,'C80000',0,2,0),(11965,638,26891,0,1,'00C800',0,2,0),(11966,638,26910,0,2,'0000C8',0,2,0),(11967,639,26879,0,0,'C80000',0,2,0),(11968,639,26880,0,1,'00C800',0,2,0),(11969,640,26906,0,0,'C80000',0,2,0),(11970,640,26895,0,1,'00C800',0,2,0),(11971,640,26889,0,2,'0000C8',0,2,0),(11972,640,26884,0,3,'C8C800',0,2,0),(11973,640,26896,0,4,'00C8C9',0,2,0),(11974,640,26887,0,5,'C800C8',0,2,0),(11975,641,26900,0,0,'C80000',0,2,0),(11976,641,26901,0,1,'00C800',0,2,0),(11977,641,26902,0,2,'0000C8',0,2,0),(11978,642,26883,0,0,'C80000',0,2,0),(11979,642,26882,0,1,'00C800',0,2,0),(11980,642,26864,0,2,'0000C8',0,2,0),(11981,643,26863,0,0,'C80000',0,2,0),(11982,643,26865,0,1,'00C800',0,2,0),(11983,643,26866,0,2,'0000C8',0,2,0),(11984,644,26867,0,0,'C80000',0,2,0),(11985,644,26862,0,1,'00C800',0,2,0),(11986,644,26861,0,2,'0000C8',0,2,0),(11987,645,26857,0,0,'C80000',0,2,0),(11988,645,26856,0,1,'00C800',0,2,0),(11989,645,26858,0,2,'0000C8',0,2,0),(11990,646,26859,0,0,'0000C8',0,2,0),(11991,646,26860,0,1,'C80000',0,2,0),(11992,646,26868,0,2,'00C800',0,2,0),(11993,647,26869,0,0,'C80000',0,2,0),(11994,647,26878,0,1,'00C800',0,2,0),(11995,647,26877,0,2,'0000C8',0,2,0),(11996,648,26872,0,0,'C80000',0,2,0),(11997,648,26870,0,1,'00C800',0,2,0),(11998,648,26873,0,2,'0000C8',0,2,0),(11999,803,28590,0,0,'DD0000',0,2,0),(12000,803,28587,0,1,'00DDDD',0,2,0),(12001,803,28588,0,2,'3333FF',0,2,0),(12002,803,28589,0,3,'00FF00',0,2,0),(12003,804,28593,0,0,'990099',0,2,0),(12004,804,28597,0,1,'990000',0,2,0),(12005,804,28599,0,2,'0000EE',0,2,0),(12006,804,28606,0,3,'FF33FF',0,2,0),(12007,804,28601,0,4,'00EE00',0,2,0),(12008,804,28602,0,5,'003300',0,2,0),(12009,804,28607,0,6,'33FFFF',0,2,0),(12010,804,28598,0,7,'DD0000',0,2,0),(12011,804,28595,0,8,'000099',0,2,0),(12012,804,28579,0,9,'00FF00',0,2,0),(12013,805,28603,0,0,'FFAA00',0,2,0),(12014,805,28591,0,1,'990099',0,2,0),(12015,805,28604,0,2,'EE0000',0,2,0),(12016,805,28596,0,3,'FF66FF',0,2,0),(12017,805,28605,0,4,'960000',0,2,0),(12018,805,28592,0,5,'009600',0,2,0),(12019,805,28594,0,6,'009999',0,2,0),(12020,805,28600,0,7,'BBBB00',0,2,0),(12021,806,28586,0,0,'00C800',0,2,0),(12022,806,28577,0,1,'C80000',0,2,0),(12023,797,28540,0,0,'C80000',0,2,0),(12024,797,28539,0,1,'00C800',0,2,0),(12025,798,28545,0,0,'009900',0,2,0),(12026,798,28537,0,1,'DD0000',0,2,0),(12027,798,28536,0,2,'00DDDD',0,2,0),(12028,798,28543,0,3,'3333FF',0,2,0),(12029,798,28538,0,4,'999900',0,2,0),(12030,798,28542,0,5,'00FF00',0,2,0),(12031,799,28575,0,0,'990099',0,2,0),(12032,799,28568,0,1,'990000',0,2,0),(12033,799,28565,0,2,'0000EE',0,2,0),(12034,799,28559,0,3,'FF33FF',0,2,0),(12035,799,28564,0,4,'009600',0,2,0),(12036,799,28563,0,5,'003300',0,2,0),(12037,799,28571,0,6,'CCCC00',0,2,0),(12038,799,28546,0,7,'33FFFF',0,2,0),(12039,799,28567,0,8,'DD0000',0,2,0),(12040,799,28573,0,9,'000099',0,2,0),(12041,799,28553,0,10,'00FF00',0,2,0),(12042,800,28566,0,0,'00EE00',0,2,0),(12043,800,28560,0,1,'0000EE',0,2,0),(12044,800,28562,0,2,'FFAA00',0,2,0),(12045,800,28555,0,3,'00EEEE',0,2,0),(12046,800,28558,0,4,'990099',0,2,0),(12047,800,28561,0,5,'EE0000',0,2,0),(12048,800,28572,0,6,'FF66FF',0,2,0),(12049,800,28574,0,7,'009999',0,2,0),(12050,800,28556,0,8,'BBBB00',0,2,0),(12051,800,28557,0,9,'AA0000',0,2,0),(12052,800,28569,0,10,'990000',0,2,0),(12053,800,28570,0,11,'008800',0,2,0),(12054,801,28554,5,0,'1A7C11',0,2,0),(12055,802,28544,5,0,'00C800',0,2,0),(12056,802,28534,5,1,'C80000',0,2,0),(12057,529,23357,0,0,'DD0000',0,2,0),(12058,529,23341,0,1,'00DDDD',0,2,0),(12059,529,23342,0,2,'3333FF',0,2,0),(12060,529,28251,0,3,'00FF00',0,2,0),(12061,530,23345,0,0,'990099',0,2,0),(12062,530,23348,0,1,'990000',0,2,0),(12063,530,23355,0,2,'0000EE',0,2,0),(12064,530,23352,0,3,'FF33FF',0,2,0),(12065,530,23356,0,4,'007700',0,2,0),(12066,530,23354,0,5,'003300',0,2,0),(12067,530,23346,0,6,'33FFFF',0,2,0),(12068,530,23349,0,7,'DD0000',0,2,0),(12069,530,23344,0,8,'000099',0,7,0),(12070,530,28250,0,9,'00FF00',0,2,0),(12071,531,23353,0,0,'FFAA00',0,2,0),(12072,531,23347,0,1,'990099',0,2,0),(12073,531,23350,0,2,'EE0000',0,2,0),(12074,531,23343,0,3,'FF66FF',0,2,0),(12075,531,23351,0,4,'960000',0,2,0),(12076,531,23360,0,5,'007700',0,2,0),(12077,531,25369,0,6,'009999',0,2,0),(12078,531,25368,0,6,'BBBB00',0,2,0),(12079,532,23340,5,0,'00C800',0,2,0),(12080,532,23358,5,1,'C80000',1,2,0),(12081,527,22199,0,0,'C80000',0,2,0),(12082,527,22196,0,1,'00C800',0,2,0),(12083,528,23628,0,0,'C80000',0,2,0),(12084,528,23625,0,1,'00C800',0,2,0),(12085,410,22185,0,0,'009900',0,2,0),(12086,410,22189,0,1,'DD0000',0,2,0),(12087,410,22396,0,2,'00DDDD',0,2,0),(12088,410,22183,0,3,'3333FF',0,2,0),(12089,410,22191,0,4,'999900',0,2,0),(12090,410,23634,0,5,'00FF00',0,2,0),(12091,520,23276,0,0,'009900',0,2,0),(12092,520,23273,0,1,'DD0000',0,2,0),(12093,520,23275,0,2,'00DDDD',0,2,0),(12094,520,23274,0,3,'3333FF',0,2,0),(12095,520,23620,0,4,'999900',0,2,0),(12096,520,23635,0,5,'00FF00',0,2,0),(12097,404,22404,0,0,'990099',0,2,0),(12098,404,22399,0,1,'990000',0,2,0),(12099,404,22416,0,2,'0000EE',0,2,0),(12100,404,22430,0,3,'FF33FF',0,2,0),(12101,404,22418,0,4,'009600',0,2,0),(12102,404,22402,0,5,'003300',0,2,0),(12103,404,22420,0,6,'CCCC00',0,2,0),(12104,404,22400,0,7,'33FFFF',0,2,0),(12105,404,22689,0,8,'DD0000',0,2,0),(12106,404,23171,0,9,'000099',0,2,0),(12107,404,22401,0,10,'00FF00',0,2,0),(12108,518,23269,0,0,'990099',0,2,0),(12109,518,23264,0,1,'990000',0,2,0),(12110,518,23261,0,2,'0000EE',0,2,0),(12111,518,23255,0,3,'FF33FF',0,2,0),(12112,518,23260,0,4,'009600',0,2,0),(12113,518,23259,0,5,'003300',0,2,0),(12114,518,23265,0,6,'CCCC00',0,2,0),(12115,518,23270,0,7,'33FFFF',0,2,0),(12116,518,23262,0,8,'DD0000',0,2,0),(12117,518,23267,0,9,'000099',0,2,0),(12118,518,23328,0,10,'00FF00',0,2,0),(12119,406,22426,0,0,'00EE00',0,2,0),(12120,406,22422,0,1,'0000EE',0,2,0),(12121,406,22408,0,2,'FFAA00',0,2,0),(12122,406,22424,0,3,'00EEEE',0,2,0),(12123,406,22412,0,4,'990099',0,2,0),(12124,406,22406,0,5,'EE0000',0,2,0),(12125,406,22414,0,6,'FF66FF',0,2,0),(12126,406,23663,0,7,'009999',0,2,0),(12127,406,25366,0,8,'BBBB00',0,2,0),(12128,406,25370,0,9,'AA0000',0,2,0),(12129,406,25665,0,10,'990000',0,2,0),(12130,406,25666,0,11,'008800',0,2,0),(12131,517,23268,0,0,'00EE00',0,2,0),(12132,517,23256,0,1,'0000EE',0,2,0),(12133,517,23258,0,2,'FFAA00',0,2,0),(12134,517,23252,0,3,'00EEEE',0,2,0),(12135,517,23253,0,4,'990099',0,2,0),(12136,517,23257,0,5,'EE0000',0,2,0),(12137,517,23266,0,6,'FF66FF',0,2,0),(12138,517,23664,0,7,'009999',0,2,0),(12139,517,25367,0,8,'BBBB00',0,2,0),(12140,517,25371,0,9,'AA0000',0,2,0),(12141,517,25667,0,10,'990000',0,2,0),(12142,517,25668,0,11,'008800',0,2,0),(12143,788,28248,5,0,'1A7C11',0,2,0),(12144,789,28249,5,0,'1A7C11',0,2,0),(12145,392,22187,5,0,'00C800',0,2,0),(12146,392,23251,5,1,'C80000',1,2,0),(12147,519,23277,5,0,'00C800',0,2,0),(12148,519,23272,5,1,'C80000',1,2,0),(12149,649,26920,5,0,'00AA00',0,2,0),(12150,649,26919,5,1,'3333FF',0,2,0),(12151,650,26921,0,0,'C8C800',0,2,0),(12152,650,26922,0,1,'006400',0,2,0),(12153,650,26923,0,2,'C80000',0,2,0),(12154,650,26918,0,3,'0000EE',0,2,0),(12155,650,26917,0,4,'640000',0,2,0),(12156,650,26912,0,5,'00C800',0,2,0),(12157,650,26911,0,6,'C800C8',0,2,0),(12158,472,22945,5,0,'00AA00',0,2,0),(12159,472,22946,5,1,'3333FF',0,2,0),(12160,473,22950,0,0,'C80000',0,2,2),(12161,473,22948,0,1,'00C800',0,2,0),(12162,471,22924,0,0,'009900',0,2,0),(12163,471,22920,0,1,'000099',0,2,0),(12164,469,22922,0,0,'009900',0,2,0),(12165,469,22923,0,1,'000099',0,2,0),(12166,469,22921,0,2,'990000',0,2,0),(12167,498,23109,0,0,'009999',0,2,0),(12168,498,23112,0,1,'990099',0,2,0),(12169,498,23115,0,2,'999900',0,2,0),(12170,498,23113,0,3,'990000',0,2,0),(12171,498,23114,0,4,'000099',0,2,0),(12172,498,23110,0,5,'009900',0,2,0),(12173,540,22942,5,0,'00C800',0,2,0),(12174,492,23073,5,0,'00AA00',0,2,0),(12175,492,23074,5,1,'3333FF',0,2,0),(12176,467,22910,0,0,'C80000',0,2,2),(12177,467,22908,0,1,'00C800',0,2,0),(12178,465,22884,0,0,'009900',0,2,0),(12179,465,22880,0,1,'000099',0,2,0),(12180,463,22882,0,0,'009900',0,2,0),(12181,463,22883,0,1,'000099',0,2,0),(12182,463,22881,0,2,'990000',0,2,0),(12183,462,22886,1,0,'009999',0,2,0),(12184,462,22888,1,1,'990099',0,2,0),(12185,462,22891,1,2,'990000',0,2,0),(12186,462,22892,1,3,'000099',0,2,0),(12187,462,22885,1,4,'009900',0,2,0),(12188,541,22902,5,0,'00C800',0,2,0),(12189,464,22897,0,0,'AA0000',0,2,2),(12190,464,22895,0,1,'00AA00',0,2,0),(12191,478,22985,5,0,'00AA00',0,2,0),(12192,478,22986,5,1,'3333FF',0,2,0),(12193,479,22990,0,0,'C80000',0,2,2),(12194,479,22988,0,1,'00C800',0,2,0),(12195,475,22962,0,0,'009900',0,2,0),(12196,475,22963,0,1,'000099',0,2,0),(12197,475,22961,0,2,'990000',0,2,0),(12198,474,22968,1,0,'990099',0,2,0),(12199,474,22971,1,1,'990000',0,2,0),(12200,474,22972,1,2,'000099',0,2,0),(12201,474,22965,1,3,'009900',0,2,0),(12202,542,22982,5,0,'00C800',0,2,0),(12203,420,22446,5,0,'00AA00',0,2,0),(12204,420,22448,5,1,'3333FF',0,2,0),(12205,521,23280,5,0,'00AA00',0,2,0),(12206,521,23281,5,1,'3333FF',0,2,0),(12207,442,22456,0,0,'C80000',0,2,2),(12208,442,22452,0,1,'00C800',0,2,0),(12209,522,23285,0,0,'C80000',0,2,2),(12210,522,23283,0,1,'00C800',0,2,0),(12211,439,22680,0,0,'009900',0,2,0),(12212,439,22683,0,1,'000099',0,2,0),(12213,523,23298,0,0,'009900',0,2,0),(12214,523,23294,0,1,'000099',0,2,0),(12215,433,10010,0,0,'009900',0,2,0),(12216,433,22674,0,1,'000099',0,2,0),(12217,433,22677,0,2,'990000',0,2,0),(12218,524,23296,0,0,'009900',0,2,0),(12219,524,23297,0,1,'000099',0,2,0),(12220,524,23295,0,2,'990000',0,2,0),(12221,387,28499,0,0,'F230E0',0,2,0),(12222,387,28497,0,1,'5CCD18',0,2,0),(12223,387,22665,1,2,'FF5555',0,2,0),(12224,387,22668,1,3,'55FF55',0,2,0),(12225,387,22671,1,4,'009999',0,2,0),(12226,387,17358,1,5,'990099',0,2,0),(12227,387,17362,1,6,'999900',0,2,0),(12228,387,17360,1,7,'990000',0,2,0),(12229,387,17356,1,8,'000099',0,2,0),(12230,387,17354,1,9,'009900',0,2,0),(12231,525,28500,0,0,'F230E0',0,2,0),(12232,525,28498,0,1,'5CCD18',0,2,0),(12233,525,23304,1,2,'FF5555',0,2,0),(12234,525,23303,1,3,'55FF55',0,2,0),(12235,525,23300,1,4,'009999',0,2,0),(12236,525,23302,1,5,'990099',0,2,0),(12237,525,23301,1,6,'999900',0,2,0),(12238,525,23305,1,7,'990000',0,2,0),(12239,525,23306,1,8,'000099',0,2,0),(12240,525,23299,1,9,'009900',0,2,0),(12241,533,22181,5,0,'00C800',0,2,0),(12242,534,23316,5,0,'00C800',0,2,0),(12243,436,10030,0,0,'AA0000',0,2,2),(12244,436,10014,0,1,'00AA00',0,2,0),(12245,526,23311,0,0,'AA0000',0,2,2),(12246,526,23309,0,1,'00AA00',0,2,0),(12247,491,23070,0,0,'C80000',0,2,2),(12248,491,23068,0,1,'00C800',0,2,0),(12249,487,23042,0,0,'009900',0,2,0),(12250,487,23043,0,1,'000099',0,2,0),(12251,487,23041,0,2,'990000',0,2,0),(12252,543,23062,5,0,'00C800',0,2,0),(12253,494,23077,5,0,'00AA00',0,2,0),(12254,494,23078,5,1,'3333FF',0,2,0),(12255,493,23075,5,0,'00AA00',0,2,0),(12256,493,23076,5,1,'3333FF',0,2,0),(12257,461,22870,0,0,'C80000',0,2,2),(12258,461,22868,0,1,'00C800',0,2,0),(12259,459,22844,0,0,'009900',0,2,0),(12260,459,22840,0,1,'000099',0,2,0),(12261,457,22842,0,0,'009900',0,2,0),(12262,457,22843,0,1,'000099',0,2,0),(12263,457,22841,0,2,'990000',0,2,0),(12264,456,22846,1,0,'009999',0,2,0),(12265,456,22848,1,1,'990099',0,2,0),(12266,456,22851,1,2,'990000',0,2,0),(12267,456,22852,1,3,'000099',0,2,0),(12268,456,22845,1,4,'009900',0,2,0),(12269,544,22862,5,0,'00C800',0,2,0),(12270,458,22857,0,0,'AA0000',0,2,2),(12271,458,22855,0,1,'00AA00',0,2,0),(12272,484,23025,5,0,'00AA00',0,2,0),(12273,484,23026,5,1,'3333FF',0,2,0),(12274,485,23030,0,0,'C80000',0,2,2),(12275,485,23028,0,1,'00C800',0,2,0),(12276,483,23004,0,0,'009900',0,2,0),(12277,483,23000,0,1,'000099',0,2,0),(12278,481,23002,0,0,'009900',0,2,0),(12279,481,23003,0,1,'000099',0,2,0),(12280,481,23001,0,2,'990000',0,2,0),(12281,480,23007,1,0,'999900',0,2,0),(12282,480,23011,1,1,'990000',0,2,0),(12283,480,23012,1,2,'000099',0,2,0),(12284,480,23005,1,3,'009900',0,2,0),(12285,545,23022,5,0,'00C800',0,2,0),(12286,482,23017,0,0,'AA0000',0,2,2),(12287,482,23015,0,1,'00AA00',0,2,0),(12288,497,23169,5,0,'00AA00',0,2,0),(12289,497,23170,5,1,'3333FF',0,2,0),(12290,496,23167,0,0,'C80000',0,2,2),(12291,496,23164,0,1,'00C800',0,2,0),(12292,495,23143,0,0,'009900',0,2,0),(12293,495,23145,0,1,'000099',0,2,0),(12294,495,23144,0,2,'990000',0,2,0),(12295,546,23158,5,0,'00C800',0,2,0),(12296,651,26928,5,0,'EE0000',0,2,0),(12297,651,26927,0,1,'000000',1,2,0),(12298,652,26925,2,0,'880000',0,2,0),(12299,652,26932,0,1,'009900',0,2,0),(12300,652,26930,0,2,'00CCCC',0,2,0),(12301,652,26931,0,3,'000000',0,2,0),(12302,652,26929,0,4,'3333FF',0,2,0),(12303,652,26926,0,5,'777700',0,2,0),(12304,653,26933,2,0,'EE0000',0,2,0),(12305,653,26943,2,1,'EE00EE',0,2,0),(12306,653,26935,0,2,'000000',1,2,0),(12307,653,26936,4,3,'000000',1,2,0),(12308,654,26934,2,0,'880000',0,2,0),(12309,654,26939,0,1,'009900',0,2,0),(12310,654,26942,0,2,'00CCCC',0,2,0),(12311,654,26938,0,3,'000000',0,2,0),(12312,654,26937,0,4,'3333FF',0,2,0),(12313,827,28716,0,0,'969696',0,9,2),(12314,827,28715,0,1,'C80000',0,9,0),(12315,828,28722,0,0,'969696',0,9,2),(12316,828,28721,0,1,'C80000',0,9,0),(12317,829,28720,5,0,'1A7C11',0,2,0),(12318,830,28726,5,0,'1A7C11',0,2,0),(12319,831,28709,5,0,'1A7C11',0,2,0),(12320,832,28710,5,0,'1A7C11',0,2,0),(12321,809,28674,0,0,'969696',0,9,2),(12322,809,28673,0,1,'C80000',0,9,0),(12323,810,28680,0,0,'969696',0,9,2),(12324,810,28679,0,1,'C80000',0,9,0),(12325,811,28686,0,0,'969696',0,9,2),(12326,811,28685,0,1,'C80000',0,9,0),(12327,812,28692,0,0,'969696',0,9,2),(12328,812,28691,0,1,'C80000',0,9,0),(12329,813,28698,0,0,'969696',0,9,2),(12330,813,28697,0,1,'C80000',0,9,0),(12331,814,28704,0,0,'969696',0,9,2),(12332,814,28703,0,1,'C80000',0,9,0),(12333,815,28678,5,0,'1A7C11',0,2,0),(12334,816,28684,5,0,'1A7C11',0,2,0),(12335,817,28690,5,0,'1A7C11',0,2,0),(12336,818,28696,5,0,'1A7C11',0,2,0),(12337,819,28702,5,0,'1A7C11',0,2,0),(12338,820,28708,5,0,'1A7C11',0,2,0),(12339,821,28655,5,0,'1A7C11',0,2,0),(12340,822,28656,5,0,'1A7C11',0,2,0),(12341,823,28657,5,0,'1A7C11',0,2,0),(12342,824,28658,5,0,'1A7C11',0,2,0),(12343,825,28659,5,0,'1A7C11',0,2,0),(12344,826,28660,5,0,'1A7C11',0,2,0),(12345,744,27094,5,0,'1A7C11',0,2,0),(12346,744,27095,2,1,'2774A4',0,2,0),(12347,744,27093,0,2,'F63100',1,2,0),(12348,744,27096,0,3,'A54F10',1,2,0),(12349,744,27092,0,4,'FC6EA3',1,2,0),(12350,744,27089,0,5,'6C59DC',1,2,0),(12351,745,27104,5,0,'1A7C11',0,2,0),(12352,745,27105,2,1,'2774A4',0,2,0),(12353,745,27103,0,2,'F63100',1,2,0),(12354,745,27106,0,3,'A54F10',1,2,0),(12355,745,27102,0,4,'FC6EA3',1,2,0),(12356,745,27099,0,5,'6C59DC',1,2,0),(12357,746,27183,5,0,'1A7C11',0,2,0),(12358,746,27186,2,1,'2774A4',0,2,0),(12359,746,27185,0,2,'F63100',1,2,0),(12360,746,27182,0,3,'A54F10',1,2,0),(12361,746,27184,0,4,'FC6EA3',1,2,0),(12362,746,27181,0,5,'6C59DC',1,2,0),(12363,747,27218,5,0,'1A7C11',0,2,0),(12364,747,27221,2,1,'2774A4',0,2,0),(12365,747,27220,0,2,'F63100',1,2,0),(12366,747,27217,0,3,'A54F10',1,2,0),(12367,747,27219,0,4,'FC6EA3',1,2,0),(12368,747,27216,0,5,'6C59DC',1,2,0),(12369,748,27254,5,0,'1A7C11',0,2,0),(12370,748,27257,2,1,'2774A4',0,2,0),(12371,748,27256,0,2,'F63100',1,2,0),(12372,748,27253,0,3,'A54F10',1,2,0),(12373,748,27255,0,4,'FC6EA3',1,2,0),(12374,748,27252,0,5,'6C59DC',1,2,0),(12375,749,27275,5,0,'1A7C11',0,2,0),(12376,749,27278,2,1,'2774A4',0,2,0),(12377,749,27277,0,2,'F63100',1,2,0),(12378,749,27274,0,3,'A54F10',1,2,0),(12379,749,27276,0,4,'FC6EA3',1,2,0),(12380,749,27273,0,5,'6C59DC',1,2,0),(12381,750,27324,5,0,'1A7C11',0,2,0),(12382,750,27327,2,1,'2774A4',0,2,0),(12383,750,27326,0,2,'F63100',1,2,0),(12384,750,27323,0,3,'A54F10',1,2,0),(12385,750,27325,0,4,'FC6EA3',1,2,0),(12386,750,27322,0,5,'6C59DC',1,2,0),(12387,752,27453,5,0,'1A7C11',0,2,0),(12388,752,27456,2,1,'2774A4',0,2,0),(12389,752,27455,0,2,'F63100',1,2,0),(12390,752,27452,0,3,'A54F10',1,2,0),(12391,752,27454,0,4,'FC6EA3',1,2,0),(12392,752,27451,0,5,'6C59DC',1,2,0),(12393,753,27489,5,0,'1A7C11',0,2,0),(12394,753,27492,2,1,'2774A4',0,2,0),(12395,753,27491,0,2,'F63100',1,2,0),(12396,753,27488,0,3,'A54F10',1,2,0),(12397,753,27490,0,4,'FC6EA3',1,2,0),(12398,753,27487,0,5,'6C59DC',1,2,0),(12399,754,27523,5,0,'1A7C11',0,2,0),(12400,754,27526,2,1,'2774A4',0,2,0),(12401,754,27525,0,2,'F63100',1,2,0),(12402,754,27522,0,3,'A54F10',1,2,0),(12403,754,27524,0,4,'FC6EA3',1,2,0),(12404,754,27521,0,5,'6C59DC',1,2,0),(12405,755,27559,5,0,'1A7C11',0,2,0),(12406,755,27562,2,1,'2774A4',0,2,0),(12407,755,27561,0,2,'F63100',1,2,0),(12408,755,27558,0,3,'A54F10',1,2,0),(12409,755,27560,0,4,'FC6EA3',1,2,0),(12410,755,27557,0,5,'6C59DC',1,2,0),(12411,756,27645,5,0,'1A7C11',0,2,0),(12412,756,27648,2,1,'2774A4',0,2,0),(12413,756,27647,0,2,'F63100',1,2,0),(12414,756,27644,0,3,'A54F10',1,2,0),(12415,756,27646,0,4,'FC6EA3',1,2,0),(12416,756,27643,0,5,'6C59DC',1,2,0),(12417,758,27725,5,0,'1A7C11',0,2,0),(12418,758,27728,2,1,'2774A4',0,2,0),(12419,758,27727,0,2,'F63100',1,2,0),(12420,758,27724,0,3,'A54F10',1,2,0),(12421,758,27726,0,4,'FC6EA3',1,2,0),(12422,758,27723,0,5,'6C59DC',1,2,0),(12423,759,27759,5,0,'1A7C11',0,2,0),(12424,759,27762,2,1,'2774A4',0,2,0),(12425,759,27761,0,2,'F63100',1,2,0),(12426,759,27758,0,3,'A54F10',1,2,0),(12427,759,27760,0,4,'FC6EA3',1,2,0),(12428,759,27757,0,5,'6C59DC',1,2,0),(12429,760,27791,5,0,'1A7C11',0,2,0),(12430,760,27794,2,1,'2774A4',0,2,0),(12431,760,27793,0,2,'F63100',1,2,0),(12432,760,27790,0,3,'A54F10',1,2,0),(12433,760,27792,0,4,'FC6EA3',1,2,0),(12434,760,27789,0,5,'6C59DC',1,2,0),(12435,762,27875,5,0,'1A7C11',0,2,0),(12436,762,27878,2,1,'2774A4',0,2,0),(12437,762,27877,0,2,'F63100',1,2,0),(12438,762,27874,0,3,'A54F10',1,2,0),(12439,762,27876,0,4,'FC6EA3',1,2,0),(12440,762,27873,0,5,'6C59DC',1,2,0),(12441,763,27912,5,0,'1A7C11',0,2,0),(12442,763,27915,2,1,'2774A4',0,2,0),(12443,763,27914,0,2,'F63100',1,2,0),(12444,763,27911,0,3,'A54F10',1,2,0),(12445,763,27913,0,4,'FC6EA3',1,2,0),(12446,763,27910,0,5,'6C59DC',1,2,0),(12447,764,27947,5,0,'1A7C11',0,2,0),(12448,764,27950,2,1,'2774A4',0,2,0),(12449,764,27949,0,2,'F63100',1,2,0),(12450,764,27946,0,3,'A54F10',1,2,0),(12451,764,27948,0,4,'FC6EA3',1,2,0),(12452,764,27945,0,5,'6C59DC',1,2,0),(12453,769,28061,5,0,'1A7C11',0,2,0),(12454,769,28064,2,1,'2774A4',0,2,0),(12455,769,28063,0,2,'F63100',1,2,0),(12456,769,28060,0,3,'A54F10',1,2,0),(12457,769,28062,0,4,'FC6EA3',1,2,0),(12458,769,28059,0,5,'6C59DC',1,2,0),(12459,773,28121,5,0,'1A7C11',0,2,0),(12460,773,28124,2,1,'2774A4',0,2,0),(12461,773,28123,0,2,'F63100',1,2,0),(12462,773,28120,0,3,'A54F10',1,2,0),(12463,773,28122,0,4,'FC6EA3',1,2,0),(12464,773,28119,0,5,'6C59DC',1,2,0),(12465,778,28178,5,0,'1A7C11',0,2,0),(12466,778,28181,2,1,'2774A4',0,2,0),(12467,778,28180,0,2,'F63100',1,2,0),(12468,778,28177,0,3,'A54F10',1,2,0),(12469,778,28179,0,4,'FC6EA3',1,2,0),(12470,778,28176,0,5,'6C59DC',1,2,0),(12471,785,28226,5,0,'1A7C11',0,2,0),(12472,785,28229,2,1,'2774A4',0,2,0),(12473,785,28228,0,2,'F63100',1,2,0),(12474,785,28225,0,3,'A54F10',1,2,0),(12475,785,28227,0,4,'FC6EA3',1,2,0),(12476,785,28224,0,5,'6C59DC',1,2,0),(12477,790,28296,5,0,'1A7C11',0,2,0),(12478,790,28299,2,1,'2774A4',0,2,0),(12479,790,28298,0,2,'F63100',1,2,0),(12480,790,28295,0,3,'A54F10',1,2,0),(12481,790,28297,0,4,'FC6EA3',1,2,0),(12482,790,28294,0,5,'6C59DC',1,2,0),(12483,738,27074,5,0,'1A7C11',0,2,0),(12484,738,27075,2,1,'2774A4',0,2,0),(12485,738,27073,0,2,'F63100',1,2,0),(12486,738,27076,0,3,'A54F10',1,2,0),(12487,738,27072,0,4,'FC6EA3',1,2,0),(12488,738,27069,0,5,'6C59DC',1,2,0),(12489,739,27599,5,0,'1A7C11',0,2,0),(12490,739,27602,2,1,'2774A4',0,2,0),(12491,739,27601,0,2,'F63100',1,2,0),(12492,739,27598,0,3,'A54F10',1,2,0),(12493,739,27600,0,4,'FC6EA3',1,2,0),(12494,739,27597,0,5,'6C59DC',1,2,0),(12495,740,28008,5,0,'1A7C11',0,2,0),(12496,740,28011,2,1,'2774A4',0,2,0),(12497,740,28010,0,2,'F63100',1,2,0),(12498,740,28007,0,3,'A54F10',1,2,0),(12499,740,28009,0,4,'FC6EA3',1,2,0),(12500,740,28006,0,5,'6C59DC',1,2,0),(12501,741,27084,5,0,'1A7C11',0,2,0),(12502,741,27085,2,1,'2774A4',0,2,0),(12503,741,27083,0,2,'F63100',1,2,0),(12504,741,27086,0,3,'A54F10',1,2,0),(12505,741,27082,0,4,'FC6EA3',1,2,0),(12506,741,27079,0,5,'6C59DC',1,2,0),(12507,742,27622,5,0,'1A7C11',0,2,0),(12508,742,27625,2,1,'2774A4',0,2,0),(12509,742,27624,0,2,'F63100',1,2,0),(12510,742,27621,0,3,'A54F10',1,2,0),(12511,742,27623,0,4,'FC6EA3',1,2,0),(12512,742,27620,0,5,'6C59DC',1,2,0),(12513,743,27979,5,0,'1A7C11',0,2,0),(12514,743,27982,2,1,'2774A4',0,2,0),(12515,743,27981,0,2,'F63100',1,2,0),(12516,743,27978,0,3,'A54F10',1,2,0),(12517,743,27980,0,4,'FC6EA3',1,2,0),(12518,743,27977,0,5,'6C59DC',1,2,0),(12519,766,27124,5,0,'1A7C11',0,2,0),(12520,766,27125,2,1,'2774A4',0,2,0),(12521,766,27123,0,2,'F63100',1,2,0),(12522,766,27126,0,3,'A54F10',1,2,0),(12523,766,27122,0,4,'FC6EA3',1,2,0),(12524,766,27119,0,5,'6C59DC',1,2,0),(12525,772,28100,5,0,'1A7C11',0,2,0),(12526,772,28103,2,1,'2774A4',0,2,0),(12527,772,28102,0,2,'F63100',1,2,0),(12528,772,28099,0,3,'A54F10',1,2,0),(12529,772,28101,0,4,'FC6EA3',1,2,0),(12530,772,28098,0,5,'6C59DC',1,2,0),(12531,668,27208,5,0,'1A7C11',0,2,0),(12532,669,27205,5,0,'1A7C11',0,2,0),(12533,671,27240,5,0,'1A7C11',0,2,0),(12534,672,27239,5,0,'1A7C11',0,2,0),(12535,675,27294,5,0,'1A7C11',0,2,0),(12536,676,27299,5,0,'1A7C11',0,2,0),(12537,677,27301,5,0,'1A7C11',0,2,0),(12538,678,27293,5,0,'1A7C11',0,2,0),(12539,679,27298,5,0,'1A7C11',0,2,0),(12540,680,27300,5,0,'1A7C11',0,2,0),(12541,683,27414,5,0,'1A7C11',0,2,0),(12542,684,27424,5,0,'1A7C11',0,2,0),(12543,686,27442,5,0,'1A7C11',0,2,0),(12544,784,28221,5,0,'1A7C11',0,2,0),(12545,687,27417,5,0,'1A7C11',0,2,0),(12546,688,27427,5,0,'1A7C11',0,2,0),(12547,786,28246,5,0,'1A7C11',0,2,0),(12548,787,28247,5,0,'1A7C11',0,2,0),(12549,691,27376,5,0,'1A7C11',0,2,0),(12550,692,27380,5,0,'1A7C11',0,2,0),(12551,694,27478,5,0,'1A7C11',0,2,0),(12552,695,27477,5,0,'1A7C11',0,2,0),(12553,697,27516,5,0,'1A7C11',0,2,0),(12554,698,27511,5,0,'1A7C11',0,2,0),(12555,700,27552,5,0,'1A7C11',0,2,0),(12556,701,27547,5,0,'1A7C11',0,2,0),(12557,703,27590,5,0,'1A7C11',0,2,0),(12558,704,27586,5,0,'1A7C11',0,2,0),(12559,708,27671,5,0,'1A7C11',0,2,0),(12560,709,27670,5,0,'1A7C11',0,2,0),(12561,774,28151,5,0,'1A7C11',0,2,0),(12562,775,28143,5,0,'1A7C11',0,2,0),(12563,714,27753,5,0,'1A7C11',0,2,0),(12564,715,27752,5,0,'1A7C11',0,2,0),(12565,807,28613,5,0,'1A7C11',0,2,0),(12566,719,27819,5,0,'1A7C11',0,2,0),(12567,724,27904,5,0,'1A7C11',0,2,0),(12568,725,27899,5,0,'1A7C11',0,2,0),(12569,727,27936,5,0,'1A7C11',0,2,0),(12570,728,27933,5,0,'1A7C11',0,2,0),(12571,730,27975,5,0,'1A7C11',0,2,0),(12572,731,27974,5,0,'1A7C11',0,2,0),(12573,733,28003,5,0,'1A7C11',0,2,0),(12574,734,28004,5,0,'1A7C11',0,2,0),(12575,736,28031,5,0,'1A7C11',0,2,0),(12576,737,28028,5,0,'1A7C11',0,2,0);
/*!40000 ALTER TABLE `graphs_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_discovery`
--

DROP TABLE IF EXISTS `group_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_discovery` (
  `groupid` bigint(20) unsigned NOT NULL,
  `parent_group_prototypeid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupid`),
  KEY `c_group_discovery_2` (`parent_group_prototypeid`),
  CONSTRAINT `c_group_discovery_2` FOREIGN KEY (`parent_group_prototypeid`) REFERENCES `group_prototype` (`group_prototypeid`),
  CONSTRAINT `c_group_discovery_1` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_discovery`
--

LOCK TABLES `group_discovery` WRITE;
/*!40000 ALTER TABLE `group_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_prototype`
--

DROP TABLE IF EXISTS `group_prototype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_prototype` (
  `group_prototypeid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `groupid` bigint(20) unsigned DEFAULT NULL,
  `templateid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`group_prototypeid`),
  KEY `group_prototype_1` (`hostid`),
  KEY `c_group_prototype_2` (`groupid`),
  KEY `c_group_prototype_3` (`templateid`),
  CONSTRAINT `c_group_prototype_3` FOREIGN KEY (`templateid`) REFERENCES `group_prototype` (`group_prototypeid`) ON DELETE CASCADE,
  CONSTRAINT `c_group_prototype_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_group_prototype_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_prototype`
--

LOCK TABLES `group_prototype` WRITE;
/*!40000 ALTER TABLE `group_prototype` DISABLE KEYS */;
INSERT INTO `group_prototype` VALUES (100,10176,'{#CLUSTER.NAME}',NULL,NULL),(101,10176,'{#DATACENTER.NAME}',NULL,NULL),(102,10176,'',7,NULL),(103,10177,'{#CLUSTER.NAME} (vm)',NULL,NULL),(104,10177,'{#DATACENTER.NAME} (vm)',NULL,NULL),(105,10177,'{#HV.NAME}',NULL,NULL),(106,10177,'',6,NULL);
/*!40000 ALTER TABLE `group_prototype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` double(16,4) NOT NULL DEFAULT '0.0000',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_log`
--

DROP TABLE IF EXISTS `history_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_log` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `source` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `severity` int(11) NOT NULL DEFAULT '0',
  `value` text COLLATE utf8_bin NOT NULL,
  `logeventid` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_log_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_log`
--

LOCK TABLES `history_log` WRITE;
/*!40000 ALTER TABLE `history_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_str`
--

DROP TABLE IF EXISTS `history_str`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_str` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_str_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_str`
--

LOCK TABLES `history_str` WRITE;
/*!40000 ALTER TABLE `history_str` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_str` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_text`
--

DROP TABLE IF EXISTS `history_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_text` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` text COLLATE utf8_bin NOT NULL,
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_text_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_text`
--

LOCK TABLES `history_text` WRITE;
/*!40000 ALTER TABLE `history_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_uint`
--

DROP TABLE IF EXISTS `history_uint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_uint` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` bigint(20) unsigned NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_uint_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_uint`
--

LOCK TABLES `history_uint` WRITE;
/*!40000 ALTER TABLE `history_uint` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_uint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_discovery`
--

DROP TABLE IF EXISTS `host_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_discovery` (
  `hostid` bigint(20) unsigned NOT NULL,
  `parent_hostid` bigint(20) unsigned DEFAULT NULL,
  `parent_itemid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`hostid`),
  KEY `c_host_discovery_2` (`parent_hostid`),
  KEY `c_host_discovery_3` (`parent_itemid`),
  CONSTRAINT `c_host_discovery_3` FOREIGN KEY (`parent_itemid`) REFERENCES `items` (`itemid`),
  CONSTRAINT `c_host_discovery_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_host_discovery_2` FOREIGN KEY (`parent_hostid`) REFERENCES `hosts` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_discovery`
--

LOCK TABLES `host_discovery` WRITE;
/*!40000 ALTER TABLE `host_discovery` DISABLE KEYS */;
INSERT INTO `host_discovery` VALUES (10176,NULL,26988,'',0,0),(10177,NULL,26989,'',0,0);
/*!40000 ALTER TABLE `host_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_inventory`
--

DROP TABLE IF EXISTS `host_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_inventory` (
  `hostid` bigint(20) unsigned NOT NULL,
  `inventory_mode` int(11) NOT NULL DEFAULT '0',
  `type` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type_full` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `alias` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `os` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `os_full` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `os_short` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `serialno_a` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `serialno_b` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `tag` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `asset_tag` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `macaddress_a` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `macaddress_b` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `hardware` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `hardware_full` text COLLATE utf8_bin NOT NULL,
  `software` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `software_full` text COLLATE utf8_bin NOT NULL,
  `software_app_a` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `software_app_b` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `software_app_c` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `software_app_d` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `software_app_e` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `contact` text COLLATE utf8_bin NOT NULL,
  `location` text COLLATE utf8_bin NOT NULL,
  `location_lat` varchar(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `location_lon` varchar(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `notes` text COLLATE utf8_bin NOT NULL,
  `chassis` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `model` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `hw_arch` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `vendor` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `contract_number` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `installer_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `deployment_status` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `url_a` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `url_b` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `url_c` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `host_networks` text COLLATE utf8_bin NOT NULL,
  `host_netmask` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `host_router` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `oob_ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `oob_netmask` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `oob_router` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `date_hw_purchase` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `date_hw_install` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `date_hw_expiry` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `date_hw_decomm` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_address_a` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_address_b` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_address_c` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_city` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_state` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_country` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_zip` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_rack` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_notes` text COLLATE utf8_bin NOT NULL,
  `poc_1_name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_1_email` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_1_phone_a` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_1_phone_b` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_1_cell` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_1_screen` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_1_notes` text COLLATE utf8_bin NOT NULL,
  `poc_2_name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_2_email` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_2_phone_a` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_2_phone_b` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_2_cell` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_2_screen` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_2_notes` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`hostid`),
  CONSTRAINT `c_host_inventory_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_inventory`
--

LOCK TABLES `host_inventory` WRITE;
/*!40000 ALTER TABLE `host_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostmacro`
--

DROP TABLE IF EXISTS `hostmacro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hostmacro` (
  `hostmacroid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `macro` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`hostmacroid`),
  UNIQUE KEY `hostmacro_1` (`hostid`,`macro`),
  CONSTRAINT `c_hostmacro_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostmacro`
--

LOCK TABLES `hostmacro` WRITE;
/*!40000 ALTER TABLE `hostmacro` DISABLE KEYS */;
INSERT INTO `hostmacro` VALUES (365,10186,'{$ICMP_LOSS_WARN}','20'),(366,10186,'{$ICMP_RESPONSE_TIME_WARN}','0.15'),(367,10187,'{$IFCONTROL}','1'),(368,10187,'{$IF_UTIL_MAX}','95'),(369,10187,'{$IF_ERRORS_WARN}','2'),(370,10188,'{$IFCONTROL}','1'),(371,10188,'{$IF_UTIL_MAX}','95'),(372,10188,'{$IF_ERRORS_WARN}','2'),(373,10189,'{$IFCONTROL}','1'),(374,10189,'{$IF_UTIL_MAX}','90'),(375,10189,'{$IF_ERRORS_WARN}','2'),(376,10190,'{$IFCONTROL}','1'),(377,10190,'{$IF_UTIL_MAX}','90'),(378,10190,'{$IF_ERRORS_WARN}','2'),(382,10192,'{$IFCONTROL}','1'),(385,10203,'{$SNMP_TIMEOUT}','3m'),(386,10204,'{$SNMP_TIMEOUT}','3m'),(393,10207,'{$TEMP_CRIT}','75'),(394,10207,'{$TEMP_WARN}','65'),(395,10207,'{$PSU_CRIT_STATUS}','4'),(396,10207,'{$FAN_CRIT_STATUS}','4'),(397,10207,'{$CPU_UTIL_MAX}','90'),(398,10207,'{$MEMORY_UTIL_MAX}','90'),(399,10207,'{$TEMP_CRIT_LOW}','5'),(402,10208,'{$TEMP_CRIT}','75'),(403,10208,'{$TEMP_WARN}','65'),(404,10208,'{$HEALTH_CRIT_STATUS}','4'),(405,10208,'{$HEALTH_WARN_STATUS:\"offline\"}','2'),(406,10208,'{$HEALTH_WARN_STATUS:\"testing\"}','3'),(407,10208,'{$TEMP_WARN_STATUS}','5'),(408,10208,'{$PSU_CRIT_STATUS}','2'),(409,10208,'{$FAN_CRIT_STATUS}','2'),(410,10208,'{$PSU_OK_STATUS}','4'),(411,10208,'{$FAN_OK_STATUS}','4'),(412,10208,'{$CPU_UTIL_MAX}','90'),(413,10208,'{$MEMORY_UTIL_MAX}','90'),(414,10208,'{$TEMP_CRIT_LOW}','5'),(417,10210,'{$TEMP_CRIT}','75'),(418,10210,'{$TEMP_WARN}','65'),(419,10210,'{$PSU_CRIT_STATUS}','3'),(420,10210,'{$FAN_CRIT_STATUS}','3'),(421,10210,'{$PSU_OK_STATUS}','2'),(422,10210,'{$FAN_OK_STATUS}','2'),(425,10210,'{$TEMP_CRIT_LOW}','5'),(428,10211,'{$TEMP_CRIT}','75'),(429,10211,'{$TEMP_WARN}','65'),(430,10211,'{$PSU_CRIT_STATUS}','3'),(431,10211,'{$FAN_CRIT_STATUS}','3'),(432,10211,'{$PSU_OK_STATUS}','2'),(433,10211,'{$FAN_OK_STATUS}','2'),(436,10211,'{$TEMP_CRIT_LOW}','5'),(439,10217,'{$TEMP_CRIT:\"CPU\"}','75'),(440,10217,'{$TEMP_WARN:\"CPU\"}','70'),(441,10217,'{$TEMP_WARN_STATUS}','2'),(442,10217,'{$TEMP_CRIT_STATUS}','3'),(443,10217,'{$TEMP_DISASTER_STATUS}','4'),(469,10221,'{$TEMP_CRIT}','65'),(470,10221,'{$TEMP_WARN}','55'),(471,10221,'{$PSU_CRIT_STATUS}','2'),(472,10221,'{$FAN_CRIT_STATUS}','2'),(473,10221,'{$PSU_OK_STATUS}','1'),(474,10221,'{$FAN_OK_STATUS}','1'),(475,10221,'{$CPU_UTIL_MAX}','90'),(476,10221,'{$MEMORY_UTIL_MAX}','90'),(477,10221,'{$TEMP_CRIT_LOW}','5'),(480,10222,'{$TEMP_CRIT}','75'),(481,10222,'{$TEMP_WARN}','65'),(482,10222,'{$PSU_CRIT_STATUS}','5'),(483,10222,'{$FAN_CRIT_STATUS}','5'),(484,10222,'{$CPU_UTIL_MAX}','90'),(485,10222,'{$MEMORY_UTIL_MAX}','90'),(486,10222,'{$TEMP_CRIT_LOW}','5'),(489,10223,'{$TEMP_CRIT}','75'),(490,10223,'{$TEMP_WARN}','65'),(491,10223,'{$PSU_CRIT_STATUS}','4'),(492,10223,'{$FAN_CRIT_STATUS}','2'),(493,10223,'{$CPU_UTIL_MAX}','90'),(494,10223,'{$MEMORY_UTIL_MAX}','90'),(495,10223,'{$TEMP_CRIT_LOW}','5'),(498,10224,'{$TEMP_CRIT}','65'),(499,10224,'{$TEMP_WARN}','55'),(500,10224,'{$TEMP_CRIT_STATUS}','1'),(501,10224,'{$PSU_CRIT_STATUS}','3'),(502,10224,'{$FAN_CRIT_STATUS}','2'),(505,10224,'{$CPU_UTIL_MAX}','90'),(506,10224,'{$MEMORY_UTIL_MAX}','90'),(507,10224,'{$TEMP_CRIT_LOW}','5'),(510,10227,'{$FAN_CRIT_STATUS:\"fanError\"}','41'),(511,10227,'{$FAN_CRIT_STATUS:\"hardwareFaulty\"}','91'),(512,10227,'{$PSU_CRIT_STATUS:\"psuError\"}','51'),(513,10227,'{$PSU_CRIT_STATUS:\"rpsError\"}','61'),(514,10227,'{$PSU_CRIT_STATUS:\"hardwareFaulty\"}','91'),(515,10227,'{$CPU_UTIL_MAX}','90'),(516,10227,'{$MEMORY_UTIL_MAX}','90'),(517,10227,'{$TEMP_CRIT}','60'),(518,10227,'{$TEMP_WARN}','50'),(519,10227,'{$TEMP_CRIT_LOW}','5'),(533,10229,'{$FAN_CRIT_STATUS}','2'),(534,10229,'{$CPU_UTIL_MAX}','90'),(535,10229,'{$MEMORY_UTIL_MAX}','90'),(536,10229,'{$TEMP_CRIT}','60'),(537,10229,'{$TEMP_WARN}','50'),(538,10229,'{$TEMP_CRIT_LOW}','5'),(541,10230,'{$TEMP_CRIT_STATUS}','3'),(542,10230,'{$TEMP_WARN_STATUS}','2'),(543,10230,'{$PSU_CRIT_STATUS}','3'),(544,10230,'{$FAN_CRIT_STATUS}','3'),(547,10230,'{$TEMP_CRIT}','60'),(548,10230,'{$TEMP_WARN}','50'),(549,10230,'{$TEMP_CRIT_LOW}','5'),(552,10231,'{$TEMP_CRIT:\"Routing Engine\"}','80'),(553,10231,'{$TEMP_WARN:\"Routing Engine\"}','70'),(554,10231,'{$HEALTH_CRIT_STATUS}','3'),(555,10231,'{$FAN_CRIT_STATUS}','6'),(556,10231,'{$PSU_CRIT_STATUS}','6'),(557,10231,'{$CPU_UTIL_MAX}','90'),(558,10231,'{$MEMORY_UTIL_MAX}','90'),(559,10231,'{$TEMP_CRIT}','60'),(560,10231,'{$TEMP_WARN}','50'),(561,10231,'{$TEMP_CRIT_LOW}','5'),(572,10233,'{$TEMP_CRIT:\"CPU\"}','75'),(573,10233,'{$TEMP_WARN:\"CPU\"}','70'),(574,10233,'{$CPU_UTIL_MAX}','90'),(575,10233,'{$MEMORY_UTIL_MAX}','90'),(576,10233,'{$TEMP_CRIT}','60'),(577,10233,'{$TEMP_WARN}','50'),(578,10233,'{$TEMP_CRIT_LOW}','5'),(579,10233,'{$STORAGE_UTIL_CRIT}','90'),(580,10233,'{$STORAGE_UTIL_WARN}','80'),(581,10234,'{$TEMP_WARN_STATUS}','2'),(582,10234,'{$TEMP_CRIT_STATUS}','3'),(583,10234,'{$PSU_CRIT_STATUS:\"failed\"}','2'),(584,10234,'{$FAN_CRIT_STATUS:\"failed\"}','2'),(585,10234,'{$CPU_UTIL_MAX}','90'),(586,10234,'{$MEMORY_UTIL_MAX}','90'),(587,10234,'{$TEMP_CRIT}','60'),(588,10234,'{$TEMP_WARN}','50'),(589,10234,'{$TEMP_CRIT_LOW}','5'),(592,10235,'{$TEMP_CRIT}','75'),(593,10235,'{$TEMP_WARN}','65'),(594,10235,'{$PSU_CRIT_STATUS}','1'),(595,10235,'{$FAN_CRIT_STATUS}','1'),(596,10235,'{$CPU_UTIL_MAX}','90'),(597,10235,'{$MEMORY_UTIL_MAX}','90'),(601,10236,'{$CPU_UTIL_MAX}','90'),(602,10236,'{$MEMORY_UTIL_MAX}','90'),(603,10237,'{$CPU_UTIL_MAX}','90'),(604,10237,'{$MEMORY_UTIL_MAX}','90'),(619,10250,'{$FAN_CRIT_STATUS:\"bad\"}','2'),(620,10250,'{$PSU_CRIT_STATUS:\"bad\"}','2'),(621,10250,'{$TEMP_WARN_STATUS}','3'),(622,10250,'{$TEMP_CRIT_STATUS}','2'),(623,10250,'{$CPU_UTIL_MAX}','90'),(624,10250,'{$MEMORY_UTIL_MAX}','90'),(625,10250,'{$TEMP_CRIT}','60'),(626,10250,'{$TEMP_WARN}','50'),(627,10250,'{$TEMP_CRIT_LOW}','5'),(630,10251,'{$PSU_CRIT_STATUS}','2'),(631,10251,'{$FAN_CRIT_STATUS}','3'),(632,10251,'{$TEMP_WARN_STATUS}','3'),(635,10251,'{$TEMP_CRIT}','60'),(636,10251,'{$TEMP_WARN}','50'),(637,10251,'{$TEMP_CRIT_LOW}','5'),(647,10230,'{$PSU_WARN_STATUS}','4'),(648,10217,'{$PSU_CRIT_STATUS:\"critical\"}','3'),(649,10217,'{$PSU_CRIT_STATUS:\"shutdown\"}','4'),(650,10217,'{$PSU_WARN_STATUS:\"warning\"}','2'),(651,10217,'{$PSU_WARN_STATUS:\"notFunctioning\"}','6'),(652,10217,'{$FAN_CRIT_STATUS:\"critical\"}','3'),(653,10217,'{$FAN_CRIT_STATUS:\"shutdown\"}','4'),(654,10217,'{$FAN_WARN_STATUS:\"warning\"}','2'),(655,10217,'{$FAN_WARN_STATUS:\"notFunctioning\"}','6'),(656,10250,'{$FAN_WARN_STATUS:\"warning\"}','3'),(657,10250,'{$PSU_WARN_STATUS:\"warning\"}','3'),(659,10254,'{$FAN_CRIT_STATUS}','3'),(661,10254,'{$PSU_CRIT_STATUS}','2'),(664,10254,'{$TEMP_CRIT_LOW}','5'),(665,10254,'{$TEMP_CRIT}','60'),(666,10254,'{$TEMP_WARN_STATUS}','3'),(667,10254,'{$TEMP_WARN}','50'),(668,10209,'{$CPU_UTIL_MAX}','90'),(669,10209,'{$MEMORY_UTIL_MAX}','90'),(670,10212,'{$MEMORY_UTIL_MAX}','90'),(671,10213,'{$CPU_UTIL_MAX}','90'),(672,10252,'{$CPU_UTIL_MAX}','90'),(673,10215,'{$CPU_UTIL_MAX}','90'),(674,10217,'{$TEMP_CRIT_LOW}','5'),(675,10217,'{$TEMP_CRIT}','60'),(676,10217,'{$TEMP_WARN}','50'),(677,10255,'{$DISK_ARRAY_CACHE_BATTERY_CRIT_STATUS}','3'),(678,10255,'{$DISK_ARRAY_CACHE_BATTERY_OK_STATUS}','2'),(679,10255,'{$DISK_ARRAY_CACHE_BATTERY_WARN_STATUS}','4'),(680,10255,'{$DISK_ARRAY_CRIT_STATUS:\"critical\"}','5'),(681,10255,'{$DISK_ARRAY_FAIL_STATUS:\"nonRecoverable\"}','6'),(682,10255,'{$DISK_ARRAY_WARN_STATUS:\"nonCritical\"}','4'),(683,10255,'{$DISK_FAIL_STATUS:\"critical\"}','5'),(684,10255,'{$DISK_FAIL_STATUS:\"nonRecoverable\"}','6'),(685,10255,'{$DISK_SMART_FAIL_STATUS}','1'),(686,10255,'{$DISK_WARN_STATUS:\"nonCritical\"}','4'),(687,10255,'{$FAN_CRIT_STATUS:\"criticalLower\"}','8'),(688,10255,'{$FAN_CRIT_STATUS:\"criticalUpper\"}','5'),(689,10255,'{$FAN_CRIT_STATUS:\"failed\"}','10'),(690,10255,'{$FAN_CRIT_STATUS:\"nonRecoverableLower\"}','9'),(691,10255,'{$FAN_CRIT_STATUS:\"nonRecoverableUpper\"}','6'),(692,10255,'{$FAN_WARN_STATUS:\"nonCriticalLower\"}','7'),(693,10255,'{$FAN_WARN_STATUS:\"nonCriticalUpper\"}','4'),(694,10255,'{$HEALTH_CRIT_STATUS}','5'),(695,10255,'{$HEALTH_DISASTER_STATUS}','6'),(696,10255,'{$HEALTH_WARN_STATUS}','4'),(697,10255,'{$PSU_CRIT_STATUS:\"critical\"}','5'),(698,10255,'{$PSU_CRIT_STATUS:\"nonRecoverable\"}','6'),(699,10255,'{$PSU_WARN_STATUS:\"nonCritical\"}','4'),(700,10255,'{$TEMP_CRIT:\"Ambient\"}','35'),(701,10255,'{$TEMP_CRIT:\"CPU\"}','75'),(702,10255,'{$TEMP_CRIT_LOW}','5'),(703,10255,'{$TEMP_CRIT_STATUS}','5'),(704,10255,'{$TEMP_CRIT}','60'),(705,10255,'{$TEMP_DISASTER_STATUS}','6'),(706,10255,'{$TEMP_WARN:\"Ambient\"}','30'),(707,10255,'{$TEMP_WARN:\"CPU\"}','70'),(708,10255,'{$TEMP_WARN_STATUS}','4'),(709,10255,'{$TEMP_WARN}','50'),(710,10255,'{$VDISK_CRIT_STATUS:\"failed\"}','3'),(711,10255,'{$VDISK_WARN_STATUS:\"degraded\"}','4'),(712,10256,'{$DISK_ARRAY_CACHE_BATTERY_CRIT_STATUS:\"capacitorFailed\"}','7'),(713,10256,'{$DISK_ARRAY_CACHE_BATTERY_CRIT_STATUS:\"failed\"}','4'),(714,10256,'{$DISK_ARRAY_CACHE_BATTERY_WARN_STATUS:\"degraded\"}','5'),(715,10256,'{$DISK_ARRAY_CACHE_BATTERY_WARN_STATUS:\"notPresent\"}','6'),(716,10256,'{$DISK_ARRAY_CACHE_CRIT_STATUS:\"cacheModCriticalFailure\"}','8'),(717,10256,'{$DISK_ARRAY_CACHE_OK_STATUS:\"enabled\"}','3'),(718,10256,'{$DISK_ARRAY_CACHE_WARN_STATUS:\"cacheModDegradedFailsafeSpeed\"}','7'),(719,10256,'{$DISK_ARRAY_CACHE_WARN_STATUS:\"cacheModFlashMemNotAttached\"}','6'),(720,10256,'{$DISK_ARRAY_CACHE_WARN_STATUS:\"cacheReadCacheNotMapped\"}','9'),(721,10256,'{$DISK_ARRAY_CACHE_WARN_STATUS:\"invalid\"}','2'),(722,10256,'{$DISK_ARRAY_CRIT_STATUS}','4'),(723,10256,'{$DISK_ARRAY_WARN_STATUS}','3'),(724,10256,'{$DISK_FAIL_STATUS}','3'),(725,10256,'{$DISK_SMART_FAIL_STATUS:\"replaceDrive\"}','3'),(726,10256,'{$DISK_SMART_FAIL_STATUS:\"replaceDriveSSDWearOut\"}','4'),(727,10256,'{$DISK_WARN_STATUS}','4'),(728,10256,'{$FAN_CRIT_STATUS}','4'),(729,10256,'{$FAN_WARN_STATUS}','3'),(730,10256,'{$HEALTH_CRIT_STATUS}','4'),(731,10256,'{$HEALTH_WARN_STATUS}','3'),(732,10256,'{$PSU_CRIT_STATUS}','4'),(733,10256,'{$PSU_WARN_STATUS}','3'),(734,10256,'{$TEMP_CRIT:\"Ambient\"}','35'),(735,10256,'{$TEMP_CRIT_LOW}','5'),(736,10256,'{$TEMP_CRIT}','60'),(737,10256,'{$TEMP_WARN:\"Ambient\"}','30'),(738,10256,'{$TEMP_WARN}','50'),(739,10256,'{$VDISK_CRIT_STATUS}','3'),(740,10256,'{$VDISK_OK_STATUS}','2'),(741,10257,'{$DISK_OK_STATUS}','Normal'),(742,10257,'{$FAN_OK_STATUS}','Normal'),(743,10257,'{$HEALTH_CRIT_STATUS}','2'),(744,10257,'{$HEALTH_DISASTER_STATUS}','0'),(745,10257,'{$HEALTH_WARN_STATUS}','4'),(746,10257,'{$PSU_OK_STATUS}','Normal'),(747,10257,'{$TEMP_CRIT:\"Ambient\"}','35'),(748,10257,'{$TEMP_CRIT_LOW}','5'),(749,10257,'{$TEMP_CRIT}','60'),(750,10257,'{$TEMP_WARN:\"Ambient\"}','30'),(751,10257,'{$TEMP_WARN}','50'),(752,10258,'{$DISK_OK_STATUS}','Normal'),(753,10258,'{$FAN_OK_STATUS}','Normal'),(754,10258,'{$HEALTH_CRIT_STATUS}','2'),(755,10258,'{$HEALTH_DISASTER_STATUS}','0'),(756,10258,'{$HEALTH_WARN_STATUS}','4'),(757,10258,'{$PSU_OK_STATUS}','Normal'),(758,10258,'{$TEMP_CRIT:\"Ambient\"}','35'),(759,10258,'{$TEMP_CRIT_LOW}','5'),(760,10258,'{$TEMP_CRIT}','60'),(761,10258,'{$TEMP_WARN:\"Ambient\"}','30'),(762,10258,'{$TEMP_WARN}','50'),(763,10259,'{$TEMP_CRIT_LOW}','5'),(764,10259,'{$TEMP_CRIT}','60'),(765,10259,'{$TEMP_WARN}','50'),(766,10260,'{$PROTOCOL_HANDLER_AJP}','ajp-nio-8009'),(767,10260,'{$PROTOCOL_HANDLER_HTTP}','http-nio-8080'),(768,10260,'{$PROTOCOL_HANDLER_HTTPS}','https-openssl-nio-8443'),(769,10261,'{$ADDRESS}',''),(770,10261,'{$PORT}',''),(771,10262,'{$ADDRESS}',''),(772,10262,'{$PORT}',''),(773,10175,'{$VMWARE_INTERVAL}','1m'),(774,10175,'{$VMWARE_INTERVAL:conf}','1h'),(775,10175,'{$VMWARE_PERF_INTERVAL}','1m'),(776,10175,'{$VMWARE_PERF_INTERVAL:datastore}','5m'),(777,10174,'{$VMWARE_INTERVAL}','1m'),(778,10174,'{$VMWARE_INTERVAL:conf}','1h'),(779,10174,'{$VMWARE_PERF_INTERVAL}','1m'),(780,10173,'{$VMWARE_PERF_INTERVAL}','1m'),(781,10173,'{$VMWARE_PERF_INTERVAL:datastore}','5m'),(782,10263,'{$DISK_ARRAY_CACHE_BATTERY_CRIT_STATUS}','2'),(783,10263,'{$DISK_ARRAY_CACHE_BATTERY_OK_STATUS}','1'),(784,10263,'{$DISK_ARRAY_CRIT_STATUS:\"inoperable\"}','2'),(785,10263,'{$DISK_ARRAY_OK_STATUS:\"operable\"}','1'),(786,10263,'{$DISK_ARRAY_WARN_STATUS:\"degraded\"}','3'),(787,10263,'{$DISK_CRIT_STATUS:\"bad\"}','16'),(788,10263,'{$DISK_CRIT_STATUS:\"predictiveFailure\"}','11'),(789,10263,'{$DISK_FAIL_STATUS:\"failed\"}','9'),(790,10263,'{$FAN_CRIT_STATUS:\"inoperable\"}','2'),(791,10263,'{$FAN_WARN_STATUS:\"degraded\"}','3'),(792,10263,'{$HEALTH_CRIT_STATUS:\"computeFailed\"}','30'),(793,10263,'{$HEALTH_CRIT_STATUS:\"configFailure\"}','33'),(794,10263,'{$HEALTH_CRIT_STATUS:\"inoperable\"}','60'),(795,10263,'{$HEALTH_CRIT_STATUS:\"unconfigFailure\"}','34'),(796,10263,'{$HEALTH_WARN_STATUS:\"diagnosticsFailed\"}','204'),(797,10263,'{$HEALTH_WARN_STATUS:\"powerProblem\"}','62'),(798,10263,'{$HEALTH_WARN_STATUS:\"testFailed\"}','35'),(799,10263,'{$HEALTH_WARN_STATUS:\"thermalProblem\"}','60'),(800,10263,'{$HEALTH_WARN_STATUS:\"voltageProblem\"}','62'),(801,10263,'{$PSU_CRIT_STATUS:\"inoperable\"}','2'),(802,10263,'{$PSU_WARN_STATUS:\"degraded\"}','3'),(803,10263,'{$TEMP_CRIT:\"Ambient\"}','35'),(804,10263,'{$TEMP_CRIT_LOW}','5'),(805,10263,'{$TEMP_CRIT}','60'),(806,10263,'{$TEMP_WARN:\"Ambient\"}','30'),(807,10263,'{$TEMP_WARN}','50'),(808,10263,'{$VDISK_OK_STATUS:\"equipped\"}','10'),(809,10254,'{$MEMORY.NAME.NOT_MATCHES}','(Buffer|Cache)'),(810,10254,'{$VFS.FS.PUSED.MAX.CRIT}','95'),(811,10254,'{$VFS.FS.PUSED.MAX.WARN}','90'),(812,10264,'{$VFS.FS.FSNAME.MATCHES}','.+'),(813,10264,'{$VFS.FS.FSNAME.NOT_MATCHES}','^(/dev|/sys|/run|/proc|.+/shm$)'),(814,10264,'{$VFS.FS.FSTYPE.MATCHES}','.*(\\.4|\\.9|hrStorageFixedDisk|hrStorageFlashMemory)$'),(815,10264,'{$VFS.FS.FSTYPE.NOT_MATCHES}','CHANGE_IF_NEEDED'),(816,10264,'{$VFS.FS.PUSED.MAX.CRIT}','90'),(817,10264,'{$VFS.FS.PUSED.MAX.WARN}','80'),(818,10265,'{$MEMORY.NAME.MATCHES}','.*'),(819,10265,'{$MEMORY.NAME.NOT_MATCHES}','CHANGE_IF_NEEDED'),(820,10265,'{$MEMORY.TYPE.MATCHES}','.*(\\.2|hrStorageRam)$'),(821,10265,'{$MEMORY.TYPE.NOT_MATCHES}','CHANGE_IF_NEEDED'),(822,10265,'{$MEMORY.UTIL.MAX}','90'),(823,10266,'{$CPU.UTIL.CRIT}','90'),(824,10192,'{$IF.ERRORS.WARN}','2'),(825,10192,'{$IF.UTIL.MAX}','90'),(826,10192,'{$NET.IF.IFADMINSTATUS.MATCHES}','^.*$'),(827,10192,'{$NET.IF.IFADMINSTATUS.NOT_MATCHES}','^2$'),(828,10192,'{$NET.IF.IFALIAS.MATCHES}','.*'),(829,10192,'{$NET.IF.IFALIAS.NOT_MATCHES}','CHANGE_IF_NEEDED'),(830,10192,'{$NET.IF.IFDESCR.MATCHES}','.*'),(831,10192,'{$NET.IF.IFDESCR.NOT_MATCHES}','Miniport|Virtual|Teredo|Kernel|Loopback|Bluetooth|HTTPS|6to4|QoS|Layer|isatap|ISATAP'),(832,10192,'{$NET.IF.IFNAME.MATCHES}','^.*$'),(833,10192,'{$NET.IF.IFNAME.NOT_MATCHES}','(^Software Loopback Interface|^NULL[0-9.]*$|^[Ll]o[0-9.]*$|^[Ss]ystem$|^Nu[0-9.]*$|^veth[0-9a-z]+$|docker[0-9]+|br-[a-z0-9]{12})'),(834,10192,'{$NET.IF.IFOPERSTATUS.MATCHES}','^.*$'),(835,10192,'{$NET.IF.IFOPERSTATUS.NOT_MATCHES}','^6$'),(836,10192,'{$NET.IF.IFTYPE.MATCHES}','.*'),(837,10192,'{$NET.IF.IFTYPE.NOT_MATCHES}','CHANGE_IF_NEEDED'),(838,10267,'{$VFS.FS.FSNAME.MATCHES}','.+'),(839,10267,'{$VFS.FS.FSNAME.NOT_MATCHES}','^(/dev|/sys|/run|/proc|.+/shm$)'),(840,10267,'{$VFS.FS.FSTYPE.MATCHES}','.*(\\.4|\\.9|hrStorageFixedDisk|hrStorageFlashMemory)$'),(841,10267,'{$VFS.FS.FSTYPE.NOT_MATCHES}','CHANGE_IF_NEEDED'),(842,10267,'{$VFS.FS.PUSED.MAX.CRIT}','90'),(843,10267,'{$VFS.FS.PUSED.MAX.WARN}','80'),(844,10268,'{$MEMORY.NAME.MATCHES}','.*'),(845,10268,'{$MEMORY.NAME.NOT_MATCHES}','CHANGE_IF_NEEDED'),(846,10268,'{$MEMORY.TYPE.MATCHES}','.*(\\.2|hrStorageRam)$'),(847,10268,'{$MEMORY.TYPE.NOT_MATCHES}','CHANGE_IF_NEEDED'),(848,10268,'{$MEMORY.UTIL.MAX}','90'),(849,10269,'{$CPU.UTIL.CRIT}','90');
/*!40000 ALTER TABLE `hostmacro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts`
--

DROP TABLE IF EXISTS `hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts` (
  `hostid` bigint(20) unsigned NOT NULL,
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `disable_until` int(11) NOT NULL DEFAULT '0',
  `error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `available` int(11) NOT NULL DEFAULT '0',
  `errors_from` int(11) NOT NULL DEFAULT '0',
  `lastaccess` int(11) NOT NULL DEFAULT '0',
  `ipmi_authtype` int(11) NOT NULL DEFAULT '-1',
  `ipmi_privilege` int(11) NOT NULL DEFAULT '2',
  `ipmi_username` varchar(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ipmi_password` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ipmi_disable_until` int(11) NOT NULL DEFAULT '0',
  `ipmi_available` int(11) NOT NULL DEFAULT '0',
  `snmp_disable_until` int(11) NOT NULL DEFAULT '0',
  `snmp_available` int(11) NOT NULL DEFAULT '0',
  `maintenanceid` bigint(20) unsigned DEFAULT NULL,
  `maintenance_status` int(11) NOT NULL DEFAULT '0',
  `maintenance_type` int(11) NOT NULL DEFAULT '0',
  `maintenance_from` int(11) NOT NULL DEFAULT '0',
  `ipmi_errors_from` int(11) NOT NULL DEFAULT '0',
  `snmp_errors_from` int(11) NOT NULL DEFAULT '0',
  `ipmi_error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmp_error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `jmx_disable_until` int(11) NOT NULL DEFAULT '0',
  `jmx_available` int(11) NOT NULL DEFAULT '0',
  `jmx_errors_from` int(11) NOT NULL DEFAULT '0',
  `jmx_error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `flags` int(11) NOT NULL DEFAULT '0',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `description` text COLLATE utf8_bin NOT NULL,
  `tls_connect` int(11) NOT NULL DEFAULT '1',
  `tls_accept` int(11) NOT NULL DEFAULT '1',
  `tls_issuer` varchar(1024) COLLATE utf8_bin NOT NULL DEFAULT '',
  `tls_subject` varchar(1024) COLLATE utf8_bin NOT NULL DEFAULT '',
  `tls_psk_identity` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `tls_psk` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `proxy_address` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `auto_compress` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`hostid`),
  KEY `hosts_1` (`host`),
  KEY `hosts_2` (`status`),
  KEY `hosts_3` (`proxy_hostid`),
  KEY `hosts_4` (`name`),
  KEY `hosts_5` (`maintenanceid`),
  KEY `c_hosts_3` (`templateid`),
  CONSTRAINT `c_hosts_3` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_hosts_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`),
  CONSTRAINT `c_hosts_2` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts`
--

LOCK TABLES `hosts` WRITE;
/*!40000 ALTER TABLE `hosts` DISABLE KEYS */;
INSERT INTO `hosts` VALUES (10001,NULL,'Template OS Linux',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Linux',0,NULL,'',1,1,'','','','','',1),(10047,NULL,'Template App Zabbix Server',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Zabbix Server',0,NULL,'',1,1,'','','','','',1),(10048,NULL,'Template App Zabbix Proxy',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Zabbix Proxy',0,NULL,'',1,1,'','','','','',1),(10050,NULL,'Template App Zabbix Agent',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Zabbix Agent',0,NULL,'',1,1,'','','','','',1),(10074,NULL,'Template OS OpenBSD',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS OpenBSD',0,NULL,'',1,1,'','','','','',1),(10075,NULL,'Template OS FreeBSD',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS FreeBSD',0,NULL,'',1,1,'','','','','',1),(10076,NULL,'Template OS AIX',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS AIX',0,NULL,'',1,1,'','','','','',1),(10077,NULL,'Template OS HP-UX',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS HP-UX',0,NULL,'',1,1,'','','','','',1),(10078,NULL,'Template OS Solaris',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Solaris',0,NULL,'',1,1,'','','','','',1),(10079,NULL,'Template OS Mac OS X',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Mac OS X',0,NULL,'',1,1,'','','','','',1),(10081,NULL,'Template OS Windows',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Windows',0,NULL,'',1,1,'','','','','',1),(10084,NULL,'Zabbix server',0,0,'',2,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Zabbix server',0,NULL,'',1,1,'','','','','',1),(10093,NULL,'Template App FTP Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App FTP Service',0,NULL,'',1,1,'','','','','',1),(10094,NULL,'Template App HTTP Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App HTTP Service',0,NULL,'',1,1,'','','','','',1),(10095,NULL,'Template App HTTPS Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App HTTPS Service',0,NULL,'',1,1,'','','','','',1),(10096,NULL,'Template App IMAP Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App IMAP Service',0,NULL,'',1,1,'','','','','',1),(10097,NULL,'Template App LDAP Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App LDAP Service',0,NULL,'',1,1,'','','','','',1),(10098,NULL,'Template App NNTP Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App NNTP Service',0,NULL,'',1,1,'','','','','',1),(10099,NULL,'Template App NTP Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App NTP Service',0,NULL,'',1,1,'','','','','',1),(10100,NULL,'Template App POP Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App POP Service',0,NULL,'',1,1,'','','','','',1),(10101,NULL,'Template App SMTP Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App SMTP Service',0,NULL,'',1,1,'','','','','',1),(10102,NULL,'Template App SSH Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App SSH Service',0,NULL,'',1,1,'','','','','',1),(10103,NULL,'Template App Telnet Service',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Telnet Service',0,NULL,'',1,1,'','','','','',1),(10169,NULL,'Template App Generic Java JMX',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Generic Java JMX',0,NULL,'',1,1,'','','','','',1),(10170,NULL,'Template DB MySQL',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template DB MySQL',0,NULL,'',1,1,'','','','','',1),(10171,NULL,'Template Server Intel SR1530 IPMI',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Server Intel SR1530 IPMI',0,NULL,'',1,1,'','','','','',1),(10172,NULL,'Template Server Intel SR1630 IPMI',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Server Intel SR1630 IPMI',0,NULL,'',1,1,'','','','','',1),(10173,NULL,'Template VM VMware',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template VM VMware',0,NULL,'',1,1,'','','','','',1),(10174,NULL,'Template VM VMware Guest',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template VM VMware Guest',0,NULL,'',1,1,'','','','','',1),(10175,NULL,'Template VM VMware Hypervisor',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template VM VMware Hypervisor',0,NULL,'',1,1,'','','','','',1),(10176,NULL,'{#HV.UUID}',0,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','{#HV.NAME}',2,NULL,'',1,1,'','','','','',1),(10177,NULL,'{#VM.UUID}',0,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','{#VM.NAME}',2,NULL,'',1,1,'','','','','',1),(10182,NULL,'Template Module EtherLike-MIB SNMPv1',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module EtherLike-MIB SNMPv1',0,NULL,'Template EtherLike-MIB (duplex control only) version: 0.15\r\nMIBs used:\r\nEtherLike-MIB',1,1,'','','','','',1),(10183,NULL,'Template Module EtherLike-MIB SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module EtherLike-MIB SNMPv2',0,NULL,'Template EtherLike-MIB (duplex control only) version: 0.15\r\nMIBs used:\r\nEtherLike-MIB',1,1,'','','','','',1),(10184,NULL,'Template Module HOST-RESOURCES-MIB SNMPv1',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module HOST-RESOURCES-MIB SNMPv1',0,NULL,'HOST-RESOURCES-MIB: CPU, memory and storage(vfs.fs.file) linked together.\r\n\r\nTemplate tooling version used: 0.33',1,1,'','','','','',1),(10185,NULL,'Template Module HOST-RESOURCES-MIB SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module HOST-RESOURCES-MIB SNMPv2',0,NULL,'HOST-RESOURCES-MIB: CPU, memory and storage(vfs.fs.file) linked together.\r\n\r\nTemplate tooling version used: 0.33',1,1,'','','','','',1),(10186,NULL,'Template Module ICMP Ping',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module ICMP Ping',0,NULL,'Template Module ICMP Ping version: 0.15',1,1,'','','','','',1),(10187,NULL,'Template Module Interfaces Simple SNMPv1',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Interfaces Simple SNMPv1',0,NULL,'Template Interfaces Simple (no ifXTable) version: 0.15\r\nMIBs used:\r\nIF-MIB',1,1,'','','','','',1),(10188,NULL,'Template Module Interfaces Simple SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Interfaces Simple SNMPv2',0,NULL,'Template Interfaces Simple (no ifXTable) version: 0.15\r\nMIBs used:\r\nIF-MIB',1,1,'','','','','',1),(10189,NULL,'Template Module Interfaces SNMPv1',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Interfaces SNMPv1',0,NULL,'Template Interfaces version: 0.15\r\nMIBs used:\r\nIF-MIB',1,1,'','','','','',1),(10190,NULL,'Template Module Interfaces SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Interfaces SNMPv2',0,NULL,'Template Interfaces version: 0.15\r\nMIBs used:\r\nIF-MIB',1,1,'','','','','',1),(10192,NULL,'Template Module Interfaces Windows SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Interfaces Windows SNMPv2',0,NULL,'Template Interfaces Windows\r\n\r\nMIBs used:\r\nIF-MIB\r\n\r\nKnown Issues:\r\n\r\n  Description: 32bit counters are used in this template (since 64bit are not supported by Windows OS). If busy interfaces return incorrect bits sent/received - set update interval to 1m or less.\r\n\r\nTemplate tooling version used: 0.33',1,1,'','','','','',1),(10203,NULL,'Template Module Generic SNMPv1',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Generic SNMPv1',0,NULL,'Template Module Generic version: 0.15\r\nMIBs used:\r\nSNMPv2-MIB',1,1,'','','','','',1),(10204,NULL,'Template Module Generic SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Generic SNMPv2',0,NULL,'Template Module Generic version: 0.15\r\nMIBs used:\r\nSNMPv2-MIB',1,1,'','','','','',1),(10207,NULL,'Template Net Alcatel Timetra TiMOS SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Alcatel Timetra TiMOS SNMPv2',0,NULL,'Template Net Alcatel Timetra TiMOS version: 0.15\r\nMIBs used:\r\nTIMETRA-CHASSIS-MIB\r\nTIMETRA-SYSTEM-MIB\r\nSNMPv2-MIB',1,1,'','','','','',1),(10208,NULL,'Template Net Brocade FC SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Brocade FC SNMPv2',0,NULL,'Template Net Brocade FC version: 0.15\r\nOverview: https://community.brocade.com/dtscp75322/attachments/dtscp75322/fibre/25235/1/FOS_MIB_Reference_v740.pdf\r\nMIBs used:\r\nSW-MIB\r\nKnown Issues:\r\ndescription : no IF-MIB::ifAlias is available\r\nversion : v6.3.1c, v7.0.0c,  v7.4.1c\r\ndevice : all',1,1,'','','','','',1),(10209,NULL,'Template Module Brocade_Foundry Performance SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Brocade_Foundry Performance SNMPv2',0,NULL,'Template Module Brocade_Foundry Performance version: 0.15\r\nMIBs used:\r\nFOUNDRY-SN-AGENT-MIB',1,1,'','','','','',1),(10210,NULL,'Template Net Brocade_Foundry Nonstackable SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Brocade_Foundry Nonstackable SNMPv2',0,NULL,'Template Net Brocade_Foundry Nonstackable version: 0.15\r\nOverview: For devices(old Foundry devices, MLXe and so on) that doesn\'t support Stackable SNMP Tables: snChasFan2Table, snChasPwrSupply2Table,snAgentTemp2Table -\r\nFOUNDRY-SN-AGENT-MIB::snChasFanTable, snChasPwrSupplyTable,snAgentTempTable are used instead.\r\nFor example:\r\nThe objects in table snChasPwrSupply2Table is not supported on the NetIron and the FastIron SX devices.\r\nsnChasFan2Table is not supported on  on the NetIron devices.\r\nsnAgentTemp2Table is not supported on old versions of MLXe\r\nMIBs used:\r\nFOUNDRY-SN-AGENT-MIB',1,1,'','','','','',1),(10211,NULL,'Template Net Brocade_Foundry Stackable SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Brocade_Foundry Stackable SNMPv2',0,NULL,'Template Brocade_Foundry Stackable version: 0.15\r\nOverview: For devices(most of the IronWare Brocade devices) that support Stackable SNMP Tables in FOUNDRY-SN-AGENT-MIB: snChasFan2Table, snChasPwrSupply2Table,snAgentTemp2Table - so objects from all Stack members are provided.\r\nMIBs used:\r\nFOUNDRY-SN-AGENT-MIB\r\nFOUNDRY-SN-STACKING-MIB\r\nKnown Issues:\r\ndescription : Correct fan(returns fan status as \'other(1)\' and temperature (returns 0) for the non-master Switches are not available in SNMP\r\nversion : Version 08.0.40b and above\r\ndevice : ICX 7750 in stack',1,1,'','','','','',1),(10212,NULL,'Template Module Cisco CISCO-MEMORY-POOL-MIB SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Cisco CISCO-MEMORY-POOL-MIB SNMPv2',0,NULL,'Template Cisco CISCO-MEMORY-POOL-MIB version: 0.15\r\nMIBs used:\r\nCISCO-MEMORY-POOL-MIB',1,1,'','','','','',1),(10213,NULL,'Template Module Cisco CISCO-PROCESS-MIB SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Cisco CISCO-PROCESS-MIB SNMPv2',0,NULL,'Template Cisco CISCO-PROCESS-MIB version: 0.15\r\nMIBs used:\r\nCISCO-PROCESS-MIB',1,1,'','','','','',1),(10215,NULL,'Template Module Cisco OLD-CISCO-CPU-MIB SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Cisco OLD-CISCO-CPU-MIB SNMPv2',0,NULL,'Template Cisco OLD-CISCO-CPU-MIB version: 0.15\r\nMIBs used:\r\nOLD-CISCO-CPU-MIB',1,1,'','','','','',1),(10216,NULL,'Template Module Cisco Inventory SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Cisco Inventory SNMPv2',0,NULL,'Template Cisco Inventory version: 0.15\r\nMIBs used:\r\nENTITY-MIB\r\nSNMPv2-MIB',1,1,'','','','','',1),(10217,NULL,'Template Module Cisco CISCO-ENVMON-MIB SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Cisco CISCO-ENVMON-MIB SNMPv2',0,NULL,'Template Cisco CISCO-ENVMON-MIB version: 0.15\r\nMIBs used:\r\nCISCO-ENVMON-MIB',1,1,'','','','','',1),(10218,NULL,'Template Net Cisco IOS SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Cisco IOS SNMPv2',0,NULL,'Template Cisco IOS Software releases 12.2(3.5) or later version: 0.15\r\nKnown Issues:\r\ndescription : no if(in|out)(Errors|Discards) are available for vlan ifType\r\nversion : IOS for example: 12.1(22)EA11, 15.4(3)M2\r\ndevice : C2911, C7600',1,1,'','','','','',1),(10220,NULL,'Template Net Cisco IOS prior to 12.0_3_T SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Cisco IOS prior to 12.0_3_T SNMPv2',0,NULL,'Cisco IOS Software releases prior to 12.0(3)T version: 0.15',1,1,'','','','','',1),(10221,NULL,'Template Net Dell Force S-Series SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Dell Force S-Series SNMPv2',0,NULL,'Template Dell Force S-Series version: 0.15\r\nMIBs used:\r\nF10-S-SERIES-CHASSIS-MIB',1,1,'','','','','',1),(10222,NULL,'Template Net D-Link DES 7200 SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net D-Link DES 7200 SNMPv2',0,NULL,'Template D-Link DES 7200 version: 0.15\r\nMIBs used:\r\nMY-PROCESS-MIB\r\nSNMPv2-MIB\r\nMY-MEMORY-MIB\r\nENTITY-MIB\r\nMY-SYSTEM-MIB',1,1,'','','','','',1),(10223,NULL,'Template Net D-Link DES_DGS Switch SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net D-Link DES_DGS Switch SNMPv2',0,NULL,'Template D-Link DES_DGS Switch version: 0.15\r\nMIBs used:\r\nDLINK-AGENT-MIB\r\nSNMPv2-MIB\r\nENTITY-MIB\r\nEQUIPMENT-MIB\r\nKnown Issues:\r\ndescription : D-Link reports missing PSU as fail(4)\r\nversion : Firmware: 1.73R008,hardware revision: B1\r\ndevice : DGS-3420-26SC Gigabit Ethernet Switch',1,1,'','','','','',1),(10224,NULL,'Template Net Extreme EXOS SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Extreme EXOS SNMPv2',0,NULL,'Template Extreme EXOS version: 0.15\r\nMIBs used:\r\nEXTREME-SOFTWARE-MONITOR-MIB\r\nEXTREME-SYSTEM-MIB\r\nENTITY-MIB',1,1,'','','','','',1),(10225,NULL,'Template Net Network Generic Device SNMPv1',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Network Generic Device SNMPv1',0,NULL,'Template Net Network Generic Device version: 0.15\r\nOverview: Use this template if you can\'t find the template for specific vendor or device family.',1,1,'','','','','',1),(10226,NULL,'Template Net Network Generic Device SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Network Generic Device SNMPv2',0,NULL,'Template Net Network Generic Device version: 0.15\r\nOverview: Use this template if you can\'t find the template for specific vendor or device family.',1,1,'','','','','',1),(10227,NULL,'Template Net HP Comware HH3C SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net HP Comware HH3C SNMPv2',0,NULL,'Template Net HP Comware (HH3C) version: 0.15\r\nOverview: http://certifiedgeek.weebly.com/blog/hp-comware-snmp-mib-for-cpu-memory-and-temperature\r\nhttp://www.h3c.com.hk/products___solutions/technology/system_management/configuration_example/200912/656451_57_0.htm\r\nMIBs used:\r\nENTITY-MIB\r\nHH3C-ENTITY-EXT-MIB\r\nKnown Issues:\r\ndescription : No temperature sensors. All entities of them return 0 for HH3C-ENTITY-EXT-MIB::hh3cEntityExtTemperature\r\nversion : 1910-48 Switch Software Version 5.20.99, Release 1116 Copyright(c)2010-2016 Hewlett Packard Enterprise Development LP\r\ndevice : HP 1910-48',1,1,'','','','','',1),(10229,NULL,'Template Net Huawei VRP SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Huawei VRP SNMPv2',0,NULL,'Template Net Huawei VRP version: 0.15\r\nOverview: Reference: https://www.slideshare.net/Huanetwork/huawei-s5700-naming-conventions-and-port-numbering-conventions\r\nReference: http://support.huawei.com/enterprise/KnowledgebaseReadAction.action?contentId=KB1000090234\r\nMIBs used:\r\nHUAWEI-ENTITY-EXTENT-MIB\r\nENTITY-MIB',1,1,'','','','','',1),(10230,NULL,'Template Net Intel_Qlogic Infiniband SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Intel_Qlogic Infiniband SNMPv2',0,NULL,'Template Net Intel_Qlogic Infiniband version: 0.15\r\nMIBs used:\r\nICS-CHASSIS-MIB',1,1,'','','','','',1),(10231,NULL,'Template Net Juniper SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Juniper SNMPv2',0,NULL,'Template Net Juniper\r\n\r\nMIBs used:\r\nJUNIPER-ALARM-MIB\r\nJUNIPER-MIB\r\nSNMPv2-MIB\r\n\r\nTemplate tooling version used: 0.23',1,1,'','','','','',1),(10233,NULL,'Template Net Mikrotik SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Mikrotik SNMPv2',0,NULL,'Template Net Mikrotik version: 0.15\r\nMIBs used:\r\nHOST-RESOURCES-MIB\r\nMIKROTIK-MIB\r\nKnown Issues:\r\ndescription : Doesn\'t have ifHighSpeed filled. fixed in more recent versions\r\nversion : RotuerOS 6.28 or lower\r\ndevice : \r\ndescription : Doesn\'t have any temperature sensors\r\nversion : RotuerOS 6.38.5\r\ndevice : Mikrotik 941-2nD, Mikrotik 951G-2HnD',1,1,'','','','','',1),(10234,NULL,'Template Net Netgear Fastpath SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Netgear Fastpath SNMPv2',0,NULL,'Template Net Netgear Fastpath version: 0.15\r\nOverview: https://kb.netgear.com/24352/MIBs-for-Smart-switches\r\nMIBs used:\r\nFASTPATH-SWITCHING-MIB\r\nFASTPATH-BOXSERVICES-PRIVATE-MIB',1,1,'','','','','',1),(10235,NULL,'Template Net QTech QSW SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net QTech QSW SNMPv2',0,NULL,'Template Net QTech QSW version: 0.15\r\nMIBs used:\r\nQTECH-MIB\r\nENTITY-MIB',1,1,'','','','','',1),(10236,NULL,'Template Net TP-LINK SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net TP-LINK SNMPv2',0,NULL,'Template Net TP-LINK JetStream version: 0.15\r\nOverview: Link to MIBs: http://www.tp-linkru.com/download/T2600G-28TS.html#MIBs_Files\r\nSample device overview page: http://www.tp-linkru.com/products/details/cat-39_T2600G-28TS.html#overview\r\nemulation page(web): http://www.tp-linkru.com/resources/simulator/T2600G-28TS(UN)_1.0/Index.htm\r\nMIBs used:\r\nTPLINK-SYSINFO-MIB\r\nTPLINK-SYSMONITOR-MIB\r\nKnown Issues:\r\ndescription : default sysLocation, sysName and sysContact is not filled with proper data. Real hostname and location can be found only in private branch(TPLINK-SYSINFO-MIB). Please check whether this problem exists in the latest firware: http://www.tp-linkru.com/download/T2600G-28TS.html#Firmware\r\nversion : 2.0.0 Build 20170628 Rel.55184(Beta)\r\ndevice : T2600G-28TS 2.0\r\ndescription : The Serial number of the product(tpSysInfoSerialNum) is missing in HW versions prior to V2_170323\r\nversion : prior to version V2_170323\r\ndevice : T2600G-28TS 2.0',1,1,'','','','','',1),(10237,NULL,'Template Net Ubiquiti AirOS SNMPv1',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Ubiquiti AirOS SNMPv1',0,NULL,'Template Net Ubiquiti AirOS version: 0.15\r\nMIBs used:\r\nIEEE802dot11-MIB\r\nFROGFOOT-RESOURCES-MIB\r\nKnown Issues:\r\ndescription : UBNT unifi reports speed: like IF-MIB::ifSpeed.1 = Gauge32: 4294967295 for all interfaces\r\nversion : Firmware: BZ.ar7240.v3.7.51.6230.170322.1513\r\ndevice : UBNT UAP-LR\r\ndescription : UBNT AirMax(NanoStation, NanoBridge etc) reports ifSpeed: as 0 for VLAN and wireless(ath0) interfaces\r\nversion : Firmware: XW.ar934x.v5.6-beta4.22359.140521.1836\r\ndevice : NanoStation M5\r\ndescription : UBNT AirMax(NanoStation, NanoBridge etc) reports always return ifType: as ethernet(6) even for wifi,vlans and other types\r\nversion : Firmware: XW.ar934x.v5.6-beta4.22359.140521.1836\r\ndevice : NanoStation M5\r\ndescription : ifXTable is not provided in IF-MIB. So Interfaces Simple Template is used instead\r\nversion : all above\r\ndevice : NanoStation, UAP-LR',1,1,'','','','','',1),(10248,NULL,'Template OS Linux SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Linux SNMPv2',0,NULL,'Template OS Linux version: 0.15',1,1,'','','','','',1),(10249,NULL,'Template OS Windows SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Windows SNMPv2',0,NULL,'Official Windows template. Requires server of Zabbix 4.0.14rc1, 4.2.8rc1, 4.4.0rc1 and newer.\r\n\r\n\r\nKnown Issues:\r\n\r\n  Description: Doesn\'t support In/Out 64 bit counters even though IfxTable is present:\r\nCurrently, Windows gets it’s interface status from MIB-2. Since these 64bit SNMP counters (ifHCInOctets, ifHCOutOctets, etc.) are defined as an extension to IF-MIB, Microsoft has not implemented it.\r\nhttps://social.technet.microsoft.com/Forums/windowsserver/en-US/07b62ff0-94f6-40ca-a99d-d129c1b33d70/windows-2008-r2-snmp-64bit-counters-support?forum=winservergen\r\n\r\n  Version: Win2008, Win2012R2.\r\n\r\n  Description: Doesn\'t support ifXTable at all\r\n  Version: WindowsXP\r\n\r\n  Description: EtherLike MIB is not supported\r\n  Version: *\r\n  Device: *\r\n\r\nTemplate tooling version used: 0.33',1,1,'','','','','',1),(10250,NULL,'Template Net HP Enterprise Switch SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net HP Enterprise Switch SNMPv2',0,NULL,'Template Net HP Enterprise Switch version: 0.15\r\nMIBs used:\r\nSEMI-MIB\r\nNETSWITCH-MIB\r\nHP-ICF-CHASSIS\r\nENTITY-SENSORS-MIB\r\nENTITY-MIB\r\nSTATISTICS-MIB',1,1,'','','','','',1),(10251,NULL,'Template Net Mellanox SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Mellanox SNMPv2',0,NULL,'Template Net Mellanox version: 0.15\r\nMIBs used:\r\nENTITY-SENSORS-MIB\r\nENTITY-STATE-MIB\r\nENTITY-MIB',1,1,'','','','','',1),(10252,NULL,'Template Module Cisco CISCO-PROCESS-MIB IOS versions 12.0_3_T-12.2_3.5 SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module Cisco CISCO-PROCESS-MIB IOS versions 12.0_3_T-12.2_3.5 SNMPv2',0,NULL,'Template Module Cisco CISCO-PROCESS-MIB IOS versions 12.0_3_T-12.2_3.5 version: 0.15\r\nMIBs used:\r\nCISCO-PROCESS-MIB',1,1,'','','','','',1),(10253,NULL,'Template Net Cisco IOS versions 12.0_3_T-12.2_3.5 SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Cisco IOS versions 12.0_3_T-12.2_3.5 SNMPv2',0,NULL,'Cisco IOS Software releases later to 12.0(3)T and prior to 12.2(3.5) version: 0.15',1,1,'','','','','',1),(10254,NULL,'Template Net Arista SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Net Arista SNMPv2',0,NULL,'Template Net Arista\r\n\r\nMIBs used:\r\nENTITY-SENSORS-MIB\r\nENTITY-STATE-MIB\r\nENTITY-MIB\r\n\r\nTemplate tooling version used: 0.33',1,1,'','','','','',1),(10255,NULL,'Template Server Dell iDRAC SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Server Dell iDRAC SNMPv2',0,NULL,'Template Server iDRAC version: 0.15\r\nOverview: for Dell servers with iDRAC controllers\r\nhttp://www.dell.com/support/manuals/us/en/19/dell-openmanage-server-administrator-v8.3/snmp_idrac8/idrac-mib?guid=guid-e686536d-bc8e-4e09-8e8b-de8eb052efee\r\nSupported systems: http://www.dell.com/support/manuals/us/en/04/dell-openmanage-server-administrator-v8.3/snmp_idrac8/supported-systems?guid=guid-f72b75ba-e686-4e8a-b8c5-ca11c7c21381\r\nMIBs used:\r\nIDRAC-MIB-SMIv2',1,1,'','','','','',1),(10256,NULL,'Template Server HP iLO SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Server HP iLO SNMPv2',0,NULL,'Template Server HP iLO version: 0.15\r\nOverview: for HP iLO adapters that support SNMP get. Or via operating system, using SNMP HP subagent\r\nMIBs used:\r\nCPQSINFO-MIB\r\nCPQHLTH-MIB\r\nCPQIDA-MIB',1,1,'','','','','',1),(10257,NULL,'Template Server IBM IMM SNMPv1',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Server IBM IMM SNMPv1',0,NULL,'Template Server IBM IMM version: 0.15\r\nOverview: for IMM2 and IMM1 IBM serverX hardware\r\nMIBs used:\r\nIMM-MIB\r\nKnown Issues:\r\ndescription : Some IMMs (IMM1) do not return disks\r\nversion : IMM1\r\ndevice : IBM x3250M3\r\ndescription : Some IMMs (IMM1) do not return fan status: fanHealthStatus\r\nversion : IMM1\r\ndevice : IBM x3250M3\r\ndescription : IMM1 servers (M2, M3 generations) sysObjectID is NET-SNMP-MIB::netSnmpAgentOIDs.10\r\nversion : IMM1\r\ndevice : IMM1 servers (M2,M3 generations)\r\ndescription : IMM1 servers (M2, M3 generations) only Ambient temperature sensor available\r\nversion : IMM1\r\ndevice : IMM1 servers (M2,M3 generations)',1,1,'','','','','',1),(10258,NULL,'Template Server IBM IMM SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Server IBM IMM SNMPv2',0,NULL,'Template Server IBM IMM version: 0.15\r\nOverview: for IMM2 and IMM1 IBM serverX hardware\r\nMIBs used:\r\nIMM-MIB\r\nKnown Issues:\r\ndescription : Some IMMs (IMM1) do not return disks\r\nversion : IMM1\r\ndevice : IBM x3250M3\r\ndescription : Some IMMs (IMM1) do not return fan status: fanHealthStatus\r\nversion : IMM1\r\ndevice : IBM x3250M3\r\ndescription : IMM1 servers (M2, M3 generations) sysObjectID is NET-SNMP-MIB::netSnmpAgentOIDs.10\r\nversion : IMM1\r\ndevice : IMM1 servers (M2,M3 generations)\r\ndescription : IMM1 servers (M2, M3 generations) only Ambient temperature sensor available\r\nversion : IMM1\r\ndevice : IMM1 servers (M2,M3 generations)',1,1,'','','','','',1),(10259,NULL,'Template Server Supermicro Aten SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Server Supermicro Aten SNMPv2',0,NULL,'Template Server Supermicro Aten version: 0.15\r\nOverview: for BMC ATEN IPMI controllers of Supermicro servers\r\nhttps://www.supermicro.com/solutions/IPMI.cfm\r\nMIBs used:\r\nATEN-IPMI-MIB',1,1,'','','','','',1),(10260,NULL,'Template App Apache Tomcat JMX',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Apache Tomcat JMX',0,NULL,'',1,1,'','','','','',1),(10261,NULL,'Template App Remote Zabbix server',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Remote Zabbix server',0,NULL,'',1,1,'','','','','',1),(10262,NULL,'Template App Remote Zabbix proxy',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Remote Zabbix proxy',0,NULL,'',1,1,'','','','','',1),(10263,NULL,'Template Server Cisco UCS SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Server Cisco UCS SNMPv2',0,NULL,'Template Server Cisco UCS version: 0.15\r\nOverview: for Cisco UCS via Integrated Management Controller\r\nMIBs used:\r\nCISCO-UNIFIED-COMPUTING-COMPUTE-MIB\r\nCISCO-UNIFIED-COMPUTING-PROCESSOR-MIB\r\nCISCO-UNIFIED-COMPUTING-EQUIPMENT-MIB\r\nCISCO-UNIFIED-COMPUTING-STORAGE-MIB',1,1,'','','','','',1),(10264,NULL,'Template Module HOST-RESOURCES-MIB storage SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module HOST-RESOURCES-MIB storage SNMPv2',0,NULL,'MIBs used:\r\nHOST-RESOURCES-MIB\r\n\r\nTemplate tooling version used: 0.33',1,1,'','','','','',1),(10265,NULL,'Template Module HOST-RESOURCES-MIB memory SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module HOST-RESOURCES-MIB memory SNMPv2',0,NULL,'MIBs used:\r\nHOST-RESOURCES-MIB\r\n\r\nTemplate tooling version used: 0.33',1,1,'','','','','',1),(10266,NULL,'Template Module HOST-RESOURCES-MIB CPU SNMPv2',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module HOST-RESOURCES-MIB CPU SNMPv2',0,NULL,'Requires Zabbix server 4.0.14, 4.2.8, 4.4.0 or newer (JSONPath function avg() used with types autoconversion).\r\n\r\nMIBs used:\r\nHOST-RESOURCES-MIB\r\n\r\nTemplate tooling version used: 0.33',1,1,'','','','','',1),(10267,NULL,'Template Module HOST-RESOURCES-MIB storage SNMPv1',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module HOST-RESOURCES-MIB storage SNMPv1',0,NULL,'MIBs used:\r\nHOST-RESOURCES-MIB\r\n\r\nTemplate tooling version used: 0.33',1,1,'','','','','',1),(10268,NULL,'Template Module HOST-RESOURCES-MIB memory SNMPv1',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module HOST-RESOURCES-MIB memory SNMPv1',0,NULL,'MIBs used:\r\nHOST-RESOURCES-MIB\r\n\r\nTemplate tooling version used: 0.33',1,1,'','','','','',1),(10269,NULL,'Template Module HOST-RESOURCES-MIB CPU SNMPv1',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Module HOST-RESOURCES-MIB CPU SNMPv1',0,NULL,'Requires Zabbix server 4.0.14, 4.2.8, 4.4.0 or newer (JSONPath function avg() used with types autoconversion).\r\n\r\nMIBs used:\r\nHOST-RESOURCES-MIB\r\n\r\nTemplate tooling version used: 0.33',1,1,'','','','','',1);
/*!40000 ALTER TABLE `hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts_groups`
--

DROP TABLE IF EXISTS `hosts_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts_groups` (
  `hostgroupid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`hostgroupid`),
  UNIQUE KEY `hosts_groups_1` (`hostid`,`groupid`),
  KEY `hosts_groups_2` (`groupid`),
  CONSTRAINT `c_hosts_groups_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE,
  CONSTRAINT `c_hosts_groups_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts_groups`
--

LOCK TABLES `hosts_groups` WRITE;
/*!40000 ALTER TABLE `hosts_groups` DISABLE KEYS */;
INSERT INTO `hosts_groups` VALUES (194,10001,10),(189,10047,12),(188,10048,12),(187,10050,8),(196,10074,10),(192,10075,10),(191,10076,10),(193,10077,10),(197,10078,10),(195,10079,10),(198,10081,10),(92,10084,4),(175,10093,8),(178,10094,8),(177,10095,8),(179,10096,8),(180,10097,8),(181,10098,8),(182,10099,8),(183,10100,8),(184,10101,8),(185,10102,8),(186,10103,8),(176,10169,12),(190,10170,13),(199,10171,11),(200,10172,11),(201,10173,14),(202,10174,14),(203,10175,14),(208,10182,8),(209,10183,8),(210,10184,8),(211,10185,8),(212,10186,8),(213,10187,8),(214,10188,8),(215,10189,8),(216,10190,8),(218,10192,8),(229,10203,8),(230,10204,8),(233,10207,9),(234,10208,9),(235,10209,8),(236,10210,9),(237,10211,9),(238,10212,8),(239,10213,8),(241,10215,8),(242,10216,8),(243,10217,8),(244,10218,9),(246,10220,9),(247,10221,9),(248,10222,9),(249,10223,9),(250,10224,9),(251,10225,9),(252,10226,9),(253,10227,9),(255,10229,9),(256,10230,9),(257,10231,9),(259,10233,9),(260,10234,9),(261,10235,9),(262,10236,9),(263,10237,9),(274,10248,10),(275,10249,10),(276,10250,9),(277,10251,9),(278,10252,8),(279,10253,9),(280,10254,9),(281,10255,11),(282,10256,11),(283,10257,11),(284,10258,11),(285,10259,11),(286,10260,12),(287,10261,12),(288,10262,12),(289,10263,11),(290,10264,8),(291,10265,8),(292,10266,8),(293,10267,8),(294,10268,8),(295,10269,8);
/*!40000 ALTER TABLE `hosts_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts_templates`
--

DROP TABLE IF EXISTS `hosts_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts_templates` (
  `hosttemplateid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`hosttemplateid`),
  UNIQUE KEY `hosts_templates_1` (`hostid`,`templateid`),
  KEY `hosts_templates_2` (`templateid`),
  CONSTRAINT `c_hosts_templates_2` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_hosts_templates_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts_templates`
--

LOCK TABLES `hosts_templates` WRITE;
/*!40000 ALTER TABLE `hosts_templates` DISABLE KEYS */;
INSERT INTO `hosts_templates` VALUES (4,10001,10050),(31,10074,10050),(32,10075,10050),(33,10076,10050),(34,10077,10050),(35,10078,10050),(36,10079,10050),(37,10081,10050),(39,10084,10001),(38,10084,10047),(131,10176,10175),(132,10177,10174),(245,10184,10267),(244,10184,10268),(243,10184,10269),(242,10185,10264),(241,10185,10265),(240,10185,10266),(133,10203,10186),(134,10204,10186),(136,10207,10183),(135,10207,10190),(137,10207,10204),(138,10208,10190),(139,10208,10204),(141,10210,10190),(142,10210,10204),(140,10210,10209),(144,10211,10190),(145,10211,10204),(143,10211,10209),(151,10218,10183),(150,10218,10190),(152,10218,10204),(149,10218,10212),(148,10218,10213),(146,10218,10216),(147,10218,10217),(163,10220,10204),(161,10220,10212),(162,10220,10215),(159,10220,10216),(160,10220,10217),(165,10221,10183),(164,10221,10190),(166,10221,10204),(167,10222,10190),(168,10222,10204),(170,10223,10183),(169,10223,10190),(171,10223,10204),(173,10224,10183),(172,10224,10190),(174,10224,10204),(176,10225,10182),(175,10225,10187),(177,10225,10203),(179,10226,10183),(178,10226,10188),(180,10226,10204),(182,10227,10183),(181,10227,10190),(183,10227,10204),(189,10229,10183),(188,10229,10190),(190,10229,10204),(191,10230,10190),(192,10230,10204),(194,10231,10183),(193,10231,10190),(195,10231,10204),(200,10233,10190),(201,10233,10204),(202,10234,10190),(203,10234,10204),(205,10235,10183),(204,10235,10190),(206,10235,10204),(207,10236,10188),(208,10236,10204),(209,10237,10187),(210,10237,10203),(213,10248,10183),(211,10248,10185),(212,10248,10190),(214,10248,10204),(215,10249,10185),(216,10249,10192),(217,10249,10204),(219,10250,10183),(218,10250,10190),(220,10250,10204),(221,10251,10185),(222,10251,10190),(223,10251,10204),(228,10253,10190),(229,10253,10204),(226,10253,10212),(224,10253,10216),(225,10253,10217),(227,10253,10252),(230,10254,10183),(239,10254,10185),(232,10254,10190),(231,10254,10204),(233,10255,10204),(234,10256,10204),(235,10257,10203),(236,10258,10204),(237,10259,10204),(238,10263,10204);
/*!40000 ALTER TABLE `hosts_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `housekeeper`
--

DROP TABLE IF EXISTS `housekeeper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `housekeeper` (
  `housekeeperid` bigint(20) unsigned NOT NULL,
  `tablename` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`housekeeperid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `housekeeper`
--

LOCK TABLES `housekeeper` WRITE;
/*!40000 ALTER TABLE `housekeeper` DISABLE KEYS */;
/*!40000 ALTER TABLE `housekeeper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hstgrp`
--

DROP TABLE IF EXISTS `hstgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hstgrp` (
  `groupid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `internal` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupid`),
  KEY `hstgrp_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hstgrp`
--

LOCK TABLES `hstgrp` WRITE;
/*!40000 ALTER TABLE `hstgrp` DISABLE KEYS */;
INSERT INTO `hstgrp` VALUES (1,'Templates',0,0),(2,'Linux servers',0,0),(4,'Zabbix servers',0,0),(5,'Discovered hosts',1,0),(6,'Virtual machines',0,0),(7,'Hypervisors',0,0),(8,'Templates/Modules',0,0),(9,'Templates/Network devices',0,0),(10,'Templates/Operating systems',0,0),(11,'Templates/Server hardware',0,0),(12,'Templates/Applications',0,0),(13,'Templates/Databases',0,0),(14,'Templates/Virtualization',0,0);
/*!40000 ALTER TABLE `hstgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httpstep`
--

DROP TABLE IF EXISTS `httpstep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httpstep` (
  `httpstepid` bigint(20) unsigned NOT NULL,
  `httptestid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `no` int(11) NOT NULL DEFAULT '0',
  `url` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timeout` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '15s',
  `posts` text COLLATE utf8_bin NOT NULL,
  `required` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `status_codes` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `follow_redirects` int(11) NOT NULL DEFAULT '1',
  `retrieve_mode` int(11) NOT NULL DEFAULT '0',
  `post_type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`httpstepid`),
  KEY `httpstep_1` (`httptestid`),
  CONSTRAINT `c_httpstep_1` FOREIGN KEY (`httptestid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httpstep`
--

LOCK TABLES `httpstep` WRITE;
/*!40000 ALTER TABLE `httpstep` DISABLE KEYS */;
/*!40000 ALTER TABLE `httpstep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httpstep_field`
--

DROP TABLE IF EXISTS `httpstep_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httpstep_field` (
  `httpstep_fieldid` bigint(20) unsigned NOT NULL,
  `httpstepid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`httpstep_fieldid`),
  KEY `httpstep_field_1` (`httpstepid`),
  CONSTRAINT `c_httpstep_field_1` FOREIGN KEY (`httpstepid`) REFERENCES `httpstep` (`httpstepid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httpstep_field`
--

LOCK TABLES `httpstep_field` WRITE;
/*!40000 ALTER TABLE `httpstep_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `httpstep_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httpstepitem`
--

DROP TABLE IF EXISTS `httpstepitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httpstepitem` (
  `httpstepitemid` bigint(20) unsigned NOT NULL,
  `httpstepid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`httpstepitemid`),
  UNIQUE KEY `httpstepitem_1` (`httpstepid`,`itemid`),
  KEY `httpstepitem_2` (`itemid`),
  CONSTRAINT `c_httpstepitem_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_httpstepitem_1` FOREIGN KEY (`httpstepid`) REFERENCES `httpstep` (`httpstepid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httpstepitem`
--

LOCK TABLES `httpstepitem` WRITE;
/*!40000 ALTER TABLE `httpstepitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `httpstepitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httptest`
--

DROP TABLE IF EXISTS `httptest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httptest` (
  `httptestid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `applicationid` bigint(20) unsigned DEFAULT NULL,
  `nextcheck` int(11) NOT NULL DEFAULT '0',
  `delay` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '1m',
  `status` int(11) NOT NULL DEFAULT '0',
  `agent` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT 'Zabbix',
  `authentication` int(11) NOT NULL DEFAULT '0',
  `http_user` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `http_password` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `hostid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `http_proxy` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `retries` int(11) NOT NULL DEFAULT '1',
  `ssl_cert_file` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ssl_key_file` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ssl_key_password` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `verify_peer` int(11) NOT NULL DEFAULT '0',
  `verify_host` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`httptestid`),
  UNIQUE KEY `httptest_2` (`hostid`,`name`),
  KEY `httptest_1` (`applicationid`),
  KEY `httptest_3` (`status`),
  KEY `httptest_4` (`templateid`),
  CONSTRAINT `c_httptest_3` FOREIGN KEY (`templateid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE,
  CONSTRAINT `c_httptest_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`),
  CONSTRAINT `c_httptest_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httptest`
--

LOCK TABLES `httptest` WRITE;
/*!40000 ALTER TABLE `httptest` DISABLE KEYS */;
/*!40000 ALTER TABLE `httptest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httptest_field`
--

DROP TABLE IF EXISTS `httptest_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httptest_field` (
  `httptest_fieldid` bigint(20) unsigned NOT NULL,
  `httptestid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`httptest_fieldid`),
  KEY `httptest_field_1` (`httptestid`),
  CONSTRAINT `c_httptest_field_1` FOREIGN KEY (`httptestid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httptest_field`
--

LOCK TABLES `httptest_field` WRITE;
/*!40000 ALTER TABLE `httptest_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `httptest_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httptestitem`
--

DROP TABLE IF EXISTS `httptestitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httptestitem` (
  `httptestitemid` bigint(20) unsigned NOT NULL,
  `httptestid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`httptestitemid`),
  UNIQUE KEY `httptestitem_1` (`httptestid`,`itemid`),
  KEY `httptestitem_2` (`itemid`),
  CONSTRAINT `c_httptestitem_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_httptestitem_1` FOREIGN KEY (`httptestid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httptestitem`
--

LOCK TABLES `httptestitem` WRITE;
/*!40000 ALTER TABLE `httptestitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `httptestitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icon_map`
--

DROP TABLE IF EXISTS `icon_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icon_map` (
  `iconmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `default_iconid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`iconmapid`),
  UNIQUE KEY `icon_map_1` (`name`),
  KEY `icon_map_2` (`default_iconid`),
  CONSTRAINT `c_icon_map_1` FOREIGN KEY (`default_iconid`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icon_map`
--

LOCK TABLES `icon_map` WRITE;
/*!40000 ALTER TABLE `icon_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `icon_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icon_mapping`
--

DROP TABLE IF EXISTS `icon_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icon_mapping` (
  `iconmappingid` bigint(20) unsigned NOT NULL,
  `iconmapid` bigint(20) unsigned NOT NULL,
  `iconid` bigint(20) unsigned NOT NULL,
  `inventory_link` int(11) NOT NULL DEFAULT '0',
  `expression` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `sortorder` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`iconmappingid`),
  KEY `icon_mapping_1` (`iconmapid`),
  KEY `icon_mapping_2` (`iconid`),
  CONSTRAINT `c_icon_mapping_2` FOREIGN KEY (`iconid`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_icon_mapping_1` FOREIGN KEY (`iconmapid`) REFERENCES `icon_map` (`iconmapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icon_mapping`
--

LOCK TABLES `icon_mapping` WRITE;
/*!40000 ALTER TABLE `icon_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `icon_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ids`
--

DROP TABLE IF EXISTS `ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ids` (
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `field_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `nextid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`table_name`,`field_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ids`
--

LOCK TABLES `ids` WRITE;
/*!40000 ALTER TABLE `ids` DISABLE KEYS */;
/*!40000 ALTER TABLE `ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `imageid` bigint(20) unsigned NOT NULL,
  `imagetype` int(11) NOT NULL DEFAULT '0',
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `image` longblob NOT NULL,
  PRIMARY KEY (`imageid`),
  UNIQUE KEY `images_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interface`
--

DROP TABLE IF EXISTS `interface`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interface` (
  `interfaceid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `main` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `useip` int(11) NOT NULL DEFAULT '1',
  `ip` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '127.0.0.1',
  `dns` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `port` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '10050',
  `bulk` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`interfaceid`),
  KEY `interface_1` (`hostid`,`type`),
  KEY `interface_2` (`ip`,`dns`),
  CONSTRAINT `c_interface_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interface`
--

LOCK TABLES `interface` WRITE;
/*!40000 ALTER TABLE `interface` DISABLE KEYS */;
INSERT INTO `interface` VALUES (1,10084,1,1,1,'127.0.0.1','','10050',1);
/*!40000 ALTER TABLE `interface` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interface_discovery`
--

DROP TABLE IF EXISTS `interface_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interface_discovery` (
  `interfaceid` bigint(20) unsigned NOT NULL,
  `parent_interfaceid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`interfaceid`),
  KEY `c_interface_discovery_2` (`parent_interfaceid`),
  CONSTRAINT `c_interface_discovery_2` FOREIGN KEY (`parent_interfaceid`) REFERENCES `interface` (`interfaceid`) ON DELETE CASCADE,
  CONSTRAINT `c_interface_discovery_1` FOREIGN KEY (`interfaceid`) REFERENCES `interface` (`interfaceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interface_discovery`
--

LOCK TABLES `interface_discovery` WRITE;
/*!40000 ALTER TABLE `interface_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `interface_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_application_prototype`
--

DROP TABLE IF EXISTS `item_application_prototype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_application_prototype` (
  `item_application_prototypeid` bigint(20) unsigned NOT NULL,
  `application_prototypeid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`item_application_prototypeid`),
  UNIQUE KEY `item_application_prototype_1` (`application_prototypeid`,`itemid`),
  KEY `item_application_prototype_2` (`itemid`),
  CONSTRAINT `c_item_application_prototype_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_item_application_prototype_1` FOREIGN KEY (`application_prototypeid`) REFERENCES `application_prototype` (`application_prototypeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_application_prototype`
--

LOCK TABLES `item_application_prototype` WRITE;
/*!40000 ALTER TABLE `item_application_prototype` DISABLE KEYS */;
INSERT INTO `item_application_prototype` VALUES (1,1,23666),(2,2,28673),(3,2,28674),(4,2,28675),(5,3,28679),(6,3,28680),(7,3,28681),(8,4,28685),(9,4,28686),(10,4,28687),(11,5,28691),(12,5,28692),(13,5,28693),(14,6,28697),(15,6,28698),(16,6,28699),(17,7,28703),(18,7,28704),(19,7,28705),(20,8,27119),(21,8,27120),(22,8,27121),(23,8,27122),(24,8,27123),(25,8,27124),(26,8,27125),(27,8,27126),(28,8,27127),(29,9,28098),(30,9,28099),(31,9,28100),(32,9,28101),(33,9,28102),(34,9,28103),(35,9,28104),(36,9,28105),(37,9,28106),(38,10,28715),(39,10,28716),(40,10,28717),(41,11,28721),(42,11,28722),(43,11,28723);
/*!40000 ALTER TABLE `item_application_prototype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_condition`
--

DROP TABLE IF EXISTS `item_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_condition` (
  `item_conditionid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `operator` int(11) NOT NULL DEFAULT '8',
  `macro` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`item_conditionid`),
  KEY `item_condition_1` (`itemid`),
  CONSTRAINT `c_item_condition_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_condition`
--

LOCK TABLES `item_condition` WRITE;
/*!40000 ALTER TABLE `item_condition` DISABLE KEYS */;
INSERT INTO `item_condition` VALUES (1,22444,8,'{#IFNAME}','@Network interfaces for discovery'),(2,22450,8,'{#FSTYPE}','@File systems for discovery'),(4,22867,8,'{#FSTYPE}','@File systems for discovery'),(5,22907,8,'{#FSTYPE}','@File systems for discovery'),(6,22944,8,'{#IFNAME}','@Network interfaces for discovery'),(7,22947,8,'{#FSTYPE}','@File systems for discovery'),(8,22984,8,'{#IFNAME}','@Network interfaces for discovery'),(9,22987,8,'{#FSTYPE}','@File systems for discovery'),(10,23024,8,'{#IFNAME}','@Network interfaces for discovery'),(11,23027,8,'{#FSTYPE}','@File systems for discovery'),(12,23067,8,'{#FSTYPE}','@File systems for discovery'),(13,23162,8,'{#FSTYPE}','@File systems for discovery'),(14,23163,8,'{#IFNAME}','@Network interfaces for discovery'),(15,23329,8,'{#IFNAME}','@Network interfaces for discovery'),(16,23540,8,'{#IFNAME}','@Network interfaces for discovery'),(19,23278,8,'{#IFNAME}','@Network interfaces for discovery'),(20,23279,8,'{#FSTYPE}','@File systems for discovery'),(21,23665,8,'{#SERVICE.NAME}','@Windows service names for discovery'),(22,23665,8,'{#SERVICE.STARTUPNAME}','@Windows service startup states for discovery'),(215,27029,8,'{#IFOPERSTATUS}','1'),(216,27029,8,'{#SNMPVALUE}','(2|3)'),(217,27031,8,'{#IFOPERSTATUS}','1'),(218,27031,8,'{#SNMPVALUE}','(2|3)'),(227,27068,8,'{#IFADMINSTATUS}','(1|3)'),(228,27068,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(229,27078,8,'{#IFADMINSTATUS}','(1|3)'),(230,27078,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(231,27088,8,'{#IFADMINSTATUS}','(1|3)'),(232,27088,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(233,27098,8,'{#IFADMINSTATUS}','(1|3)'),(234,27098,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(237,27118,8,'{#IFADMINSTATUS}','{$NET.IF.IFADMINSTATUS.MATCHES}'),(238,27118,9,'{#IFADMINSTATUS}','{$NET.IF.IFADMINSTATUS.NOT_MATCHES}'),(243,27180,8,'{#IFADMINSTATUS}','(1|3)'),(244,27180,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(245,27190,8,'{#IFOPERSTATUS}','1'),(246,27190,8,'{#SNMPVALUE}','(2|3)'),(247,27209,8,'{#TEMP_SENSOR}','1'),(248,27210,8,'{#SNMPVALUE}','[^1]'),(249,27211,8,'{#ENT_SN}','.+'),(250,27215,8,'{#IFADMINSTATUS}','(1|3)'),(251,27215,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(253,27242,8,'{#SENSOR_TYPE}','1'),(254,27243,8,'{#SENSOR_TYPE}','3'),(255,27244,8,'{#SENSOR_TYPE}','2'),(256,27251,8,'{#IFADMINSTATUS}','(1|3)'),(257,27251,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(258,27272,8,'{#IFADMINSTATUS}','(1|3)'),(259,27272,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(260,27321,8,'{#IFADMINSTATUS}','(1|3)'),(261,27321,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(262,27331,8,'{#IFOPERSTATUS}','1'),(263,27331,8,'{#SNMPVALUE}','(2|3)'),(266,27393,8,'{#ENT_SN}','.+'),(267,27393,8,'{#ENT_CLASS}','[^3]'),(268,27399,8,'{#ENT_SN}','.+'),(269,27399,8,'{#ENT_CLASS}','[^3]'),(272,27410,8,'{#ENT_SN}','.+'),(273,27410,8,'{#ENT_CLASS}','[^3]'),(274,27450,8,'{#IFADMINSTATUS}','(1|3)'),(275,27450,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(276,27460,8,'{#IFOPERSTATUS}','1'),(277,27460,8,'{#SNMPVALUE}','(2|3)'),(278,27486,8,'{#IFADMINSTATUS}','(1|3)'),(279,27486,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(280,27520,8,'{#IFADMINSTATUS}','(1|3)'),(281,27520,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(282,27530,8,'{#IFOPERSTATUS}','1'),(283,27530,8,'{#SNMPVALUE}','(2|3)'),(284,27550,8,'{#STATUS}','[^0]'),(285,27551,8,'{#STATUS}','[^0]'),(286,27556,8,'{#IFADMINSTATUS}','(1|3)'),(287,27556,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(288,27566,8,'{#IFOPERSTATUS}','1'),(289,27566,8,'{#SNMPVALUE}','(2|3)'),(290,27596,8,'{#IFADMINSTATUS}','(1|3)'),(291,27596,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(292,27606,8,'{#IFOPERSTATUS}','1'),(293,27606,8,'{#SNMPVALUE}','(2|3)'),(294,27619,8,'{#IFADMINSTATUS}','(1|3)'),(295,27619,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(296,27629,8,'{#IFOPERSTATUS}','1'),(297,27629,8,'{#SNMPVALUE}','(2|3)'),(298,27642,8,'{#IFADMINSTATUS}','(1|3)'),(299,27642,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(300,27652,8,'{#IFOPERSTATUS}','1'),(301,27652,8,'{#SNMPVALUE}','(2|3)'),(302,27665,8,'{#SNMPVALUE}','^(MODULE|Module) (LEVEL|level)1$'),(303,27665,8,'{#SNMPVALUE}','(Fabric|FABRIC) (.+) (Module|MODULE)'),(304,27666,8,'{#SNMPVALUE}','^(MODULE|Module) (LEVEL|level)1$'),(305,27666,8,'{#SNMPVALUE}','(Fabric|FABRIC) (.+) (Module|MODULE)'),(306,27666,8,'{#SNMPVALUE}','(T|t)emperature.*(s|S)ensor'),(307,27667,8,'{#ENT_CLASS}','7'),(308,27668,8,'{#ENT_CLASS}','6'),(309,27669,8,'{#ENT_CLASS}','3'),(323,27722,8,'{#IFADMINSTATUS}','(1|3)'),(324,27722,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(325,27732,8,'{#IFOPERSTATUS}','1'),(326,27732,8,'{#SNMPVALUE}','(2|3)'),(327,27745,8,'{#ENT_NAME}','MPU.*'),(328,27746,8,'{#ENT_CLASS}','3'),(329,27756,8,'{#IFADMINSTATUS}','(1|3)'),(330,27756,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(331,27779,8,'{#SENSOR_TYPE}','2'),(332,27780,8,'{#ENT_CLASS}','2'),(333,27788,8,'{#IFADMINSTATUS}','(1|3)'),(334,27788,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(335,27798,8,'{#IFOPERSTATUS}','1'),(336,27798,8,'{#SNMPVALUE}','(2|3)'),(337,27815,8,'{#SNMPVALUE}','Routing Engine.*'),(338,27816,8,'{#SNMPVALUE}','[^0]+'),(350,27872,8,'{#IFADMINSTATUS}','(1|3)'),(351,27872,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(352,27903,8,'{#STORAGE_TYPE}','.+4$'),(353,27903,8,'{#STORAGE_TYPE}','.+hrStorageFixedDisk'),(354,27909,8,'{#IFADMINSTATUS}','(1|3)'),(355,27909,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(356,27944,8,'{#IFADMINSTATUS}','(1|3)'),(357,27944,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(358,27954,8,'{#IFOPERSTATUS}','1'),(359,27954,8,'{#SNMPVALUE}','(2|3)'),(360,27976,8,'{#IFADMINSTATUS}','(1|3)'),(361,27976,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(362,28005,8,'{#IFADMINSTATUS}','(1|3)'),(363,28005,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(368,28058,8,'{#IFADMINSTATUS}','(1|3)'),(369,28058,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(370,28068,8,'{#IFOPERSTATUS}','1'),(371,28068,8,'{#SNMPVALUE}','(2|3)'),(376,28097,8,'{#IFADMINSTATUS}','{$NET.IF.IFADMINSTATUS.MATCHES}'),(377,28097,9,'{#IFADMINSTATUS}','{$NET.IF.IFADMINSTATUS.NOT_MATCHES}'),(378,28118,8,'{#IFADMINSTATUS}','(1|3)'),(379,28118,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(380,28128,8,'{#IFOPERSTATUS}','1'),(381,28128,8,'{#SNMPVALUE}','(2|3)'),(382,28144,8,'{#SENSOR_TYPE}','8'),(383,28144,8,'{#SENSOR_PRECISION}','0'),(384,28146,8,'{#ENT_CLASS}','.+8.3.2$'),(385,28146,8,'{#ENT_STATUS}','(1|2|3|4)'),(386,28147,8,'{#ENT_CLASS}','.+8.3.1$'),(387,28147,8,'{#ENT_STATUS}','(1|2|3|4)'),(388,28148,8,'{#ENT_CLASS}','.+8.3.3$'),(389,28148,8,'{#ENT_STATUS}','(1|2|3|4)'),(390,28149,8,'{#ENT_CLASS}','3'),(395,28175,8,'{#IFADMINSTATUS}','(1|3)'),(396,28175,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(397,28196,8,'{#SENSOR_TYPE}','8'),(398,28196,8,'{#SENSOR_PRECISION}','1'),(399,28197,8,'{#SNMPVALUE}','10'),(400,28198,8,'{#ENT_CLASS}','3'),(401,28199,8,'{#ENT_CLASS}','6'),(402,28207,8,'{#ENT_SN}','.+'),(403,28207,8,'{#ENT_CLASS}','[^3]'),(404,28223,8,'{#IFADMINSTATUS}','(1|3)'),(405,28223,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(406,27088,8,'{#IFNAME}','@Network interfaces for discovery'),(407,27098,8,'{#IFNAME}','@Network interfaces for discovery'),(408,27180,8,'{#IFNAME}','@Network interfaces for discovery'),(409,27215,8,'{#IFNAME}','@Network interfaces for discovery'),(410,27251,8,'{#IFNAME}','@Network interfaces for discovery'),(411,27272,8,'{#IFNAME}','@Network interfaces for discovery'),(412,27321,8,'{#IFNAME}','@Network interfaces for discovery'),(413,27450,8,'{#IFNAME}','@Network interfaces for discovery'),(414,27486,8,'{#IFNAME}','@Network interfaces for discovery'),(415,27520,8,'{#IFNAME}','@Network interfaces for discovery'),(416,27556,8,'{#IFNAME}','@Network interfaces for discovery'),(417,27642,8,'{#IFNAME}','@Network interfaces for discovery'),(418,27722,8,'{#IFNAME}','@Network interfaces for discovery'),(419,27756,8,'{#IFNAME}','@Network interfaces for discovery'),(420,27788,8,'{#IFNAME}','@Network interfaces for discovery'),(421,27872,8,'{#IFNAME}','@Network interfaces for discovery'),(422,27909,8,'{#IFNAME}','@Network interfaces for discovery'),(423,27944,8,'{#IFNAME}','@Network interfaces for discovery'),(424,28058,8,'{#IFNAME}','@Network interfaces for discovery'),(425,28118,8,'{#IFNAME}','@Network interfaces for discovery'),(426,28175,8,'{#IFNAME}','@Network interfaces for discovery'),(427,28223,8,'{#IFNAME}','@Network interfaces for discovery'),(428,27068,8,'{#IFNAME}','@Network interfaces for discovery'),(429,27596,8,'{#IFNAME}','@Network interfaces for discovery'),(430,28005,8,'{#IFNAME}','@Network interfaces for discovery'),(431,27078,8,'{#IFNAME}','@Network interfaces for discovery'),(432,27619,8,'{#IFNAME}','@Network interfaces for discovery'),(433,27976,8,'{#IFNAME}','@Network interfaces for discovery'),(434,27118,8,'{#IFOPERSTATUS}','{$NET.IF.IFOPERSTATUS.MATCHES}'),(435,28097,8,'{#IFOPERSTATUS}','{$NET.IF.IFOPERSTATUS.MATCHES}'),(436,28280,8,'{#IFOPERSTATUS}','1'),(437,28280,8,'{#SNMPVALUE}','(2|3)'),(438,28293,8,'{#IFADMINSTATUS}','(1|3)'),(439,28293,8,'{#IFOPERSTATUS}','(1|2|3|4|5|7)'),(440,28293,8,'{#IFNAME}','@Network interfaces for discovery'),(448,28306,8,'{#SENSOR_TYPE}','8'),(449,28306,8,'{#SENSOR_PRECISION}','1'),(450,28307,8,'{#SNMPVALUE}','10'),(451,28308,8,'{#ENT_CLASS}','3'),(452,28309,8,'{#ENT_CLASS}','6'),(453,28346,8,'{#SENSOR_LOCALE}','.*CPU.*'),(454,28347,8,'{#SENSOR_LOCALE}','.*Inlet Temp.*'),(455,28349,8,'{#TYPE}','3'),(456,28392,8,'{#SENSOR_LOCALE}','(4|8|9|12|13)'),(457,28393,8,'{#SNMPINDEX}','0\\.1'),(458,28393,8,'{#SENSOR_LOCALE}','11'),(459,28394,8,'{#SENSOR_LOCALE}','6'),(460,28395,8,'{#SENSOR_LOCALE}','7'),(461,28396,8,'{#SENSOR_LOCALE}','10'),(462,28397,8,'{#SENSOR_LOCALE}','3'),(463,28440,8,'{#SNMPVALUE}','(DIMM|PSU|PCH|RAID|RR|PCI).*'),(464,28441,8,'{#SNMPVALUE}','Ambient.*'),(465,28442,8,'{#SNMPVALUE}','CPU [0-9]* Temp'),(466,28468,8,'{#SNMPVALUE}','(DIMM|PSU|PCH|RAID|RR|PCI).*'),(467,28469,8,'{#SNMPVALUE}','Ambient.*'),(468,28470,8,'{#SNMPVALUE}','CPU [0-9]* Temp'),(469,28493,8,'{#SNMPVALUE}','[1-9]+'),(470,28493,8,'{#SENSOR_DESCR}','.*Temp.*'),(471,28494,8,'{#SNMPVALUE}','[1-9]+'),(472,28494,8,'{#SENSOR_DESCR}','FAN.*'),(473,28661,8,'{#FSTYPE}','{$VFS.FS.FSTYPE.MATCHES}'),(474,28661,9,'{#FSTYPE}','{$VFS.FS.FSTYPE.NOT_MATCHES}'),(475,28661,8,'{#FSNAME}','{$VFS.FS.FSNAME.MATCHES}'),(476,28661,9,'{#FSNAME}','{$VFS.FS.FSNAME.NOT_MATCHES}'),(477,28662,8,'{#MEMTYPE}','{$MEMORY.TYPE.MATCHES}'),(478,28662,9,'{#MEMTYPE}','{$MEMORY.TYPE.NOT_MATCHES}'),(479,28662,8,'{#MEMNAME}','{$MEMORY.NAME.MATCHES}'),(480,28662,9,'{#MEMNAME}','{$MEMORY.NAME.NOT_MATCHES}'),(481,28663,8,'{#FSTYPE}','{$VFS.FS.FSTYPE.MATCHES}'),(482,28663,9,'{#FSTYPE}','{$VFS.FS.FSTYPE.NOT_MATCHES}'),(483,28663,8,'{#FSNAME}','{$VFS.FS.FSNAME.MATCHES}'),(484,28663,9,'{#FSNAME}','{$VFS.FS.FSNAME.NOT_MATCHES}'),(485,28664,8,'{#MEMTYPE}','{$MEMORY.TYPE.MATCHES}'),(486,28664,9,'{#MEMTYPE}','{$MEMORY.TYPE.NOT_MATCHES}'),(487,28664,8,'{#MEMNAME}','{$MEMORY.NAME.MATCHES}'),(488,28664,9,'{#MEMNAME}','{$MEMORY.NAME.NOT_MATCHES}'),(489,28665,8,'{#FSTYPE}','{$VFS.FS.FSTYPE.MATCHES}'),(490,28665,9,'{#FSTYPE}','{$VFS.FS.FSTYPE.NOT_MATCHES}'),(491,28665,8,'{#FSNAME}','{$VFS.FS.FSNAME.MATCHES}'),(492,28665,9,'{#FSNAME}','{$VFS.FS.FSNAME.NOT_MATCHES}'),(493,28666,8,'{#MEMTYPE}','{$MEMORY.TYPE.MATCHES}'),(494,28666,9,'{#MEMTYPE}','{$MEMORY.TYPE.NOT_MATCHES}'),(495,28666,8,'{#MEMNAME}','{$MEMORY.NAME.MATCHES}'),(496,28666,9,'{#MEMNAME}','{$MEMORY.NAME.NOT_MATCHES}'),(497,28667,8,'{#FSTYPE}','{$VFS.FS.FSTYPE.MATCHES}'),(498,28667,9,'{#FSTYPE}','{$VFS.FS.FSTYPE.NOT_MATCHES}'),(499,28667,8,'{#FSNAME}','{$VFS.FS.FSNAME.MATCHES}'),(500,28667,9,'{#FSNAME}','{$VFS.FS.FSNAME.NOT_MATCHES}'),(501,28668,8,'{#MEMTYPE}','{$MEMORY.TYPE.MATCHES}'),(502,28668,9,'{#MEMTYPE}','{$MEMORY.TYPE.NOT_MATCHES}'),(503,28668,8,'{#MEMNAME}','{$MEMORY.NAME.MATCHES}'),(504,28668,9,'{#MEMNAME}','{$MEMORY.NAME.NOT_MATCHES}'),(505,28669,8,'{#FSTYPE}','{$VFS.FS.FSTYPE.MATCHES}'),(506,28669,9,'{#FSTYPE}','{$VFS.FS.FSTYPE.NOT_MATCHES}'),(507,28669,8,'{#FSNAME}','{$VFS.FS.FSNAME.MATCHES}'),(508,28669,9,'{#FSNAME}','{$VFS.FS.FSNAME.NOT_MATCHES}'),(509,28670,8,'{#MEMTYPE}','{$MEMORY.TYPE.MATCHES}'),(510,28670,9,'{#MEMTYPE}','{$MEMORY.TYPE.NOT_MATCHES}'),(511,28670,8,'{#MEMNAME}','{$MEMORY.NAME.MATCHES}'),(512,28670,9,'{#MEMNAME}','{$MEMORY.NAME.NOT_MATCHES}'),(513,28671,8,'{#FSTYPE}','{$VFS.FS.FSTYPE.MATCHES}'),(514,28671,9,'{#FSTYPE}','{$VFS.FS.FSTYPE.NOT_MATCHES}'),(515,28671,8,'{#FSNAME}','{$VFS.FS.FSNAME.MATCHES}'),(516,28671,9,'{#FSNAME}','{$VFS.FS.FSNAME.NOT_MATCHES}'),(517,28672,8,'{#MEMTYPE}','{$MEMORY.TYPE.MATCHES}'),(518,28672,9,'{#MEMTYPE}','{$MEMORY.TYPE.NOT_MATCHES}'),(519,28672,8,'{#MEMNAME}','{$MEMORY.NAME.MATCHES}'),(520,28672,9,'{#MEMNAME}','{$MEMORY.NAME.NOT_MATCHES}'),(521,27118,9,'{#IFOPERSTATUS}','{$NET.IF.IFOPERSTATUS.NOT_MATCHES}'),(522,27118,8,'{#IFNAME}','{$NET.IF.IFNAME.MATCHES}'),(523,27118,9,'{#IFNAME}','{$NET.IF.IFNAME.NOT_MATCHES}'),(524,27118,8,'{#IFDESCR}','{$NET.IF.IFDESCR.MATCHES}'),(525,27118,9,'{#IFDESCR}','{$NET.IF.IFDESCR.NOT_MATCHES}'),(526,27118,8,'{#IFALIAS}','{$NET.IF.IFALIAS.MATCHES}'),(527,27118,9,'{#IFALIAS}','{$NET.IF.IFALIAS.NOT_MATCHES}'),(528,27118,8,'{#IFTYPE}','{$NET.IF.IFTYPE.MATCHES}'),(529,27118,9,'{#IFTYPE}','{$NET.IF.IFTYPE.NOT_MATCHES}'),(530,28097,9,'{#IFOPERSTATUS}','{$NET.IF.IFOPERSTATUS.NOT_MATCHES}'),(531,28097,8,'{#IFNAME}','{$NET.IF.IFNAME.MATCHES}'),(532,28097,9,'{#IFNAME}','{$NET.IF.IFNAME.NOT_MATCHES}'),(533,28097,8,'{#IFDESCR}','{$NET.IF.IFDESCR.MATCHES}'),(534,28097,9,'{#IFDESCR}','{$NET.IF.IFDESCR.NOT_MATCHES}'),(535,28097,8,'{#IFALIAS}','{$NET.IF.IFALIAS.MATCHES}'),(536,28097,9,'{#IFALIAS}','{$NET.IF.IFALIAS.NOT_MATCHES}'),(537,28097,8,'{#IFTYPE}','{$NET.IF.IFTYPE.MATCHES}'),(538,28097,9,'{#IFTYPE}','{$NET.IF.IFTYPE.NOT_MATCHES}'),(539,28711,8,'{#FSTYPE}','{$VFS.FS.FSTYPE.MATCHES}'),(540,28711,9,'{#FSTYPE}','{$VFS.FS.FSTYPE.NOT_MATCHES}'),(541,28711,8,'{#FSNAME}','{$VFS.FS.FSNAME.MATCHES}'),(542,28711,9,'{#FSNAME}','{$VFS.FS.FSNAME.NOT_MATCHES}'),(543,28712,8,'{#MEMTYPE}','{$MEMORY.TYPE.MATCHES}'),(544,28712,9,'{#MEMTYPE}','{$MEMORY.TYPE.NOT_MATCHES}'),(545,28712,8,'{#MEMNAME}','{$MEMORY.NAME.MATCHES}'),(546,28712,9,'{#MEMNAME}','{$MEMORY.NAME.NOT_MATCHES}'),(547,28713,8,'{#FSTYPE}','{$VFS.FS.FSTYPE.MATCHES}'),(548,28713,9,'{#FSTYPE}','{$VFS.FS.FSTYPE.NOT_MATCHES}'),(549,28713,8,'{#FSNAME}','{$VFS.FS.FSNAME.MATCHES}'),(550,28713,9,'{#FSNAME}','{$VFS.FS.FSNAME.NOT_MATCHES}'),(551,28714,8,'{#MEMTYPE}','{$MEMORY.TYPE.MATCHES}'),(552,28714,9,'{#MEMTYPE}','{$MEMORY.TYPE.NOT_MATCHES}'),(553,28714,8,'{#MEMNAME}','{$MEMORY.NAME.MATCHES}'),(554,28714,9,'{#MEMNAME}','{$MEMORY.NAME.NOT_MATCHES}');
/*!40000 ALTER TABLE `item_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_discovery`
--

DROP TABLE IF EXISTS `item_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_discovery` (
  `itemdiscoveryid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `parent_itemid` bigint(20) unsigned NOT NULL,
  `key_` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemdiscoveryid`),
  UNIQUE KEY `item_discovery_1` (`itemid`,`parent_itemid`),
  KEY `item_discovery_2` (`parent_itemid`),
  CONSTRAINT `c_item_discovery_2` FOREIGN KEY (`parent_itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_item_discovery_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_discovery`
--

LOCK TABLES `item_discovery` WRITE;
/*!40000 ALTER TABLE `item_discovery` DISABLE KEYS */;
INSERT INTO `item_discovery` VALUES (1,22446,22444,'',0,0),(3,22448,22444,'',0,0),(5,22452,22450,'',0,0),(7,22454,22450,'',0,0),(9,22456,22450,'',0,0),(11,22458,22450,'',0,0),(65,22686,22450,'',0,0),(135,22868,22867,'',0,0),(136,22869,22867,'',0,0),(137,22870,22867,'',0,0),(138,22871,22867,'',0,0),(139,22872,22867,'',0,0),(142,22908,22907,'',0,0),(143,22909,22907,'',0,0),(144,22910,22907,'',0,0),(145,22911,22907,'',0,0),(146,22912,22907,'',0,0),(147,22945,22944,'',0,0),(148,22946,22944,'',0,0),(149,22948,22947,'',0,0),(150,22949,22947,'',0,0),(151,22950,22947,'',0,0),(152,22951,22947,'',0,0),(153,22952,22947,'',0,0),(154,22985,22984,'',0,0),(155,22986,22984,'',0,0),(156,22988,22987,'',0,0),(157,22989,22987,'',0,0),(158,22990,22987,'',0,0),(159,22991,22987,'',0,0),(160,22992,22987,'',0,0),(161,23025,23024,'',0,0),(162,23026,23024,'',0,0),(163,23028,23027,'',0,0),(164,23029,23027,'',0,0),(165,23030,23027,'',0,0),(166,23031,23027,'',0,0),(167,23032,23027,'',0,0),(170,23068,23067,'',0,0),(171,23069,23067,'',0,0),(172,23070,23067,'',0,0),(173,23071,23067,'',0,0),(174,23072,23067,'',0,0),(175,23164,23162,'',0,0),(176,23165,23162,'',0,0),(178,23167,23162,'',0,0),(179,23168,23162,'',0,0),(180,23169,23163,'',0,0),(181,23170,23163,'',0,0),(182,23280,23278,'',0,0),(183,23281,23278,'',0,0),(184,23282,23279,'',0,0),(185,23283,23279,'',0,0),(186,23284,23279,'',0,0),(187,23285,23279,'',0,0),(188,23286,23279,'',0,0),(189,23073,23540,'',0,0),(190,23074,23540,'',0,0),(191,23075,23329,'',0,0),(192,23076,23329,'',0,0),(220,23666,23665,'',0,0),(746,26994,26987,'',0,0),(747,26995,26990,'',0,0),(748,26996,26990,'',0,0),(749,26997,26990,'',0,0),(750,26998,26990,'',0,0),(751,26999,26991,'',0,0),(752,27000,26991,'',0,0),(753,27001,26991,'',0,0),(754,27002,26991,'',0,0),(755,27003,26992,'',0,0),(756,27004,26992,'',0,0),(757,27005,26992,'',0,0),(758,27006,26992,'',0,0),(759,27007,26993,'',0,0),(760,27008,26993,'',0,0),(761,27009,26993,'',0,0),(762,27010,26993,'',0,0),(775,27030,27029,'',0,0),(776,27032,27031,'',0,0),(803,27069,27068,'',0,0),(804,27070,27068,'',0,0),(805,27071,27068,'',0,0),(806,27072,27068,'',0,0),(807,27073,27068,'',0,0),(808,27074,27068,'',0,0),(809,27075,27068,'',0,0),(810,27076,27068,'',0,0),(811,27077,27068,'',0,0),(812,27079,27078,'',0,0),(813,27080,27078,'',0,0),(814,27081,27078,'',0,0),(815,27082,27078,'',0,0),(816,27083,27078,'',0,0),(817,27084,27078,'',0,0),(818,27085,27078,'',0,0),(819,27086,27078,'',0,0),(820,27087,27078,'',0,0),(821,27089,27088,'',0,0),(822,27090,27088,'',0,0),(823,27091,27088,'',0,0),(824,27092,27088,'',0,0),(825,27093,27088,'',0,0),(826,27094,27088,'',0,0),(827,27095,27088,'',0,0),(828,27096,27088,'',0,0),(829,27097,27088,'',0,0),(830,27099,27098,'',0,0),(831,27100,27098,'',0,0),(832,27101,27098,'',0,0),(833,27102,27098,'',0,0),(834,27103,27098,'',0,0),(835,27104,27098,'',0,0),(836,27105,27098,'',0,0),(837,27106,27098,'',0,0),(838,27107,27098,'',0,0),(848,27119,27118,'',0,0),(849,27120,27118,'',0,0),(850,27121,27118,'',0,0),(851,27122,27118,'',0,0),(852,27123,27118,'',0,0),(853,27124,27118,'',0,0),(854,27125,27118,'',0,0),(855,27126,27118,'',0,0),(856,27127,27118,'',0,0),(875,27181,27180,'',0,0),(876,27182,27180,'',0,0),(877,27183,27180,'',0,0),(878,27184,27180,'',0,0),(879,27185,27180,'',0,0),(880,27186,27180,'',0,0),(881,27187,27180,'',0,0),(882,27188,27180,'',0,0),(883,27189,27180,'',0,0),(884,27191,27190,'',0,0),(885,27212,27209,'',0,0),(886,27213,27210,'',0,0),(887,27214,27211,'',0,0),(888,27216,27215,'',0,0),(889,27217,27215,'',0,0),(890,27218,27215,'',0,0),(891,27219,27215,'',0,0),(892,27220,27215,'',0,0),(893,27221,27215,'',0,0),(894,27222,27215,'',0,0),(895,27223,27215,'',0,0),(896,27224,27215,'',0,0),(898,27246,27242,'',0,0),(899,27247,27242,'',0,0),(900,27248,27243,'',0,0),(901,27249,27244,'',0,0),(902,27250,27244,'',0,0),(903,27252,27251,'',0,0),(904,27253,27251,'',0,0),(905,27254,27251,'',0,0),(906,27255,27251,'',0,0),(907,27256,27251,'',0,0),(908,27257,27251,'',0,0),(909,27258,27251,'',0,0),(910,27259,27251,'',0,0),(911,27260,27251,'',0,0),(912,27273,27272,'',0,0),(913,27274,27272,'',0,0),(914,27275,27272,'',0,0),(915,27276,27272,'',0,0),(916,27277,27272,'',0,0),(917,27278,27272,'',0,0),(918,27279,27272,'',0,0),(919,27280,27272,'',0,0),(920,27281,27272,'',0,0),(921,27312,27302,'',0,0),(922,27313,27303,'',0,0),(923,27314,27304,'',0,0),(924,27315,27306,'',0,0),(925,27316,27307,'',0,0),(926,27317,27308,'',0,0),(927,27318,27309,'',0,0),(928,27319,27310,'',0,0),(929,27320,27311,'',0,0),(930,27322,27321,'',0,0),(931,27323,27321,'',0,0),(932,27324,27321,'',0,0),(933,27325,27321,'',0,0),(934,27326,27321,'',0,0),(935,27327,27321,'',0,0),(936,27328,27321,'',0,0),(937,27329,27321,'',0,0),(938,27330,27321,'',0,0),(939,27332,27331,'',0,0),(949,27414,27390,'',0,0),(950,27415,27390,'',0,0),(951,27416,27390,'',0,0),(952,27417,27391,'',0,0),(954,27419,27393,'',0,0),(955,27420,27394,'',0,0),(956,27421,27394,'',0,0),(957,27422,27395,'',0,0),(958,27423,27396,'',0,0),(959,27424,27397,'',0,0),(960,27425,27397,'',0,0),(961,27426,27397,'',0,0),(962,27427,27398,'',0,0),(963,27428,27399,'',0,0),(964,27429,27400,'',0,0),(965,27430,27400,'',0,0),(966,27431,27401,'',0,0),(967,27432,27402,'',0,0),(977,27442,27409,'',0,0),(978,27443,27409,'',0,0),(979,27444,27409,'',0,0),(980,27445,27410,'',0,0),(981,27446,27411,'',0,0),(982,27447,27411,'',0,0),(983,27448,27412,'',0,0),(984,27449,27413,'',0,0),(985,27451,27450,'',0,0),(986,27452,27450,'',0,0),(987,27453,27450,'',0,0),(988,27454,27450,'',0,0),(989,27455,27450,'',0,0),(990,27456,27450,'',0,0),(991,27457,27450,'',0,0),(992,27458,27450,'',0,0),(993,27459,27450,'',0,0),(994,27461,27460,'',0,0),(995,27477,27473,'',0,0),(996,27478,27473,'',0,0),(997,27479,27474,'',0,0),(998,27480,27475,'',0,0),(999,27481,27476,'',0,0),(1000,27482,27476,'',0,0),(1001,27483,27476,'',0,0),(1002,27484,27476,'',0,0),(1003,27485,27476,'',0,0),(1004,27487,27486,'',0,0),(1005,27488,27486,'',0,0),(1006,27489,27486,'',0,0),(1007,27490,27486,'',0,0),(1008,27491,27486,'',0,0),(1009,27492,27486,'',0,0),(1010,27493,27486,'',0,0),(1011,27494,27486,'',0,0),(1012,27495,27486,'',0,0),(1013,27516,27512,'',0,0),(1014,27517,27513,'',0,0),(1015,27518,27514,'',0,0),(1016,27519,27515,'',0,0),(1017,27521,27520,'',0,0),(1018,27522,27520,'',0,0),(1019,27523,27520,'',0,0),(1020,27524,27520,'',0,0),(1021,27525,27520,'',0,0),(1022,27526,27520,'',0,0),(1023,27527,27520,'',0,0),(1024,27528,27520,'',0,0),(1025,27529,27520,'',0,0),(1026,27531,27530,'',0,0),(1027,27552,27548,'',0,0),(1028,27553,27549,'',0,0),(1029,27554,27550,'',0,0),(1030,27555,27551,'',0,0),(1031,27557,27556,'',0,0),(1032,27558,27556,'',0,0),(1033,27559,27556,'',0,0),(1034,27560,27556,'',0,0),(1035,27561,27556,'',0,0),(1036,27562,27556,'',0,0),(1037,27563,27556,'',0,0),(1038,27564,27556,'',0,0),(1039,27565,27556,'',0,0),(1040,27567,27566,'',0,0),(1041,27590,27587,'',0,0),(1042,27591,27587,'',0,0),(1043,27592,27587,'',0,0),(1044,27593,27588,'',0,0),(1045,27594,27589,'',0,0),(1046,27595,27589,'',0,0),(1047,27597,27596,'',0,0),(1048,27598,27596,'',0,0),(1049,27599,27596,'',0,0),(1050,27600,27596,'',0,0),(1051,27601,27596,'',0,0),(1052,27602,27596,'',0,0),(1053,27603,27596,'',0,0),(1054,27604,27596,'',0,0),(1055,27605,27596,'',0,0),(1056,27607,27606,'',0,0),(1057,27620,27619,'',0,0),(1058,27621,27619,'',0,0),(1059,27622,27619,'',0,0),(1060,27623,27619,'',0,0),(1061,27624,27619,'',0,0),(1062,27625,27619,'',0,0),(1063,27626,27619,'',0,0),(1064,27627,27619,'',0,0),(1065,27628,27619,'',0,0),(1066,27630,27629,'',0,0),(1067,27643,27642,'',0,0),(1068,27644,27642,'',0,0),(1069,27645,27642,'',0,0),(1070,27646,27642,'',0,0),(1071,27647,27642,'',0,0),(1072,27648,27642,'',0,0),(1073,27649,27642,'',0,0),(1074,27650,27642,'',0,0),(1075,27651,27642,'',0,0),(1076,27653,27652,'',0,0),(1077,27670,27665,'',0,0),(1078,27671,27665,'',0,0),(1079,27672,27666,'',0,0),(1080,27673,27667,'',0,0),(1081,27674,27668,'',0,0),(1082,27675,27669,'',0,0),(1083,27676,27669,'',0,0),(1084,27677,27669,'',0,0),(1085,27678,27669,'',0,0),(1086,27679,27669,'',0,0),(1107,27723,27722,'',0,0),(1108,27724,27722,'',0,0),(1109,27725,27722,'',0,0),(1110,27726,27722,'',0,0),(1111,27727,27722,'',0,0),(1112,27728,27722,'',0,0),(1113,27729,27722,'',0,0),(1114,27730,27722,'',0,0),(1115,27731,27722,'',0,0),(1116,27733,27732,'',0,0),(1117,27748,27745,'',0,0),(1118,27749,27745,'',0,0),(1119,27750,27745,'',0,0),(1120,27751,27745,'',0,0),(1121,27752,27745,'',0,0),(1122,27753,27745,'',0,0),(1123,27754,27746,'',0,0),(1124,27755,27747,'',0,0),(1125,27757,27756,'',0,0),(1126,27758,27756,'',0,0),(1127,27759,27756,'',0,0),(1128,27760,27756,'',0,0),(1129,27761,27756,'',0,0),(1130,27762,27756,'',0,0),(1131,27763,27756,'',0,0),(1132,27764,27756,'',0,0),(1133,27765,27756,'',0,0),(1134,27783,27779,'',0,0),(1135,27784,27779,'',0,0),(1136,27785,27780,'',0,0),(1137,27786,27781,'',0,0),(1138,27787,27782,'',0,0),(1139,27789,27788,'',0,0),(1140,27790,27788,'',0,0),(1141,27791,27788,'',0,0),(1142,27792,27788,'',0,0),(1143,27793,27788,'',0,0),(1144,27794,27788,'',0,0),(1145,27795,27788,'',0,0),(1146,27796,27788,'',0,0),(1147,27797,27788,'',0,0),(1148,27799,27798,'',0,0),(1149,27819,27815,'',0,0),(1151,27821,27816,'',0,0),(1152,27822,27817,'',0,0),(1153,27823,27818,'',0,0),(1183,27873,27872,'',0,0),(1184,27874,27872,'',0,0),(1185,27875,27872,'',0,0),(1186,27876,27872,'',0,0),(1187,27877,27872,'',0,0),(1188,27878,27872,'',0,0),(1189,27879,27872,'',0,0),(1190,27880,27872,'',0,0),(1191,27881,27872,'',0,0),(1192,27904,27901,'',0,0),(1193,27905,27902,'',0,0),(1194,27906,27903,'',0,0),(1195,27907,27903,'',0,0),(1196,27908,27903,'',0,0),(1197,27910,27909,'',0,0),(1198,27911,27909,'',0,0),(1199,27912,27909,'',0,0),(1200,27913,27909,'',0,0),(1201,27914,27909,'',0,0),(1202,27915,27909,'',0,0),(1203,27916,27909,'',0,0),(1204,27917,27909,'',0,0),(1205,27918,27909,'',0,0),(1206,27940,27937,'',0,0),(1207,27941,27937,'',0,0),(1208,27942,27938,'',0,0),(1209,27943,27939,'',0,0),(1210,27945,27944,'',0,0),(1211,27946,27944,'',0,0),(1212,27947,27944,'',0,0),(1213,27948,27944,'',0,0),(1214,27949,27944,'',0,0),(1215,27950,27944,'',0,0),(1216,27951,27944,'',0,0),(1217,27952,27944,'',0,0),(1218,27953,27944,'',0,0),(1219,27955,27954,'',0,0),(1220,27977,27976,'',0,0),(1221,27978,27976,'',0,0),(1222,27979,27976,'',0,0),(1223,27980,27976,'',0,0),(1224,27981,27976,'',0,0),(1225,27982,27976,'',0,0),(1226,27983,27976,'',0,0),(1227,27984,27976,'',0,0),(1228,27985,27976,'',0,0),(1229,28003,28001,'',0,0),(1230,28004,28002,'',0,0),(1231,28006,28005,'',0,0),(1232,28007,28005,'',0,0),(1233,28008,28005,'',0,0),(1234,28009,28005,'',0,0),(1235,28010,28005,'',0,0),(1236,28011,28005,'',0,0),(1237,28012,28005,'',0,0),(1238,28013,28005,'',0,0),(1239,28014,28005,'',0,0),(1253,28059,28058,'',0,0),(1254,28060,28058,'',0,0),(1255,28061,28058,'',0,0),(1256,28062,28058,'',0,0),(1257,28063,28058,'',0,0),(1258,28064,28058,'',0,0),(1259,28065,28058,'',0,0),(1260,28066,28058,'',0,0),(1261,28067,28058,'',0,0),(1262,28069,28068,'',0,0),(1276,28098,28097,'',0,0),(1277,28099,28097,'',0,0),(1278,28100,28097,'',0,0),(1279,28101,28097,'',0,0),(1280,28102,28097,'',0,0),(1281,28103,28097,'',0,0),(1282,28104,28097,'',0,0),(1283,28105,28097,'',0,0),(1284,28106,28097,'',0,0),(1285,28119,28118,'',0,0),(1286,28120,28118,'',0,0),(1287,28121,28118,'',0,0),(1288,28122,28118,'',0,0),(1289,28123,28118,'',0,0),(1290,28124,28118,'',0,0),(1291,28125,28118,'',0,0),(1292,28126,28118,'',0,0),(1293,28127,28118,'',0,0),(1294,28129,28128,'',0,0),(1295,28150,28144,'',0,0),(1296,28151,28145,'',0,0),(1297,28152,28145,'',0,0),(1298,28153,28145,'',0,0),(1299,28154,28146,'',0,0),(1300,28155,28147,'',0,0),(1301,28156,28148,'',0,0),(1302,28157,28149,'',0,0),(1303,28158,28149,'',0,0),(1317,28176,28175,'',0,0),(1318,28177,28175,'',0,0),(1319,28178,28175,'',0,0),(1320,28179,28175,'',0,0),(1321,28180,28175,'',0,0),(1322,28181,28175,'',0,0),(1323,28182,28175,'',0,0),(1324,28183,28175,'',0,0),(1325,28184,28175,'',0,0),(1326,28200,28196,'',0,0),(1327,28201,28196,'',0,0),(1328,28202,28197,'',0,0),(1329,28203,28197,'',0,0),(1330,28204,28198,'',0,0),(1331,28205,28198,'',0,0),(1332,28206,28199,'',0,0),(1333,28208,28207,'',0,0),(1334,28215,28212,'',0,0),(1335,28216,28213,'',0,0),(1336,28217,28214,'',0,0),(1337,28218,28214,'',0,0),(1338,28220,28219,'',0,0),(1339,28221,28219,'',0,0),(1340,28222,28219,'',0,0),(1341,28224,28223,'',0,0),(1342,28225,28223,'',0,0),(1343,28226,28223,'',0,0),(1344,28227,28223,'',0,0),(1345,28228,28223,'',0,0),(1346,28229,28223,'',0,0),(1347,28230,28223,'',0,0),(1348,28231,28223,'',0,0),(1349,28232,28223,'',0,0),(1350,28246,28244,'',0,0),(1351,28247,28245,'',0,0),(1352,28281,28280,'',0,0),(1353,28294,28293,'',0,0),(1354,28295,28293,'',0,0),(1355,28296,28293,'',0,0),(1356,28297,28293,'',0,0),(1357,28298,28293,'',0,0),(1358,28299,28293,'',0,0),(1359,28300,28293,'',0,0),(1360,28301,28293,'',0,0),(1361,28302,28293,'',0,0),(1375,28323,28306,'',0,0),(1376,28324,28306,'',0,0),(1377,28325,28307,'',0,0),(1378,28326,28307,'',0,0),(1379,28327,28308,'',0,0),(1380,28328,28308,'',0,0),(1381,28329,28309,'',0,0),(1382,28354,28346,'',0,0),(1383,28355,28346,'',0,0),(1384,28356,28347,'',0,0),(1385,28357,28347,'',0,0),(1386,28358,28348,'',0,0),(1387,28359,28349,'',0,0),(1388,28360,28349,'',0,0),(1389,28361,28350,'',0,0),(1390,28362,28350,'',0,0),(1391,28363,28350,'',0,0),(1392,28364,28350,'',0,0),(1393,28365,28350,'',0,0),(1394,28366,28350,'',0,0),(1395,28367,28350,'',0,0),(1396,28368,28351,'',0,0),(1397,28369,28351,'',0,0),(1398,28370,28351,'',0,0),(1399,28371,28351,'',0,0),(1400,28372,28351,'',0,0),(1401,28373,28351,'',0,0),(1402,28374,28352,'',0,0),(1403,28375,28352,'',0,0),(1404,28376,28353,'',0,0),(1405,28404,28392,'',0,0),(1406,28405,28392,'',0,0),(1407,28406,28393,'',0,0),(1408,28407,28394,'',0,0),(1409,28408,28395,'',0,0),(1410,28409,28396,'',0,0),(1411,28410,28397,'',0,0),(1412,28411,28398,'',0,0),(1413,28412,28399,'',0,0),(1414,28413,28400,'',0,0),(1415,28414,28400,'',0,0),(1416,28415,28401,'',0,0),(1417,28416,28401,'',0,0),(1418,28417,28402,'',0,0),(1419,28418,28402,'',0,0),(1420,28419,28402,'',0,0),(1421,28420,28402,'',0,0),(1422,28421,28402,'',0,0),(1423,28422,28402,'',0,0),(1424,28423,28403,'',0,0),(1425,28424,28403,'',0,0),(1426,28425,28403,'',0,0),(1427,28446,28440,'',0,0),(1428,28447,28441,'',0,0),(1429,28448,28442,'',0,0),(1430,28449,28443,'',0,0),(1431,28450,28444,'',0,0),(1432,28451,28444,'',0,0),(1433,28452,28445,'',0,0),(1434,28453,28445,'',0,0),(1435,28474,28468,'',0,0),(1436,28475,28469,'',0,0),(1437,28476,28470,'',0,0),(1438,28477,28471,'',0,0),(1439,28478,28472,'',0,0),(1440,28479,28472,'',0,0),(1441,28480,28473,'',0,0),(1442,28481,28473,'',0,0),(1443,28495,28493,'',0,0),(1444,28496,28494,'',0,0),(1445,28609,28608,'',0,0),(1446,28610,28608,'',0,0),(1447,28611,28608,'',0,0),(1448,28612,28608,'',0,0),(1449,28613,27815,'',0,0),(1450,28634,28625,'',0,0),(1451,28635,28625,'',0,0),(1452,28636,28625,'',0,0),(1453,28637,28625,'',0,0),(1454,28638,28626,'',0,0),(1455,28639,28627,'',0,0),(1456,28640,28628,'',0,0),(1457,28641,28628,'',0,0),(1458,28642,28628,'',0,0),(1459,28643,28629,'',0,0),(1460,28644,28630,'',0,0),(1461,28645,28630,'',0,0),(1462,28646,28630,'',0,0),(1463,28647,28630,'',0,0),(1464,28648,28631,'',0,0),(1465,28649,28631,'',0,0),(1466,28650,28631,'',0,0),(1467,28651,28632,'',0,0),(1468,28652,28632,'',0,0),(1469,28653,28633,'',0,0),(1470,28673,28661,'',0,0),(1471,28674,28661,'',0,0),(1472,28675,28661,'',0,0),(1473,28676,28662,'',0,0),(1474,28677,28662,'',0,0),(1475,28678,28662,'',0,0),(1476,28679,28663,'',0,0),(1477,28680,28663,'',0,0),(1478,28681,28663,'',0,0),(1479,28682,28664,'',0,0),(1480,28683,28664,'',0,0),(1481,28684,28664,'',0,0),(1482,28685,28665,'',0,0),(1483,28686,28665,'',0,0),(1484,28687,28665,'',0,0),(1485,28688,28666,'',0,0),(1486,28689,28666,'',0,0),(1487,28690,28666,'',0,0),(1488,28691,28667,'',0,0),(1489,28692,28667,'',0,0),(1490,28693,28667,'',0,0),(1491,28694,28668,'',0,0),(1492,28695,28668,'',0,0),(1493,28696,28668,'',0,0),(1494,28697,28669,'',0,0),(1495,28698,28669,'',0,0),(1496,28699,28669,'',0,0),(1497,28700,28670,'',0,0),(1498,28701,28670,'',0,0),(1499,28702,28670,'',0,0),(1500,28703,28671,'',0,0),(1501,28704,28671,'',0,0),(1502,28705,28671,'',0,0),(1503,28706,28672,'',0,0),(1504,28707,28672,'',0,0),(1505,28708,28672,'',0,0),(1506,28715,28711,'',0,0),(1507,28716,28711,'',0,0),(1508,28717,28711,'',0,0),(1509,28718,28712,'',0,0),(1510,28719,28712,'',0,0),(1511,28720,28712,'',0,0),(1512,28721,28713,'',0,0),(1513,28722,28713,'',0,0),(1514,28723,28713,'',0,0),(1515,28724,28714,'',0,0),(1516,28725,28714,'',0,0),(1517,28726,28714,'',0,0);
/*!40000 ALTER TABLE `item_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_preproc`
--

DROP TABLE IF EXISTS `item_preproc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_preproc` (
  `item_preprocid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `step` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `params` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`item_preprocid`),
  KEY `item_preproc_1` (`itemid`,`step`),
  CONSTRAINT `c_item_preproc_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_preproc`
--

LOCK TABLES `item_preproc` WRITE;
/*!40000 ALTER TABLE `item_preproc` DISABLE KEYS */;
INSERT INTO `item_preproc` VALUES (10848,28501,1,10,''),(10849,28514,1,10,''),(10850,28517,1,10,''),(10851,28519,1,10,''),(10852,28520,1,1,'0.001'),(10853,28521,1,10,''),(10854,28522,1,10,''),(10855,28523,1,10,''),(10856,28524,1,10,''),(10857,28525,1,1,'0.001'),(10858,28526,1,10,''),(10859,28527,1,10,''),(10860,28528,1,10,''),(10861,28529,1,10,''),(10862,28530,1,1,'0.001'),(10863,28531,1,10,''),(10864,26876,1,1,'0.001'),(10865,26881,1,1,'100'),(10866,26884,1,10,''),(10867,26885,1,1,'0.001'),(10868,26886,1,1,'0.001'),(10869,26887,1,10,''),(10870,26888,1,1,'0.001'),(10871,26889,1,10,''),(10872,26890,1,1,'0.001'),(10873,26894,1,1,'0.001'),(10874,26895,1,10,''),(10875,26896,1,10,''),(10876,26897,1,1,'0.001'),(10877,26905,1,1,'0.001'),(10878,26906,1,10,''),(10879,28577,1,12,'$.queue'),(10880,28578,1,12,'$.queue'),(10881,28579,1,12,'$.data.process[\'vmware collector\'].busy.avg'),(10882,28580,1,12,'$.data.wcache.values.uint'),(10883,28580,2,10,''),(10884,28581,1,12,'$.data.wcache.values.text'),(10885,28581,2,10,''),(10886,28582,1,12,'$.data.wcache.values.str'),(10887,28582,2,10,''),(10888,28583,1,12,'$.data.wcache.values[\'not supported\']'),(10889,28583,2,10,''),(10890,28584,1,12,'$.data.wcache.values.log'),(10891,28584,2,10,''),(10892,28585,1,12,'$.data.wcache.values.float'),(10893,28585,2,10,''),(10894,28586,1,12,'$.data.wcache.values.all'),(10895,28586,2,10,''),(10896,28587,1,12,'$.data.wcache.index.pused'),(10897,28588,1,12,'$.data.wcache.history.pused'),(10898,28589,1,12,'$.data.vmware.pused'),(10899,28590,1,12,'$.data.rcache.pused'),(10900,28591,1,12,'$.data.process[\'configuration syncer\'].busy.avg'),(10901,28592,1,12,'$.data.process[\'data sender\'].busy.avg'),(10902,28593,1,12,'$.data.process.trapper.busy.avg'),(10903,28594,1,12,'$.data.process[\'task manager\'].busy.avg'),(10904,28595,1,12,'$.data.process[\'snmp trapper\'].busy.avg'),(10905,28596,1,12,'$.data.process[\'self-monitoring\'].busy.avg'),(10906,28597,1,12,'$.data.process.poller.busy.avg'),(10907,28598,1,12,'$.data.process[\'java poller\'].busy.avg'),(10908,28599,1,12,'$.data.process[\'ipmi poller\'].busy.avg'),(10909,28600,1,12,'$.data.process[\'ipmi manager\'].busy.avg'),(10910,28601,1,12,'$.data.process[\'icmp pinger\'].busy.avg'),(10911,28602,1,12,'$.data.process[\'http poller\'].busy.avg'),(10912,28603,1,12,'$.data.process.housekeeper.busy.avg'),(10913,28604,1,12,'$.data.process[\'history syncer\'].busy.avg'),(10914,28605,1,12,'$.data.process[\'heartbeat sender\'].busy.avg'),(10915,28606,1,12,'$.data.process.discoverer.busy.avg'),(10916,28607,1,12,'$.data.process[\'unreachable poller\'].busy.avg'),(10917,28534,1,12,'$.queue'),(10918,28535,1,12,'$.queue'),(10919,28536,1,12,'$.data.wcache.index.pused'),(10920,28537,1,12,'$.data.rcache.pused'),(10921,28538,1,12,'$.data.vcache.buffer.pused'),(10922,28539,1,12,'$.data.vcache.cache.hits'),(10923,28539,2,10,''),(10924,28540,1,12,'$.data.vcache.cache.misses'),(10925,28540,2,10,''),(10926,28541,1,12,'$.data.vcache.cache.mode'),(10927,28542,1,12,'$.data.vmware.pused'),(10928,28543,1,12,'$.data.wcache.history.pused'),(10929,28544,1,12,'$.data.wcache.values.all'),(10930,28544,2,10,''),(10931,28545,1,12,'$.data.wcache.trend.pused'),(10932,28546,1,12,'$.data.process[\'unreachable poller\'].busy.avg'),(10933,28547,1,12,'$.data.wcache.values.float'),(10934,28547,2,10,''),(10935,28548,1,12,'$.data.wcache.values.log'),(10936,28548,2,10,''),(10937,28549,1,12,'$.data.wcache.values[\'not supported\']'),(10938,28549,2,10,''),(10939,28550,1,12,'$.data.wcache.values.str'),(10940,28550,2,10,''),(10941,28551,1,12,'$.data.wcache.values.text'),(10942,28551,2,10,''),(10943,28552,1,12,'$.data.wcache.values.uint'),(10944,28552,2,10,''),(10945,28553,1,12,'$.data.process[\'vmware collector\'].busy.avg'),(10946,28554,1,12,'$.data.preprocessing_queue'),(10947,28555,1,12,'$.data.process.alerter.busy.avg'),(10948,28556,1,12,'$.data.process[\'ipmi manager\'].busy.avg'),(10949,28557,1,12,'$.data.process[\'alert manager\'].busy.avg'),(10950,28558,1,12,'$.data.process[\'configuration syncer\'].busy.avg'),(10951,28559,1,12,'$.data.process.discoverer.busy.avg'),(10952,28560,1,12,'$.data.process.escalator.busy.avg'),(10953,28561,1,12,'$.data.process[\'history syncer\'].busy.avg'),(10954,28562,1,12,'$.data.process.housekeeper.busy.avg'),(10955,28563,1,12,'$.data.process[\'http poller\'].busy.avg'),(10956,28564,1,12,'$.data.process[\'icmp pinger\'].busy.avg'),(10957,28565,1,12,'$.data.process[\'ipmi poller\'].busy.avg'),(10958,28566,1,12,'$.data.process.timer.busy.avg'),(10959,28567,1,12,'$.data.process[\'java poller\'].busy.avg'),(10960,28568,1,12,'$.data.process.poller.busy.avg'),(10961,28569,1,12,'$.data.process[\'preprocessing manager\'].busy.avg'),(10962,28570,1,12,'$.data.process[\'preprocessing worker\'].busy.avg'),(10963,28571,1,12,'$.data.process[\'proxy poller\'].busy.avg'),(10964,28572,1,12,'$.data.process[\'self-monitoring\'].busy.avg'),(10965,28573,1,12,'$.data.process[\'snmp trapper\'].busy.avg'),(10966,28574,1,12,'$.data.process[\'task manager\'].busy.avg'),(10967,28575,1,12,'$.data.process.trapper.busy.avg'),(10968,10067,1,10,''),(10969,10068,1,10,''),(10970,10069,1,10,''),(10971,10070,1,10,''),(10972,10071,1,10,''),(10973,10072,1,10,''),(10974,23340,1,10,''),(10975,10061,1,10,''),(10976,10062,1,10,''),(10977,10063,1,10,''),(10978,10064,1,10,''),(10979,10065,1,10,''),(10980,10066,1,10,''),(10981,22187,1,10,''),(10982,22196,1,10,''),(10983,22199,1,10,''),(10984,10073,1,10,''),(10985,10074,1,10,''),(10986,10075,1,10,''),(10987,10076,1,10,''),(10988,10077,1,10,''),(10989,10078,1,10,''),(10990,23277,1,10,''),(10991,23625,1,10,''),(10992,23628,1,10,''),(10993,26911,1,10,''),(10994,26912,1,10,''),(10995,26913,1,10,''),(10996,26917,1,10,''),(10997,26918,1,10,''),(10998,26919,1,10,''),(10999,26920,1,10,''),(11000,26921,1,10,''),(11001,26922,1,10,''),(11002,26923,1,10,''),(11003,22920,1,10,''),(11004,22924,1,10,''),(11005,22945,1,10,''),(11006,22945,2,1,'8'),(11007,22946,1,10,''),(11008,22946,2,1,'8'),(11009,22880,1,10,''),(11010,22884,1,10,''),(11011,23073,1,10,''),(11012,23073,2,1,'8'),(11013,23074,1,10,''),(11014,23074,2,1,'8'),(11015,22985,1,10,''),(11016,22985,2,1,'8'),(11017,22986,1,10,''),(11018,22986,2,1,'8'),(11019,22680,1,10,''),(11020,22683,1,10,''),(11021,23294,1,10,''),(11022,23298,1,10,''),(11023,22446,1,10,''),(11024,22446,2,1,'8'),(11025,22448,1,10,''),(11026,22448,2,1,'8'),(11027,23280,1,10,''),(11028,23280,2,1,'8'),(11029,23281,1,10,''),(11030,23281,2,1,'8'),(11031,23077,1,10,''),(11032,23077,2,1,'8'),(11033,23078,1,10,''),(11034,23078,2,1,'8'),(11035,22840,1,10,''),(11036,22844,1,10,''),(11037,23075,1,10,''),(11038,23075,2,1,'8'),(11039,23076,1,10,''),(11040,23076,2,1,'8'),(11041,23000,1,10,''),(11042,23004,1,10,''),(11043,23025,1,10,''),(11044,23025,2,1,'8'),(11045,23026,1,10,''),(11046,23026,2,1,'8'),(11047,23169,1,10,''),(11048,23169,2,1,'8'),(11049,23170,1,10,''),(11050,23170,2,1,'8'),(11051,28252,1,1,'0.01'),(11052,28253,1,1,'0.01'),(11053,28254,1,1,'0.01'),(11054,28435,1,1,'0.01'),(11055,28255,1,1,'0.01'),(11056,28256,1,1,'0.01'),(11057,28257,1,1,'0.01'),(11058,28258,1,1,'0.01'),(11059,28259,1,1,'0.01'),(11060,28260,1,1,'0.01'),(11061,28261,1,1,'0.01'),(11062,28262,1,1,'0.01'),(11063,28263,1,1,'0.01'),(11064,28264,1,1,'0.01'),(11065,28265,1,1,'0.01'),(11066,28266,1,1,'0.01'),(11067,28267,1,1,'0.01'),(11068,28268,1,1,'0.01'),(11069,28269,1,1,'0.01'),(11070,28270,1,1,'0.01'),(11071,28271,1,1,'0.01'),(11072,28272,1,1,'0.01'),(11073,28273,1,1,'0.01'),(11074,28274,1,1,'0.01'),(11075,28275,1,1,'0.01'),(11076,28276,1,1,'0.01'),(11077,28277,1,1,'0.01'),(11078,28278,1,1,'0.01'),(11079,28279,1,1,'0.01'),(11080,28291,1,1,'0.01'),(11081,28339,1,1,'0.01'),(11082,28386,1,1,'0.01'),(11083,28463,1,1,'0.01'),(11084,28491,1,1,'0.01'),(11085,28623,1,1,'0.01'),(11086,28709,1,12,'$..[\'{#CPU.UTIL}\'].avg()'),(11087,28710,1,12,'$..[\'{#CPU.UTIL}\'].avg()'),(11088,28715,1,1,'{#ALLOC_UNITS}'),(11089,28716,1,1,'{#ALLOC_UNITS}'),(11090,28718,1,1,'{#ALLOC_UNITS}'),(11091,28719,1,1,'{#ALLOC_UNITS}'),(11092,28721,1,1,'{#ALLOC_UNITS}'),(11093,28722,1,1,'{#ALLOC_UNITS}'),(11094,28724,1,1,'{#ALLOC_UNITS}'),(11095,28725,1,1,'{#ALLOC_UNITS}'),(11096,28655,1,12,'$..[\'{#CPU.UTIL}\'].avg()'),(11097,28656,1,12,'$..[\'{#CPU.UTIL}\'].avg()'),(11098,28657,1,12,'$..[\'{#CPU.UTIL}\'].avg()'),(11099,28658,1,12,'$..[\'{#CPU.UTIL}\'].avg()'),(11100,28659,1,12,'$..[\'{#CPU.UTIL}\'].avg()'),(11101,28660,1,12,'$..[\'{#CPU.UTIL}\'].avg()'),(11102,28673,1,1,'{#ALLOC_UNITS}'),(11103,28674,1,1,'{#ALLOC_UNITS}'),(11104,28676,1,1,'{#ALLOC_UNITS}'),(11105,28677,1,1,'{#ALLOC_UNITS}'),(11106,28679,1,1,'{#ALLOC_UNITS}'),(11107,28680,1,1,'{#ALLOC_UNITS}'),(11108,28682,1,1,'{#ALLOC_UNITS}'),(11109,28683,1,1,'{#ALLOC_UNITS}'),(11110,28685,1,1,'{#ALLOC_UNITS}'),(11111,28686,1,1,'{#ALLOC_UNITS}'),(11112,28688,1,1,'{#ALLOC_UNITS}'),(11113,28689,1,1,'{#ALLOC_UNITS}'),(11114,28691,1,1,'{#ALLOC_UNITS}'),(11115,28692,1,1,'{#ALLOC_UNITS}'),(11116,28694,1,1,'{#ALLOC_UNITS}'),(11117,28695,1,1,'{#ALLOC_UNITS}'),(11118,28697,1,1,'{#ALLOC_UNITS}'),(11119,28698,1,1,'{#ALLOC_UNITS}'),(11120,28700,1,1,'{#ALLOC_UNITS}'),(11121,28701,1,1,'{#ALLOC_UNITS}'),(11122,28703,1,1,'{#ALLOC_UNITS}'),(11123,28704,1,1,'{#ALLOC_UNITS}'),(11124,28706,1,1,'{#ALLOC_UNITS}'),(11125,28707,1,1,'{#ALLOC_UNITS}'),(11126,27089,1,10,''),(11127,27091,1,1,'1000000'),(11128,27092,1,10,''),(11129,27093,1,10,''),(11130,27094,1,10,''),(11131,27094,2,1,'8'),(11132,27095,1,10,''),(11133,27095,2,1,'8'),(11134,27096,1,10,''),(11135,27099,1,10,''),(11136,27101,1,1,'1000000'),(11137,27102,1,10,''),(11138,27103,1,10,''),(11139,27104,1,10,''),(11140,27104,2,1,'8'),(11141,27105,1,10,''),(11142,27105,2,1,'8'),(11143,27106,1,10,''),(11144,27181,1,10,''),(11145,27182,1,10,''),(11146,27183,1,10,''),(11147,27183,2,1,'8'),(11148,27184,1,10,''),(11149,27185,1,10,''),(11150,27186,1,10,''),(11151,27186,2,1,'8'),(11152,27187,1,1,'1000000'),(11153,27216,1,10,''),(11154,27217,1,10,''),(11155,27218,1,10,''),(11156,27218,2,1,'8'),(11157,27219,1,10,''),(11158,27220,1,10,''),(11159,27221,1,10,''),(11160,27221,2,1,'8'),(11161,27222,1,1,'1000000'),(11162,27252,1,10,''),(11163,27253,1,10,''),(11164,27254,1,10,''),(11165,27254,2,1,'8'),(11166,27255,1,10,''),(11167,27256,1,10,''),(11168,27257,1,10,''),(11169,27257,2,1,'8'),(11170,27258,1,1,'1000000'),(11171,27273,1,10,''),(11172,27274,1,10,''),(11173,27275,1,10,''),(11174,27275,2,1,'8'),(11175,27276,1,10,''),(11176,27277,1,10,''),(11177,27278,1,10,''),(11178,27278,2,1,'8'),(11179,27279,1,1,'1000000'),(11180,27322,1,10,''),(11181,27323,1,10,''),(11182,27324,1,10,''),(11183,27324,2,1,'8'),(11184,27325,1,10,''),(11185,27326,1,10,''),(11186,27327,1,10,''),(11187,27327,2,1,'8'),(11188,27328,1,1,'1000000'),(11189,27451,1,10,''),(11190,27452,1,10,''),(11191,27453,1,10,''),(11192,27453,2,1,'8'),(11193,27454,1,10,''),(11194,27455,1,10,''),(11195,27456,1,10,''),(11196,27456,2,1,'8'),(11197,27457,1,1,'1000000'),(11198,27487,1,10,''),(11199,27488,1,10,''),(11200,27489,1,10,''),(11201,27489,2,1,'8'),(11202,27490,1,10,''),(11203,27491,1,10,''),(11204,27492,1,10,''),(11205,27492,2,1,'8'),(11206,27493,1,1,'1000000'),(11207,27521,1,10,''),(11208,27522,1,10,''),(11209,27523,1,10,''),(11210,27523,2,1,'8'),(11211,27524,1,10,''),(11212,27525,1,10,''),(11213,27526,1,10,''),(11214,27526,2,1,'8'),(11215,27527,1,1,'1000000'),(11216,27557,1,10,''),(11217,27558,1,10,''),(11218,27559,1,10,''),(11219,27559,2,1,'8'),(11220,27560,1,10,''),(11221,27561,1,10,''),(11222,27562,1,10,''),(11223,27562,2,1,'8'),(11224,27563,1,1,'1000000'),(11225,27643,1,10,''),(11226,27644,1,10,''),(11227,27645,1,10,''),(11228,27645,2,1,'8'),(11229,27646,1,10,''),(11230,27647,1,10,''),(11231,27648,1,10,''),(11232,27648,2,1,'8'),(11233,27649,1,1,'1000000'),(11234,27723,1,10,''),(11235,27724,1,10,''),(11236,27725,1,10,''),(11237,27725,2,1,'8'),(11238,27726,1,10,''),(11239,27727,1,10,''),(11240,27728,1,10,''),(11241,27728,2,1,'8'),(11242,27729,1,1,'1000000'),(11243,27757,1,10,''),(11244,27758,1,10,''),(11245,27759,1,10,''),(11246,27759,2,1,'8'),(11247,27760,1,10,''),(11248,27761,1,10,''),(11249,27762,1,10,''),(11250,27762,2,1,'8'),(11251,27763,1,1,'1000000'),(11252,27789,1,10,''),(11253,27790,1,10,''),(11254,27791,1,10,''),(11255,27791,2,1,'8'),(11256,27792,1,10,''),(11257,27793,1,10,''),(11258,27794,1,10,''),(11259,27794,2,1,'8'),(11260,27795,1,1,'1000000'),(11261,27873,1,10,''),(11262,27874,1,10,''),(11263,27875,1,10,''),(11264,27875,2,1,'8'),(11265,27876,1,10,''),(11266,27877,1,10,''),(11267,27878,1,10,''),(11268,27878,2,1,'8'),(11269,27879,1,1,'1000000'),(11270,27910,1,10,''),(11271,27911,1,10,''),(11272,27912,1,10,''),(11273,27912,2,1,'8'),(11274,27913,1,10,''),(11275,27914,1,10,''),(11276,27915,1,10,''),(11277,27915,2,1,'8'),(11278,27916,1,1,'1000000'),(11279,27945,1,10,''),(11280,27946,1,10,''),(11281,27947,1,10,''),(11282,27947,2,1,'8'),(11283,27948,1,10,''),(11284,27949,1,10,''),(11285,27950,1,10,''),(11286,27950,2,1,'8'),(11287,27951,1,1,'1000000'),(11288,28059,1,10,''),(11289,28060,1,10,''),(11290,28061,1,10,''),(11291,28061,2,1,'8'),(11292,28062,1,10,''),(11293,28063,1,10,''),(11294,28064,1,10,''),(11295,28064,2,1,'8'),(11296,28065,1,1,'1000000'),(11297,28119,1,10,''),(11298,28120,1,10,''),(11299,28121,1,10,''),(11300,28121,2,1,'8'),(11301,28122,1,10,''),(11302,28123,1,10,''),(11303,28124,1,10,''),(11304,28124,2,1,'8'),(11305,28125,1,1,'1000000'),(11306,28176,1,10,''),(11307,28177,1,10,''),(11308,28178,1,10,''),(11309,28178,2,1,'8'),(11310,28179,1,10,''),(11311,28180,1,10,''),(11312,28181,1,10,''),(11313,28181,2,1,'8'),(11314,28182,1,1,'1000000'),(11315,28224,1,10,''),(11316,28225,1,10,''),(11317,28226,1,10,''),(11318,28226,2,1,'8'),(11319,28227,1,10,''),(11320,28228,1,10,''),(11321,28229,1,10,''),(11322,28229,2,1,'8'),(11323,28230,1,1,'1000000'),(11324,28294,1,10,''),(11325,28295,1,10,''),(11326,28296,1,10,''),(11327,28296,2,1,'8'),(11328,28297,1,10,''),(11329,28298,1,10,''),(11330,28299,1,10,''),(11331,28299,2,1,'8'),(11332,28300,1,1,'1000000'),(11333,27069,1,10,''),(11334,27072,1,10,''),(11335,27073,1,10,''),(11336,27074,1,10,''),(11337,27074,2,1,'8'),(11338,27075,1,10,''),(11339,27075,2,1,'8'),(11340,27076,1,10,''),(11341,27597,1,10,''),(11342,27598,1,10,''),(11343,27599,1,10,''),(11344,27599,2,1,'8'),(11345,27600,1,10,''),(11346,27601,1,10,''),(11347,27602,1,10,''),(11348,27602,2,1,'8'),(11349,28006,1,10,''),(11350,28007,1,10,''),(11351,28008,1,10,''),(11352,28008,2,1,'8'),(11353,28009,1,10,''),(11354,28010,1,10,''),(11355,28011,1,10,''),(11356,28011,2,1,'8'),(11357,27079,1,10,''),(11358,27082,1,10,''),(11359,27083,1,10,''),(11360,27084,1,10,''),(11361,27084,2,1,'8'),(11362,27085,1,10,''),(11363,27085,2,1,'8'),(11364,27086,1,10,''),(11365,27620,1,10,''),(11366,27621,1,10,''),(11367,27622,1,10,''),(11368,27622,2,1,'8'),(11369,27623,1,10,''),(11370,27624,1,10,''),(11371,27625,1,10,''),(11372,27625,2,1,'8'),(11373,27977,1,10,''),(11374,27978,1,10,''),(11375,27979,1,10,''),(11376,27979,2,1,'8'),(11377,27980,1,10,''),(11378,27981,1,10,''),(11379,27982,1,10,''),(11380,27982,2,1,'8'),(11381,27119,1,10,''),(11382,27121,1,1,'1000000'),(11383,27122,1,10,''),(11384,27123,1,10,''),(11385,27124,1,10,''),(11386,27124,2,1,'8'),(11387,27125,1,10,''),(11388,27125,2,1,'8'),(11389,27126,1,10,''),(11390,28098,1,10,''),(11391,28099,1,10,''),(11392,28100,1,10,''),(11393,28100,2,1,'8'),(11394,28101,1,10,''),(11395,28102,1,10,''),(11396,28103,1,10,''),(11397,28103,2,1,'8'),(11398,28104,1,1,'1000000'),(11399,27203,1,5,'^(\\w|-|\\.|/)+ (\\w|-|\\.|/)+ (.+) Copyright\n\\3'),(11400,27204,1,5,'^((\\w|-|\\.|/)+)\n\\1'),(11401,27206,1,1,'1024'),(11402,27207,1,1,'1024'),(11403,28323,1,1,'0.1'),(11404,27314,1,1,'0.5'),(11405,27315,1,1,'0.5'),(11406,27318,1,1,'0.5'),(11407,27377,1,5,'Version (.+), RELEASE\n\\1'),(11408,27381,1,5,'Version (.+), RELEASE\n\\1'),(11409,27384,1,5,'Version (.+), RELEASE\n\\1'),(11410,28211,1,5,'Version (.+), RELEASE\n\\1'),(11411,27591,1,1,'1024'),(11412,27592,1,1,'1024'),(11413,27777,1,5,'Firmware Version: ([0-9.]+),\n\\1'),(11414,27778,1,5,'(.+) - Firmware\n\\1'),(11415,27811,1,5,'kernel (JUNOS [0-9a-zA-Z\\.\\-]+)\n\\1'),(11416,28201,1,1,'0.1'),(11417,27897,1,1,'0.1'),(11418,27898,1,1,'1024'),(11419,27900,1,1,'1024'),(11420,27905,1,1,'0.1'),(11421,27907,1,1,'1024'),(11422,27908,1,1,'1024'),(11423,27936,1,5,'60 Secs \\( ([0-9\\.]+)%\\).+300 Secs\n\\1'),(11424,28029,1,1,'1024'),(11425,28030,1,1,'1024'),(11426,28647,1,1,'1048576'),(11427,28650,1,1,'1048576'),(11428,28354,1,1,'0.1'),(11429,28356,1,1,'0.1'),(11430,28367,1,1,'1048576'),(11431,28372,1,1,'1048576'),(11432,28422,1,1,'1048576'),(11433,28425,1,1,'1048576'),(11434,28451,1,5,'(\\d{1,3}) *%( of maximum)?\n\\1'),(11435,28479,1,5,'(\\d{1,3}) *%( of maximum)?\n\\1');
/*!40000 ALTER TABLE `item_preproc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `snmp_community` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmp_oid` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `key_` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `delay` varchar(1024) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `history` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '90d',
  `trends` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '365d',
  `status` int(11) NOT NULL DEFAULT '0',
  `value_type` int(11) NOT NULL DEFAULT '0',
  `trapper_hosts` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `units` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmpv3_securityname` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmpv3_securitylevel` int(11) NOT NULL DEFAULT '0',
  `snmpv3_authpassphrase` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmpv3_privpassphrase` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `formula` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `lastlogsize` bigint(20) unsigned NOT NULL DEFAULT '0',
  `logtimefmt` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `valuemapid` bigint(20) unsigned DEFAULT NULL,
  `params` text COLLATE utf8_bin NOT NULL,
  `ipmi_sensor` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `authtype` int(11) NOT NULL DEFAULT '0',
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `password` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `publickey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `privatekey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  `interfaceid` bigint(20) unsigned DEFAULT NULL,
  `port` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` text COLLATE utf8_bin NOT NULL,
  `inventory_link` int(11) NOT NULL DEFAULT '0',
  `lifetime` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '30d',
  `snmpv3_authprotocol` int(11) NOT NULL DEFAULT '0',
  `snmpv3_privprotocol` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `snmpv3_contextname` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `evaltype` int(11) NOT NULL DEFAULT '0',
  `jmx_endpoint` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_itemid` bigint(20) unsigned DEFAULT NULL,
  `timeout` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '3s',
  `url` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `query_fields` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `posts` text COLLATE utf8_bin NOT NULL,
  `status_codes` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '200',
  `follow_redirects` int(11) NOT NULL DEFAULT '1',
  `post_type` int(11) NOT NULL DEFAULT '0',
  `http_proxy` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `headers` text COLLATE utf8_bin NOT NULL,
  `retrieve_mode` int(11) NOT NULL DEFAULT '0',
  `request_method` int(11) NOT NULL DEFAULT '0',
  `output_format` int(11) NOT NULL DEFAULT '0',
  `ssl_cert_file` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ssl_key_file` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ssl_key_password` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `verify_peer` int(11) NOT NULL DEFAULT '0',
  `verify_host` int(11) NOT NULL DEFAULT '0',
  `allow_traps` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemid`),
  UNIQUE KEY `items_1` (`hostid`,`key_`),
  KEY `items_3` (`status`),
  KEY `items_4` (`templateid`),
  KEY `items_5` (`valuemapid`),
  KEY `items_6` (`interfaceid`),
  KEY `items_7` (`master_itemid`),
  CONSTRAINT `c_items_5` FOREIGN KEY (`master_itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_items_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_items_2` FOREIGN KEY (`templateid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_items_3` FOREIGN KEY (`valuemapid`) REFERENCES `valuemaps` (`valuemapid`),
  CONSTRAINT `c_items_4` FOREIGN KEY (`interfaceid`) REFERENCES `interface` (`interfaceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_applications`
--

DROP TABLE IF EXISTS `items_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items_applications` (
  `itemappid` bigint(20) unsigned NOT NULL,
  `applicationid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`itemappid`),
  UNIQUE KEY `items_applications_1` (`applicationid`,`itemid`),
  KEY `items_applications_2` (`itemid`),
  CONSTRAINT `c_items_applications_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_items_applications_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_applications`
--

LOCK TABLES `items_applications` WRITE;
/*!40000 ALTER TABLE `items_applications` DISABLE KEYS */;
INSERT INTO `items_applications` VALUES (39097,1,10016),(39101,1,10025),(39104,1,10055),(39105,1,10056),(39107,1,10057),(39109,1,10058),(39111,1,17318),(39114,1,17352),(39198,5,22452),(39199,5,22454),(39200,5,22456),(39201,5,22458),(39202,5,22686),(39196,7,22446),(39197,7,22448),(39092,9,10009),(39095,9,10013),(39093,13,10010),(39115,13,17354),(39117,13,17356),(39119,13,17358),(39121,13,17360),(39123,13,17362),(39126,13,22665),(39128,13,22668),(39130,13,22671),(39132,13,22674),(39134,13,22677),(39136,13,22680),(39138,13,22683),(39140,13,28497),(39142,13,28499),(39096,15,10014),(39102,15,10026),(39103,15,10030),(39112,15,17350),(39125,15,22181),(39094,17,10010),(39116,17,17354),(39118,17,17356),(39120,17,17358),(39122,17,17360),(39124,17,17362),(39127,17,22665),(39129,17,22668),(39131,17,22671),(39133,17,22674),(39135,17,22677),(39137,17,22680),(39139,17,22683),(39141,17,28497),(39143,17,28499),(39100,21,10025),(39106,21,10057),(39108,21,10058),(39110,21,17318),(39113,21,17352),(39098,23,10016),(39099,23,10019),(38837,179,10061),(38838,179,10062),(38839,179,10063),(38840,179,10064),(38841,179,10065),(38842,179,10066),(38843,179,22183),(38844,179,22185),(38845,179,22187),(38846,179,22189),(38847,179,22191),(38848,179,22196),(38849,179,22199),(38850,179,22219),(38851,179,22396),(38852,179,22399),(38853,179,22400),(38854,179,22401),(38855,179,22402),(38856,179,22404),(38857,179,22406),(38858,179,22408),(38859,179,22412),(38860,179,22414),(38861,179,22416),(38862,179,22418),(38863,179,22420),(38864,179,22422),(38865,179,22424),(38866,179,22426),(38867,179,22430),(38868,179,22689),(38869,179,23171),(38870,179,23251),(38871,179,23634),(38872,179,23661),(38873,179,23663),(38874,179,25366),(38875,179,25370),(38876,179,25665),(38877,179,25666),(38878,179,28248),(38776,206,22231),(38777,206,22232),(38778,206,23318),(38779,207,10020),(38780,207,10059),(38795,207,23319),(38781,252,22833),(38782,252,22834),(38796,252,23320),(39246,253,22840),(39248,253,22841),(39250,253,22842),(39252,253,22843),(39254,253,22844),(39256,253,22845),(39258,253,22846),(39260,253,22848),(39262,253,22851),(39264,253,22852),(39282,254,22868),(39283,254,22869),(39284,254,22870),(39285,254,22871),(39286,254,22872),(39244,255,22839),(39266,255,22853),(39268,255,22854),(39273,255,22858),(39275,255,22859),(39270,256,22855),(39271,256,22856),(39272,256,22857),(39280,256,22862),(39281,256,22863),(39287,257,23075),(39288,257,23076),(39240,258,22835),(39241,258,22836),(39245,258,22839),(39267,258,22853),(39269,258,22854),(39274,258,22858),(39276,258,22859),(39277,258,22860),(39247,259,22840),(39249,259,22841),(39251,259,22842),(39253,259,22843),(39255,259,22844),(39257,259,22845),(39259,259,22846),(39261,259,22848),(39263,259,22851),(39265,259,22852),(39242,260,22837),(39243,260,22838),(39278,261,22860),(39279,261,22861),(38783,262,22873),(38784,262,22874),(38797,262,23321),(39017,263,22880),(39019,263,22881),(39021,263,22882),(39023,263,22883),(39025,263,22884),(39027,263,22885),(39029,263,22886),(39031,263,22888),(39033,263,22891),(39035,263,22892),(39053,264,22908),(39054,264,22909),(39055,264,22910),(39056,264,22911),(39057,264,22912),(39015,265,22879),(39037,265,22893),(39039,265,22894),(39044,265,22898),(39046,265,22899),(39041,266,22895),(39042,266,22896),(39043,266,22897),(39051,266,22902),(39052,266,22903),(39058,267,23073),(39059,267,23074),(39011,268,22875),(39012,268,22876),(39016,268,22879),(39038,268,22893),(39040,268,22894),(39045,268,22898),(39047,268,22899),(39048,268,22900),(39018,269,22880),(39020,269,22881),(39022,269,22882),(39024,269,22883),(39026,269,22884),(39028,269,22885),(39030,269,22886),(39032,269,22888),(39034,269,22891),(39036,269,22892),(39013,270,22877),(39014,270,22878),(39049,271,22900),(39050,271,22901),(38785,272,22913),(38786,272,22914),(38798,272,23322),(38937,273,22920),(38939,273,22921),(38941,273,22922),(38943,273,22923),(38945,273,22924),(38960,273,23108),(38963,273,23109),(38966,273,23110),(38968,273,23111),(38971,273,23112),(38974,273,23113),(38976,273,23114),(38978,273,23115),(38984,273,23118),(38986,273,23119),(38988,273,23120),(38990,273,23121),(38994,273,23123),(39006,274,22948),(39007,274,22949),(39008,274,22950),(39009,274,22951),(39010,274,22952),(38980,274,23116),(38982,274,23117),(38947,275,22933),(38949,275,22934),(38951,275,22938),(38953,275,22939),(38958,276,22942),(38959,276,22943),(38992,276,23122),(38996,276,23124),(38997,276,23125),(38998,276,23126),(38999,276,23127),(39000,276,23128),(39001,276,23129),(39002,276,23130),(39003,276,23131),(39004,277,22945),(39005,277,22946),(38948,278,22933),(38950,278,22934),(38952,278,22938),(38954,278,22939),(38955,278,22940),(38938,279,22920),(38940,279,22921),(38942,279,22922),(38944,279,22923),(38946,279,22924),(38962,279,23108),(38965,279,23109),(38967,279,23110),(38970,279,23111),(38973,279,23112),(38975,279,23113),(38977,279,23114),(38979,279,23115),(38981,279,23116),(38983,279,23117),(38987,279,23119),(38989,279,23120),(38991,279,23121),(38993,279,23122),(38995,279,23123),(38935,280,22917),(38936,280,22918),(38956,281,22940),(38957,281,22941),(38787,282,22953),(38788,282,22954),(38799,282,23323),(39060,283,22961),(39062,283,22962),(39064,283,22963),(39066,283,22965),(39068,283,22968),(39070,283,22971),(39072,283,22972),(39087,284,22988),(39088,284,22989),(39089,284,22990),(39090,284,22991),(39091,284,22992),(39074,285,22973),(39076,285,22974),(39078,285,22978),(39083,286,22982),(39084,286,22983),(39085,287,22985),(39086,287,22986),(39075,288,22973),(39077,288,22974),(39079,288,22978),(39080,288,22980),(39061,289,22961),(39063,289,22962),(39065,289,22963),(39067,289,22965),(39069,289,22968),(39071,289,22971),(39073,289,22972),(39081,291,22980),(39082,291,22981),(38789,292,22993),(38790,292,22994),(38800,292,23324),(39294,293,23000),(39296,293,23001),(39298,293,23002),(39300,293,23003),(39302,293,23004),(39304,293,23005),(39306,293,23007),(39308,293,23011),(39310,293,23012),(39330,294,23028),(39331,294,23029),(39332,294,23030),(39333,294,23031),(39334,294,23032),(39292,295,22999),(39312,295,23013),(39314,295,23014),(39319,295,23018),(39321,295,23019),(39316,296,23015),(39317,296,23016),(39318,296,23017),(39326,296,23022),(39327,296,23023),(39328,297,23025),(39329,297,23026),(39289,298,22996),(39293,298,22999),(39313,298,23013),(39315,298,23014),(39320,298,23018),(39322,298,23019),(39323,298,23020),(39295,299,23000),(39297,299,23001),(39299,299,23002),(39301,299,23003),(39303,299,23004),(39305,299,23005),(39307,299,23007),(39309,299,23011),(39311,299,23012),(39290,300,22997),(39291,300,22998),(39324,301,23020),(39325,301,23021),(38791,302,23033),(38792,302,23034),(38801,302,23325),(39214,303,23041),(39216,303,23042),(39218,303,23043),(39235,304,23068),(39236,304,23069),(39237,304,23070),(39238,304,23071),(39239,304,23072),(39212,305,23039),(39220,305,23053),(39222,305,23054),(39224,305,23058),(39226,305,23059),(39231,306,23062),(39232,306,23063),(39233,307,23077),(39234,307,23078),(39210,308,23035),(39211,308,23036),(39213,308,23039),(39221,308,23053),(39223,308,23054),(39225,308,23058),(39227,308,23059),(39228,308,23060),(39215,309,23041),(39217,309,23042),(39219,309,23043),(39229,311,23060),(39230,311,23061),(39353,319,23149),(39355,319,23150),(39336,320,23134),(39338,320,23135),(39340,320,23136),(39342,320,23137),(39346,320,23143),(39348,320,23144),(39350,320,23145),(39365,321,23666),(39335,322,23134),(39337,322,23135),(39339,322,23136),(39341,322,23137),(39359,322,23164),(39360,322,23165),(39361,322,23167),(39362,322,23168),(39343,323,23138),(39354,323,23149),(39344,324,23140),(39345,325,23143),(39347,325,23144),(39349,325,23145),(39351,328,23147),(39352,328,23148),(39356,328,23158),(39357,328,23159),(39358,328,23668),(38793,329,23160),(38794,329,23161),(38802,329,23326),(39363,330,23169),(39364,330,23170),(38961,331,23108),(38964,331,23109),(38969,331,23111),(38972,331,23112),(38985,331,23118),(38879,345,10073),(38880,345,10074),(38881,345,10075),(38882,345,10076),(38883,345,10077),(38884,345,10078),(38885,345,23252),(38886,345,23253),(38887,345,23255),(38888,345,23256),(38889,345,23257),(38890,345,23258),(38891,345,23259),(38892,345,23260),(38893,345,23261),(38894,345,23262),(38895,345,23264),(38896,345,23265),(38897,345,23266),(38898,345,23267),(38899,345,23268),(38900,345,23269),(38901,345,23270),(38902,345,23271),(38903,345,23272),(38904,345,23273),(38905,345,23274),(38906,345,23275),(38907,345,23276),(38908,345,23277),(38909,345,23328),(38910,345,23620),(38911,345,23625),(38912,345,23628),(38913,345,23635),(38914,345,23662),(38915,345,23664),(38916,345,25367),(38917,345,25371),(38918,345,25667),(38919,345,25668),(38920,345,28249),(39150,346,23294),(39152,346,23295),(39154,346,23296),(39156,346,23297),(39158,346,23298),(39160,346,23299),(39162,346,23300),(39164,346,23301),(39166,346,23302),(39168,346,23303),(39170,346,23304),(39172,346,23305),(39174,346,23306),(39192,346,28498),(39194,346,28500),(39205,347,23282),(39206,347,23283),(39207,347,23284),(39208,347,23285),(39209,347,23286),(39148,348,23293),(39176,348,23307),(39178,348,23308),(39183,348,23312),(39185,348,23313),(39180,349,23309),(39181,349,23310),(39182,349,23311),(39190,349,23316),(39191,349,23317),(39203,350,23280),(39204,350,23281),(39144,351,23289),(39145,351,23290),(39149,351,23293),(39177,351,23307),(39179,351,23308),(39184,351,23312),(39186,351,23313),(39187,351,23314),(39151,352,23294),(39153,352,23295),(39155,352,23296),(39157,352,23297),(39159,352,23298),(39161,352,23299),(39163,352,23300),(39165,352,23301),(39167,352,23302),(39169,352,23303),(39171,352,23304),(39173,352,23305),(39175,352,23306),(39193,352,28498),(39195,352,28500),(39146,353,23291),(39147,353,23292),(39188,354,23314),(39189,354,23315),(38803,355,23287),(38804,355,23288),(38805,355,23327),(38806,356,10067),(38807,356,10068),(38808,356,10069),(38809,356,10070),(38810,356,10071),(38811,356,10072),(38812,356,23340),(38813,356,23341),(38814,356,23342),(38815,356,23343),(38816,356,23344),(38817,356,23345),(38818,356,23346),(38819,356,23347),(38820,356,23348),(38821,356,23349),(38822,356,23350),(38823,356,23351),(38824,356,23352),(38825,356,23353),(38826,356,23354),(38827,356,23355),(38828,356,23356),(38829,356,23357),(38830,356,23358),(38831,356,23359),(38832,356,23360),(38833,356,25368),(38834,356,25369),(38835,356,28250),(38836,356,28251),(38635,446,23644),(38691,447,23645),(38692,448,23646),(38693,449,23647),(38694,450,23648),(38695,451,23649),(38696,452,23650),(38697,453,23651),(38773,454,23652),(38774,455,23653),(38775,456,23654),(38671,732,26891),(38672,732,26892),(38690,732,26910),(38673,733,26893),(38674,733,26894),(38664,734,26884),(38665,734,26885),(38666,734,26886),(38667,734,26887),(38668,734,26888),(38669,734,26889),(38670,734,26890),(38675,734,26895),(38676,734,26896),(38677,734,26897),(38685,734,26905),(38686,734,26906),(38678,735,26898),(38679,735,26899),(38683,735,26903),(38684,735,26904),(38687,735,26907),(38688,735,26908),(38689,735,26909),(38636,736,26856),(38637,736,26857),(38638,736,26858),(38639,736,26859),(38640,736,26860),(38641,736,26861),(38642,736,26862),(38643,736,26863),(38644,736,26864),(38645,736,26865),(38646,736,26866),(38647,736,26867),(38648,736,26868),(38649,736,26869),(38657,736,26877),(38658,736,26878),(38662,736,26882),(38663,736,26883),(38680,736,26900),(38681,736,26901),(38682,736,26902),(38659,737,26879),(38660,737,26880),(38661,737,26881),(38651,738,26871),(38655,738,26875),(38656,738,26876),(38650,739,26870),(38652,739,26872),(38653,739,26873),(38654,739,26874),(38921,740,26911),(38922,740,26912),(38923,740,26913),(38924,740,26914),(38925,740,26915),(38926,740,26916),(38927,740,26917),(38928,740,26918),(38929,740,26919),(38930,740,26920),(38931,740,26921),(38932,740,26922),(38933,740,26923),(38934,740,26924),(39368,741,26927),(39369,742,26928),(39366,743,26925),(39367,743,26926),(39370,743,26929),(39371,743,26930),(39372,743,26931),(39373,743,26932),(39376,744,26935),(39377,744,26936),(39374,745,26933),(39384,745,26943),(39375,746,26934),(39378,746,26937),(39379,746,26938),(39380,746,26939),(39381,746,26940),(39382,746,26941),(39383,746,26942),(39433,747,26994),(39385,748,26944),(39386,748,26945),(39387,749,26946),(39398,750,26957),(39399,750,26958),(39400,750,26959),(39438,751,26999),(39439,751,27000),(39440,751,27001),(39441,751,27002),(39442,752,27003),(39443,752,27004),(39444,752,27005),(39445,752,27006),(39391,753,26950),(39393,753,26952),(39401,753,26960),(39402,753,26961),(39406,753,26965),(39434,754,26995),(39435,754,26996),(39436,754,26997),(39437,754,26998),(39388,755,26947),(39389,755,26948),(39390,755,26949),(39396,755,26955),(39397,755,26956),(39403,755,26962),(39404,755,26963),(39405,755,26964),(39392,757,26951),(39394,757,26953),(39395,757,26954),(39418,758,26977),(39422,758,26980),(39423,758,26981),(39425,758,26982),(39430,758,26985),(39446,759,27007),(39447,759,27008),(39448,759,27009),(39449,759,27010),(39411,760,26970),(39412,760,26971),(39413,760,26972),(39414,760,26973),(39415,760,26974),(39420,760,26978),(39421,760,26979),(39432,760,26986),(39416,761,26975),(39417,761,26976),(39419,761,26977),(39424,761,26981),(39426,761,26982),(39427,761,26983),(39428,761,26984),(39431,761,26985),(39409,762,26968),(39410,762,26969),(39429,762,26984),(39407,763,26966),(39408,763,26967),(39562,770,27030),(39564,771,27032),(39454,780,27065),(39455,780,27066),(39456,780,27067),(40097,781,27069),(40098,781,27070),(40099,781,27071),(40100,781,27072),(40101,781,27073),(40102,781,27074),(40103,781,27075),(40104,781,27076),(40105,781,27077),(40124,782,27079),(40125,782,27080),(40126,782,27081),(40127,782,27082),(40128,782,27083),(40129,782,27084),(40130,782,27085),(40131,782,27086),(40132,782,27087),(39890,783,27089),(39891,783,27090),(39892,783,27091),(39893,783,27092),(39894,783,27093),(39895,783,27094),(39896,783,27095),(39897,783,27096),(39898,783,27097),(39899,784,27099),(39900,784,27100),(39901,784,27101),(39902,784,27102),(39903,784,27103),(39904,784,27104),(39905,784,27105),(39906,784,27106),(39907,784,27107),(39457,797,27138),(39458,797,27139),(39459,797,27140),(39580,797,27143),(39585,797,28252),(39578,798,27141),(39579,798,27142),(39581,798,27144),(39582,798,27145),(39583,798,27146),(39584,798,27147),(39460,799,27149),(39461,799,27150),(39462,799,27151),(39612,799,27154),(39617,799,28255),(39610,800,27152),(39611,800,27153),(39613,800,27155),(39614,800,27156),(39615,800,27157),(39616,800,27158),(39908,803,27181),(39909,803,27182),(39910,803,27183),(39911,803,27184),(39912,803,27185),(39913,803,27186),(39914,803,27187),(39915,803,27188),(39916,803,27189),(39565,803,27191),(39618,804,27195),(39619,804,27196),(39620,804,27197),(39621,804,27198),(39622,804,27199),(39623,804,27200),(39463,805,27192),(39464,805,27193),(39465,805,27194),(39624,805,27202),(39786,805,28256),(40156,806,27208),(40153,807,27205),(40154,807,27206),(40155,807,27207),(40157,808,27212),(40158,809,27213),(40151,810,27203),(40152,810,27204),(40159,810,27214),(39917,811,27216),(39918,811,27217),(39919,811,27218),(39920,811,27219),(39921,811,27220),(39922,811,27221),(39923,811,27222),(39924,811,27223),(39925,811,27224),(39625,812,27228),(39626,812,27229),(39627,812,27230),(39628,812,27231),(39629,812,27232),(39630,812,27233),(39466,813,27225),(39467,813,27226),(39468,813,27227),(39631,813,27235),(40169,813,27238),(39787,813,28257),(40171,814,27240),(40170,815,27239),(40172,816,27246),(40173,816,27247),(40174,817,27248),(40175,818,27249),(40176,818,27250),(40167,819,27236),(40168,819,27237),(39926,820,27252),(39927,820,27253),(39928,820,27254),(39929,820,27255),(39930,820,27256),(39931,820,27257),(39932,820,27258),(39933,820,27259),(39934,820,27260),(39632,821,27264),(39633,821,27265),(39634,821,27266),(39635,821,27267),(39636,821,27268),(39637,821,27269),(39469,822,27261),(39470,822,27262),(39471,822,27263),(39638,822,27271),(39788,822,28258),(39935,823,27273),(39936,823,27274),(39937,823,27275),(39938,823,27276),(39939,823,27277),(39940,823,27278),(39941,823,27279),(39942,823,27280),(39943,823,27281),(39639,824,27285),(39640,824,27286),(39641,824,27287),(39642,824,27288),(39643,824,27289),(39644,824,27290),(39472,825,27282),(39473,825,27283),(39474,825,27284),(39645,825,27292),(39789,825,28259),(40178,826,27294),(40177,827,27293),(40188,828,27314),(40189,828,27315),(40186,829,27312),(40187,830,27313),(40179,831,27295),(40180,831,27296),(40192,832,27318),(40190,833,27316),(40191,834,27317),(40181,835,27297),(40193,835,27319),(40194,835,27320),(40183,836,27299),(40182,837,27298),(40185,838,27301),(40184,839,27300),(39944,840,27322),(39945,840,27323),(39946,840,27324),(39947,840,27325),(39948,840,27326),(39949,840,27327),(39950,840,27328),(39951,840,27329),(39952,840,27330),(39566,840,27332),(39646,841,27336),(39647,841,27337),(39648,841,27338),(39649,841,27339),(39650,841,27340),(39651,841,27341),(39475,842,27333),(39476,842,27334),(39477,842,27335),(39652,842,27343),(39790,842,28260),(39653,846,27368),(39654,846,27369),(39655,846,27370),(39656,846,27371),(39657,846,27372),(39658,846,27373),(39478,847,27365),(39479,847,27366),(39480,847,27367),(39659,847,27375),(39791,847,28261),(40209,848,27414),(40210,848,27415),(40211,848,27416),(40212,849,27417),(40195,851,27376),(40196,852,27377),(40197,852,27378),(40198,852,27379),(40213,852,27419),(40214,853,27420),(40215,853,27421),(40216,854,27422),(40217,855,27423),(40219,856,27424),(40220,856,27425),(40221,856,27426),(40222,857,27427),(40203,858,27384),(40204,858,27385),(40205,858,27386),(40223,858,27428),(40224,859,27429),(40225,859,27430),(40226,860,27431),(40227,861,27432),(40228,868,27442),(40229,868,27443),(40230,868,27444),(40199,869,27380),(40200,870,27381),(40201,870,27382),(40202,870,27383),(40231,870,27445),(40232,871,27446),(40233,871,27447),(40234,872,27448),(40235,873,27449),(39953,874,27451),(39954,874,27452),(39955,874,27453),(39956,874,27454),(39957,874,27455),(39958,874,27456),(39959,874,27457),(39960,874,27458),(39961,874,27459),(39567,874,27461),(39660,875,27465),(39661,875,27466),(39662,875,27467),(39663,875,27468),(39664,875,27469),(39665,875,27470),(39481,876,27462),(39482,876,27463),(39483,876,27464),(39666,876,27472),(39792,876,28262),(40246,877,27478),(40245,878,27477),(40253,879,27485),(40247,880,27479),(40248,881,27480),(40249,882,27481),(40250,882,27482),(40251,882,27483),(40252,882,27484),(39962,883,27487),(39963,883,27488),(39964,883,27489),(39965,883,27490),(39966,883,27491),(39967,883,27492),(39968,883,27493),(39969,883,27494),(39970,883,27495),(39667,884,27499),(39668,884,27500),(39669,884,27501),(39670,884,27502),(39671,884,27503),(39672,884,27504),(39484,885,27496),(39485,885,27497),(39486,885,27498),(39673,885,27506),(39793,885,28263),(40258,886,27511),(40259,887,27516),(40260,888,27517),(40262,889,27519),(40261,890,27518),(40254,891,27507),(40255,891,27508),(40256,891,27509),(40257,891,27510),(39971,892,27521),(39972,892,27522),(39973,892,27523),(39974,892,27524),(39975,892,27525),(39976,892,27526),(39977,892,27527),(39978,892,27528),(39979,892,27529),(39568,892,27531),(39674,893,27535),(39675,893,27536),(39676,893,27537),(39677,893,27538),(39678,893,27539),(39679,893,27540),(39487,894,27532),(39488,894,27533),(39489,894,27534),(39680,894,27542),(39794,894,28264),(40267,895,27547),(40268,896,27552),(40269,897,27553),(40271,898,27555),(40270,899,27554),(40263,900,27543),(40264,900,27544),(40265,900,27545),(40266,900,27546),(39980,901,27557),(39981,901,27558),(39982,901,27559),(39983,901,27560),(39984,901,27561),(39985,901,27562),(39986,901,27563),(39987,901,27564),(39988,901,27565),(39569,901,27567),(39681,902,27571),(39682,902,27572),(39683,902,27573),(39684,902,27574),(39685,902,27575),(39686,902,27576),(39490,903,27568),(39491,903,27569),(39492,903,27570),(39687,903,27578),(39795,903,28265),(40279,904,27586),(40280,905,27590),(40281,905,27591),(40282,905,27592),(40277,906,27584),(40278,906,27585),(40283,907,27593),(40284,908,27594),(40285,908,27595),(40272,909,27579),(40273,909,27580),(40274,909,27581),(40275,909,27582),(40276,909,27583),(40106,910,27597),(40107,910,27598),(40108,910,27599),(40109,910,27600),(40110,910,27601),(40111,910,27602),(40112,910,27603),(40113,910,27604),(40114,910,27605),(39563,910,27607),(39586,911,27611),(39587,911,27612),(39588,911,27613),(39589,911,27614),(39590,911,27615),(39591,911,27616),(39493,912,27608),(39494,912,27609),(39495,912,27610),(39592,912,27618),(39600,912,28253),(40133,913,27620),(40134,913,27621),(40135,913,27622),(40136,913,27623),(40137,913,27624),(40138,913,27625),(40139,913,27626),(40140,913,27627),(40141,913,27628),(39570,913,27630),(39688,914,27634),(39689,914,27635),(39690,914,27636),(39691,914,27637),(39692,914,27638),(39693,914,27639),(39496,915,27631),(39497,915,27632),(39498,915,27633),(39694,915,27641),(39796,915,28266),(39989,916,27643),(39990,916,27644),(39991,916,27645),(39992,916,27646),(39993,916,27647),(39994,916,27648),(39995,916,27649),(39996,916,27650),(39997,916,27651),(39571,916,27653),(39695,917,27657),(39696,917,27658),(39697,917,27659),(39698,917,27660),(39699,917,27661),(39700,917,27662),(39499,918,27654),(39500,918,27655),(39501,918,27656),(39701,918,27664),(39797,918,28267),(40287,919,27671),(40286,920,27670),(40288,921,27672),(40289,922,27673),(40290,923,27674),(40291,924,27675),(40292,924,27676),(40293,924,27677),(40294,924,27678),(40295,924,27679),(39998,934,27723),(39999,934,27724),(40000,934,27725),(40001,934,27726),(40002,934,27727),(40003,934,27728),(40004,934,27729),(40005,934,27730),(40006,934,27731),(39572,934,27733),(39702,935,27737),(39703,935,27738),(39704,935,27739),(39705,935,27740),(39706,935,27741),(39707,935,27742),(39502,936,27734),(39503,936,27735),(39504,936,27736),(39708,936,27744),(39798,936,28268),(40313,937,27753),(40312,938,27752),(40311,939,27751),(40315,940,27755),(40308,941,27748),(40309,941,27749),(40310,941,27750),(40314,941,27754),(40007,942,27757),(40008,942,27758),(40009,942,27759),(40010,942,27760),(40011,942,27761),(40012,942,27762),(40013,942,27763),(40014,942,27764),(40015,942,27765),(39709,943,27769),(39710,943,27770),(39711,943,27771),(39712,943,27772),(39713,943,27773),(39714,943,27774),(39505,944,27766),(39506,944,27767),(39507,944,27768),(39715,944,27776),(39799,944,28269),(40318,945,27783),(40319,945,27784),(40321,946,27786),(40322,947,27787),(40316,948,27777),(40317,948,27778),(40320,948,27785),(40016,949,27789),(40017,949,27790),(40018,949,27791),(40019,949,27792),(40020,949,27793),(40021,949,27794),(40022,949,27795),(40023,949,27796),(40024,949,27797),(39573,949,27799),(39716,950,27803),(39717,950,27804),(39718,950,27805),(39719,950,27806),(39720,950,27807),(39721,950,27808),(39508,951,27800),(39509,951,27801),(39510,951,27802),(39722,951,27810),(40326,951,27814),(39800,951,28270),(40331,952,28613),(40327,953,27819),(40328,954,27821),(40330,955,27823),(40329,956,27822),(40323,957,27811),(40324,957,27812),(40325,957,27813),(40025,969,27873),(40026,969,27874),(40027,969,27875),(40028,969,27876),(40029,969,27877),(40030,969,27878),(40031,969,27879),(40032,969,27880),(40033,969,27881),(39723,970,27885),(39724,970,27886),(39725,970,27887),(39726,970,27888),(39727,970,27889),(39728,970,27890),(39511,971,27882),(39512,971,27883),(39513,971,27884),(39729,971,27892),(39801,971,28271),(40347,972,27904),(40344,973,27898),(40345,973,27899),(40346,973,27900),(40343,974,27897),(40348,974,27905),(40349,975,27906),(40350,975,27907),(40351,975,27908),(40339,976,27893),(40340,976,27894),(40341,976,27895),(40342,976,27896),(40034,977,27910),(40035,977,27911),(40036,977,27912),(40037,977,27913),(40038,977,27914),(40039,977,27915),(40040,977,27916),(40041,977,27917),(40042,977,27918),(39730,978,27922),(39731,978,27923),(39732,978,27924),(39733,978,27925),(39734,978,27926),(39735,978,27927),(39514,979,27919),(39515,979,27920),(39516,979,27921),(39736,979,27929),(39802,979,28272),(40358,980,27936),(40355,981,27933),(40356,981,27934),(40357,981,27935),(40359,982,27940),(40360,982,27941),(40362,983,27943),(40361,984,27942),(40352,985,27930),(40353,985,27931),(40354,985,27932),(40043,986,27945),(40044,986,27946),(40045,986,27947),(40046,986,27948),(40047,986,27949),(40048,986,27950),(40049,986,27951),(40050,986,27952),(40051,986,27953),(39574,986,27955),(39737,987,27959),(39738,987,27960),(39739,987,27961),(39740,987,27962),(39741,987,27963),(39742,987,27964),(39517,988,27956),(39518,988,27957),(39519,988,27958),(39743,988,27966),(39803,988,28273),(40371,989,27975),(40368,990,27972),(40369,990,27973),(40370,990,27974),(40363,991,27967),(40364,991,27968),(40365,991,27969),(40366,991,27970),(40367,991,27971),(40142,992,27977),(40143,992,27978),(40144,992,27979),(40145,992,27980),(40146,992,27981),(40147,992,27982),(40148,992,27983),(40149,992,27984),(40150,992,27985),(39744,993,27989),(39745,993,27990),(39746,993,27991),(39747,993,27992),(39748,993,27993),(39749,993,27994),(39520,994,27986),(39521,994,27987),(39522,994,27988),(39750,994,27996),(39804,994,28274),(40376,995,28003),(40377,996,28004),(40372,997,27997),(40373,997,27998),(40374,997,27999),(40375,997,28000),(40115,998,28006),(40116,998,28007),(40117,998,28008),(40118,998,28009),(40119,998,28010),(40120,998,28011),(40121,998,28012),(40122,998,28013),(40123,998,28014),(39593,999,28018),(39594,999,28019),(39595,999,28020),(39596,999,28021),(39597,999,28022),(39598,999,28023),(39523,1000,28015),(39524,1000,28016),(39525,1000,28017),(39599,1000,28025),(39601,1000,28254),(40383,1001,28031),(40380,1002,28028),(40381,1002,28029),(40382,1002,28030),(40378,1003,28026),(40379,1003,28027),(40052,1018,28059),(40053,1018,28060),(40054,1018,28061),(40055,1018,28062),(40056,1018,28063),(40057,1018,28064),(40058,1018,28065),(40059,1018,28066),(40060,1018,28067),(39575,1018,28069),(39751,1019,28073),(39752,1019,28074),(39753,1019,28075),(39754,1019,28076),(39755,1019,28077),(39756,1019,28078),(39526,1020,28070),(39527,1020,28071),(39528,1020,28072),(39757,1020,28080),(39805,1020,28275),(39758,1026,28110),(39759,1026,28111),(39760,1026,28112),(39761,1026,28113),(39762,1026,28114),(39763,1026,28115),(39529,1027,28107),(39530,1027,28108),(39531,1027,28109),(39764,1027,28117),(39806,1027,28276),(40061,1028,28119),(40062,1028,28120),(40063,1028,28121),(40064,1028,28122),(40065,1028,28123),(40066,1028,28124),(40067,1028,28125),(40068,1028,28126),(40069,1028,28127),(39576,1028,28129),(39765,1029,28133),(39766,1029,28134),(39767,1029,28135),(39768,1029,28136),(39769,1029,28137),(39770,1029,28138),(39532,1030,28130),(39533,1030,28131),(39534,1030,28132),(39771,1030,28140),(39807,1030,28277),(40298,1031,28143),(40300,1032,28151),(40301,1032,28152),(40302,1032,28153),(40299,1033,28150),(40305,1033,28156),(40303,1034,28154),(40304,1035,28155),(40296,1036,28141),(40297,1036,28142),(40306,1036,28157),(40307,1036,28158),(40070,1041,28176),(40071,1041,28177),(40072,1041,28178),(40073,1041,28179),(40074,1041,28180),(40075,1041,28181),(40076,1041,28182),(40077,1041,28183),(40078,1041,28184),(39772,1042,28188),(39773,1042,28189),(39774,1042,28190),(39775,1042,28191),(39776,1042,28192),(39777,1042,28193),(39535,1043,28185),(39536,1043,28186),(39537,1043,28187),(39778,1043,28195),(39808,1043,28278),(40332,1044,28200),(40333,1044,28201),(40334,1045,28202),(40335,1045,28203),(40338,1046,28206),(40336,1047,28204),(40337,1047,28205),(40236,1048,28208),(40206,1048,28209),(40207,1048,28210),(40208,1048,28211),(40237,1049,28215),(40238,1050,28216),(40239,1051,28217),(40240,1051,28218),(40241,1052,28220),(40242,1052,28221),(40243,1052,28222),(40079,1053,28224),(40080,1053,28225),(40081,1053,28226),(40082,1053,28227),(40083,1053,28228),(40084,1053,28229),(40085,1053,28230),(40086,1053,28231),(40087,1053,28232),(39779,1054,28236),(39780,1054,28237),(39781,1054,28238),(39782,1054,28239),(39783,1054,28240),(39784,1054,28241),(39538,1055,28233),(39539,1055,28234),(39540,1055,28235),(39785,1055,28243),(39809,1055,28279),(40218,1056,28246),(40244,1057,28247),(39577,1058,28281),(40088,1058,28294),(40089,1058,28295),(40090,1058,28296),(40091,1058,28297),(40092,1058,28298),(40093,1058,28299),(40094,1058,28300),(40095,1058,28301),(40096,1058,28302),(39810,1059,28285),(39811,1059,28286),(39812,1059,28287),(39813,1059,28288),(39814,1059,28289),(39815,1059,28290),(39541,1060,28282),(39542,1060,28283),(39543,1060,28284),(39816,1060,28291),(39817,1060,28292),(40162,1062,28325),(40163,1062,28326),(40164,1064,28327),(40165,1064,28328),(40166,1066,28329),(40160,1068,28323),(40161,1068,28324),(39818,1069,28333),(39819,1069,28334),(39820,1069,28335),(39821,1069,28336),(39822,1069,28337),(39823,1069,28338),(39544,1070,28330),(39545,1070,28331),(39546,1070,28332),(39824,1070,28339),(39825,1070,28340),(40404,1070,28341),(40429,1071,28374),(40430,1071,28375),(40431,1071,28376),(40414,1072,28359),(40415,1072,28360),(40405,1073,28342),(40406,1073,28343),(40407,1073,28344),(40408,1073,28345),(40416,1074,28361),(40417,1074,28362),(40418,1074,28363),(40419,1074,28364),(40420,1074,28365),(40421,1074,28366),(40422,1074,28367),(40413,1075,28358),(40409,1076,28354),(40410,1076,28355),(40411,1076,28356),(40412,1076,28357),(40423,1077,28368),(40424,1077,28369),(40425,1077,28370),(40426,1077,28371),(40427,1077,28372),(40428,1077,28373),(39826,1078,28380),(39827,1078,28381),(39828,1078,28382),(39829,1078,28383),(39830,1078,28384),(39831,1078,28385),(39547,1079,28377),(39548,1079,28378),(39549,1079,28379),(39832,1079,28386),(39833,1079,28387),(40435,1079,28654),(40445,1080,28413),(40446,1080,28414),(40447,1080,28415),(40448,1080,28416),(40444,1081,28412),(40433,1082,28390),(40434,1082,28391),(40449,1083,28417),(40450,1083,28418),(40451,1083,28419),(40452,1083,28420),(40453,1083,28421),(40454,1083,28422),(40443,1084,28411),(40432,1085,28388),(40436,1085,28404),(40437,1085,28405),(40438,1085,28406),(40439,1085,28407),(40440,1085,28408),(40441,1085,28409),(40442,1085,28410),(40455,1086,28423),(40456,1086,28424),(40457,1086,28425),(39602,1087,28429),(39603,1087,28430),(39604,1087,28431),(39605,1087,28432),(39606,1087,28433),(39607,1087,28434),(39550,1088,28426),(39551,1088,28427),(39552,1088,28428),(39608,1088,28435),(39609,1088,28436),(40458,1088,28437),(40465,1089,28450),(40466,1089,28451),(40459,1090,28438),(40460,1090,28439),(40467,1091,28452),(40468,1091,28453),(40464,1092,28449),(40461,1093,28446),(40462,1093,28447),(40463,1093,28448),(39834,1094,28457),(39835,1094,28458),(39836,1094,28459),(39837,1094,28460),(39838,1094,28461),(39839,1094,28462),(39553,1095,28454),(39554,1095,28455),(39555,1095,28456),(39840,1095,28463),(39841,1095,28464),(40469,1095,28465),(40476,1096,28478),(40477,1096,28479),(40470,1097,28466),(40471,1097,28467),(40478,1098,28480),(40479,1098,28481),(40475,1099,28477),(40472,1100,28474),(40473,1100,28475),(40474,1100,28476),(39842,1101,28485),(39843,1101,28486),(39844,1101,28487),(39845,1101,28488),(39846,1101,28489),(39847,1101,28490),(39556,1102,28482),(39557,1102,28483),(39558,1102,28484),(39848,1102,28491),(39849,1102,28492),(40481,1103,28496),(40480,1104,28495),(38605,1105,28503),(38606,1105,28504),(38615,1105,28513),(38621,1105,28519),(38622,1105,28520),(38623,1105,28521),(38624,1105,28522),(38625,1105,28523),(38634,1105,28532),(38607,1106,28505),(38608,1106,28506),(38609,1106,28507),(38614,1106,28512),(38626,1106,28524),(38627,1106,28525),(38628,1106,28526),(38629,1106,28527),(38630,1106,28528),(38603,1107,28501),(38610,1107,28508),(38611,1107,28509),(38612,1107,28510),(38619,1107,28517),(38631,1107,28529),(38632,1107,28530),(38633,1107,28531),(38604,1108,28502),(38616,1108,28514),(38617,1108,28515),(38618,1108,28516),(38620,1108,28518),(38613,1109,28511),(38730,1110,28533),(38731,1110,28534),(38732,1110,28535),(38733,1110,28536),(38734,1110,28537),(38735,1110,28538),(38736,1110,28539),(38737,1110,28540),(38738,1110,28541),(38739,1110,28542),(38740,1110,28543),(38741,1110,28544),(38742,1110,28545),(38743,1110,28546),(38744,1110,28547),(38745,1110,28548),(38746,1110,28549),(38747,1110,28550),(38748,1110,28551),(38749,1110,28552),(38750,1110,28553),(38751,1110,28554),(38752,1110,28555),(38753,1110,28556),(38754,1110,28557),(38755,1110,28558),(38756,1110,28559),(38757,1110,28560),(38758,1110,28561),(38759,1110,28562),(38760,1110,28563),(38761,1110,28564),(38762,1110,28565),(38763,1110,28566),(38764,1110,28567),(38765,1110,28568),(38766,1110,28569),(38767,1110,28570),(38768,1110,28571),(38769,1110,28572),(38770,1110,28573),(38771,1110,28574),(38772,1110,28575),(38698,1111,28576),(38699,1111,28577),(38700,1111,28578),(38701,1111,28579),(38702,1111,28580),(38703,1111,28581),(38704,1111,28582),(38705,1111,28583),(38706,1111,28584),(38707,1111,28585),(38708,1111,28586),(38709,1111,28587),(38710,1111,28588),(38711,1111,28589),(38712,1111,28590),(38713,1111,28591),(38714,1111,28592),(38715,1111,28593),(38716,1111,28594),(38717,1111,28595),(38718,1111,28596),(38719,1111,28597),(38720,1111,28598),(38721,1111,28599),(38722,1111,28600),(38723,1111,28601),(38724,1111,28602),(38725,1111,28603),(38726,1111,28604),(38727,1111,28605),(38728,1111,28606),(38729,1111,28607),(39450,1112,28609),(39451,1112,28610),(39452,1112,28611),(39453,1112,28612),(39850,1113,28617),(39851,1113,28618),(39852,1113,28619),(39853,1113,28620),(39854,1113,28621),(39855,1113,28622),(39559,1114,28614),(39560,1114,28615),(39561,1114,28616),(39856,1114,28623),(39857,1114,28624),(40390,1114,28640),(40401,1115,28651),(40402,1115,28652),(40403,1115,28653),(40393,1116,28643),(40391,1117,28641),(40392,1117,28642),(40394,1118,28644),(40395,1118,28645),(40396,1118,28646),(40397,1118,28647),(40389,1119,28639),(40384,1120,28634),(40385,1120,28635),(40386,1120,28636),(40387,1120,28637),(40388,1120,28638),(40398,1121,28648),(40399,1121,28649),(40400,1121,28650),(39872,1123,28676),(39873,1123,28677),(39874,1123,28678),(39866,1124,28655),(39875,1126,28682),(39876,1126,28683),(39877,1126,28684),(39867,1127,28656),(39878,1129,28688),(39879,1129,28689),(39880,1129,28690),(39868,1130,28657),(39881,1132,28694),(39882,1132,28695),(39883,1132,28696),(39869,1133,28658),(39884,1135,28700),(39885,1135,28701),(39886,1135,28702),(39870,1136,28659),(39887,1138,28706),(39888,1138,28707),(39889,1138,28708),(39871,1139,28660),(39860,1141,28718),(39861,1141,28719),(39862,1141,28720),(39858,1142,28709),(39863,1144,28724),(39864,1144,28725),(39865,1144,28726),(39859,1145,28710);
/*!40000 ALTER TABLE `items_applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance_tag`
--

DROP TABLE IF EXISTS `maintenance_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenance_tag` (
  `maintenancetagid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `operator` int(11) NOT NULL DEFAULT '2',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`maintenancetagid`),
  KEY `maintenance_tag_1` (`maintenanceid`),
  CONSTRAINT `c_maintenance_tag_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_tag`
--

LOCK TABLES `maintenance_tag` WRITE;
/*!40000 ALTER TABLE `maintenance_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenance_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances`
--

DROP TABLE IF EXISTS `maintenances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances` (
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `maintenance_type` int(11) NOT NULL DEFAULT '0',
  `description` text COLLATE utf8_bin NOT NULL,
  `active_since` int(11) NOT NULL DEFAULT '0',
  `active_till` int(11) NOT NULL DEFAULT '0',
  `tags_evaltype` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`maintenanceid`),
  UNIQUE KEY `maintenances_2` (`name`),
  KEY `maintenances_1` (`active_since`,`active_till`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances`
--

LOCK TABLES `maintenances` WRITE;
/*!40000 ALTER TABLE `maintenances` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_groups`
--

DROP TABLE IF EXISTS `maintenances_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances_groups` (
  `maintenance_groupid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_groupid`),
  UNIQUE KEY `maintenances_groups_1` (`maintenanceid`,`groupid`),
  KEY `maintenances_groups_2` (`groupid`),
  CONSTRAINT `c_maintenances_groups_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_groups_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_groups`
--

LOCK TABLES `maintenances_groups` WRITE;
/*!40000 ALTER TABLE `maintenances_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_hosts`
--

DROP TABLE IF EXISTS `maintenances_hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances_hosts` (
  `maintenance_hostid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_hostid`),
  UNIQUE KEY `maintenances_hosts_1` (`maintenanceid`,`hostid`),
  KEY `maintenances_hosts_2` (`hostid`),
  CONSTRAINT `c_maintenances_hosts_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_hosts_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_hosts`
--

LOCK TABLES `maintenances_hosts` WRITE;
/*!40000 ALTER TABLE `maintenances_hosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_windows`
--

DROP TABLE IF EXISTS `maintenances_windows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances_windows` (
  `maintenance_timeperiodid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `timeperiodid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_timeperiodid`),
  UNIQUE KEY `maintenances_windows_1` (`maintenanceid`,`timeperiodid`),
  KEY `maintenances_windows_2` (`timeperiodid`),
  CONSTRAINT `c_maintenances_windows_2` FOREIGN KEY (`timeperiodid`) REFERENCES `timeperiods` (`timeperiodid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_windows_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_windows`
--

LOCK TABLES `maintenances_windows` WRITE;
/*!40000 ALTER TABLE `maintenances_windows` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_windows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mappings`
--

DROP TABLE IF EXISTS `mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mappings` (
  `mappingid` bigint(20) unsigned NOT NULL,
  `valuemapid` bigint(20) unsigned NOT NULL,
  `value` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `newvalue` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`mappingid`),
  KEY `mappings_1` (`valuemapid`),
  CONSTRAINT `c_mappings_1` FOREIGN KEY (`valuemapid`) REFERENCES `valuemaps` (`valuemapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mappings`
--

LOCK TABLES `mappings` WRITE;
/*!40000 ALTER TABLE `mappings` DISABLE KEYS */;
INSERT INTO `mappings` VALUES (1,1,'0','Down'),(2,1,'1','Up'),(3,2,'0','not available'),(4,2,'1','available'),(5,2,'2','unknown'),(13,6,'1','Other'),(14,6,'2','OK'),(15,6,'3','Degraded'),(17,7,'1','Other'),(18,7,'2','Unknown'),(19,7,'3','OK'),(20,7,'4','NonCritical'),(21,7,'5','Critical'),(22,7,'6','NonRecoverable'),(23,5,'1','unknown'),(24,5,'2','batteryNormal'),(25,5,'3','batteryLow'),(26,4,'1','unknown'),(27,4,'2','notInstalled'),(28,4,'3','ok'),(29,4,'4','failed'),(30,4,'5','highTemperature'),(31,4,'6','replaceImmediately'),(32,4,'7','lowCapacity'),(33,3,'0','Running'),(34,3,'1','Paused'),(35,3,'3','Pause pending'),(36,3,'4','Continue pending'),(37,3,'5','Stop pending'),(38,3,'6','Stopped'),(39,3,'7','Unknown'),(40,3,'255','No such service'),(41,3,'2','Start pending'),(49,9,'1','unknown'),(50,9,'2','running'),(51,9,'3','warning'),(52,9,'4','testing'),(53,9,'5','down'),(61,8,'1','up'),(62,8,'2','down'),(63,8,'3','testing'),(64,8,'4','unknown'),(65,8,'5','dormant'),(66,8,'6','notPresent'),(67,8,'7','lowerLayerDown'),(68,10,'1','Up'),(69,11,'1','up'),(70,11,'2','down'),(71,11,'3','testing'),(72,12,'0','poweredOff'),(73,12,'1','poweredOn'),(74,12,'2','suspended'),(75,13,'0','gray'),(76,13,'1','green'),(77,13,'2','yellow'),(78,13,'3','red'),(79,14,'0','normal'),(80,14,'1','in maintenance'),(81,14,'2','no data collection'),(82,15,'0','Normal'),(83,15,'1','Low memory'),(84,16,'0','Automatic'),(85,16,'1','Automatic delayed'),(86,16,'2','Manual'),(87,16,'3','Disabled'),(88,16,'4','Unknown'),(89,17,'100','Continue'),(90,17,'101','Switching Protocols'),(91,17,'102','Processing'),(92,17,'200','OK'),(93,17,'201','Created'),(94,17,'202','Accepted'),(95,17,'203','Non-Authoritative Information'),(96,17,'204','No Content'),(97,17,'205','Reset Content'),(98,17,'206','Partial Content'),(99,17,'207','Multi-Status'),(100,17,'208','Already Reported'),(101,17,'226','IM Used'),(102,17,'300','Multiple Choices'),(103,17,'301','Moved Permanently'),(104,17,'302','Found'),(105,17,'303','See Other'),(106,17,'304','Not Modified'),(107,17,'305','Use Proxy'),(108,17,'306','Switch Proxy'),(109,17,'307','Temporary Redirect'),(110,17,'308','Permanent Redirect/Resume Incomplete'),(111,17,'400','Bad Request'),(112,17,'401','Unauthorized'),(113,17,'402','Payment Required'),(114,17,'403','Forbidden'),(115,17,'404','Not Found'),(116,17,'405','Method Not Allowed'),(117,17,'406','Not Acceptable'),(118,17,'407','Proxy Authentication Required'),(119,17,'408','Request Timeout'),(120,17,'409','Conflict'),(121,17,'410','Gone'),(122,17,'411','Length Required'),(123,17,'412','Precondition Failed'),(124,17,'413','Payload Too Large'),(125,17,'414','Request-URI Too Long'),(126,17,'415','Unsupported Media Type'),(127,17,'416','Requested Range Not Satisfiable'),(128,17,'417','Expectation Failed'),(129,17,'418','I\'m a Teapot'),(130,17,'419','Authentication Timeout'),(131,17,'420','Method Failure/Enhance Your Calm'),(132,17,'421','Misdirected Request'),(133,17,'422','Unprocessable Entity'),(134,17,'423','Locked'),(135,17,'424','Failed Dependency'),(136,17,'426','Upgrade Required'),(137,17,'428','Precondition Required'),(138,17,'429','Too Many Requests'),(139,17,'431','Request Header Fields Too Large'),(140,17,'440','Login Timeout'),(141,17,'444','No Response'),(142,17,'449','Retry With'),(143,17,'450','Blocked by Windows Parental Controls'),(144,17,'451','Unavailable for Legal Reasons/Redirect'),(145,17,'494','Request Header Too Large'),(146,17,'495','Cert Error'),(147,17,'496','No Cert'),(148,17,'497','HTTP to HTTPS'),(149,17,'498','Token Expired/Invalid'),(150,17,'499','Client Closed Request/Token Required'),(151,17,'500','Internal Server Error'),(152,17,'501','Not Implemented'),(153,17,'502','Bad Gateway'),(154,17,'503','Service Unavailable'),(155,17,'504','Gateway Timeout'),(156,17,'505','HTTP Version Not Supported'),(157,17,'506','Variant Also Negotiates'),(158,17,'507','Insufficient Storage'),(159,17,'508','Loop Detected'),(160,17,'509','Bandwidth Limit Exceeded'),(161,17,'510','Not Extended'),(162,17,'511','Network Authentication Required'),(163,17,'520','Unknown Error'),(164,17,'598','Network Read Timeout Error'),(165,17,'599','Network Connect Timeout Error'),(166,18,'1','ok'),(167,18,'2','unavailable'),(168,18,'3','nonoperational'),(169,19,'1','unknown'),(170,19,'2','halfDuplex'),(171,19,'3','fullDuplex'),(172,20,'1','up'),(173,20,'2','down'),(174,20,'3','testing'),(175,20,'4','unknown'),(176,20,'5','dormant'),(177,20,'6','notPresent'),(178,20,'7','lowerLayerDown'),(179,21,'1','other'),(180,21,'2','regular1822'),(181,21,'3','hdh1822'),(182,21,'4','ddnX25'),(183,21,'5','rfc877x25'),(184,21,'6','ethernetCsmacd'),(185,21,'7','iso88023Csmacd'),(186,21,'8','iso88024TokenBus'),(187,21,'9','iso88025TokenRing'),(188,21,'10','iso88026Man'),(189,21,'11','starLan'),(190,21,'12','proteon10Mbit'),(191,21,'13','proteon80Mbit'),(192,21,'14','hyperchannel'),(193,21,'15','fddi'),(194,21,'16','lapb'),(195,21,'17','sdlc'),(196,21,'18','ds1'),(197,21,'19','e1'),(198,21,'20','basicISDN'),(199,21,'21','primaryISDN'),(200,21,'22','propPointToPointSerial'),(201,21,'23','ppp'),(202,21,'24','softwareLoopback'),(203,21,'25','eon'),(204,21,'26','ethernet3Mbit'),(205,21,'27','nsip'),(206,21,'28','slip'),(207,21,'29','ultra'),(208,21,'30','ds3'),(209,21,'31','sip'),(210,21,'32','frameRelay'),(211,21,'33','rs232'),(212,21,'34','para'),(213,21,'35','arcnet'),(214,21,'36','arcnetPlus'),(215,21,'37','atm'),(216,21,'38','miox25'),(217,21,'39','sonet'),(218,21,'40','x25ple'),(219,21,'41','iso88022llc'),(220,21,'42','localTalk'),(221,21,'43','smdsDxi'),(222,21,'44','frameRelayService'),(223,21,'45','v35'),(224,21,'46','hssi'),(225,21,'47','hippi'),(226,21,'48','modem'),(227,21,'49','aal5'),(228,21,'50','sonetPath'),(229,21,'51','sonetVT'),(230,21,'52','smdsIcip'),(231,21,'53','propVirtual'),(232,21,'54','propMultiplexor'),(233,21,'55','ieee80212'),(234,21,'56','fibreChannel'),(235,21,'57','hippiInterface'),(236,21,'58','frameRelayInterconnect'),(237,21,'59','aflane8023'),(238,21,'60','aflane8025'),(239,21,'61','cctEmul'),(240,21,'62','fastEther'),(241,21,'63','isdn'),(242,21,'64','v11'),(243,21,'65','v36'),(244,21,'66','g703at64k'),(245,21,'67','g703at2mb'),(246,21,'68','qllc'),(247,21,'69','fastEtherFX'),(248,21,'70','channel'),(249,21,'71','ieee80211'),(250,21,'72','ibm370parChan'),(251,21,'73','escon'),(252,21,'74','dlsw'),(253,21,'75','isdns'),(254,21,'76','isdnu'),(255,21,'77','lapd'),(256,21,'78','ipSwitch'),(257,21,'79','rsrb'),(258,21,'80','atmLogical'),(259,21,'81','ds0'),(260,21,'82','ds0Bundle'),(261,21,'83','bsc'),(262,21,'84','async'),(263,21,'85','cnr'),(264,21,'86','iso88025Dtr'),(265,21,'87','eplrs'),(266,21,'88','arap'),(267,21,'89','propCnls'),(268,21,'90','hostPad'),(269,21,'91','termPad'),(270,21,'92','frameRelayMPI'),(271,21,'93','x213'),(272,21,'94','adsl'),(273,21,'95','radsl'),(274,21,'96','sdsl'),(275,21,'97','vdsl'),(276,21,'98','iso88025CRFPInt'),(277,21,'99','myrinet'),(278,21,'100','voiceEM'),(279,21,'101','voiceFXO'),(280,21,'102','voiceFXS'),(281,21,'103','voiceEncap'),(282,21,'104','voiceOverIp'),(283,21,'105','atmDxi'),(284,21,'106','atmFuni'),(285,21,'107','atmIma'),(286,21,'108','pppMultilinkBundle'),(287,21,'109','ipOverCdlc'),(288,21,'110','ipOverClaw'),(289,21,'111','stackToStack'),(290,21,'112','virtualIpAddress'),(291,21,'113','mpc'),(292,21,'114','ipOverAtm'),(293,21,'115','iso88025Fiber'),(294,21,'116','tdlc'),(295,21,'117','gigabitEthernet'),(296,21,'118','hdlc'),(297,21,'119','lapf'),(298,21,'120','v37'),(299,21,'121','x25mlp'),(300,21,'122','x25huntGroup'),(301,21,'123','trasnpHdlc'),(302,21,'124','interleave'),(303,21,'125','fast'),(304,21,'126','ip'),(305,21,'127','docsCableMaclayer'),(306,21,'128','docsCableDownstream'),(307,21,'129','docsCableUpstream'),(308,21,'130','a12MppSwitch'),(309,21,'131','tunnel'),(310,21,'132','coffee'),(311,21,'133','ces'),(312,21,'134','atmSubInterface'),(313,21,'135','l2vlan'),(314,21,'136','l3ipvlan'),(315,21,'137','l3ipxvlan'),(316,21,'138','digitalPowerline'),(317,21,'139','mediaMailOverIp'),(318,21,'140','dtm'),(319,21,'141','dcn'),(320,21,'142','ipForward'),(321,21,'143','msdsl'),(322,21,'144','ieee1394'),(323,21,'145','if-gsn'),(324,21,'146','dvbRccMacLayer'),(325,21,'147','dvbRccDownstream'),(326,21,'148','dvbRccUpstream'),(327,21,'149','atmVirtual'),(328,21,'150','mplsTunnel'),(329,21,'151','srp'),(330,21,'152','voiceOverAtm'),(331,21,'153','voiceOverFrameRelay'),(332,21,'154','idsl'),(333,21,'155','compositeLink'),(334,21,'156','ss7SigLink'),(335,21,'157','propWirelessP2P'),(336,21,'158','frForward'),(337,21,'159','rfc1483'),(338,21,'160','usb'),(339,21,'161','ieee8023adLag'),(340,21,'162','bgppolicyaccounting'),(341,21,'163','frf16MfrBundle'),(342,21,'164','h323Gatekeeper'),(343,21,'165','h323Proxy'),(344,21,'166','mpls'),(345,21,'167','mfSigLink'),(346,21,'168','hdsl2'),(347,21,'169','shdsl'),(348,21,'170','ds1FDL'),(349,21,'171','pos'),(350,21,'172','dvbAsiIn'),(351,21,'173','dvbAsiOut'),(352,21,'174','plc'),(353,21,'175','nfas'),(354,21,'176','tr008'),(355,21,'177','gr303RDT'),(356,21,'178','gr303IDT'),(357,21,'179','isup'),(358,21,'180','propDocsWirelessMaclayer'),(359,21,'181','propDocsWirelessDownstream'),(360,21,'182','propDocsWirelessUpstream'),(361,21,'183','hiperlan2'),(362,21,'184','propBWAp2Mp'),(363,21,'185','sonetOverheadChannel'),(364,21,'186','digitalWrapperOverheadChannel'),(365,21,'187','aal2'),(366,21,'188','radioMAC'),(367,21,'189','atmRadio'),(368,21,'190','imt'),(369,21,'191','mvl'),(370,21,'192','reachDSL'),(371,21,'193','frDlciEndPt'),(372,21,'194','atmVciEndPt'),(373,21,'195','opticalChannel'),(374,21,'196','opticalTransport'),(375,21,'197','propAtm'),(376,21,'198','voiceOverCable'),(377,21,'199','infiniband'),(378,21,'200','teLink'),(379,21,'201','q2931'),(380,21,'202','virtualTg'),(381,21,'203','sipTg'),(382,21,'204','sipSig'),(383,21,'205','docsCableUpstreamChannel'),(384,21,'206','econet'),(385,21,'207','pon155'),(386,21,'208','pon622'),(387,21,'209','bridge'),(388,21,'210','linegroup'),(389,21,'211','voiceEMFGD'),(390,21,'212','voiceFGDEANA'),(391,21,'213','voiceDID'),(392,21,'214','mpegTransport'),(393,21,'215','sixToFour'),(394,21,'216','gtp'),(395,21,'217','pdnEtherLoop1'),(396,21,'218','pdnEtherLoop2'),(397,21,'219','opticalChannelGroup'),(398,21,'220','homepna'),(399,21,'221','gfp'),(400,21,'222','ciscoISLvlan'),(401,21,'223','actelisMetaLOOP'),(402,21,'224','fcipLink'),(403,21,'225','rpr'),(404,21,'226','qam'),(405,21,'227','lmp'),(406,21,'228','cblVectaStar'),(407,21,'229','docsCableMCmtsDownstream'),(408,21,'230','adsl2'),(409,21,'231','macSecControlledIF'),(410,21,'232','macSecUncontrolledIF'),(411,21,'233','aviciOpticalEther'),(412,21,'234','atmbond'),(413,21,'235','voiceFGDOS'),(414,21,'236','mocaVersion1'),(415,21,'237','ieee80216WMAN'),(416,21,'238','adsl2plus'),(417,21,'239','dvbRcsMacLayer'),(418,21,'240','dvbTdm'),(419,21,'241','dvbRcsTdma'),(420,21,'242','x86Laps'),(421,21,'243','wwanPP'),(422,21,'244','wwanPP2'),(423,21,'245','voiceEBS'),(424,21,'246','ifPwType'),(425,21,'247','ilan'),(426,21,'248','pip'),(427,21,'249','aluELP'),(428,21,'250','gpon'),(429,21,'251','vdsl2'),(430,21,'252','capwapDot11Profile'),(431,21,'253','capwapDot11Bss'),(432,21,'254','capwapWtpVirtualRadio'),(433,21,'255','bits'),(434,21,'256','docsCableUpstreamRfPort'),(435,21,'257','cableDownstreamRfPort'),(436,21,'258','vmwareVirtualNic'),(437,21,'259','ieee802154'),(438,21,'260','otnOdu'),(439,21,'261','otnOtu'),(440,21,'262','ifVfiType'),(441,21,'263','g9981'),(442,21,'264','g9982'),(443,21,'265','g9983'),(444,21,'266','aluEpon'),(445,21,'267','aluEponOnu'),(446,21,'268','aluEponPhysicalUni'),(447,21,'269','aluEponLogicalLink'),(448,21,'270','aluGponOnu'),(449,21,'271','aluGponPhysicalUni'),(450,21,'272','vmwareNicTeam'),(451,21,'277','docsOfdmDownstream'),(452,21,'278','docsOfdmaUpstream'),(453,21,'279','gfast'),(454,21,'280','sdci'),(455,21,'281','xboxWireless'),(456,21,'282','fastdsl'),(457,21,'283','docsCableScte55d1FwdOob'),(458,21,'284','docsCableScte55d1RetOob'),(459,21,'285','docsCableScte55d2DsOob'),(460,21,'286','docsCableScte55d2UsOob'),(461,21,'287','docsCableNdf'),(462,21,'288','docsCableNdr'),(463,21,'289','ptm'),(464,21,'290','ghn'),(465,22,'0','not available'),(466,22,'1','available'),(467,22,'2','unknown'),(468,23,'1','deviceStateUnknown'),(469,23,'2','deviceNotEquipped'),(470,23,'3','deviceStateOk'),(471,23,'4','deviceStateFailed'),(472,23,'5','deviceStateOutOfService'),(473,24,'1','unknown'),(474,24,'2','faulty'),(475,24,'3','below-min'),(476,24,'4','nominal'),(477,24,'5','above-max'),(478,24,'6','absent'),(479,25,'1','online'),(480,25,'2','offline'),(481,25,'3','testing'),(482,25,'4','faulty'),(483,26,'1','other'),(484,26,'2','normal'),(485,26,'3','failure'),(486,27,'1','other'),(487,27,'2','normal'),(488,27,'3','failure'),(489,28,'1','normal'),(490,28,'2','warning'),(491,28,'3','critical'),(492,28,'4','shutdown'),(493,28,'5','notPresent'),(494,28,'6','notFunctioning'),(495,29,'1','true - on'),(496,29,'2','false - off'),(497,30,'1','up'),(498,30,'2','down'),(499,30,'3','absent'),(500,31,'1','up'),(501,31,'2','down'),(502,31,'3','absent'),(503,32,'1','noexist'),(504,32,'2','existnopower'),(505,32,'3','existreadypower'),(506,32,'4','normal'),(507,32,'5','powerbutabnormal'),(508,32,'6','unknown'),(509,33,'0','other'),(510,33,'1','working'),(511,33,'2','fail'),(512,33,'3','speed-0'),(513,33,'4','speed-low'),(514,33,'5','speed-middle'),(515,33,'6','speed-high'),(516,34,'0','other'),(517,34,'1','lowVoltage'),(518,34,'2','overCurrent'),(519,34,'3','working'),(520,34,'4','fail'),(521,34,'5','connect'),(522,34,'6','disconnect'),(523,35,'1','true'),(524,35,'2','false'),(525,36,'1','true - on'),(526,36,'2','false - off'),(527,37,'1','alarm'),(528,37,'2','normal'),(529,38,'1','notPresent'),(530,38,'2','presentOK'),(531,38,'3','presentNotOK'),(532,38,'4','presentPowerOff'),(533,39,'1','notSupported'),(534,39,'2','normal'),(535,39,'3','postFailure'),(536,39,'4','entityAbsent'),(543,39,'11','poeError'),(550,40,'1','unknown'),(551,40,'2','bad'),(552,40,'3','warning'),(553,40,'4','good'),(554,40,'5','notPresent'),(555,41,'1','normal'),(556,41,'2','abnormal'),(557,42,'1','online'),(558,42,'2','operational'),(559,42,'3','failed'),(560,42,'4','offline'),(561,43,'1','invalid'),(562,43,'2','bad'),(563,43,'3','warning'),(564,43,'4','good'),(565,43,'5','disabled'),(566,44,'1','unknown'),(567,44,'2','disabled'),(568,44,'3','failed'),(569,44,'4','warning'),(570,44,'5','standby'),(571,44,'6','engaged'),(572,44,'7','redundant'),(573,44,'8','notPresent'),(574,45,'1','normal'),(575,45,'2','high'),(576,45,'3','excessivelyHigh'),(577,45,'4','low'),(578,45,'5','excessivelyLow'),(579,45,'6','noSensor'),(580,45,'7','unknown'),(581,46,'1','other'),(582,46,'2','off'),(583,46,'3','on - RedAlarm'),(584,47,'1','unknown'),(585,47,'2','running'),(586,47,'3','ready'),(587,47,'4','reset'),(588,47,'5','runningAtFullSpeed'),(589,47,'6','down or off'),(590,47,'7','standby'),(591,48,'1','unknown'),(592,48,'2','disabled'),(593,48,'3','enabled'),(594,48,'4','testing'),(595,49,'1','operational'),(596,49,'2','failed'),(597,49,'3','powering'),(598,49,'4','notpowering'),(599,49,'5','notpresent'),(600,50,'1','operational'),(601,50,'2','failed'),(602,50,'3','powering'),(603,50,'4','notpowering'),(604,50,'5','notpresent'),(605,51,'1','normal'),(606,51,'2','warning'),(607,51,'3','critical'),(608,51,'4','shutdown'),(609,51,'5','notpresent'),(610,51,'6','notoperational'),(611,52,'0','normal'),(612,52,'1','abnormal'),(613,53,'0','normal'),(614,53,'1','abnormal'),(615,53,'2','not available'),(616,54,'1','other'),(617,54,'2','ok'),(618,54,'3','degraded'),(619,54,'4','failed'),(620,55,'1','other'),(621,55,'2','unknown'),(622,55,'3','system'),(623,55,'4','systemBoard'),(624,55,'5','ioBoard'),(625,55,'6','cpu'),(626,55,'7','memory'),(627,55,'8','storage'),(628,55,'9','removableMedia'),(629,55,'10','powerSupply'),(630,55,'11','ambient'),(631,55,'12','chassis'),(632,55,'13','bridgeCard'),(633,56,'1','other'),(634,56,'2','ida'),(635,56,'3','idaExpansion'),(636,56,'4','ida-2'),(637,56,'5','smart'),(638,56,'6','smart-2e'),(639,56,'7','smart-2p'),(640,56,'8','smart-2sl'),(641,56,'9','smart-3100es'),(642,56,'10','smart-3200'),(643,56,'11','smart-2dh'),(644,56,'12','smart-221'),(645,56,'13','sa-4250es'),(646,56,'14','sa-4200'),(647,56,'15','sa-integrated'),(648,56,'16','sa-431'),(649,56,'17','sa-5300'),(650,56,'18','raidLc2'),(651,56,'19','sa-5i'),(652,56,'20','sa-532'),(653,56,'21','sa-5312'),(654,56,'22','sa-641'),(655,56,'23','sa-642'),(656,56,'24','sa-6400'),(657,56,'25','sa-6400em'),(658,56,'26','sa-6i'),(659,56,'27','sa-generic'),(660,56,'29','sa-p600'),(661,56,'30','sa-p400'),(662,56,'31','sa-e200'),(663,56,'32','sa-e200i'),(664,56,'33','sa-p400i'),(665,56,'34','sa-p800'),(666,56,'35','sa-e500'),(667,56,'36','sa-p700m'),(668,56,'37','sa-p212'),(669,56,'38','sa-p410'),(670,56,'39','sa-p410i'),(671,56,'40','sa-p411'),(672,56,'41','sa-b110i'),(673,56,'42','sa-p712m'),(674,56,'43','sa-p711m'),(675,56,'44','sa-p812'),(676,57,'1','other'),(677,57,'2','ok'),(678,57,'3','failed'),(679,57,'4','predictiveFailure'),(680,58,'0','nonRecoverable'),(681,58,'2','critical'),(682,58,'4','nonCritical'),(683,58,'255','normal'),(684,59,'1','other'),(685,59,'2','unknown'),(686,59,'3','ok'),(687,59,'4','nonCritical'),(688,59,'5','critical'),(689,59,'6','nonRecoverable'),(690,60,'1','other'),(691,60,'2','unknown'),(692,60,'3','ok'),(693,60,'4','nonCriticalUpper'),(694,60,'5','criticalUpper'),(695,60,'6','nonRecoverableUpper'),(696,60,'7','nonCriticalLower'),(697,60,'8','criticalLower'),(698,60,'9','nonRecoverableLower'),(699,60,'10','failed'),(700,61,'1','other'),(701,61,'2','unknown'),(702,61,'3','ok'),(703,61,'4','nonCritical'),(704,61,'5','critical'),(705,61,'6','nonRecoverable'),(706,62,'0','ok'),(707,62,'1','failed'),(708,63,'1','Unknown'),(709,63,'2','HDD'),(710,63,'3','SSD'),(711,64,'1','Unknown'),(712,64,'2','Ready'),(713,64,'3','Failed'),(714,64,'4','Degraded'),(715,64,'5','Missing'),(716,64,'6','Charging'),(717,64,'7','Below threshold'),(718,65,'1','Other'),(719,65,'2','RAID-0'),(720,65,'3','RAID-1'),(721,65,'4','RAID-5'),(722,65,'5','RAID-6'),(723,65,'6','RAID-10'),(724,65,'7','RAID-50'),(725,65,'8','RAID-60'),(726,65,'9','Concatenated RAID 1'),(727,65,'10','Concatenated RAID 5'),(728,66,'1','Not applicable'),(729,66,'2','Reconstructing'),(730,66,'3','Resynching'),(731,66,'4','Initializing'),(732,66,'5','Background init'),(733,67,'1','Write Through'),(734,67,'2','Write Back'),(735,67,'3','Force Write Back'),(736,68,'1','No Read Ahead'),(737,68,'2','Read Ahead'),(738,68,'3','Adaptive Read Ahead'),(739,69,'1','Unknown'),(740,69,'2','Online'),(741,69,'3','Failed'),(742,69,'4','Degraded'),(743,70,'1','other'),(744,70,'2','ok'),(745,70,'3','replaceDrive'),(746,70,'4','replaceDriveSSDWearOut'),(747,71,'1','other'),(748,71,'2','invalid'),(749,71,'3','enabled'),(750,71,'4','tmpDisabled'),(751,71,'5','permDisabled'),(752,71,'6','cacheModFlashMemNotAttached'),(753,71,'7','cacheModDegradedFailsafeSpeed'),(754,71,'8','cacheModCriticalFailure'),(755,71,'9','cacheReadCacheNotMapped'),(756,72,'1','Other'),(757,72,'2','Ok'),(758,72,'3','Recharging'),(759,72,'4','Failed'),(760,72,'5','Degraded'),(761,72,'6','Not Present'),(762,72,'7','Capacitor failed'),(763,73,'1','Other'),(764,73,'2','rotatingPlatters'),(765,73,'3','solidState'),(766,74,'0','other'),(767,74,'2','none'),(768,74,'3','RAID-1/RAID-10'),(769,74,'4','RAID-4'),(770,74,'5','RAID-5'),(771,74,'7','RAID-6'),(772,74,'8','RAID-50'),(773,74,'9','RAID-60'),(774,74,'10','RAID-1 ADM'),(775,74,'11','RAID-10 ADM'),(776,75,'1','other'),(777,75,'2','ok'),(778,75,'3','failed'),(779,75,'4','unconfigured'),(780,75,'5','recovering'),(781,75,'6','readyForRebuild'),(782,75,'7','rebuilding'),(783,75,'8','wrongDrive'),(784,75,'9','badConnect'),(785,75,'10','overheating'),(786,75,'11','shutdown'),(787,75,'12','expanding'),(788,75,'13','notAvailable'),(789,75,'14','queuedForExpansion'),(790,75,'15','multipathAccessDegraded'),(791,75,'16','erasing'),(792,75,'17','predictiveSpareRebuildReady'),(793,75,'18','rapidParityInitInProgress'),(794,75,'19','rapidParityInitPending'),(795,75,'20','noAccessEncryptedNoCntlrKey'),(796,75,'21','unencryptedToEncryptedInProgress'),(797,75,'22','newLogDrvKeyRekeyInProgress'),(798,75,'23','noAccessEncryptedCntlrEncryptnNotEnbld'),(799,75,'24','unencryptedToEncryptedNotStarted'),(800,75,'25','newLogDrvKeyRekeyRequestReceived'),(801,56,'45','sw-1210m'),(802,56,'46','sa-p220i'),(803,56,'47','sa-p222'),(804,56,'48','sa-p420'),(805,56,'49','sa-p420i'),(806,56,'50','sa-p421'),(807,56,'51','sa-b320i'),(808,56,'52','sa-p822'),(809,56,'53','sa-p721m'),(810,56,'54','sa-b120i'),(811,56,'55','hps-1224'),(812,56,'56','hps-1228'),(813,56,'57','hps-1228m'),(814,56,'58','sa-p822se'),(815,56,'59','hps-1224e'),(816,56,'60','hps-1228e'),(817,56,'61','hps-1228em'),(818,56,'62','sa-p230i'),(819,56,'63','sa-p430i'),(820,56,'64','sa-p430'),(821,56,'65','sa-p431'),(822,56,'66','sa-p731m'),(823,56,'67','sa-p830i'),(824,56,'68','sa-p830'),(825,56,'69','sa-p831'),(826,56,'70','sa-p530'),(827,56,'71','sa-p531'),(828,56,'72','sa-p244br'),(829,56,'73','sa-p246br'),(830,56,'74','sa-p440'),(831,56,'75','sa-p440ar'),(832,56,'76','sa-p441'),(833,56,'77','sa-p741m'),(834,56,'78','sa-p840'),(835,56,'79','sa-p841'),(836,56,'80','sh-h240ar'),(837,56,'81','sh-h244br'),(838,56,'82','sh-h240'),(839,56,'83','sh-h241'),(840,56,'84','sa-b140i'),(841,56,'85','sh-generic'),(842,56,'88','sa-p840ar'),(843,39,'21','stackError'),(844,39,'22','stackPortBlocked'),(845,39,'23','stackPortFailed'),(846,39,'31','sfpRecvError'),(847,39,'32','sfpSendError'),(848,39,'33','sfpBothError'),(849,39,'41','fanError'),(850,39,'51','psuError'),(851,39,'61','rpsError'),(852,39,'71','moduleFaulty'),(853,39,'81','sensorError'),(854,39,'91','hardwareFaulty'),(855,76,'0','unknown'),(856,76,'1','operable'),(857,76,'2','inoperable'),(858,76,'3','degraded'),(859,76,'4','poweredOff'),(860,76,'5','powerProblem'),(861,76,'6','removed'),(862,76,'7','voltageProblem'),(863,76,'8','thermalProblem'),(864,76,'9','performanceProblem'),(865,76,'10','accessibilityProblem'),(866,76,'11','identityUnestablishable'),(867,76,'12','biosPostTimeout'),(868,76,'13','disabled'),(869,76,'14','malformedFru'),(870,76,'15','backplanePortProblem'),(871,76,'16','chassisIntrusion'),(872,76,'51','fabricConnProblem'),(873,76,'52','fabricUnsupportedConn'),(874,76,'81','config'),(875,76,'82','equipmentProblem'),(876,76,'83','decomissioning'),(877,76,'84','chassisLimitExceeded'),(878,76,'100','notSupported'),(879,76,'101','discovery'),(880,76,'102','discoveryFailed'),(881,76,'103','identify'),(882,76,'104','postFailure'),(883,76,'105','upgradeProblem'),(884,76,'106','peerCommProblem'),(885,76,'107','autoUpgrade'),(886,76,'108','linkActivateBlocked'),(887,77,'0','indeterminate'),(888,77,'1','unassociated'),(889,77,'10','ok'),(890,77,'11','discovery'),(891,77,'12','config'),(892,77,'13','unconfig'),(893,77,'14','powerOff'),(894,77,'15','restart'),(895,77,'20','maintenance'),(896,77,'21','test'),(897,77,'29','computeMismatch'),(898,77,'30','computeFailed'),(899,77,'31','degraded'),(900,77,'32','discoveryFailed'),(901,77,'33','configFailure'),(902,77,'34','unconfigFailed'),(903,77,'35','testFailed'),(904,77,'36','maintenanceFailed'),(905,77,'40','removed'),(906,77,'41','disabled'),(907,77,'50','inaccessible'),(908,77,'60','thermalProblem'),(909,77,'61','powerProblem'),(910,77,'62','voltageProblem'),(911,77,'63','inoperable'),(912,77,'101','decomissioning'),(913,77,'201','biosRestore'),(914,77,'202','cmosReset'),(915,77,'203','diagnostics'),(916,77,'204','diagnosticsFailed'),(917,77,'210','pendingReboot'),(918,77,'211','pendingReassociation'),(919,77,'212','svnicNotPresent'),(920,78,'0','unknown'),(921,78,'1','online'),(922,78,'2','unconfiguredGood'),(923,78,'3','globalHotSpare'),(924,78,'4','dedicatedHotSpare'),(925,78,'5','jbod'),(926,78,'6','offline'),(927,78,'7','rebuilding'),(928,78,'8','copyback'),(929,78,'9','failed'),(930,78,'10','unconfiguredBad'),(931,78,'11','predictiveFailure'),(932,78,'12','disabledForRemoval'),(933,78,'13','foreignConfiguration'),(934,78,'14','zeroing'),(935,78,'15','good'),(936,78,'16','bad'),(937,78,'17','lockedForeignConfiguration'),(938,79,'0','unspecified'),(939,79,'1','simple'),(940,79,'2','mirror'),(941,79,'3','stripe'),(942,79,'4','raid'),(943,79,'5','stripeParity'),(944,79,'6','stripeDualParity'),(945,79,'7','mirrorStripe'),(946,79,'8','stripeParityStripe'),(947,79,'9','stripeDualParityStripe'),(948,80,'0','unknown'),(949,80,'1','empty'),(950,80,'10','equipped'),(951,80,'11','missing'),(952,80,'12','mismatch'),(953,80,'13','equippedNotPrimary'),(954,80,'14','equippedSlave'),(955,80,'15','mismatchSlave'),(956,80,'16','missingSlave'),(957,80,'20','equippedIdentityUnestablishable'),(958,80,'21','mismatchIdentityUnestablishable'),(959,80,'22','equippedWithMalformedFru'),(960,80,'30','inaccessible'),(961,80,'40','unauthorized'),(962,80,'100','notSupported'),(963,80,'101','equippedUnsupported'),(964,80,'102','equippedDiscNotStarted'),(965,80,'103','equippedDiscInProgress'),(966,80,'104','equippedDiscError'),(967,80,'105','equippedDiscUnknown');
/*!40000 ALTER TABLE `mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `mediaid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `mediatypeid` bigint(20) unsigned NOT NULL,
  `sendto` varchar(1024) COLLATE utf8_bin NOT NULL DEFAULT '',
  `active` int(11) NOT NULL DEFAULT '0',
  `severity` int(11) NOT NULL DEFAULT '63',
  `period` varchar(1024) COLLATE utf8_bin NOT NULL DEFAULT '1-7,00:00-24:00',
  PRIMARY KEY (`mediaid`),
  KEY `media_1` (`userid`),
  KEY `media_2` (`mediatypeid`),
  CONSTRAINT `c_media_2` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`) ON DELETE CASCADE,
  CONSTRAINT `c_media_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_type`
--

DROP TABLE IF EXISTS `media_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_type` (
  `mediatypeid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `description` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `smtp_server` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `smtp_helo` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `smtp_email` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `exec_path` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `gsm_modem` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `username` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `passwd` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `smtp_port` int(11) NOT NULL DEFAULT '25',
  `smtp_security` int(11) NOT NULL DEFAULT '0',
  `smtp_verify_peer` int(11) NOT NULL DEFAULT '0',
  `smtp_verify_host` int(11) NOT NULL DEFAULT '0',
  `smtp_authentication` int(11) NOT NULL DEFAULT '0',
  `exec_params` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `maxsessions` int(11) NOT NULL DEFAULT '1',
  `maxattempts` int(11) NOT NULL DEFAULT '3',
  `attempt_interval` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '10s',
  PRIMARY KEY (`mediatypeid`),
  UNIQUE KEY `media_type_1` (`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_type`
--

LOCK TABLES `media_type` WRITE;
/*!40000 ALTER TABLE `media_type` DISABLE KEYS */;
INSERT INTO `media_type` VALUES (1,0,'Email','mail.example.com','example.com','zabbix@example.com','','','','',0,25,0,0,0,0,'',1,3,'10s'),(2,3,'Jabber','','','','','','jabber@example.com','zabbix',0,25,0,0,0,0,'',1,3,'10s'),(3,2,'SMS','','','','','/dev/ttyS0','','',0,25,0,0,0,0,'',1,3,'10s');
/*!40000 ALTER TABLE `media_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand`
--

DROP TABLE IF EXISTS `opcommand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opcommand` (
  `operationid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `scriptid` bigint(20) unsigned DEFAULT NULL,
  `execute_on` int(11) NOT NULL DEFAULT '0',
  `port` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `authtype` int(11) NOT NULL DEFAULT '0',
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `password` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `publickey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `privatekey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `command` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`operationid`),
  KEY `opcommand_1` (`scriptid`),
  CONSTRAINT `c_opcommand_2` FOREIGN KEY (`scriptid`) REFERENCES `scripts` (`scriptid`),
  CONSTRAINT `c_opcommand_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand`
--

LOCK TABLES `opcommand` WRITE;
/*!40000 ALTER TABLE `opcommand` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand_grp`
--

DROP TABLE IF EXISTS `opcommand_grp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opcommand_grp` (
  `opcommand_grpid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opcommand_grpid`),
  KEY `opcommand_grp_1` (`operationid`),
  KEY `opcommand_grp_2` (`groupid`),
  CONSTRAINT `c_opcommand_grp_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`),
  CONSTRAINT `c_opcommand_grp_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand_grp`
--

LOCK TABLES `opcommand_grp` WRITE;
/*!40000 ALTER TABLE `opcommand_grp` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand_grp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand_hst`
--

DROP TABLE IF EXISTS `opcommand_hst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opcommand_hst` (
  `opcommand_hstid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`opcommand_hstid`),
  KEY `opcommand_hst_1` (`operationid`),
  KEY `opcommand_hst_2` (`hostid`),
  CONSTRAINT `c_opcommand_hst_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`),
  CONSTRAINT `c_opcommand_hst_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand_hst`
--

LOCK TABLES `opcommand_hst` WRITE;
/*!40000 ALTER TABLE `opcommand_hst` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand_hst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opconditions`
--

DROP TABLE IF EXISTS `opconditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opconditions` (
  `opconditionid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `conditiontype` int(11) NOT NULL DEFAULT '0',
  `operator` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`opconditionid`),
  KEY `opconditions_1` (`operationid`),
  CONSTRAINT `c_opconditions_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opconditions`
--

LOCK TABLES `opconditions` WRITE;
/*!40000 ALTER TABLE `opconditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `opconditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operations`
--

DROP TABLE IF EXISTS `operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operations` (
  `operationid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `operationtype` int(11) NOT NULL DEFAULT '0',
  `esc_period` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `esc_step_from` int(11) NOT NULL DEFAULT '1',
  `esc_step_to` int(11) NOT NULL DEFAULT '1',
  `evaltype` int(11) NOT NULL DEFAULT '0',
  `recovery` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`operationid`),
  KEY `operations_1` (`actionid`),
  CONSTRAINT `c_operations_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operations`
--

LOCK TABLES `operations` WRITE;
/*!40000 ALTER TABLE `operations` DISABLE KEYS */;
INSERT INTO `operations` VALUES (1,2,6,'0',1,1,0,0),(2,2,4,'0',1,1,0,0),(3,3,0,'0',1,1,0,0),(4,4,0,'0',1,1,0,0),(5,5,0,'0',1,1,0,0),(6,6,0,'0',1,1,0,0),(7,3,11,'0',1,1,0,1),(8,4,11,'0',1,1,0,1),(9,5,11,'0',1,1,0,1),(10,6,11,'0',1,1,0,1);
/*!40000 ALTER TABLE `operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opgroup`
--

DROP TABLE IF EXISTS `opgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opgroup` (
  `opgroupid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opgroupid`),
  UNIQUE KEY `opgroup_1` (`operationid`,`groupid`),
  KEY `opgroup_2` (`groupid`),
  CONSTRAINT `c_opgroup_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`),
  CONSTRAINT `c_opgroup_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opgroup`
--

LOCK TABLES `opgroup` WRITE;
/*!40000 ALTER TABLE `opgroup` DISABLE KEYS */;
INSERT INTO `opgroup` VALUES (1,2,2);
/*!40000 ALTER TABLE `opgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opinventory`
--

DROP TABLE IF EXISTS `opinventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opinventory` (
  `operationid` bigint(20) unsigned NOT NULL,
  `inventory_mode` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`operationid`),
  CONSTRAINT `c_opinventory_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opinventory`
--

LOCK TABLES `opinventory` WRITE;
/*!40000 ALTER TABLE `opinventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `opinventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage`
--

DROP TABLE IF EXISTS `opmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opmessage` (
  `operationid` bigint(20) unsigned NOT NULL,
  `default_msg` int(11) NOT NULL DEFAULT '0',
  `subject` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `message` text COLLATE utf8_bin NOT NULL,
  `mediatypeid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`operationid`),
  KEY `opmessage_1` (`mediatypeid`),
  CONSTRAINT `c_opmessage_2` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`),
  CONSTRAINT `c_opmessage_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage`
--

LOCK TABLES `opmessage` WRITE;
/*!40000 ALTER TABLE `opmessage` DISABLE KEYS */;
INSERT INTO `opmessage` VALUES (3,1,'Problem: {EVENT.NAME}','Problem started at {EVENT.TIME} on {EVENT.DATE}\r\nProblem name: {EVENT.NAME}\r\nHost: {HOST.NAME}\r\nSeverity: {EVENT.SEVERITY}\r\n\r\nOriginal problem ID: {EVENT.ID}\r\n{TRIGGER.URL}',NULL),(4,1,'','',NULL),(5,1,'','',NULL),(6,1,'','',NULL),(7,1,'Resolved: {EVENT.NAME}','Problem has been resolved at {EVENT.RECOVERY.TIME} on {EVENT.RECOVERY.DATE}\r\nProblem name: {EVENT.NAME}\r\nHost: {HOST.NAME}\r\nSeverity: {EVENT.SEVERITY}\r\n\r\nOriginal problem ID: {EVENT.ID}\r\n{TRIGGER.URL}',NULL),(8,1,'{ITEM.STATE}: {HOST.NAME}:{ITEM.NAME}','Host: {HOST.NAME}\r\nItem: {ITEM.NAME}\r\nKey: {ITEM.KEY}\r\nState: {ITEM.STATE}',NULL),(9,1,'{LLDRULE.STATE}: {HOST.NAME}:{LLDRULE.NAME}','Host: {HOST.NAME}\r\nLow level discovery rule: {LLDRULE.NAME}\r\nKey: {LLDRULE.KEY}\r\nState: {LLDRULE.STATE}',NULL),(10,1,'{TRIGGER.STATE}: {TRIGGER.NAME}','Trigger name: {TRIGGER.NAME}\r\nExpression: {TRIGGER.EXPRESSION}\r\nState: {TRIGGER.STATE}',NULL);
/*!40000 ALTER TABLE `opmessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage_grp`
--

DROP TABLE IF EXISTS `opmessage_grp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opmessage_grp` (
  `opmessage_grpid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opmessage_grpid`),
  UNIQUE KEY `opmessage_grp_1` (`operationid`,`usrgrpid`),
  KEY `opmessage_grp_2` (`usrgrpid`),
  CONSTRAINT `c_opmessage_grp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`),
  CONSTRAINT `c_opmessage_grp_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage_grp`
--

LOCK TABLES `opmessage_grp` WRITE;
/*!40000 ALTER TABLE `opmessage_grp` DISABLE KEYS */;
INSERT INTO `opmessage_grp` VALUES (1,3,7),(2,4,7),(3,5,7),(4,6,7);
/*!40000 ALTER TABLE `opmessage_grp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage_usr`
--

DROP TABLE IF EXISTS `opmessage_usr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opmessage_usr` (
  `opmessage_usrid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opmessage_usrid`),
  UNIQUE KEY `opmessage_usr_1` (`operationid`,`userid`),
  KEY `opmessage_usr_2` (`userid`),
  CONSTRAINT `c_opmessage_usr_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`),
  CONSTRAINT `c_opmessage_usr_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage_usr`
--

LOCK TABLES `opmessage_usr` WRITE;
/*!40000 ALTER TABLE `opmessage_usr` DISABLE KEYS */;
/*!40000 ALTER TABLE `opmessage_usr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `optemplate`
--

DROP TABLE IF EXISTS `optemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `optemplate` (
  `optemplateid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`optemplateid`),
  UNIQUE KEY `optemplate_1` (`operationid`,`templateid`),
  KEY `optemplate_2` (`templateid`),
  CONSTRAINT `c_optemplate_2` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`),
  CONSTRAINT `c_optemplate_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optemplate`
--

LOCK TABLES `optemplate` WRITE;
/*!40000 ALTER TABLE `optemplate` DISABLE KEYS */;
INSERT INTO `optemplate` VALUES (1,1,10001);
/*!40000 ALTER TABLE `optemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `problem`
--

DROP TABLE IF EXISTS `problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `problem` (
  `eventid` bigint(20) unsigned NOT NULL,
  `source` int(11) NOT NULL DEFAULT '0',
  `object` int(11) NOT NULL DEFAULT '0',
  `objectid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `clock` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  `r_eventid` bigint(20) unsigned DEFAULT NULL,
  `r_clock` int(11) NOT NULL DEFAULT '0',
  `r_ns` int(11) NOT NULL DEFAULT '0',
  `correlationid` bigint(20) unsigned DEFAULT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `acknowledged` int(11) NOT NULL DEFAULT '0',
  `severity` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`eventid`),
  KEY `problem_1` (`source`,`object`,`objectid`),
  KEY `problem_2` (`r_clock`),
  KEY `problem_3` (`r_eventid`),
  CONSTRAINT `c_problem_2` FOREIGN KEY (`r_eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_problem_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `problem`
--

LOCK TABLES `problem` WRITE;
/*!40000 ALTER TABLE `problem` DISABLE KEYS */;
/*!40000 ALTER TABLE `problem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `problem_tag`
--

DROP TABLE IF EXISTS `problem_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `problem_tag` (
  `problemtagid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`problemtagid`),
  KEY `problem_tag_1` (`eventid`,`tag`,`value`),
  CONSTRAINT `c_problem_tag_1` FOREIGN KEY (`eventid`) REFERENCES `problem` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `problem_tag`
--

LOCK TABLES `problem_tag` WRITE;
/*!40000 ALTER TABLE `problem_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `problem_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `profileid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `idx` varchar(96) COLLATE utf8_bin NOT NULL DEFAULT '',
  `idx2` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_int` int(11) NOT NULL DEFAULT '0',
  `value_str` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `source` varchar(96) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`profileid`),
  KEY `profiles_1` (`userid`,`idx`,`idx2`),
  KEY `profiles_2` (`userid`,`profileid`),
  CONSTRAINT `c_profiles_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_autoreg_host`
--

DROP TABLE IF EXISTS `proxy_autoreg_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxy_autoreg_host` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clock` int(11) NOT NULL DEFAULT '0',
  `host` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `listen_ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `listen_port` int(11) NOT NULL DEFAULT '0',
  `listen_dns` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `host_metadata` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `proxy_autoreg_host_1` (`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_autoreg_host`
--

LOCK TABLES `proxy_autoreg_host` WRITE;
/*!40000 ALTER TABLE `proxy_autoreg_host` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_autoreg_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_dhistory`
--

DROP TABLE IF EXISTS `proxy_dhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxy_dhistory` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clock` int(11) NOT NULL DEFAULT '0',
  `druleid` bigint(20) unsigned NOT NULL,
  `ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `dcheckid` bigint(20) unsigned DEFAULT NULL,
  `dns` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `proxy_dhistory_1` (`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_dhistory`
--

LOCK TABLES `proxy_dhistory` WRITE;
/*!40000 ALTER TABLE `proxy_dhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_dhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_history`
--

DROP TABLE IF EXISTS `proxy_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxy_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `source` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `severity` int(11) NOT NULL DEFAULT '0',
  `value` longtext COLLATE utf8_bin NOT NULL,
  `logeventid` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `lastlogsize` bigint(20) unsigned NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `proxy_history_1` (`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_history`
--

LOCK TABLES `proxy_history` WRITE;
/*!40000 ALTER TABLE `proxy_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regexps`
--

DROP TABLE IF EXISTS `regexps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regexps` (
  `regexpid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `test_string` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`regexpid`),
  UNIQUE KEY `regexps_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regexps`
--

LOCK TABLES `regexps` WRITE;
/*!40000 ALTER TABLE `regexps` DISABLE KEYS */;
INSERT INTO `regexps` VALUES (1,'File systems for discovery','ext3'),(2,'Network interfaces for discovery','eth0'),(3,'Storage devices for SNMP discovery','/boot'),(4,'Windows service names for discovery','SysmonLog'),(5,'Windows service startup states for discovery','automatic');
/*!40000 ALTER TABLE `regexps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rights`
--

DROP TABLE IF EXISTS `rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rights` (
  `rightid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '0',
  `id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`rightid`),
  KEY `rights_1` (`groupid`),
  KEY `rights_2` (`id`),
  CONSTRAINT `c_rights_2` FOREIGN KEY (`id`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE,
  CONSTRAINT `c_rights_1` FOREIGN KEY (`groupid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rights`
--

LOCK TABLES `rights` WRITE;
/*!40000 ALTER TABLE `rights` DISABLE KEYS */;
/*!40000 ALTER TABLE `rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screen_user`
--

DROP TABLE IF EXISTS `screen_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screen_user` (
  `screenuserid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`screenuserid`),
  UNIQUE KEY `screen_user_1` (`screenid`,`userid`),
  KEY `c_screen_user_2` (`userid`),
  CONSTRAINT `c_screen_user_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_screen_user_1` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screen_user`
--

LOCK TABLES `screen_user` WRITE;
/*!40000 ALTER TABLE `screen_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `screen_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screen_usrgrp`
--

DROP TABLE IF EXISTS `screen_usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screen_usrgrp` (
  `screenusrgrpid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`screenusrgrpid`),
  UNIQUE KEY `screen_usrgrp_1` (`screenid`,`usrgrpid`),
  KEY `c_screen_usrgrp_2` (`usrgrpid`),
  CONSTRAINT `c_screen_usrgrp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE,
  CONSTRAINT `c_screen_usrgrp_1` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screen_usrgrp`
--

LOCK TABLES `screen_usrgrp` WRITE;
/*!40000 ALTER TABLE `screen_usrgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `screen_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screens`
--

DROP TABLE IF EXISTS `screens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screens` (
  `screenid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `hsize` int(11) NOT NULL DEFAULT '1',
  `vsize` int(11) NOT NULL DEFAULT '1',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  `private` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`screenid`),
  KEY `screens_1` (`templateid`),
  KEY `c_screens_3` (`userid`),
  CONSTRAINT `c_screens_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`),
  CONSTRAINT `c_screens_1` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screens`
--

LOCK TABLES `screens` WRITE;
/*!40000 ALTER TABLE `screens` DISABLE KEYS */;
INSERT INTO `screens` VALUES (3,'System performance',2,3,10001,NULL,0),(4,'Zabbix server health',2,3,10047,NULL,0),(5,'System performance',2,2,10076,NULL,0),(6,'System performance',2,2,10077,NULL,0),(7,'System performance',2,2,10075,NULL,0),(9,'System performance',2,3,10074,NULL,0),(10,'System performance',2,3,10078,NULL,0),(16,'Zabbix server',2,2,NULL,1,0),(17,'Zabbix proxy health',2,2,10048,NULL,0),(18,'System performance',1,2,10079,NULL,0),(19,'System performance',2,2,10081,NULL,0),(20,'MySQL performance',2,1,10170,NULL,1),(21,'Zabbix server health',2,3,10261,NULL,1),(22,'Zabbix proxy health',2,2,10262,NULL,1),(23,'System performance',2,3,10185,NULL,1),(24,'Network interfaces',1,1,10192,NULL,1),(25,'System performance',2,3,10184,NULL,1);
/*!40000 ALTER TABLE `screens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screens_items`
--

DROP TABLE IF EXISTS `screens_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screens_items` (
  `screenitemid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `resourcetype` int(11) NOT NULL DEFAULT '0',
  `resourceid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `width` int(11) NOT NULL DEFAULT '320',
  `height` int(11) NOT NULL DEFAULT '200',
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `colspan` int(11) NOT NULL DEFAULT '1',
  `rowspan` int(11) NOT NULL DEFAULT '1',
  `elements` int(11) NOT NULL DEFAULT '25',
  `valign` int(11) NOT NULL DEFAULT '0',
  `halign` int(11) NOT NULL DEFAULT '0',
  `style` int(11) NOT NULL DEFAULT '0',
  `url` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `dynamic` int(11) NOT NULL DEFAULT '0',
  `sort_triggers` int(11) NOT NULL DEFAULT '0',
  `application` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `max_columns` int(11) NOT NULL DEFAULT '3',
  PRIMARY KEY (`screenitemid`),
  KEY `screens_items_1` (`screenid`),
  CONSTRAINT `c_screens_items_1` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screens_items`
--

LOCK TABLES `screens_items` WRITE;
/*!40000 ALTER TABLE `screens_items` DISABLE KEYS */;
INSERT INTO `screens_items` VALUES (44,16,2,1,500,100,0,0,2,1,0,0,0,0,'',0,0,'',3),(45,16,0,524,400,156,0,1,1,1,0,0,0,0,'',0,0,'',3),(46,16,0,525,400,100,1,1,1,1,0,0,0,0,'',0,0,'',3),(717,22,0,806,500,212,0,0,1,1,0,1,0,0,'',0,0,'',3),(718,22,0,804,500,100,1,0,1,1,0,1,0,0,'',0,0,'',3),(719,22,0,805,500,100,0,1,1,1,0,1,0,0,'',0,0,'',3),(720,22,0,803,500,128,1,1,1,1,0,1,0,0,'',0,0,'',3),(721,21,0,802,500,212,0,0,1,1,0,1,0,0,'',0,0,'',3),(722,21,0,799,500,100,1,0,1,1,0,0,0,0,'',0,0,'',3),(723,21,0,800,555,114,0,1,1,1,0,1,0,0,'',0,0,'',3),(724,21,0,798,500,128,1,1,1,1,0,1,0,0,'',0,0,'',3),(725,21,0,797,500,160,0,2,1,1,0,0,0,0,'',0,0,'',3),(726,21,0,801,500,160,1,2,1,1,0,0,0,0,'',0,0,'',3),(727,17,0,532,500,212,0,0,1,1,0,1,0,0,'',0,0,'',3),(728,17,0,530,500,100,1,0,1,1,0,1,0,0,'',0,0,'',3),(729,17,0,531,500,100,0,1,1,1,0,1,0,0,'',0,0,'',3),(730,17,0,529,500,128,1,1,1,1,0,1,0,0,'',0,0,'',3),(731,4,0,392,500,212,0,0,1,1,0,1,0,0,'',0,0,'',3),(732,4,0,404,500,100,1,0,1,1,0,1,0,0,'',0,0,'',3),(733,4,0,406,555,114,0,1,1,1,0,1,0,0,'',0,0,'',3),(734,4,0,410,500,128,1,1,1,1,0,1,0,0,'',0,0,'',3),(735,4,0,527,500,160,0,2,1,1,0,0,0,0,'',0,0,'',3),(736,4,0,788,500,160,1,2,1,1,0,0,0,0,'',0,0,'',3),(737,20,0,650,500,200,0,0,1,1,0,1,0,0,'',0,0,'',3),(738,20,0,649,500,270,1,0,1,1,0,1,0,0,'',0,0,'',3),(739,5,0,469,500,148,0,0,1,1,0,1,0,0,'',0,0,'',3),(740,5,0,471,500,100,1,0,1,1,0,0,0,0,'',0,0,'',3),(741,5,0,498,500,100,0,1,1,1,0,0,0,0,'',0,0,'',3),(742,5,0,540,500,100,1,1,1,1,0,0,0,0,'',0,0,'',3),(743,7,0,463,500,120,0,0,1,1,0,1,0,0,'',0,0,'',3),(744,7,0,462,500,106,1,0,1,1,0,1,0,0,'',0,0,'',3),(745,7,0,541,500,100,0,1,1,1,0,0,0,0,'',0,0,'',3),(746,7,0,464,500,300,1,1,1,1,0,0,0,0,'',0,0,'',3),(747,6,0,475,500,114,0,0,1,1,0,1,0,0,'',0,0,'',3),(748,6,0,474,500,100,1,0,1,1,0,1,0,0,'',0,0,'',3),(749,6,0,542,500,100,0,1,1,1,0,0,0,0,'',0,0,'',3),(750,3,0,433,500,120,0,0,1,1,0,1,0,0,'',0,0,'',3),(751,3,0,387,500,148,1,0,1,1,0,1,0,0,'',0,0,'',3),(752,3,0,533,500,100,0,1,1,1,0,0,0,0,'',0,0,'',3),(753,3,0,436,500,300,1,1,1,1,0,0,0,0,'',0,0,'',3),(754,3,1,10009,500,100,0,2,1,1,0,0,0,0,'',0,0,'',3),(755,3,1,10013,500,100,1,2,1,1,0,0,0,0,'',0,0,'',3),(756,18,0,487,500,100,0,0,1,1,0,0,0,0,'',0,0,'',3),(757,18,0,543,500,100,0,1,1,1,0,0,0,0,'',0,0,'',3),(758,9,0,457,500,120,0,0,1,1,0,1,0,0,'',0,0,'',3),(759,9,0,456,500,106,1,0,1,1,0,1,0,0,'',0,0,'',3),(760,9,0,544,500,100,0,1,1,1,0,0,0,0,'',0,0,'',3),(761,9,0,458,500,300,1,1,1,1,0,0,0,0,'',0,0,'',3),(762,9,1,22838,500,100,0,2,1,1,0,0,0,0,'',0,0,'',3),(763,9,1,22837,500,100,1,2,1,1,0,0,0,0,'',0,0,'',3),(764,10,0,481,500,114,0,0,1,1,0,1,0,0,'',0,0,'',3),(765,10,0,480,500,100,1,0,1,1,0,1,0,0,'',0,0,'',3),(766,10,0,545,500,100,0,1,1,1,0,0,0,0,'',0,0,'',3),(767,10,0,482,500,300,1,1,1,1,0,0,0,0,'',0,0,'',3),(768,10,1,22998,500,100,0,2,1,1,0,0,0,0,'',0,0,'',3),(769,10,1,22997,500,100,1,2,1,1,0,0,0,0,'',0,0,'',3),(770,19,0,495,500,100,0,0,1,1,0,0,0,0,'',0,0,'',3),(771,19,0,546,500,100,1,0,1,1,0,0,0,0,'',0,0,'',3),(772,19,1,23140,500,100,0,1,1,1,0,0,0,0,'',0,0,'',3),(773,19,1,23138,500,100,1,1,1,1,0,0,0,0,'',0,0,'',3),(774,25,0,832,750,100,0,0,1,1,25,0,0,0,'',0,0,'',3),(775,25,20,830,750,100,0,1,1,1,25,0,0,0,'',0,0,'',3),(776,25,20,828,750,100,0,2,1,1,25,0,0,0,'',0,0,'',3),(777,23,0,822,750,100,0,0,1,1,25,0,0,0,'',0,0,'',3),(778,23,20,816,750,100,0,1,1,1,25,0,0,0,'',0,0,'',3),(779,23,20,810,750,100,0,2,1,1,25,0,0,0,'',0,0,'',3),(780,24,20,766,750,100,0,0,1,1,25,0,0,0,'',0,0,'',3);
/*!40000 ALTER TABLE `screens_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scripts`
--

DROP TABLE IF EXISTS `scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scripts` (
  `scriptid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `command` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `host_access` int(11) NOT NULL DEFAULT '2',
  `usrgrpid` bigint(20) unsigned DEFAULT NULL,
  `groupid` bigint(20) unsigned DEFAULT NULL,
  `description` text COLLATE utf8_bin NOT NULL,
  `confirmation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT '0',
  `execute_on` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`scriptid`),
  UNIQUE KEY `scripts_3` (`name`),
  KEY `scripts_1` (`usrgrpid`),
  KEY `scripts_2` (`groupid`),
  CONSTRAINT `c_scripts_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`),
  CONSTRAINT `c_scripts_1` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scripts`
--

LOCK TABLES `scripts` WRITE;
/*!40000 ALTER TABLE `scripts` DISABLE KEYS */;
INSERT INTO `scripts` VALUES (1,'Ping','ping -c 3 {HOST.CONN}; case $? in [01]) true;; *) false;; esac',2,NULL,NULL,'','',0,2),(2,'Traceroute','/bin/traceroute {HOST.CONN}',2,NULL,NULL,'','',0,2),(3,'Detect operating system','sudo /usr/bin/nmap -O {HOST.CONN}',2,7,NULL,'','',0,2);
/*!40000 ALTER TABLE `scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_alarms`
--

DROP TABLE IF EXISTS `service_alarms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_alarms` (
  `servicealarmid` bigint(20) unsigned NOT NULL,
  `serviceid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`servicealarmid`),
  KEY `service_alarms_1` (`serviceid`,`clock`),
  KEY `service_alarms_2` (`clock`),
  CONSTRAINT `c_service_alarms_1` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_alarms`
--

LOCK TABLES `service_alarms` WRITE;
/*!40000 ALTER TABLE `service_alarms` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_alarms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `serviceid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `algorithm` int(11) NOT NULL DEFAULT '0',
  `triggerid` bigint(20) unsigned DEFAULT NULL,
  `showsla` int(11) NOT NULL DEFAULT '0',
  `goodsla` double(16,4) NOT NULL DEFAULT '99.9000',
  `sortorder` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`serviceid`),
  KEY `services_1` (`triggerid`),
  CONSTRAINT `c_services_1` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_links`
--

DROP TABLE IF EXISTS `services_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_links` (
  `linkid` bigint(20) unsigned NOT NULL,
  `serviceupid` bigint(20) unsigned NOT NULL,
  `servicedownid` bigint(20) unsigned NOT NULL,
  `soft` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`linkid`),
  UNIQUE KEY `services_links_2` (`serviceupid`,`servicedownid`),
  KEY `services_links_1` (`servicedownid`),
  CONSTRAINT `c_services_links_2` FOREIGN KEY (`servicedownid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE,
  CONSTRAINT `c_services_links_1` FOREIGN KEY (`serviceupid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_links`
--

LOCK TABLES `services_links` WRITE;
/*!40000 ALTER TABLE `services_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `services_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_times`
--

DROP TABLE IF EXISTS `services_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_times` (
  `timeid` bigint(20) unsigned NOT NULL,
  `serviceid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `ts_from` int(11) NOT NULL DEFAULT '0',
  `ts_to` int(11) NOT NULL DEFAULT '0',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`timeid`),
  KEY `services_times_1` (`serviceid`,`type`,`ts_from`,`ts_to`),
  CONSTRAINT `c_services_times_1` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_times`
--

LOCK TABLES `services_times` WRITE;
/*!40000 ALTER TABLE `services_times` DISABLE KEYS */;
/*!40000 ALTER TABLE `services_times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `sessionid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `userid` bigint(20) unsigned NOT NULL,
  `lastaccess` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sessionid`),
  KEY `sessions_1` (`userid`,`status`,`lastaccess`),
  CONSTRAINT `c_sessions_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slides`
--

DROP TABLE IF EXISTS `slides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slides` (
  `slideid` bigint(20) unsigned NOT NULL,
  `slideshowid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `step` int(11) NOT NULL DEFAULT '0',
  `delay` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '0',
  PRIMARY KEY (`slideid`),
  KEY `slides_1` (`slideshowid`),
  KEY `slides_2` (`screenid`),
  CONSTRAINT `c_slides_2` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE,
  CONSTRAINT `c_slides_1` FOREIGN KEY (`slideshowid`) REFERENCES `slideshows` (`slideshowid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slides`
--

LOCK TABLES `slides` WRITE;
/*!40000 ALTER TABLE `slides` DISABLE KEYS */;
/*!40000 ALTER TABLE `slides` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slideshow_user`
--

DROP TABLE IF EXISTS `slideshow_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slideshow_user` (
  `slideshowuserid` bigint(20) unsigned NOT NULL,
  `slideshowid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`slideshowuserid`),
  UNIQUE KEY `slideshow_user_1` (`slideshowid`,`userid`),
  KEY `c_slideshow_user_2` (`userid`),
  CONSTRAINT `c_slideshow_user_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_slideshow_user_1` FOREIGN KEY (`slideshowid`) REFERENCES `slideshows` (`slideshowid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slideshow_user`
--

LOCK TABLES `slideshow_user` WRITE;
/*!40000 ALTER TABLE `slideshow_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `slideshow_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slideshow_usrgrp`
--

DROP TABLE IF EXISTS `slideshow_usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slideshow_usrgrp` (
  `slideshowusrgrpid` bigint(20) unsigned NOT NULL,
  `slideshowid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`slideshowusrgrpid`),
  UNIQUE KEY `slideshow_usrgrp_1` (`slideshowid`,`usrgrpid`),
  KEY `c_slideshow_usrgrp_2` (`usrgrpid`),
  CONSTRAINT `c_slideshow_usrgrp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE,
  CONSTRAINT `c_slideshow_usrgrp_1` FOREIGN KEY (`slideshowid`) REFERENCES `slideshows` (`slideshowid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slideshow_usrgrp`
--

LOCK TABLES `slideshow_usrgrp` WRITE;
/*!40000 ALTER TABLE `slideshow_usrgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `slideshow_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slideshows`
--

DROP TABLE IF EXISTS `slideshows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slideshows` (
  `slideshowid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `delay` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '30s',
  `userid` bigint(20) unsigned NOT NULL,
  `private` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`slideshowid`),
  UNIQUE KEY `slideshows_1` (`name`),
  KEY `c_slideshows_3` (`userid`),
  CONSTRAINT `c_slideshows_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slideshows`
--

LOCK TABLES `slideshows` WRITE;
/*!40000 ALTER TABLE `slideshows` DISABLE KEYS */;
/*!40000 ALTER TABLE `slideshows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_element_trigger`
--

DROP TABLE IF EXISTS `sysmap_element_trigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_element_trigger` (
  `selement_triggerid` bigint(20) unsigned NOT NULL,
  `selementid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`selement_triggerid`),
  UNIQUE KEY `sysmap_element_trigger_1` (`selementid`,`triggerid`),
  KEY `c_sysmap_element_trigger_2` (`triggerid`),
  CONSTRAINT `c_sysmap_element_trigger_2` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmap_element_trigger_1` FOREIGN KEY (`selementid`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_element_trigger`
--

LOCK TABLES `sysmap_element_trigger` WRITE;
/*!40000 ALTER TABLE `sysmap_element_trigger` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_element_trigger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_element_url`
--

DROP TABLE IF EXISTS `sysmap_element_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_element_url` (
  `sysmapelementurlid` bigint(20) unsigned NOT NULL,
  `selementid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `url` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`sysmapelementurlid`),
  UNIQUE KEY `sysmap_element_url_1` (`selementid`,`name`),
  CONSTRAINT `c_sysmap_element_url_1` FOREIGN KEY (`selementid`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_element_url`
--

LOCK TABLES `sysmap_element_url` WRITE;
/*!40000 ALTER TABLE `sysmap_element_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_element_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_shape`
--

DROP TABLE IF EXISTS `sysmap_shape`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_shape` (
  `sysmap_shapeid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `width` int(11) NOT NULL DEFAULT '200',
  `height` int(11) NOT NULL DEFAULT '200',
  `text` text COLLATE utf8_bin NOT NULL,
  `font` int(11) NOT NULL DEFAULT '9',
  `font_size` int(11) NOT NULL DEFAULT '11',
  `font_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '000000',
  `text_halign` int(11) NOT NULL DEFAULT '0',
  `text_valign` int(11) NOT NULL DEFAULT '0',
  `border_type` int(11) NOT NULL DEFAULT '0',
  `border_width` int(11) NOT NULL DEFAULT '1',
  `border_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '000000',
  `background_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `zindex` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sysmap_shapeid`),
  KEY `sysmap_shape_1` (`sysmapid`),
  CONSTRAINT `c_sysmap_shape_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_shape`
--

LOCK TABLES `sysmap_shape` WRITE;
/*!40000 ALTER TABLE `sysmap_shape` DISABLE KEYS */;
INSERT INTO `sysmap_shape` VALUES (1,1,0,0,0,680,15,'{MAP.NAME}',9,11,'000000',0,0,0,0,'000000','',0);
/*!40000 ALTER TABLE `sysmap_shape` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_url`
--

DROP TABLE IF EXISTS `sysmap_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_url` (
  `sysmapurlid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `url` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `elementtype` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sysmapurlid`),
  UNIQUE KEY `sysmap_url_1` (`sysmapid`,`name`),
  CONSTRAINT `c_sysmap_url_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_url`
--

LOCK TABLES `sysmap_url` WRITE;
/*!40000 ALTER TABLE `sysmap_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_user`
--

DROP TABLE IF EXISTS `sysmap_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_user` (
  `sysmapuserid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`sysmapuserid`),
  UNIQUE KEY `sysmap_user_1` (`sysmapid`,`userid`),
  KEY `c_sysmap_user_2` (`userid`),
  CONSTRAINT `c_sysmap_user_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmap_user_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_user`
--

LOCK TABLES `sysmap_user` WRITE;
/*!40000 ALTER TABLE `sysmap_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_usrgrp`
--

DROP TABLE IF EXISTS `sysmap_usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_usrgrp` (
  `sysmapusrgrpid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`sysmapusrgrpid`),
  UNIQUE KEY `sysmap_usrgrp_1` (`sysmapid`,`usrgrpid`),
  KEY `c_sysmap_usrgrp_2` (`usrgrpid`),
  CONSTRAINT `c_sysmap_usrgrp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmap_usrgrp_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_usrgrp`
--

LOCK TABLES `sysmap_usrgrp` WRITE;
/*!40000 ALTER TABLE `sysmap_usrgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps`
--

DROP TABLE IF EXISTS `sysmaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps` (
  `sysmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `width` int(11) NOT NULL DEFAULT '600',
  `height` int(11) NOT NULL DEFAULT '400',
  `backgroundid` bigint(20) unsigned DEFAULT NULL,
  `label_type` int(11) NOT NULL DEFAULT '2',
  `label_location` int(11) NOT NULL DEFAULT '0',
  `highlight` int(11) NOT NULL DEFAULT '1',
  `expandproblem` int(11) NOT NULL DEFAULT '1',
  `markelements` int(11) NOT NULL DEFAULT '0',
  `show_unack` int(11) NOT NULL DEFAULT '0',
  `grid_size` int(11) NOT NULL DEFAULT '50',
  `grid_show` int(11) NOT NULL DEFAULT '1',
  `grid_align` int(11) NOT NULL DEFAULT '1',
  `label_format` int(11) NOT NULL DEFAULT '0',
  `label_type_host` int(11) NOT NULL DEFAULT '2',
  `label_type_hostgroup` int(11) NOT NULL DEFAULT '2',
  `label_type_trigger` int(11) NOT NULL DEFAULT '2',
  `label_type_map` int(11) NOT NULL DEFAULT '2',
  `label_type_image` int(11) NOT NULL DEFAULT '2',
  `label_string_host` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label_string_hostgroup` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label_string_trigger` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label_string_map` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label_string_image` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `iconmapid` bigint(20) unsigned DEFAULT NULL,
  `expand_macros` int(11) NOT NULL DEFAULT '0',
  `severity_min` int(11) NOT NULL DEFAULT '0',
  `userid` bigint(20) unsigned NOT NULL,
  `private` int(11) NOT NULL DEFAULT '1',
  `show_suppressed` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sysmapid`),
  UNIQUE KEY `sysmaps_1` (`name`),
  KEY `sysmaps_2` (`backgroundid`),
  KEY `sysmaps_3` (`iconmapid`),
  KEY `c_sysmaps_3` (`userid`),
  CONSTRAINT `c_sysmaps_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`),
  CONSTRAINT `c_sysmaps_1` FOREIGN KEY (`backgroundid`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_2` FOREIGN KEY (`iconmapid`) REFERENCES `icon_map` (`iconmapid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps`
--

LOCK TABLES `sysmaps` WRITE;
/*!40000 ALTER TABLE `sysmaps` DISABLE KEYS */;
INSERT INTO `sysmaps` VALUES (1,'Local network',680,200,NULL,0,0,1,1,1,0,50,1,1,0,2,2,2,2,2,'','','','','',NULL,1,0,1,0,0);
/*!40000 ALTER TABLE `sysmaps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_elements`
--

DROP TABLE IF EXISTS `sysmaps_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps_elements` (
  `selementid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `elementid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `elementtype` int(11) NOT NULL DEFAULT '0',
  `iconid_off` bigint(20) unsigned DEFAULT NULL,
  `iconid_on` bigint(20) unsigned DEFAULT NULL,
  `label` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label_location` int(11) NOT NULL DEFAULT '-1',
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `iconid_disabled` bigint(20) unsigned DEFAULT NULL,
  `iconid_maintenance` bigint(20) unsigned DEFAULT NULL,
  `elementsubtype` int(11) NOT NULL DEFAULT '0',
  `areatype` int(11) NOT NULL DEFAULT '0',
  `width` int(11) NOT NULL DEFAULT '200',
  `height` int(11) NOT NULL DEFAULT '200',
  `viewtype` int(11) NOT NULL DEFAULT '0',
  `use_iconmap` int(11) NOT NULL DEFAULT '1',
  `application` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`selementid`),
  KEY `sysmaps_elements_1` (`sysmapid`),
  KEY `sysmaps_elements_2` (`iconid_off`),
  KEY `sysmaps_elements_3` (`iconid_on`),
  KEY `sysmaps_elements_4` (`iconid_disabled`),
  KEY `sysmaps_elements_5` (`iconid_maintenance`),
  CONSTRAINT `c_sysmaps_elements_5` FOREIGN KEY (`iconid_maintenance`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_elements_2` FOREIGN KEY (`iconid_off`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_3` FOREIGN KEY (`iconid_on`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_4` FOREIGN KEY (`iconid_disabled`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_elements`
--

LOCK TABLES `sysmaps_elements` WRITE;
/*!40000 ALTER TABLE `sysmaps_elements` DISABLE KEYS */;
INSERT INTO `sysmaps_elements` VALUES (1,1,10084,0,185,NULL,'{HOST.NAME}\r\n{HOST.CONN}',0,111,61,NULL,NULL,0,0,200,200,0,0,'');
/*!40000 ALTER TABLE `sysmaps_elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_link_triggers`
--

DROP TABLE IF EXISTS `sysmaps_link_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps_link_triggers` (
  `linktriggerid` bigint(20) unsigned NOT NULL,
  `linkid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT '0',
  `color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '000000',
  PRIMARY KEY (`linktriggerid`),
  UNIQUE KEY `sysmaps_link_triggers_1` (`linkid`,`triggerid`),
  KEY `sysmaps_link_triggers_2` (`triggerid`),
  CONSTRAINT `c_sysmaps_link_triggers_2` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_link_triggers_1` FOREIGN KEY (`linkid`) REFERENCES `sysmaps_links` (`linkid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_link_triggers`
--

LOCK TABLES `sysmaps_link_triggers` WRITE;
/*!40000 ALTER TABLE `sysmaps_link_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps_link_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_links`
--

DROP TABLE IF EXISTS `sysmaps_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps_links` (
  `linkid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `selementid1` bigint(20) unsigned NOT NULL,
  `selementid2` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT '0',
  `color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '000000',
  `label` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`linkid`),
  KEY `sysmaps_links_1` (`sysmapid`),
  KEY `sysmaps_links_2` (`selementid1`),
  KEY `sysmaps_links_3` (`selementid2`),
  CONSTRAINT `c_sysmaps_links_3` FOREIGN KEY (`selementid2`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_links_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_links_2` FOREIGN KEY (`selementid1`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_links`
--

LOCK TABLES `sysmaps_links` WRITE;
/*!40000 ALTER TABLE `sysmaps_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag_filter`
--

DROP TABLE IF EXISTS `tag_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag_filter` (
  `tag_filterid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`tag_filterid`),
  KEY `c_tag_filter_1` (`usrgrpid`),
  KEY `c_tag_filter_2` (`groupid`),
  CONSTRAINT `c_tag_filter_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE,
  CONSTRAINT `c_tag_filter_1` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_filter`
--

LOCK TABLES `tag_filter` WRITE;
/*!40000 ALTER TABLE `tag_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `taskid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `clock` int(11) NOT NULL DEFAULT '0',
  `ttl` int(11) NOT NULL DEFAULT '0',
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`taskid`),
  KEY `task_1` (`status`,`proxy_hostid`),
  KEY `c_task_1` (`proxy_hostid`),
  CONSTRAINT `c_task_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_acknowledge`
--

DROP TABLE IF EXISTS `task_acknowledge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_acknowledge` (
  `taskid` bigint(20) unsigned NOT NULL,
  `acknowledgeid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_acknowledge_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_acknowledge`
--

LOCK TABLES `task_acknowledge` WRITE;
/*!40000 ALTER TABLE `task_acknowledge` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_acknowledge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_check_now`
--

DROP TABLE IF EXISTS `task_check_now`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_check_now` (
  `taskid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_check_now_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_check_now`
--

LOCK TABLES `task_check_now` WRITE;
/*!40000 ALTER TABLE `task_check_now` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_check_now` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_close_problem`
--

DROP TABLE IF EXISTS `task_close_problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_close_problem` (
  `taskid` bigint(20) unsigned NOT NULL,
  `acknowledgeid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_close_problem_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_close_problem`
--

LOCK TABLES `task_close_problem` WRITE;
/*!40000 ALTER TABLE `task_close_problem` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_close_problem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_remote_command`
--

DROP TABLE IF EXISTS `task_remote_command`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_remote_command` (
  `taskid` bigint(20) unsigned NOT NULL,
  `command_type` int(11) NOT NULL DEFAULT '0',
  `execute_on` int(11) NOT NULL DEFAULT '0',
  `port` int(11) NOT NULL DEFAULT '0',
  `authtype` int(11) NOT NULL DEFAULT '0',
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `password` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `publickey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `privatekey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `command` text COLLATE utf8_bin NOT NULL,
  `alertid` bigint(20) unsigned DEFAULT NULL,
  `parent_taskid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_remote_command_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_remote_command`
--

LOCK TABLES `task_remote_command` WRITE;
/*!40000 ALTER TABLE `task_remote_command` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_remote_command` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_remote_command_result`
--

DROP TABLE IF EXISTS `task_remote_command_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_remote_command_result` (
  `taskid` bigint(20) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `parent_taskid` bigint(20) unsigned NOT NULL,
  `info` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_remote_command_result_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_remote_command_result`
--

LOCK TABLES `task_remote_command_result` WRITE;
/*!40000 ALTER TABLE `task_remote_command_result` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_remote_command_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeperiods`
--

DROP TABLE IF EXISTS `timeperiods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeperiods` (
  `timeperiodid` bigint(20) unsigned NOT NULL,
  `timeperiod_type` int(11) NOT NULL DEFAULT '0',
  `every` int(11) NOT NULL DEFAULT '1',
  `month` int(11) NOT NULL DEFAULT '0',
  `dayofweek` int(11) NOT NULL DEFAULT '0',
  `day` int(11) NOT NULL DEFAULT '0',
  `start_time` int(11) NOT NULL DEFAULT '0',
  `period` int(11) NOT NULL DEFAULT '0',
  `start_date` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`timeperiodid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeperiods`
--

LOCK TABLES `timeperiods` WRITE;
/*!40000 ALTER TABLE `timeperiods` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeperiods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trends`
--

DROP TABLE IF EXISTS `trends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trends` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `num` int(11) NOT NULL DEFAULT '0',
  `value_min` double(16,4) NOT NULL DEFAULT '0.0000',
  `value_avg` double(16,4) NOT NULL DEFAULT '0.0000',
  `value_max` double(16,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trends`
--

LOCK TABLES `trends` WRITE;
/*!40000 ALTER TABLE `trends` DISABLE KEYS */;
/*!40000 ALTER TABLE `trends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trends_uint`
--

DROP TABLE IF EXISTS `trends_uint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trends_uint` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `num` int(11) NOT NULL DEFAULT '0',
  `value_min` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_avg` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_max` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trends_uint`
--

LOCK TABLES `trends_uint` WRITE;
/*!40000 ALTER TABLE `trends_uint` DISABLE KEYS */;
/*!40000 ALTER TABLE `trends_uint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_depends`
--

DROP TABLE IF EXISTS `trigger_depends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trigger_depends` (
  `triggerdepid` bigint(20) unsigned NOT NULL,
  `triggerid_down` bigint(20) unsigned NOT NULL,
  `triggerid_up` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`triggerdepid`),
  UNIQUE KEY `trigger_depends_1` (`triggerid_down`,`triggerid_up`),
  KEY `trigger_depends_2` (`triggerid_up`),
  CONSTRAINT `c_trigger_depends_2` FOREIGN KEY (`triggerid_up`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_trigger_depends_1` FOREIGN KEY (`triggerid_down`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_depends`
--

LOCK TABLES `trigger_depends` WRITE;
/*!40000 ALTER TABLE `trigger_depends` DISABLE KEYS */;
INSERT INTO `trigger_depends` VALUES (8245,14195,14205),(8246,14196,14195),(8247,14196,14205),(8248,14197,14205),(8249,14198,14197),(8250,14198,14205),(8251,14200,14199),(8252,14201,14205),(8253,14202,14201),(8254,14202,14205),(8255,14204,14203),(8256,14206,14222),(8257,14207,14206),(8258,14207,14222),(8259,14208,14222),(8260,14209,14208),(8261,14209,14222),(8262,14210,14222),(8263,14211,14210),(8264,14211,14222),(8265,14212,14222),(8266,14213,14212),(8267,14213,14222),(8268,14214,14222),(8269,14215,14214),(8270,14215,14222),(8271,14217,14216),(8272,14218,14222),(8273,14219,14218),(8274,14219,14222),(8275,14220,14222),(8276,14221,14220),(8277,14221,14222),(8278,14223,14222),(8279,14224,14222),(8280,14224,14223),(8281,14225,14222),(8282,14226,14222),(8283,14226,14225),(8284,14252,14251),(8356,14253,14251),(8320,14253,14252),(8285,14289,14288),(8357,14290,14288),(8321,14290,14289),(8289,14294,14293),(8361,14295,14293),(8325,14295,14294),(8290,14312,14311),(8362,14313,14311),(8326,14313,14312),(8563,14318,14319),(8291,14328,14327),(8363,14329,14327),(8327,14329,14328),(8292,14348,14347),(8364,14349,14347),(8328,14349,14348),(8293,14357,14356),(8365,14358,14356),(8329,14358,14357),(8571,14372,14373),(8572,14375,14376),(8575,14380,14381),(8294,14390,14389),(8366,14391,14389),(8330,14391,14390),(8295,14404,14403),(8367,14405,14403),(8331,14405,14404),(8296,14452,14451),(8368,14453,14451),(8332,14453,14452),(8590,14460,14461),(8297,14469,14468),(8369,14470,14468),(8333,14470,14469),(8591,14476,14477),(8298,14487,14486),(8370,14488,14486),(8334,14488,14487),(8592,14495,14496),(8299,14506,14505),(8371,14507,14505),(8335,14507,14506),(8593,14511,15368),(8286,14525,14524),(8358,14526,14524),(8322,14526,14525),(8300,14535,14534),(8372,14536,14534),(8336,14536,14535),(8301,14545,14544),(8373,14546,14544),(8337,14546,14545),(8594,14551,14552),(8302,14583,14582),(8374,14584,14582),(8338,14584,14583),(8598,14589,14590),(8303,14599,14598),(8375,14600,14598),(8339,14600,14599),(8304,14616,14615),(8376,14617,14615),(8340,14617,14616),(8601,14624,14625),(8305,14653,14652),(8377,14654,14652),(8341,14654,14653),(8603,14658,14659),(8604,14664,14665),(8605,14668,14667),(8306,14674,14673),(8378,14675,14673),(8342,14675,14674),(8307,14692,14691),(8379,14693,14691),(8343,14693,14692),(8308,14705,14704),(8380,14706,14704),(8344,14706,14705),(8287,14718,14717),(8359,14719,14717),(8323,14719,14718),(8309,14870,14869),(8381,14871,14869),(8345,14871,14870),(8310,14883,14882),(8382,14884,14882),(8346,14884,14883),(8311,14907,14906),(8383,14908,14906),(8347,14908,14907),(8595,14914,14915),(8312,14929,14928),(8384,14930,14928),(8348,14930,14929),(8396,15161,14288),(8397,15162,14524),(8398,15163,14717),(8431,15170,14293),(8432,15171,14311),(8433,15172,14327),(8434,15173,14347),(8435,15174,14356),(8436,15175,14389),(8437,15176,14403),(8438,15177,14451),(8439,15178,14468),(8440,15179,14486),(8441,15180,14505),(8442,15181,14534),(8443,15182,14544),(8444,15183,14582),(8445,15184,14598),(8446,15185,14615),(8447,15186,14652),(8448,15187,14673),(8449,15188,14691),(8450,15189,14704),(8451,15190,14869),(8452,15191,14882),(8453,15192,14906),(8454,15193,14928),(8313,15221,15220),(8385,15222,15220),(8349,15222,15221),(8455,15224,15220),(8588,15332,15331),(8589,15334,15333),(8599,15335,15336),(8600,15338,15337),(8576,15342,15343),(8577,15345,15344),(8578,15347,15346),(8579,15348,15351),(8580,15349,15352),(8581,15350,15353),(8582,15357,15354),(8583,15358,15355),(8584,15359,15356),(8585,15363,15360),(8586,15364,15361),(8587,15365,15362),(8596,15374,15373),(8597,15376,15375),(8569,15380,15379),(8570,15382,15381),(8573,15384,15383),(8574,15386,15385),(8602,15387,14934),(8566,15390,14339),(8567,15392,15391),(8568,15394,15393),(8606,15396,15397),(8539,15550,15490),(8540,15551,15490),(8542,15553,15492),(8543,15554,15493),(8544,15555,15492),(8545,15556,15493),(8548,15559,15496),(8549,15560,15496),(8551,15562,15498),(8552,15563,15499),(8553,15564,15498),(8554,15565,15499),(8470,15574,15506),(8471,15575,15506),(8473,15577,15508),(8474,15578,15508),(8476,15580,15510),(8477,15581,15511),(8478,15582,15512),(8479,15583,15513),(8480,15584,15514),(8481,15585,15515),(8482,15586,15516),(8483,15587,15517),(8484,15588,15518),(8485,15589,15519),(8486,15590,15520),(8487,15591,15521),(8488,15592,15522),(8489,15593,15523),(8490,15594,15524),(8491,15595,15525),(8492,15596,15526),(8493,15597,15527),(8494,15598,15528),(8495,15599,15529),(8497,15600,15510),(8498,15601,15511),(8499,15602,15512),(8500,15603,15513),(8501,15604,15514),(8502,15605,15515),(8503,15606,15516),(8504,15607,15517),(8505,15608,15518),(8506,15609,15519),(8507,15610,15520),(8508,15611,15521),(8509,15612,15522),(8510,15613,15523),(8511,15614,15524),(8512,15615,15525),(8513,15616,15526),(8514,15617,15527),(8515,15618,15528),(8516,15619,15529),(8392,15642,15161),(8393,15643,15162),(8394,15644,15163),(8400,15645,15170),(8401,15646,15171),(8402,15647,15172),(8403,15648,15173),(8404,15649,15174),(8405,15650,15175),(8406,15651,15176),(8407,15652,15177),(8408,15653,15178),(8409,15654,15179),(8410,15655,15180),(8411,15656,15181),(8412,15657,15182),(8413,15658,15183),(8414,15659,15184),(8415,15660,15185),(8416,15661,15186),(8417,15662,15187),(8418,15663,15188),(8419,15664,15189),(8420,15665,15190),(8421,15666,15191),(8422,15667,15192),(8423,15668,15193),(8424,15669,15224),(8472,15670,15506),(8475,15671,15508),(8518,15672,15510),(8519,15673,15511),(8520,15674,15512),(8521,15675,15513),(8522,15676,15514),(8523,15677,15515),(8524,15678,15516),(8525,15679,15517),(8526,15680,15518),(8527,15681,15519),(8528,15682,15520),(8529,15683,15521),(8530,15684,15522),(8531,15685,15523),(8532,15686,15524),(8533,15687,15525),(8534,15688,15526),(8535,15689,15527),(8536,15690,15528),(8537,15691,15529),(8541,15692,15490),(8546,15693,15492),(8547,15694,15493),(8550,15695,15496),(8555,15696,15498),(8556,15697,15499),(8559,15698,15502),(8562,15699,15504),(8314,15702,15701),(8386,15703,15701),(8350,15703,15702),(8425,15704,15705),(8456,15705,15701),(8517,15706,15709),(8496,15707,15709),(8538,15708,15709),(8564,15714,15715),(8565,15721,15720),(8315,15724,15723),(8387,15725,15723),(8351,15725,15724),(8426,15726,15727),(8457,15727,15723),(8620,15729,15728),(8621,15730,15728),(8622,15730,15729),(8623,15733,15734),(8624,15736,15737),(8625,15740,15739),(8626,15742,15741),(8627,15744,15743),(8628,15746,15743),(8629,15748,15747),(8630,15750,15749),(8632,15751,15749),(8631,15751,15750),(8633,15752,15754),(8635,15753,15752),(8634,15753,15754),(8316,15756,15755),(8388,15757,15755),(8352,15757,15756),(8427,15758,15759),(8458,15759,15755),(8637,15763,15764),(8638,15766,15767),(8639,15769,15770),(8640,15772,15773),(8641,15775,15776),(8642,15778,15779),(8643,15782,15781),(8644,15784,15783),(8645,15786,15785),(8646,15788,15787),(8647,15789,15787),(8648,15789,15788),(8649,15791,15790),(8650,15793,15792),(8651,15794,15792),(8652,15797,15796),(8288,15799,15798),(8360,15800,15798),(8324,15800,15799),(8395,15801,15802),(8399,15802,15798),(8653,15804,15803),(8654,15805,15803),(8655,15805,15804),(8656,15807,15808),(8657,15810,15811),(8658,15813,15814),(8317,15820,15819),(8389,15821,15819),(8353,15821,15820),(8428,15822,15823),(8459,15823,15819),(8659,15825,15824),(8660,15826,15824),(8661,15826,15825),(8662,15828,15829),(8663,15831,15832),(8664,15834,15835),(8318,15841,15840),(8390,15842,15840),(8354,15842,15841),(8429,15843,15844),(8460,15844,15840),(8665,15845,15846),(8319,15909,15908),(8391,15910,15908),(8355,15910,15909),(8430,15911,15912),(8461,15912,15908),(8607,15913,15914),(8608,15916,15917),(8609,15919,15920),(8610,15922,15923),(8611,15925,15926),(8612,15929,15928),(8613,15931,15930),(8614,15934,15933),(8615,15936,15935),(8616,15939,15938),(8617,15940,15938),(8618,15940,15939),(8619,15942,15941),(8636,15944,15943),(8464,15953,15952),(8465,15960,15955),(8466,15961,15956),(8467,15962,15957),(8468,15963,15958),(8469,15964,15959),(8557,15970,15502),(8558,15971,15502),(8560,15972,15504),(8561,15973,15504),(8462,15977,15976),(8463,15980,15979);
/*!40000 ALTER TABLE `trigger_depends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_discovery`
--

DROP TABLE IF EXISTS `trigger_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trigger_discovery` (
  `triggerid` bigint(20) unsigned NOT NULL,
  `parent_triggerid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`triggerid`),
  KEY `trigger_discovery_1` (`parent_triggerid`),
  CONSTRAINT `c_trigger_discovery_2` FOREIGN KEY (`parent_triggerid`) REFERENCES `triggers` (`triggerid`),
  CONSTRAINT `c_trigger_discovery_1` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_discovery`
--

LOCK TABLES `trigger_discovery` WRITE;
/*!40000 ALTER TABLE `trigger_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `trigger_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_tag`
--

DROP TABLE IF EXISTS `trigger_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trigger_tag` (
  `triggertagid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`triggertagid`),
  KEY `trigger_tag_1` (`triggerid`),
  CONSTRAINT `c_trigger_tag_1` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_tag`
--

LOCK TABLES `trigger_tag` WRITE;
/*!40000 ALTER TABLE `trigger_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `trigger_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `triggers`
--

DROP TABLE IF EXISTS `triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `triggers` (
  `triggerid` bigint(20) unsigned NOT NULL,
  `expression` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `url` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0',
  `lastchange` int(11) NOT NULL DEFAULT '0',
  `comments` text COLLATE utf8_bin NOT NULL,
  `error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  `recovery_mode` int(11) NOT NULL DEFAULT '0',
  `recovery_expression` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `correlation_mode` int(11) NOT NULL DEFAULT '0',
  `correlation_tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `manual_close` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`triggerid`),
  KEY `triggers_1` (`status`),
  KEY `triggers_2` (`value`,`lastchange`),
  KEY `triggers_3` (`templateid`),
  CONSTRAINT `c_triggers_1` FOREIGN KEY (`templateid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `triggers`
--

LOCK TABLES `triggers` WRITE;
/*!40000 ALTER TABLE `triggers` DISABLE KEYS */;
INSERT INTO `triggers` VALUES (10010,'{13078}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(10011,'{13084}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(10012,'{12580}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',NULL,0,0,0,0,'',0,'',0),(10016,'{10199}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(10021,'{12583}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(10041,'{10204}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(10042,'{12553}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(10043,'{10208}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(10044,'{10207}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(10045,'{12927}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0,0,'',0,'',0),(10047,'{12550}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0,0,'',0,'',0),(10190,'{13082}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13000,'{12144}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13015,'{12641}>75','More than 75% used in the configuration cache','',0,0,3,0,'Consider increasing CacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0),(13017,'{12651}>75','More than 75% used in the history index cache','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13019,'{12649}>75','More than 75% used in the trends cache','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13023,'{12653}>100','More than 100 items having missing data for more than 10 minutes','',0,0,2,0,'zabbix[queue,10m] item is collecting data about how many items are missing data for more than 10 minutes (next parameter)','',NULL,0,0,0,0,'',0,'',0),(13025,'{12549}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13026,'{12926}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13073,'{12645}>75','More than 75% used in the history cache','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13074,'{12646}>95','More than 95% used in the value cache','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13075,'{12648}>95','More than 95% used in the value cache','',0,0,3,0,'','',13074,0,0,0,0,'',0,'',0),(13080,'{13164}>75','Zabbix alerter processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13164}<65',0,'',0),(13081,'{13170}>75','Zabbix configuration syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13170}<65',0,'',0),(13083,'{13172}>75','Zabbix discoverer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13172}<65',0,'',0),(13084,'{13174}>75','Zabbix escalator processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13174}<65',0,'',0),(13085,'{13176}>75','Zabbix history syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13176}<65',0,'',0),(13086,'{13178}>75','Zabbix housekeeper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13178}<65',0,'',0),(13087,'{13180}>75','Zabbix http poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13180}<65',0,'',0),(13088,'{13182}>75','Zabbix icmp pinger processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13182}<65',0,'',0),(13089,'{13184}>75','Zabbix ipmi poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13184}<65',0,'',0),(13091,'{13188}>75','Zabbix poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13188}<65',0,'',0),(13092,'{13190}>75','Zabbix proxy poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13190}<65',0,'',0),(13093,'{13192}>75','Zabbix self-monitoring processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13192}<65',0,'',0),(13094,'{13198}>75','Zabbix timer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13198}<65',0,'',0),(13095,'{13200}>75','Zabbix trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13200}<65',0,'',0),(13096,'{13202}>75','Zabbix unreachable poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13202}<65',0,'',0),(13097,'{13204}>75','Zabbix vmware collector processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13204}<65',0,'',0),(13243,'{13080}>20','Disk I/O is overloaded on {HOST.NAME}','',0,0,2,0,'OS spends significant time waiting for I/O (input/output) operations. It could be indicator of performance issues with storage system.','',NULL,0,0,0,0,'',0,'',0),(13266,'{12592}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0),(13272,'{12598}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0),(13275,'{13186}>75','Zabbix java poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13186}<65',0,'',0),(13285,'{13159}=0','Telnet service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13328,'{12715}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0,0,'',0,'',0),(13329,'{12929}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0,0,'',0,'',0),(13330,'{12717}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13331,'{12718}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13332,'{13089}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13333,'{13088}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13334,'{13087}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13336,'{12723}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13337,'{12724}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',NULL,0,0,0,0,'',0,'',0),(13338,'{12725}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13339,'{12726}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13340,'{12727}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13341,'{12728}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13342,'{12729}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0),(13343,'{12730}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0),(13344,'{12731}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0,0,'',0,'',0),(13345,'{12930}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0,0,'',0,'',0),(13346,'{12733}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13347,'{12734}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13348,'{13074}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13349,'{13073}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13350,'{13072}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13352,'{12739}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13353,'{12740}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',NULL,0,0,0,0,'',0,'',0),(13354,'{12741}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13355,'{12742}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13356,'{12743}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13357,'{12744}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13358,'{12745}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0),(13359,'{12746}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0),(13360,'{12747}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0,0,'',0,'',0),(13361,'{12931}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0,0,'',0,'',0),(13364,'{13071}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13365,'{13070}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13366,'{13069}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13367,'{13068}>20','Disk I/O is overloaded on {HOST.NAME}','',0,0,2,0,'OS spends significant time waiting for I/O (input/output) operations. It could be indicator of performance issues with storage system.','',NULL,0,0,0,0,'',0,'',0),(13368,'{12755}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13370,'{12757}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13371,'{12758}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13372,'{12759}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13373,'{12760}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13374,'{12761}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0),(13375,'{12762}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0),(13376,'{12763}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0,0,'',0,'',0),(13377,'{12932}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0,0,'',0,'',0),(13382,'{13075}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13384,'{12771}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13386,'{12773}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13388,'{12775}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13389,'{12776}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13390,'{12777}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0),(13391,'{12778}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0),(13392,'{12779}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0,0,'',0,'',0),(13393,'{12933}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0,0,'',0,'',0),(13395,'{12782}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13396,'{13093}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13397,'{13092}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13398,'{13091}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13399,'{13090}>20','Disk I/O is overloaded on {HOST.NAME}','',0,0,2,0,'OS spends significant time waiting for I/O (input/output) operations. It could be indicator of performance issues with storage system.','',NULL,0,0,0,0,'',0,'',0),(13400,'{12787}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13401,'{12788}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',NULL,0,0,0,0,'',0,'',0),(13402,'{12789}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13403,'{12790}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13404,'{12791}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13405,'{12792}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13406,'{12793}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0),(13407,'{12794}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0),(13408,'{12795}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0,0,'',0,'',0),(13409,'{12934}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0,0,'',0,'',0),(13410,'{12797}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13411,'{12798}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13414,'{13086}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13416,'{12803}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13418,'{12805}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13419,'{12806}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13420,'{12807}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13421,'{12808}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13422,'{12809}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0),(13423,'{12810}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0),(13425,'{12812}>0','Host information was changed on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13428,'{12815}<0','{HOST.NAME} has just been restarted','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13430,'{13095}>300','Too many processes on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13431,'{12818}<10','Lack of available virtual memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,1,'{12818}>20',0,'',0),(13433,'{12820}<10000','Lack of free memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13435,'{13094}>5','Processor load is too high on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13436,'{13205}>75','Zabbix vmware collector processes more than 75% busy','',0,0,3,0,'','',13097,0,0,0,1,'{13205}<65',0,'',0),(13437,'{12824}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0,0,'',0,'',0),(13438,'{12935}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0,0,'',0,'',0),(13439,'{12826}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0),(13441,'{13194}>75','Zabbix snmp trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13194}<65',0,'',0),(13467,'{13165}>75','Zabbix alerter processes more than 75% busy','',0,0,3,0,'','',13080,0,0,0,1,'{13165}<65',0,'',0),(13468,'{13171}>75','Zabbix configuration syncer processes more than 75% busy','',0,0,3,0,'','',13081,0,0,0,1,'{13171}<65',0,'',0),(13470,'{13173}>75','Zabbix discoverer processes more than 75% busy','',0,0,3,0,'','',13083,0,0,0,1,'{13173}<65',0,'',0),(13471,'{13175}>75','Zabbix escalator processes more than 75% busy','',0,0,3,0,'','',13084,0,0,0,1,'{13175}<65',0,'',0),(13472,'{13177}>75','Zabbix history syncer processes more than 75% busy','',0,0,3,0,'','',13085,0,0,0,1,'{13177}<65',0,'',0),(13473,'{13179}>75','Zabbix housekeeper processes more than 75% busy','',0,0,3,0,'','',13086,0,0,0,1,'{13179}<65',0,'',0),(13474,'{13181}>75','Zabbix http poller processes more than 75% busy','',0,0,3,0,'','',13087,0,0,0,1,'{13181}<65',0,'',0),(13475,'{13183}>75','Zabbix icmp pinger processes more than 75% busy','',0,0,3,0,'','',13088,0,0,0,1,'{13183}<65',0,'',0),(13476,'{13185}>75','Zabbix ipmi poller processes more than 75% busy','',0,0,3,0,'','',13089,0,0,0,1,'{13185}<65',0,'',0),(13477,'{13187}>75','Zabbix java poller processes more than 75% busy','',0,0,3,0,'','',13275,0,0,0,1,'{13187}<65',0,'',0),(13479,'{13189}>75','Zabbix poller processes more than 75% busy','',0,0,3,0,'','',13091,0,0,0,1,'{13189}<65',0,'',0),(13480,'{13191}>75','Zabbix proxy poller processes more than 75% busy','',0,0,3,0,'','',13092,0,0,0,1,'{13191}<65',0,'',0),(13481,'{13193}>75','Zabbix self-monitoring processes more than 75% busy','',0,0,3,0,'','',13093,0,0,0,1,'{13193}<65',0,'',0),(13482,'{13195}>75','Zabbix snmp trapper processes more than 75% busy','',0,0,3,0,'','',13441,0,0,0,1,'{13195}<65',0,'',0),(13483,'{13199}>75','Zabbix timer processes more than 75% busy','',0,0,3,0,'','',13094,0,0,0,1,'{13199}<65',0,'',0),(13484,'{13201}>75','Zabbix trapper processes more than 75% busy','',0,0,3,0,'','',13095,0,0,0,1,'{13201}<65',0,'',0),(13485,'{13203}>75','Zabbix unreachable poller processes more than 75% busy','',0,0,3,0,'','',13096,0,0,0,1,'{13203}<65',0,'',0),(13486,'{12895}>100','More than 100 items having missing data for more than 10 minutes','',0,0,2,0,'zabbix[queue,10m] item is collecting data about how many items are missing data for more than 10 minutes (next parameter)','',13023,0,0,0,0,'',0,'',0),(13487,'{12896}>75','More than 75% used in the configuration cache','',0,0,3,0,'Consider increasing CacheSize in the zabbix_server.conf configuration file','',13015,0,0,0,0,'',0,'',0),(13488,'{12897}>75','More than 75% used in the history cache','',0,0,3,0,'','',13073,0,0,0,0,'',0,'',0),(13489,'{12898}>75','More than 75% used in the history index cache','',0,0,3,0,'','',13017,0,0,0,0,'',0,'',0),(13490,'{12899}>75','More than 75% used in the trends cache','',0,0,3,0,'','',13019,0,0,0,0,'',0,'',0),(13491,'{12900}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',10047,0,0,0,0,'',0,'',0),(13492,'{12928}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',10045,0,0,0,0,'',0,'',0),(13493,'{12902}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',10042,0,0,0,0,'',0,'',0),(13494,'{12903}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',10041,0,0,0,0,'',0,'',0),(13495,'{13085}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',10011,0,0,0,0,'',0,'',0),(13496,'{13083}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',10190,0,0,0,0,'',0,'',0),(13497,'{13079}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',10010,0,0,0,0,'',0,'',0),(13498,'{13081}>20','Disk I/O is overloaded on {HOST.NAME}','',0,0,2,0,'OS spends significant time waiting for I/O (input/output) operations. It could be indicator of performance issues with storage system.','',13243,0,0,0,0,'',0,'',0),(13499,'{12908}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',10043,0,0,0,0,'',0,'',0),(13500,'{12909}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',10012,0,0,0,0,'',0,'',0),(13501,'{12910}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',10044,0,0,0,0,'',0,'',0),(13502,'{12911}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',10021,0,0,0,0,'',0,'',0),(13503,'{12912}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',10016,0,0,0,0,'',0,'',0),(13504,'{12913}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',13000,0,0,0,0,'',0,'',0),(13505,'{12914}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',13272,0,0,2,0,'',0,'',0),(13506,'{12915}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',13266,0,0,2,0,'',0,'',0),(13507,'{12936}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13508,'{12937}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0,0,'',0,'',0),(13509,'{12938}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13508,0,0,0,0,'',0,'',0),(13510,'{12939}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0,0,'',0,'',0),(13511,'{12940}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0,0,'',0,'',0),(13512,'{12941}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0,0,'',0,'',0),(13513,'{12942}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0,0,'',0,'',0),(13514,'{12943}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0,0,'',0,'',0),(13515,'{12944}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0,0,'',0,'',0),(13516,'{12945}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0,0,'',0,'',0),(13517,'{12946}>75','More than 75% used in the configuration cache','',0,0,3,0,'Consider increasing CacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0),(13518,'{12947}>75','More than 75% used in the history cache','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13519,'{12948}>75','More than 75% used in the history index cache','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13520,'{12949}>100','More than 100 items having missing data for more than 10 minutes','',0,0,2,0,'zabbix[queue,10m] item is collecting data about how many items are missing data for more than 10 minutes (next parameter)','',NULL,0,0,0,0,'',0,'',0),(13521,'{13206}>75','Zabbix configuration syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13206}<65',0,'',0),(13522,'{13208}>75','Zabbix discoverer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13208}<65',0,'',0),(13523,'{13210}>75','Zabbix history syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13210}<65',0,'',0),(13524,'{13211}>75','Zabbix housekeeper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13211}<65',0,'',0),(13525,'{13212}>75','Zabbix http poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13212}<65',0,'',0),(13526,'{13213}>75','Zabbix icmp pinger processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13213}<65',0,'',0),(13527,'{13214}>75','Zabbix ipmi poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13214}<65',0,'',0),(13528,'{13215}>75','Zabbix java poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13215}<65',0,'',0),(13529,'{13216}>75','Zabbix poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13216}<65',0,'',0),(13530,'{13217}>75','Zabbix self-monitoring processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13217}<65',0,'',0),(13531,'{13218}>75','Zabbix snmp trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13218}<65',0,'',0),(13532,'{13219}>75','Zabbix trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13219}<65',0,'',0),(13533,'{13220}>75','Zabbix unreachable poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13220}<65',0,'',0),(13534,'{13207}>75','Zabbix data sender processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13207}<65',0,'',0),(13535,'{13209}>75','Zabbix heartbeat sender processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13209}<65',0,'',0),(13536,'{12965}>75','More than 75% used in the vmware cache','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13537,'{12966}>75','More than 75% used in the vmware cache','',0,0,3,0,'','',13536,0,0,0,0,'',0,'',0),(13544,'{12994}=0','FTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13545,'{12995}=0','HTTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13546,'{12996}=0','HTTPS service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13547,'{12997}=0','IMAP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13548,'{12998}=0','LDAP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13549,'{13154}=0','NNTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13550,'{13156}=0','NTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13551,'{13152}=0','POP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13552,'{13157}=0','SMTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13553,'{13158}=0','SSH service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13557,'{13160}=1','Zabbix value cache working in low memory mode','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13558,'{13161}=1','Zabbix value cache working in low memory mode','',0,0,4,0,'','',13557,0,0,0,0,'',0,'',0),(13559,'{13196}>75','Zabbix task manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13196}<65',0,'',0),(13560,'{13197}>75','Zabbix task manager processes more than 75% busy','',0,0,3,0,'','',13559,0,0,0,1,'{13197}<65',0,'',0),(13561,'{13221}<>0','Service \"{#SERVICE.NAME}\" ({#SERVICE.DISPLAYNAME}) is not running (startup type {#SERVICE.STARTUPNAME})','',0,0,3,0,'','',NULL,0,0,2,0,'',0,'',0),(13562,'{13222}>75','Zabbix ipmi manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13222}<65',0,'',0),(13563,'{13223}>75','Zabbix ipmi manager processes more than 75% busy','',0,0,3,0,'','',13562,0,0,0,1,'{13223}<65',0,'',0),(13564,'{13224}>75','Zabbix ipmi manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13224}<65',0,'',0),(13565,'{13225}>75','Zabbix task manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13225}<65',0,'',0),(13566,'{13226}>75','Zabbix alert manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13226}<65',0,'',0),(13567,'{13227}>75','Zabbix alert manager processes more than 75% busy','',0,0,3,0,'','',13566,0,0,0,1,'{13227}<65',0,'',0),(13568,'{13228}>75','Zabbix preprocessing manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13228}<65',0,'',0),(13569,'{13229}>75','Zabbix preprocessing worker processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{13229}<65',0,'',0),(13570,'{13230}>75','Zabbix preprocessing manager processes more than 75% busy','',0,0,3,0,'','',13568,0,0,0,1,'{13230}<65',0,'',0),(13571,'{13231}>75','Zabbix preprocessing worker processes more than 75% busy','',0,0,3,0,'','',13569,0,0,0,1,'{13231}<65',0,'',0),(14168,'{14257}>({14258}*0.7)','70% mem Heap Memory used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14169,'{14259}>({14260}*0.7)','70% mem Non-Heap Memory used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14170,'{14261}>({14262}*0.7)','70% mp CMS Old Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14171,'{14263}>({14264}*0.7)','70% mp CMS Perm Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14172,'{14265}>({14266}*0.7)','70% mp Code Cache used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14173,'{14267}>({14268}*0.7)','70% mp Perm Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14174,'{14269}>({14270}*0.7)','70% mp PS Old Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14175,'{14271}>({14272}*0.7)','70% mp PS Perm Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14176,'{14273}>({14274}*0.7)','70% mp Tenured Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14177,'{14275}>({14276}*0.7)','70% os Opened File Descriptor Count used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14178,'{14277}>70','70% os Process CPU Load on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14179,'{14278}<{14279}','gc Concurrent Mark Sweep in fire fighting mode on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14180,'{14280}<{14281}','gc Mark Sweep Compact in fire fighting mode on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14181,'{14282}<{14283}','gc PS Mark Sweep in fire fighting mode on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14182,'{14284}={14285}','mem Heap Memory fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(14183,'{14286}={14287}','mem Non-Heap Memory fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(14184,'{14288}={14289}','mp CMS Old Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(14185,'{14290}={14291}','mp CMS Perm Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(14186,'{14292}={14293}','mp Code Cache fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(14187,'{14294}={14295}','mp Perm Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(14188,'{14296}={14297}','mp PS Old Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(14189,'{14298}={14299}','mp PS Perm Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(14190,'{14300}={14301}','mp Tenured Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(14191,'{14302}=1','{HOST.NAME} is not reachable','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14192,'{14303}<>1','{HOST.NAME} runs suboptimal VM type','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(14193,'{14304}=1','{HOST.NAME} uses suboptimal JIT compiler','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(14194,'{14305}=0','MySQL is down','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(14195,'{14306}<1.597 or {14306}>2.019','BB +1.8V SM Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(14196,'{14307}<1.646 or {14307}>1.960','BB +1.8V SM Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(14197,'{14308}<2.876 or {14308}>3.729','BB +3.3V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(14198,'{14309}<2.970 or {14309}>3.618','BB +3.3V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(14199,'{14310}<2.876 or {14310}>3.729','BB +3.3V STBY Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(14200,'{14311}<2.970 or {14311}>3.618','BB +3.3V STBY Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(14201,'{14312}<4.362 or {14312}>5.663','BB +5.0V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(14202,'{14313}<4.483 or {14313}>5.495','BB +5.0V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(14203,'{14314}<5 or {14314}>66','BB Ambient Temp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(14204,'{14315}<10 or {14315}>61','BB Ambient Temp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(14205,'{14316}=0','Power','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(14206,'{14317}<5 or {14317}>90','Baseboard Temp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(14207,'{14318}<10 or {14318}>83','Baseboard Temp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(14208,'{14319}<0.953 or {14319}>1.149','BB +1.05V PCH Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(14209,'{14320}<0.985 or {14320}>1.117','BB +1.05V PCH Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(14210,'{14321}<0.683 or {14321}>1.543','BB +1.1V P1 Vccp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(14211,'{14322}<0.708 or {14322}>1.501','BB +1.1V P1 Vccp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(14212,'{14323}<1.362 or {14323}>1.635','BB +1.5V P1 DDR3 Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(14213,'{14324}<1.401 or {14324}>1.589','BB +1.5V P1 DDR3 Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(14214,'{14325}<2.982 or {14325}>3.625','BB +3.3V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(14215,'{14326}<3.067 or {14326}>3.525','BB +3.3V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(14216,'{14327}<2.982 or {14327}>3.625','BB +3.3V STBY Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(14217,'{14328}<3.067 or {14328}>3.525','BB +3.3V STBY Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(14218,'{14329}<4.471 or {14329}>5.538','BB +5.0V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(14219,'{14330}<4.630 or {14330}>5.380','BB +5.0V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(14220,'{14331}<0 or {14331}>48','Front Panel Temp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(14221,'{14332}<5 or {14332}>44','Front Panel Temp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(14222,'{14333}=0','Power','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(14223,'{14334}<324','System Fan 2 Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(14224,'{14335}<378','System Fan 2 Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(14225,'{14336}<324','System Fan 3 Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(14226,'{14337}<378','System Fan 3 Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(14251,'{14378}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',NULL,0,0,0,0,'',0,'',0),(14252,'{14379}>{$ICMP_LOSS_WARN} and {14379}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14253,'{14380}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14288,'{14463}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14251,0,0,0,0,'',0,'',0),(14289,'{14464}>{$ICMP_LOSS_WARN} and {14464}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14252,0,0,0,0,'',0,'',0),(14290,'{14465}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14253,0,0,0,0,'',0,'',0),(14293,'{14468}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14251,0,0,0,0,'',0,'',0),(14294,'{14469}>{$ICMP_LOSS_WARN} and {14469}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14252,0,0,0,0,'',0,'',0),(14295,'{14470}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14253,0,0,0,0,'',0,'',0),(14311,'{14508}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14312,'{14509}>{$ICMP_LOSS_WARN} and {14509}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14313,'{14510}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14316,'{14513}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14317,'{14514}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14318,'{14515}>{$TEMP_WARN:\"\"}','{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14516}<{$TEMP_WARN:\"\"}-3',0,'',0),(14319,'{14517}>{$TEMP_CRIT:\"\"}','{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14518}<{$TEMP_CRIT:\"\"}-3',0,'',0),(14320,'{14519}<{$TEMP_CRIT_LOW:\"\"}','{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14520}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(14322,'{14522}=1 and {14523}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1),(14327,'{14536}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14328,'{14537}>{$ICMP_LOSS_WARN} and {14537}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14329,'{14538}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14332,'{14541}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14333,'{14542}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14336,'{14545}=1 and {14546}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14337,'{14547}=1 and {14548}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14339,'{14552}>{$TEMP_CRIT:\"\"}','{#SENSOR_INFO}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14553}<{$TEMP_CRIT:\"\"}-3',0,'',0),(14340,'{14554}<{$TEMP_CRIT_LOW:\"\"}','{#SENSOR_INFO}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14555}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(14347,'{14570}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14348,'{14571}>{$ICMP_LOSS_WARN} and {14571}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14349,'{14572}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14356,'{14587}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14357,'{14588}>{$ICMP_LOSS_WARN} and {14588}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14358,'{14589}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14361,'{14592}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14362,'{14593}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14363,'{14594}=1 and {14595}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14364,'{14596}=1 and {14597}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14365,'{14598}=1 and {14599}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14366,'{14600}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14361,0,0,0,0,'',0,'',0),(14367,'{14601}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14361,0,0,0,0,'',0,'',0),(14368,'{14602}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14362,0,0,0,0,'',0,'',0),(14369,'{14603}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14362,0,0,0,0,'',0,'',0),(14372,'{14606}>{$TEMP_WARN:\"\"}','{#SENSOR_DESCR}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14607}<{$TEMP_WARN:\"\"}-3',0,'',0),(14373,'{14608}>{$TEMP_CRIT:\"\"}','{#SENSOR_DESCR}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14609}<{$TEMP_CRIT:\"\"}-3',0,'',0),(14374,'{14610}<{$TEMP_CRIT_LOW:\"\"}','{#SENSOR_DESCR}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14611}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(14375,'{14612}>{$TEMP_WARN:\"\"}','Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14613}<{$TEMP_WARN:\"\"}-3',0,'',0),(14376,'{14614}>{$TEMP_CRIT:\"\"}','Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14615}<{$TEMP_CRIT:\"\"}-3',0,'',0),(14377,'{14616}<{$TEMP_CRIT_LOW:\"\"}','Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14617}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(14380,'{14620}>{$TEMP_WARN:\"\"}','{#SENSOR_DESCR}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14621}<{$TEMP_WARN:\"\"}-3',0,'',0),(14381,'{14622}>{$TEMP_CRIT:\"\"}','{#SENSOR_DESCR}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14623}<{$TEMP_CRIT:\"\"}-3',0,'',0),(14382,'{14624}<{$TEMP_CRIT_LOW:\"\"}','{#SENSOR_DESCR}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14625}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(14383,'{14626}=1 and {14627}>0','Unit {#SNMPVALUE}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1),(14389,'{14641}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14390,'{14642}>{$ICMP_LOSS_WARN} and {14642}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14391,'{14643}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14403,'{14663}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14404,'{14664}>{$ICMP_LOSS_WARN} and {14664}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14405,'{14665}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14408,'{14668}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14409,'{14669}=1 and {14670}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14410,'{14671}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14408,0,0,0,0,'',0,'',0),(14411,'{14672}=1 and {14673}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',14409,0,0,0,2,'',0,'',1),(14413,'{14676}=1 and {14677}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',14409,0,0,0,2,'',0,'',1),(14414,'{14678}>{$MEMORY_UTIL_MAX}','{#SNMPVALUE}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(14415,'{14679}>{$CPU_UTIL_MAX}','#{#SNMPINDEX}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(14417,'{14681}=1 and {14682}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1),(14420,'{14689}<{$TEMP_CRIT_LOW:\"\"}','{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14690}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(14423,'{14693}>{$MEMORY_UTIL_MAX}','{#SNMPVALUE}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14414,0,0,2,0,'',0,'',0),(14425,'{14695}>{$MEMORY_UTIL_MAX}','{#SNMPVALUE}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14414,0,0,2,0,'',0,'',0),(14426,'{14696}>{$CPU_UTIL_MAX}','#{#SNMPINDEX}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14415,0,0,2,0,'',0,'',0),(14428,'{14698}=1 and {14699}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',14417,0,0,2,2,'',0,'',1),(14430,'{14702}=1 and {14703}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',14417,0,0,2,2,'',0,'',1),(14437,'{14722}<{$TEMP_CRIT_LOW:\"\"}','{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14420,0,0,2,1,'{14723}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(14439,'{14726}<{$TEMP_CRIT_LOW:\"\"}','{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14420,0,0,2,1,'{14727}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(14451,'{14747}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14452,'{14748}>{$ICMP_LOSS_WARN} and {14748}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14453,'{14749}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14456,'{14752}>{$CPU_UTIL_MAX}','#{#SNMPINDEX}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(14457,'{14753}>{$MEMORY_UTIL_MAX}','#{#SNMPINDEX}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(14460,'{14756}>{$TEMP_WARN:\"\"}','Device {#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14757}<{$TEMP_WARN:\"\"}-3',0,'',0),(14461,'{14758}>{$TEMP_CRIT:\"\"}','Device {#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14759}<{$TEMP_CRIT:\"\"}-3',0,'',0),(14462,'{14760}<{$TEMP_CRIT_LOW:\"\"}','Device {#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14761}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(14463,'{14762}=1 and {14763}>0','#{#SNMPVALUE}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1),(14468,'{14776}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14469,'{14777}>{$ICMP_LOSS_WARN} and {14777}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14470,'{14778}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14473,'{14781}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14474,'{14782}=1 and {14783}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14475,'{14784}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(14476,'{14785}>{$TEMP_WARN:\"\"}','{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14786}<{$TEMP_WARN:\"\"}-3',0,'',0),(14477,'{14787}>{$TEMP_CRIT:\"\"}','{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14788}<{$TEMP_CRIT:\"\"}-3',0,'',0),(14478,'{14789}<{$TEMP_CRIT_LOW:\"\"}','{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14790}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(14486,'{14806}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14487,'{14807}>{$ICMP_LOSS_WARN} and {14807}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14488,'{14808}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14491,'{14811}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14492,'{14812}=1 and {14813}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14493,'{14814}=1 and {14815}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14494,'{14816}>{$MEMORY_UTIL_MAX}','#{#SNMPVALUE}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(14495,'{14817}>{$TEMP_WARN:\"\"}','#{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14818}<{$TEMP_WARN:\"\"}-3',0,'',0),(14496,'{14819}>{$TEMP_CRIT:\"\"}','#{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14820}<{$TEMP_CRIT:\"\"}-3',0,'',0),(14497,'{14821}<{$TEMP_CRIT_LOW:\"\"}','#{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14822}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(14505,'{14838}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14506,'{14839}>{$ICMP_LOSS_WARN} and {14839}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14507,'{14840}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14510,'{14843}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14511,'{14844}>{$TEMP_WARN:\"\"}','Device: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,0,1,'{14845}<{$TEMP_WARN:\"\"}-3',0,'',0),(14513,'{14849}<{$TEMP_CRIT_LOW:\"\"}','Device: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,1,'{14850}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(14514,'{14851}=1 and {14852}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14515,'{14853}=1 and {14854}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14516,'{14855}>{$MEMORY_UTIL_MAX}','#{#SNMPVALUE}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(14524,'{14871}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14288,0,0,0,0,'',0,'',0),(14525,'{14872}>{$ICMP_LOSS_WARN} and {14872}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14289,0,0,0,0,'',0,'',0),(14526,'{14873}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14290,0,0,0,0,'',0,'',0),(14534,'{14889}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14535,'{14890}>{$ICMP_LOSS_WARN} and {14890}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14536,'{14891}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14544,'{14907}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14545,'{14908}>{$ICMP_LOSS_WARN} and {14908}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14546,'{14909}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14549,'{14912}>{$CPU_UTIL_MAX}','{#MODULE_NAME}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(14550,'{14913}>{$MEMORY_UTIL_MAX}','{#MODULE_NAME}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(14551,'{14914}>{$TEMP_WARN:\"\"}','{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14915}<{$TEMP_WARN:\"\"}-3',0,'',0),(14552,'{14916}>{$TEMP_CRIT:\"\"}','{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14917}<{$TEMP_CRIT:\"\"}-3',0,'',0),(14553,'{14918}<{$TEMP_CRIT_LOW:\"\"}','{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14919}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(14556,'{14922}=1 and {14923}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1),(14557,'{14924}=1 and {14925}>0','{#ENT_NAME}: Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1),(14582,'{14972}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14583,'{14973}>{$ICMP_LOSS_WARN} and {14973}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14584,'{14974}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14587,'{14977}>{$CPU_UTIL_MAX}','{#ENT_NAME}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(14588,'{14978}>{$MEMORY_UTIL_MAX}','{#ENT_NAME}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(14589,'{14979}>{$TEMP_WARN:\"\"}','{#ENT_NAME}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14980}<{$TEMP_WARN:\"\"}-3',0,'',0),(14590,'{14981}>{$TEMP_CRIT:\"\"}','{#ENT_NAME}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{14982}<{$TEMP_CRIT:\"\"}-3',0,'',0),(14591,'{14983}<{$TEMP_CRIT_LOW:\"\"}','{#ENT_NAME}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{14984}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(14592,'{14985}=1 and {14986}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1),(14598,'{15000}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14599,'{15001}>{$ICMP_LOSS_WARN} and {15001}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14600,'{15002}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14603,'{15005}=1 and {15006}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14606,'{15013}<{$TEMP_CRIT_LOW:\"\"}','{#SENSOR_INFO}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{15014}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(14607,'{15015}=1 and {15016}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1),(14615,'{15032}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14616,'{15033}>{$ICMP_LOSS_WARN} and {15033}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14617,'{15034}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14621,'{15038}=1 and {15039}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14623,'{15041}>{$MEMORY_UTIL_MAX}','{#SNMPVALUE}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(14624,'{15042}>{$TEMP_WARN:\"\"}','{#SENSOR_INFO}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{15043}<{$TEMP_WARN:\"\"}-3',0,'',0),(14625,'{15044}>{$TEMP_CRIT:\"\"}','{#SENSOR_INFO}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{15045}<{$TEMP_CRIT:\"\"}-3',0,'',0),(14626,'{15046}<{$TEMP_CRIT_LOW:\"\"}','{#SENSOR_INFO}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{15047}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(14652,'{15094}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14653,'{15095}>{$ICMP_LOSS_WARN} and {15095}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14654,'{15096}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14657,'{15099}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14658,'{15100}>{$TEMP_WARN:\"Device\"}','Device: Temperature is above warning threshold: >{$TEMP_WARN:\"Device\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,0,1,'{15101}<{$TEMP_WARN:\"Device\"}-3',0,'',0),(14659,'{15102}>{$TEMP_CRIT:\"Device\"}','Device: Temperature is above critical threshold: >{$TEMP_CRIT:\"Device\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,0,1,'{15103}<{$TEMP_CRIT:\"Device\"}-3',0,'',0),(14660,'{15104}<{$TEMP_CRIT_LOW:\"Device\"}','Device: Temperature is too low: <{$TEMP_CRIT_LOW:\"Device\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,1,'{15105}>{$TEMP_CRIT_LOW:\"Device\"}+3',0,'',0),(14661,'{15106}=1 and {15107}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14662,'{15108}=1 and {15109}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14663,'{15110}>{$CPU_UTIL_MAX}','#{#SNMPINDEX}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(14664,'{15111}>{$TEMP_WARN:\"CPU\"}','CPU: Temperature is above warning threshold: >{$TEMP_WARN:\"CPU\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{15112}<{$TEMP_WARN:\"CPU\"}-3',0,'',0),(14665,'{15113}>{$TEMP_CRIT:\"CPU\"}','CPU: Temperature is above critical threshold: >{$TEMP_CRIT:\"CPU\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{15114}<{$TEMP_CRIT:\"CPU\"}-3',0,'',0),(14666,'{15115}<{$TEMP_CRIT_LOW:\"CPU\"}','CPU: Temperature is too low: <{$TEMP_CRIT_LOW:\"CPU\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{15116}>{$TEMP_CRIT_LOW:\"CPU\"}+3',0,'',0),(14667,'{15117}>{$STORAGE_UTIL_CRIT}','Disk-{#SNMPINDEX}: Disk space is critically low','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(14668,'{15118}>{$STORAGE_UTIL_WARN}','Disk-{#SNMPINDEX}: Disk space is low','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(14673,'{15131}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14674,'{15132}>{$ICMP_LOSS_WARN} and {15132}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14675,'{15133}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14678,'{15136}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14679,'{15137}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14680,'{15138}=1 and {15139}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14683,'{15146}<{$TEMP_CRIT_LOW:\"\"}','#{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{15147}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(14691,'{15163}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14692,'{15164}>{$ICMP_LOSS_WARN} and {15164}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14693,'{15165}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14696,'{15168}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14697,'{15169}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14698,'{15170}=1 and {15171}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14699,'{15172}=1 and {15173}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14704,'{15186}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14705,'{15187}>{$ICMP_LOSS_WARN} and {15187}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14706,'{15188}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14709,'{15191}=1 and {15192}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14710,'{15193}=1 and {15194}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14711,'{15195}>{$CPU_UTIL_MAX}','#{#SNMPVALUE}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(14712,'{15196}>{$MEMORY_UTIL_MAX}','#{#SNMPVALUE}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(14717,'{15209}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14288,0,0,0,0,'',0,'',0),(14718,'{15210}>{$ICMP_LOSS_WARN} and {15210}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14289,0,0,0,0,'',0,'',0),(14719,'{15211}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14290,0,0,0,0,'',0,'',0),(14722,'{15214}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14723,'{15215}>{$MEMORY_UTIL_MAX}','High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14724,'{15216}=1 and {15217}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14869,'{15597}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14870,'{15598}>{$ICMP_LOSS_WARN} and {15598}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14871,'{15599}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14882,'{15618}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14883,'{15619}>{$ICMP_LOSS_WARN} and {15619}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14884,'{15620}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14906,'{15678}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14907,'{15679}>{$ICMP_LOSS_WARN} and {15679}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14908,'{15680}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14911,'{15683}>{$CPU_UTIL_MAX}','High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,0,0,'',0,'',0),(14912,'{15684}=1 and {15685}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14913,'{15686}=1 and {15687}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(14914,'{15688}>{$TEMP_WARN:\"\"}','{#SENSOR_INFO}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{15689}<{$TEMP_WARN:\"\"}-3',0,'',0),(14915,'{15690}>{$TEMP_CRIT:\"\"}','{#SENSOR_INFO}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{15691}<{$TEMP_CRIT:\"\"}-3',0,'',0),(14916,'{15692}<{$TEMP_CRIT_LOW:\"\"}','{#SENSOR_INFO}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{15693}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(14917,'{15694}>{$MEMORY_UTIL_MAX}','#{#SNMPVALUE}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(14928,'{15713}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(14929,'{15714}>{$ICMP_LOSS_WARN} and {15714}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(14930,'{15715}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(14934,'{15721}>{$TEMP_CRIT:\"\"}','{#SENSOR_INFO}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{15722}<{$TEMP_CRIT:\"\"}-3',0,'',0),(14935,'{15723}<{$TEMP_CRIT_LOW:\"\"}','{#SENSOR_INFO}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{15724}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(14937,'{15726}=1 and {15727}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1),(14939,'{15729}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',NULL,0,0,2,0,'',0,'',1),(14940,'{15730}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14939,0,0,2,0,'',0,'',1),(14941,'{15731}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',NULL,0,0,2,0,'',0,'',1),(14942,'{15732}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1),(14943,'{15733}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1),(14944,'{15734}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1),(14945,'{15735}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1),(14946,'{15736}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1),(14947,'{15737}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1),(14948,'{15738}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1),(14949,'{15739}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1),(14950,'{15740}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1),(14951,'{15741}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1),(14952,'{15742}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1),(14953,'{15743}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1),(15161,'{16352}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',NULL,0,0,0,0,'',0,'',0),(15162,'{16353}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15161,0,0,0,0,'',0,'',0),(15163,'{16354}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15161,0,0,0,0,'',0,'',0),(15170,'{16375}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',NULL,0,0,0,0,'',0,'',0),(15171,'{16376}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15172,'{16377}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15173,'{16378}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15174,'{16379}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15175,'{16380}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15176,'{16381}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15177,'{16382}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15178,'{16383}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15179,'{16384}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15180,'{16385}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15181,'{16386}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15182,'{16387}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15183,'{16388}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15184,'{16389}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15185,'{16390}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15186,'{16391}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15187,'{16392}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15188,'{16393}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15189,'{16394}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15190,'{16395}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15191,'{16396}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15192,'{16397}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15193,'{16398}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15208,'{16445}=1 and {16446}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',14409,0,0,0,2,'',0,'',1),(15209,'{16447}=1 and {16448}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',14417,0,0,2,2,'',0,'',1),(15214,'{16457}<{$TEMP_CRIT_LOW:\"\"}','{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14420,0,0,2,1,'{16458}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(15215,'{16459}>{$MEMORY_UTIL_MAX}','{#SNMPVALUE}: High memory utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',14414,0,0,2,0,'',0,'',0),(15220,'{16472}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(15221,'{16473}>{$ICMP_LOSS_WARN} and {16473}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(15222,'{16474}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(15224,'{16476}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15225,'{16477}>{$CPU_UTIL_MAX}','{#SNMPVALUE}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(15228,'{16484}>{$CPU_UTIL_MAX}','{#SNMPVALUE}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',15225,0,0,2,0,'',0,'',0),(15330,'{16818}=1','#{#SNMPINDEX}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15331,'{16819}=1','PSU {#SNMPVALUE}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15332,'{16820}=1','PSU {#SNMPVALUE}: Power supply is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15333,'{16821}=1','Fan {#SNMPVALUE}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15334,'{16822}=1','Fan {#SNMPVALUE}: Fan is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15335,'{16823}>{$TEMP_WARN:\"\"}\r\nor\r\n{16824}={$TEMP_WARN_STATUS}','{#SENSOR_INFO}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{16825}<{$TEMP_WARN:\"\"}-3',0,'',0),(15336,'{16826}>{$TEMP_CRIT:\"\"}\r\nor\r\n{16827}={$TEMP_CRIT_STATUS}','{#SENSOR_INFO}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{16828}<{$TEMP_CRIT:\"\"}-3',0,'',0),(15337,'{16829}=1','{#SNMPVALUE}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15338,'{16830}=1','{#SNMPVALUE}: Power supply is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15339,'{16831}=1','{#SNMPVALUE}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15340,'{16832}=1','#{#SNMPVALUE}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15341,'{16833}=1','#{#SNMPVALUE}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15342,'{16834}>{$TEMP_WARN:\"\"}\r\nor\r\n{16835}={$TEMP_WARN_STATUS}','{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{16836}<{$TEMP_WARN:\"\"}-3',0,'',0),(15343,'{16837}>{$TEMP_CRIT:\"\"}\r\nor\r\n{16838}={$TEMP_CRIT_STATUS}\r\nor\r\n{16838}={$TEMP_DISASTER_STATUS}','{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{16839}<{$TEMP_CRIT:\"\"}-3',0,'',0),(15344,'{16840}=1 or {16841}=1','{#SENSOR_INFO}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15345,'{16842}=1 or {16843}=1','{#SENSOR_INFO}: Power supply is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15346,'{16844}=1 or {16845}=1','{#SENSOR_INFO}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15347,'{16846}=1 or {16847}=1','{#SENSOR_INFO}: Fan is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15348,'{16848}>{$TEMP_WARN:\"\"}\r\nor\r\n{16849}={$TEMP_WARN_STATUS}','{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',15342,0,0,2,1,'{16850}<{$TEMP_WARN:\"\"}-3',0,'',0),(15349,'{16851}>{$TEMP_WARN:\"\"}\r\nor\r\n{16852}={$TEMP_WARN_STATUS}','{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',15342,0,0,2,1,'{16853}<{$TEMP_WARN:\"\"}-3',0,'',0),(15350,'{16854}>{$TEMP_WARN:\"\"}\r\nor\r\n{16855}={$TEMP_WARN_STATUS}','{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',15342,0,0,2,1,'{16856}<{$TEMP_WARN:\"\"}-3',0,'',0),(15351,'{16857}>{$TEMP_CRIT:\"\"}\r\nor\r\n{16858}={$TEMP_CRIT_STATUS}\r\nor\r\n{16858}={$TEMP_DISASTER_STATUS}','{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',15343,0,0,2,1,'{16859}<{$TEMP_CRIT:\"\"}-3',0,'',0),(15352,'{16860}>{$TEMP_CRIT:\"\"}\r\nor\r\n{16861}={$TEMP_CRIT_STATUS}\r\nor\r\n{16861}={$TEMP_DISASTER_STATUS}','{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',15343,0,0,2,1,'{16862}<{$TEMP_CRIT:\"\"}-3',0,'',0),(15353,'{16863}>{$TEMP_CRIT:\"\"}\r\nor\r\n{16864}={$TEMP_CRIT_STATUS}\r\nor\r\n{16864}={$TEMP_DISASTER_STATUS}','{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',15343,0,0,2,1,'{16865}<{$TEMP_CRIT:\"\"}-3',0,'',0),(15354,'{16866}=1 or {16867}=1','{#SENSOR_INFO}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',15344,0,0,2,0,'',0,'',0),(15355,'{16868}=1 or {16869}=1','{#SENSOR_INFO}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',15344,0,0,2,0,'',0,'',0),(15356,'{16870}=1 or {16871}=1','{#SENSOR_INFO}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',15344,0,0,2,0,'',0,'',0),(15357,'{16872}=1 or {16873}=1','{#SENSOR_INFO}: Power supply is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',15345,0,0,2,0,'',0,'',0),(15358,'{16874}=1 or {16875}=1','{#SENSOR_INFO}: Power supply is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',15345,0,0,2,0,'',0,'',0),(15359,'{16876}=1 or {16877}=1','{#SENSOR_INFO}: Power supply is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',15345,0,0,2,0,'',0,'',0),(15360,'{16878}=1 or {16879}=1','{#SENSOR_INFO}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',15346,0,0,2,0,'',0,'',0),(15361,'{16880}=1 or {16881}=1','{#SENSOR_INFO}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',15346,0,0,2,0,'',0,'',0),(15362,'{16882}=1 or {16883}=1','{#SENSOR_INFO}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',15346,0,0,2,0,'',0,'',0),(15363,'{16884}=1 or {16885}=1','{#SENSOR_INFO}: Fan is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',15347,0,0,2,0,'',0,'',0),(15364,'{16886}=1 or {16887}=1','{#SENSOR_INFO}: Fan is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',15347,0,0,2,0,'',0,'',0),(15365,'{16888}=1 or {16889}=1','{#SENSOR_INFO}: Fan is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',15347,0,0,2,0,'',0,'',0),(15366,'{16890}=1','{#SNMPVALUE}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15367,'{16891}=1','{#SNMPVALUE}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15368,'{16892}>{$TEMP_CRIT:\"\"}\r\nor\r\n{16893}={$TEMP_CRIT_STATUS}','Device: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,0,1,'{16894}<{$TEMP_CRIT:\"\"}-3',0,'',0),(15369,'{16895}=1','PSU {#SNMPVALUE}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15370,'{16896}=1','Fan {#SNMPVALUE}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15371,'{16897}=1 or {16898}=1','{#ENT_NAME}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15372,'{16899}=1 or {16900}=1 or {16901}=1','{#ENT_NAME}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15373,'{16902}=1','{#ENT_DESCR}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15374,'{16903}=1','{#ENT_DESCR}: Fan is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15375,'{16904}=1','{#ENT_DESCR}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15376,'{16905}=1','{#ENT_DESCR}: Power supply is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15377,'{16906}=1','{#SNMPVALUE}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15378,'{16907}=1','{#SNMPVALUE}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15379,'{16908}=1','PSU {#PSU_INDEX}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15380,'{16909}=1','PSU {#PSU_INDEX}: Power supply is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15381,'{16910}=1','Fan {#FAN_INDEX}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15382,'{16911}=1','Fan {#FAN_INDEX}: Fan is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15383,'{16912}=1','Unit {#PSU_UNIT} PSU {#PSU_INDEX}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15384,'{16913}=1','Unit {#PSU_UNIT} PSU {#PSU_INDEX}: Power supply is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15385,'{16914}=1','Unit {#FAN_UNIT} Fan {#FAN_INDEX}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15386,'{16915}=1','Unit {#FAN_UNIT} Fan {#FAN_INDEX}: Fan is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15387,'{16916}>{$TEMP_WARN:\"\"}\r\nor\r\n{16917}={$TEMP_WARN_STATUS}','{#SENSOR_INFO}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{16918}<{$TEMP_WARN:\"\"}-3',0,'',0),(15388,'{16919}=1','{#SENSOR_INFO}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15389,'{16920}=1','{#ENT_NAME}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15390,'{16921}>{$TEMP_WARN:\"\"}\r\nor\r\n{16922}={$TEMP_WARN_STATUS}','{#SENSOR_INFO}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{16923}<{$TEMP_WARN:\"\"}-3',0,'',0),(15391,'{16924}=1','{#SENSOR_INFO}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15392,'{16925}=1','{#SENSOR_INFO}: Power supply is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15393,'{16926}=1','{#SENSOR_INFO}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15394,'{16927}=1','{#SENSOR_INFO}: Fan is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15395,'{16928}=1','#{#SNMPVALUE}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15396,'{16929}>{$TEMP_WARN:\"\"}\r\nor\r\n{16930}={$TEMP_WARN_STATUS}','#{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{16931}<{$TEMP_WARN:\"\"}-3',0,'',0),(15397,'{16932}>{$TEMP_CRIT:\"\"}\r\nor\r\n{16933}={$TEMP_CRIT_STATUS}','#{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{16934}<{$TEMP_CRIT:\"\"}-3',0,'',0),(15398,'{16935}=1','#{#SNMPVALUE}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15399,'{16936}=1','#{#SNMPVALUE}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15490,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17237}=2 and {17238}=1)','Interface {#IFDESCR}: Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',NULL,0,0,2,1,'{17237}<>2',0,'',0),(15492,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17241}=2 and {17242}=1)','Interface {#IFDESCR}: Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15490,0,0,2,1,'{17241}<>2',0,'',0),(15493,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17243}=2 and {17244}=1)','Interface {#IFDESCR}: Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15490,0,0,2,1,'{17243}<>2',0,'',0),(15496,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17249}=2 and {17250}=1)','Interface {#IFDESCR}: Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',NULL,0,0,2,1,'{17249}<>2',0,'',0),(15498,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17253}=2 and {17254}=1)','Interface {#IFDESCR}: Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15496,0,0,2,1,'{17253}<>2',0,'',0),(15499,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17255}=2 and {17256}=1)','Interface {#IFDESCR}: Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15496,0,0,2,1,'{17255}<>2',0,'',0),(15502,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17261}=2 and {17262}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Current state: {ITEM.LASTVALUE1}\r\nThis trigger expression works as follows:\r\n1. Can be triggered if operations status is down.\r\n2. {$IFCONTROL:\"{#IFNAME}\"}=1 - user can redefine Context macro to value - 0. That marks this interface as not important. No new trigger will be fired if this interface is down.\r\n3. {TEMPLATE_NAME:METRIC.diff()}=1) - trigger fires only if operational status was up(1) sometime before. (So, do not fire \'ethernal off\' interfaces.)\r\n\r\nWARNING: if closed manually - won\'t fire again on next poll, because of .diff.','',NULL,0,0,2,1,'{17261}<>2',0,'',1),(15504,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17265}=2 and {17266}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Current state: {ITEM.LASTVALUE1}\r\nThis trigger expression works as follows:\r\n1. Can be triggered if operations status is down.\r\n2. {$IFCONTROL:\"{#IFNAME}\"}=1 - user can redefine Context macro to value - 0. That marks this interface as not important. No new trigger will be fired if this interface is down.\r\n3. {TEMPLATE_NAME:METRIC.diff()}=1) - trigger fires only if operational status was up(1) sometime before. (So, do not fire \'ethernal off\' interfaces.)\r\n\r\nWARNING: if closed manually - won\'t fire again on next poll, because of .diff.','',15502,0,0,2,1,'{17265}<>2',0,'',1),(15506,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17269}=2 and {17270}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',NULL,0,0,2,1,'{17269}<>2',0,'',0),(15508,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17273}=2 and {17274}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',NULL,0,0,2,1,'{17273}<>2',0,'',0),(15510,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17277}=2 and {17278}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17277}<>2',0,'',0),(15511,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17279}=2 and {17280}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17279}<>2',0,'',0),(15512,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17281}=2 and {17282}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17281}<>2',0,'',0),(15513,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17283}=2 and {17284}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17283}<>2',0,'',0),(15514,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17285}=2 and {17286}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17285}<>2',0,'',0),(15515,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17287}=2 and {17288}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17287}<>2',0,'',0),(15516,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17289}=2 and {17290}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17289}<>2',0,'',0),(15517,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17291}=2 and {17292}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17291}<>2',0,'',0),(15518,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17293}=2 and {17294}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17293}<>2',0,'',0),(15519,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17295}=2 and {17296}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17295}<>2',0,'',0),(15520,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17297}=2 and {17298}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17297}<>2',0,'',0),(15521,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17299}=2 and {17300}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17299}<>2',0,'',0),(15522,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17301}=2 and {17302}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17301}<>2',0,'',0),(15523,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17303}=2 and {17304}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17303}<>2',0,'',0),(15524,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17305}=2 and {17306}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17305}<>2',0,'',0),(15525,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17307}=2 and {17308}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17307}<>2',0,'',0),(15526,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17309}=2 and {17310}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17309}<>2',0,'',0),(15527,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17311}=2 and {17312}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17311}<>2',0,'',0),(15528,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17313}=2 and {17314}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17313}<>2',0,'',0),(15529,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17315}=2 and {17316}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17315}<>2',0,'',0),(15550,'({17357}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17358} or\r\n{17359}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17358}) and\r\n{17358}>0','Interface {#IFDESCR}: High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17357}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17358} and\r\n{17359}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17358}',0,'',1),(15551,'{17360}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17361}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFDESCR}: High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',NULL,0,0,2,1,'{17360}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17361}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15553,'({17367}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17368} or\r\n{17369}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17368}) and\r\n{17368}>0','Interface {#IFDESCR}: High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15550,0,0,2,1,'{17367}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17368} and\r\n{17369}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17368}',0,'',1),(15554,'({17370}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17371} or\r\n{17372}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17371}) and\r\n{17371}>0','Interface {#IFDESCR}: High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15550,0,0,2,1,'{17370}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17371} and\r\n{17372}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17371}',0,'',1),(15555,'{17373}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17374}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFDESCR}: High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15551,0,0,2,1,'{17373}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17374}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15556,'{17375}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17376}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFDESCR}: High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15551,0,0,2,1,'{17375}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17376}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15559,'({17387}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17388} or\r\n{17389}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17388}) and\r\n{17388}>0','Interface {#IFDESCR}: High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17387}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17388} and\r\n{17389}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17388}',0,'',1),(15560,'{17390}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17391}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFDESCR}: High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',NULL,0,0,2,1,'{17390}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17391}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15562,'({17397}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17398} or\r\n{17399}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17398}) and\r\n{17398}>0','Interface {#IFDESCR}: High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15559,0,0,2,1,'{17397}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17398} and\r\n{17399}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17398}',0,'',1),(15563,'({17400}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17401} or\r\n{17402}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17401}) and\r\n{17401}>0','Interface {#IFDESCR}: High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15559,0,0,2,1,'{17400}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17401} and\r\n{17402}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17401}',0,'',1),(15564,'{17403}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17404}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFDESCR}: High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15560,0,0,2,1,'{17403}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17404}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15565,'{17405}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17406}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFDESCR}: High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15560,0,0,2,1,'{17405}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17406}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15574,'({17437}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17438} or\r\n{17439}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17438}) and\r\n{17438}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17437}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17438} and\r\n{17439}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17438}',0,'',1),(15575,'{17440}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17441}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',NULL,0,0,2,1,'{17440}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17441}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15577,'({17447}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17448} or\r\n{17449}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17448}) and\r\n{17448}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17447}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17448} and\r\n{17449}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17448}',0,'',1),(15578,'{17450}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17451}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',NULL,0,0,2,1,'{17450}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17451}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15580,'({17457}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17458} or\r\n{17459}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17458}) and\r\n{17458}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17457}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17458} and\r\n{17459}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17458}',0,'',1),(15581,'({17460}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17461} or\r\n{17462}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17461}) and\r\n{17461}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17460}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17461} and\r\n{17462}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17461}',0,'',1),(15582,'({17463}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17464} or\r\n{17465}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17464}) and\r\n{17464}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17463}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17464} and\r\n{17465}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17464}',0,'',1),(15583,'({17466}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17467} or\r\n{17468}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17467}) and\r\n{17467}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17466}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17467} and\r\n{17468}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17467}',0,'',1),(15584,'({17469}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17470} or\r\n{17471}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17470}) and\r\n{17470}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17469}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17470} and\r\n{17471}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17470}',0,'',1),(15585,'({17472}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17473} or\r\n{17474}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17473}) and\r\n{17473}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17472}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17473} and\r\n{17474}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17473}',0,'',1),(15586,'({17475}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17476} or\r\n{17477}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17476}) and\r\n{17476}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17475}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17476} and\r\n{17477}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17476}',0,'',1),(15587,'({17478}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17479} or\r\n{17480}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17479}) and\r\n{17479}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17478}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17479} and\r\n{17480}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17479}',0,'',1),(15588,'({17481}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17482} or\r\n{17483}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17482}) and\r\n{17482}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17481}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17482} and\r\n{17483}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17482}',0,'',1),(15589,'({17484}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17485} or\r\n{17486}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17485}) and\r\n{17485}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17484}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17485} and\r\n{17486}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17485}',0,'',1),(15590,'({17487}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17488} or\r\n{17489}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17488}) and\r\n{17488}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17487}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17488} and\r\n{17489}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17488}',0,'',1),(15591,'({17490}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17491} or\r\n{17492}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17491}) and\r\n{17491}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17490}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17491} and\r\n{17492}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17491}',0,'',1),(15592,'({17493}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17494} or\r\n{17495}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17494}) and\r\n{17494}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17493}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17494} and\r\n{17495}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17494}',0,'',1),(15593,'({17496}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17497} or\r\n{17498}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17497}) and\r\n{17497}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17496}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17497} and\r\n{17498}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17497}',0,'',1),(15594,'({17499}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17500} or\r\n{17501}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17500}) and\r\n{17500}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17499}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17500} and\r\n{17501}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17500}',0,'',1),(15595,'({17502}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17503} or\r\n{17504}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17503}) and\r\n{17503}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17502}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17503} and\r\n{17504}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17503}',0,'',1),(15596,'({17505}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17506} or\r\n{17507}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17506}) and\r\n{17506}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17505}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17506} and\r\n{17507}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17506}',0,'',1),(15597,'({17508}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17509} or\r\n{17510}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17509}) and\r\n{17509}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17508}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17509} and\r\n{17510}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17509}',0,'',1),(15598,'({17511}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17512} or\r\n{17513}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17512}) and\r\n{17512}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17511}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17512} and\r\n{17513}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17512}',0,'',1),(15599,'({17514}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17515} or\r\n{17516}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17515}) and\r\n{17515}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17514}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17515} and\r\n{17516}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17515}',0,'',1),(15600,'{17517}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17518}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17517}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17518}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15601,'{17519}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17520}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17519}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17520}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15602,'{17521}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17522}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17521}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17522}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15603,'{17523}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17524}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17523}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17524}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15604,'{17525}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17526}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17525}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17526}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15605,'{17527}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17528}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17527}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17528}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15606,'{17529}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17530}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17529}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17530}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15607,'{17531}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17532}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17531}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17532}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15608,'{17533}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17534}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17533}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17534}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15609,'{17535}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17536}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17535}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17536}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15610,'{17537}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17538}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17537}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17538}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15611,'{17539}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17540}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17539}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17540}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15612,'{17541}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17542}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17541}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17542}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15613,'{17543}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17544}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17543}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17544}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15614,'{17545}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17546}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17545}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17546}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15615,'{17547}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17548}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17547}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17548}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15616,'{17549}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17550}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17549}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17550}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15617,'{17551}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17552}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17551}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17552}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15618,'{17553}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17554}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17553}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17554}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15619,'{17555}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17556}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17555}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17556}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15640,'{17657}>75','More than 75% used in the vmware cache','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(15641,'{17658}>75','Zabbix vmware collector processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{17658}<65',0,'',0),(15642,'{17659}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',NULL,0,0,0,0,'',0,'',1),(15643,'{17660}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15642,0,0,0,0,'',0,'',1),(15644,'{17661}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15642,0,0,0,0,'',0,'',1),(15645,'{17662}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',NULL,0,0,0,0,'',0,'',1),(15646,'{17663}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15647,'{17664}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15648,'{17665}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15649,'{17666}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15650,'{17667}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15651,'{17668}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15652,'{17669}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15653,'{17670}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15654,'{17671}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15655,'{17672}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15656,'{17673}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15657,'{17674}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15658,'{17675}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15659,'{17676}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15660,'{17677}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15661,'{17678}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15662,'{17679}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15663,'{17680}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15664,'{17681}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15665,'{17682}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15666,'{17683}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15667,'{17684}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15668,'{17685}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15669,'{17686}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15670,'{17687}<0 and {17688}>0\r\nand (\r\n{17689}=6 or\r\n{17689}=7 or\r\n{17689}=11 or\r\n{17689}=62 or\r\n{17689}=69 or\r\n{17689}=117\r\n)\r\nand\r\n({17690}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',NULL,0,0,2,1,'({17687}>0 and {17691}>0) or\r\n({17690}=2)',0,'',1),(15671,'{17692}<0 and {17693}>0\r\nand (\r\n{17694}=6 or\r\n{17694}=7 or\r\n{17694}=11 or\r\n{17694}=62 or\r\n{17694}=69 or\r\n{17694}=117\r\n)\r\nand\r\n({17695}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',NULL,0,0,2,1,'({17692}>0 and {17696}>0) or\r\n({17695}=2)',0,'',1),(15672,'{17697}<0 and {17698}>0\r\nand (\r\n{17699}=6 or\r\n{17699}=7 or\r\n{17699}=11 or\r\n{17699}=62 or\r\n{17699}=69 or\r\n{17699}=117\r\n)\r\nand\r\n({17700}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17697}>0 and {17701}>0) or\r\n({17700}=2)',0,'',1),(15673,'{17702}<0 and {17703}>0\r\nand (\r\n{17704}=6 or\r\n{17704}=7 or\r\n{17704}=11 or\r\n{17704}=62 or\r\n{17704}=69 or\r\n{17704}=117\r\n)\r\nand\r\n({17705}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17702}>0 and {17706}>0) or\r\n({17705}=2)',0,'',1),(15674,'{17707}<0 and {17708}>0\r\nand (\r\n{17709}=6 or\r\n{17709}=7 or\r\n{17709}=11 or\r\n{17709}=62 or\r\n{17709}=69 or\r\n{17709}=117\r\n)\r\nand\r\n({17710}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17707}>0 and {17711}>0) or\r\n({17710}=2)',0,'',1),(15675,'{17712}<0 and {17713}>0\r\nand (\r\n{17714}=6 or\r\n{17714}=7 or\r\n{17714}=11 or\r\n{17714}=62 or\r\n{17714}=69 or\r\n{17714}=117\r\n)\r\nand\r\n({17715}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17712}>0 and {17716}>0) or\r\n({17715}=2)',0,'',1),(15676,'{17717}<0 and {17718}>0\r\nand (\r\n{17719}=6 or\r\n{17719}=7 or\r\n{17719}=11 or\r\n{17719}=62 or\r\n{17719}=69 or\r\n{17719}=117\r\n)\r\nand\r\n({17720}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17717}>0 and {17721}>0) or\r\n({17720}=2)',0,'',1),(15677,'{17722}<0 and {17723}>0\r\nand (\r\n{17724}=6 or\r\n{17724}=7 or\r\n{17724}=11 or\r\n{17724}=62 or\r\n{17724}=69 or\r\n{17724}=117\r\n)\r\nand\r\n({17725}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17722}>0 and {17726}>0) or\r\n({17725}=2)',0,'',1),(15678,'{17727}<0 and {17728}>0\r\nand (\r\n{17729}=6 or\r\n{17729}=7 or\r\n{17729}=11 or\r\n{17729}=62 or\r\n{17729}=69 or\r\n{17729}=117\r\n)\r\nand\r\n({17730}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17727}>0 and {17731}>0) or\r\n({17730}=2)',0,'',1),(15679,'{17732}<0 and {17733}>0\r\nand (\r\n{17734}=6 or\r\n{17734}=7 or\r\n{17734}=11 or\r\n{17734}=62 or\r\n{17734}=69 or\r\n{17734}=117\r\n)\r\nand\r\n({17735}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17732}>0 and {17736}>0) or\r\n({17735}=2)',0,'',1),(15680,'{17737}<0 and {17738}>0\r\nand (\r\n{17739}=6 or\r\n{17739}=7 or\r\n{17739}=11 or\r\n{17739}=62 or\r\n{17739}=69 or\r\n{17739}=117\r\n)\r\nand\r\n({17740}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17737}>0 and {17741}>0) or\r\n({17740}=2)',0,'',1),(15681,'{17742}<0 and {17743}>0\r\nand (\r\n{17744}=6 or\r\n{17744}=7 or\r\n{17744}=11 or\r\n{17744}=62 or\r\n{17744}=69 or\r\n{17744}=117\r\n)\r\nand\r\n({17745}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17742}>0 and {17746}>0) or\r\n({17745}=2)',0,'',1),(15682,'{17747}<0 and {17748}>0\r\nand (\r\n{17749}=6 or\r\n{17749}=7 or\r\n{17749}=11 or\r\n{17749}=62 or\r\n{17749}=69 or\r\n{17749}=117\r\n)\r\nand\r\n({17750}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17747}>0 and {17751}>0) or\r\n({17750}=2)',0,'',1),(15683,'{17752}<0 and {17753}>0\r\nand (\r\n{17754}=6 or\r\n{17754}=7 or\r\n{17754}=11 or\r\n{17754}=62 or\r\n{17754}=69 or\r\n{17754}=117\r\n)\r\nand\r\n({17755}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17752}>0 and {17756}>0) or\r\n({17755}=2)',0,'',1),(15684,'{17757}<0 and {17758}>0\r\nand (\r\n{17759}=6 or\r\n{17759}=7 or\r\n{17759}=11 or\r\n{17759}=62 or\r\n{17759}=69 or\r\n{17759}=117\r\n)\r\nand\r\n({17760}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17757}>0 and {17761}>0) or\r\n({17760}=2)',0,'',1),(15685,'{17762}<0 and {17763}>0\r\nand (\r\n{17764}=6 or\r\n{17764}=7 or\r\n{17764}=11 or\r\n{17764}=62 or\r\n{17764}=69 or\r\n{17764}=117\r\n)\r\nand\r\n({17765}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17762}>0 and {17766}>0) or\r\n({17765}=2)',0,'',1),(15686,'{17767}<0 and {17768}>0\r\nand (\r\n{17769}=6 or\r\n{17769}=7 or\r\n{17769}=11 or\r\n{17769}=62 or\r\n{17769}=69 or\r\n{17769}=117\r\n)\r\nand\r\n({17770}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17767}>0 and {17771}>0) or\r\n({17770}=2)',0,'',1),(15687,'{17772}<0 and {17773}>0\r\nand (\r\n{17774}=6 or\r\n{17774}=7 or\r\n{17774}=11 or\r\n{17774}=62 or\r\n{17774}=69 or\r\n{17774}=117\r\n)\r\nand\r\n({17775}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17772}>0 and {17776}>0) or\r\n({17775}=2)',0,'',1),(15688,'{17777}<0 and {17778}>0\r\nand (\r\n{17779}=6 or\r\n{17779}=7 or\r\n{17779}=11 or\r\n{17779}=62 or\r\n{17779}=69 or\r\n{17779}=117\r\n)\r\nand\r\n({17780}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17777}>0 and {17781}>0) or\r\n({17780}=2)',0,'',1),(15689,'{17782}<0 and {17783}>0\r\nand (\r\n{17784}=6 or\r\n{17784}=7 or\r\n{17784}=11 or\r\n{17784}=62 or\r\n{17784}=69 or\r\n{17784}=117\r\n)\r\nand\r\n({17785}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17782}>0 and {17786}>0) or\r\n({17785}=2)',0,'',1),(15690,'{17787}<0 and {17788}>0\r\nand (\r\n{17789}=6 or\r\n{17789}=7 or\r\n{17789}=11 or\r\n{17789}=62 or\r\n{17789}=69 or\r\n{17789}=117\r\n)\r\nand\r\n({17790}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17787}>0 and {17791}>0) or\r\n({17790}=2)',0,'',1),(15691,'{17792}<0 and {17793}>0\r\nand (\r\n{17794}=6 or\r\n{17794}=7 or\r\n{17794}=11 or\r\n{17794}=62 or\r\n{17794}=69 or\r\n{17794}=117\r\n)\r\nand\r\n({17795}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17792}>0 and {17796}>0) or\r\n({17795}=2)',0,'',1),(15692,'{17797}<0 and {17798}>0\r\nand (\r\n{17799}=6 or\r\n{17799}=7 or\r\n{17799}=11 or\r\n{17799}=62 or\r\n{17799}=69 or\r\n{17799}=117\r\n)\r\nand\r\n({17800}<>2)','Interface {#IFDESCR}: Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',NULL,0,0,2,1,'({17797}>0 and {17801}>0) or\r\n({17800}=2)',0,'',1),(15693,'{17802}<0 and {17803}>0\r\nand (\r\n{17804}=6 or\r\n{17804}=7 or\r\n{17804}=11 or\r\n{17804}=62 or\r\n{17804}=69 or\r\n{17804}=117\r\n)\r\nand\r\n({17805}<>2)','Interface {#IFDESCR}: Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15692,0,0,2,1,'({17802}>0 and {17806}>0) or\r\n({17805}=2)',0,'',1),(15694,'{17807}<0 and {17808}>0\r\nand (\r\n{17809}=6 or\r\n{17809}=7 or\r\n{17809}=11 or\r\n{17809}=62 or\r\n{17809}=69 or\r\n{17809}=117\r\n)\r\nand\r\n({17810}<>2)','Interface {#IFDESCR}: Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15692,0,0,2,1,'({17807}>0 and {17811}>0) or\r\n({17810}=2)',0,'',1),(15695,'{17812}<0 and {17813}>0\r\nand (\r\n{17814}=6 or\r\n{17814}=7 or\r\n{17814}=11 or\r\n{17814}=62 or\r\n{17814}=69 or\r\n{17814}=117\r\n)\r\nand\r\n({17815}<>2)','Interface {#IFDESCR}: Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',NULL,0,0,2,1,'({17812}>0 and {17816}>0) or\r\n({17815}=2)',0,'',1),(15696,'{17817}<0 and {17818}>0\r\nand (\r\n{17819}=6 or\r\n{17819}=7 or\r\n{17819}=11 or\r\n{17819}=62 or\r\n{17819}=69 or\r\n{17819}=117\r\n)\r\nand\r\n({17820}<>2)','Interface {#IFDESCR}: Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15695,0,0,2,1,'({17817}>0 and {17821}>0) or\r\n({17820}=2)',0,'',1),(15697,'{17822}<0 and {17823}>0\r\nand (\r\n{17824}=6 or\r\n{17824}=7 or\r\n{17824}=11 or\r\n{17824}=62 or\r\n{17824}=69 or\r\n{17824}=117\r\n)\r\nand\r\n({17825}<>2)','Interface {#IFDESCR}: Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15695,0,0,2,1,'({17822}>0 and {17826}>0) or\r\n({17825}=2)',0,'',1),(15698,'{17827}<0 and {17828}>0\r\nand (\r\n{17829}=6 or\r\n{17829}=7 or\r\n{17829}=11 or\r\n{17829}=62 or\r\n{17829}=69 or\r\n{17829}=117\r\n)\r\nand\r\n({17830}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Current reported speed: {ITEM.LASTVALUE1}\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',NULL,0,0,2,1,'({17827}>0 and {17831}>0) or\r\n({17830}=2)',0,'',1),(15699,'{17832}<0 and {17833}>0\r\nand (\r\n{17834}=6 or\r\n{17834}=7 or\r\n{17834}=11 or\r\n{17834}=62 or\r\n{17834}=69 or\r\n{17834}=117\r\n)\r\nand\r\n({17835}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Current reported speed: {ITEM.LASTVALUE1}\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15698,0,0,2,1,'({17832}>0 and {17836}>0) or\r\n({17835}=2)',0,'',1),(15700,'{17837}=2','Interface {#IFNAME}({#IFALIAS}): In half-duplex mode','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check autonegotiation settings and cabling','',14941,0,0,2,0,'',0,'',1),(15701,'{17838}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(15702,'{17839}>{$ICMP_LOSS_WARN} and {17839}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(15703,'{17840}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(15704,'{17841}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15705,'{17842}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15706,'{17843}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}\r\nor {17844}>{$IF_ERRORS_WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nRecovers when below 80% of {$IF_ERRORS_WARN:\"{#IFNAME}\"} threshold','',15578,0,0,2,1,'{17843}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8\r\nand {17844}<{$IF_ERRORS_WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15707,'({17845}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17846} or\r\n{17847}>({$IF_UTIL_MAX:\"{#IFNAME}\"}/100)*{17846}) and\r\n{17846}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage >{$IF_UTIL_MAX:\"{#IFNAME}\"}%','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',15577,0,0,2,1,'{17845}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17846} and\r\n{17847}<(({$IF_UTIL_MAX:\"{#IFNAME}\"}-3)/100)*{17846}',0,'',1),(15708,'{17848}<0 and {17849}>0\r\nand (\r\n{17850}=6 or\r\n{17850}=7 or\r\n{17850}=11 or\r\n{17850}=62 or\r\n{17850}=69 or\r\n{17850}=117\r\n)\r\nand\r\n({17851}<>2)','Interface {#IFNAME}({#IFALIAS}): Ethernet has changed to lower speed than it was before','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis Ethernet connection has transitioned down from its known maximum speed. This might be a sign of autonegotiation issues. Ack to close.','',15671,0,0,2,1,'({17848}>0 and {17852}>0) or\r\n({17851}=2)',0,'',1),(15709,'{$IFCONTROL:\"{#IFNAME}\"}=1 and ({17853}=2 and {17854}=1)','Interface {#IFNAME}({#IFALIAS}): Link down','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nInterface is down','',15508,0,0,2,1,'{17853}<>2',0,'',0),(15714,'{17859}>{$TEMP_WARN:\"\"}\r\nor\r\n{17860}={$TEMP_WARN_STATUS}','{#SENSOR_INFO}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Current value: {ITEM.LASTVALUE1}\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17861}<{$TEMP_WARN:\"\"}-3',0,'',0),(15715,'{17862}>{$TEMP_CRIT:\"\"}','{#SENSOR_INFO}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Current value: {ITEM.LASTVALUE1}\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17863}<{$TEMP_CRIT:\"\"}-3',0,'',0),(15716,'{17864}<{$TEMP_CRIT_LOW:\"\"}','{#SENSOR_INFO}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Current value: {ITEM.LASTVALUE1}','',NULL,0,0,2,1,'{17865}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(15717,'{17866}=1','{#SENSOR_INFO}: Fan is in critical state','',0,0,3,0,'Current state: {ITEM.LASTVALUE1}\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15718,'{17867}=1 and {17868}>0','{#ENT_NAME}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}\r\nDevice serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1),(15719,'{17869}=1','{#ENT_NAME}: Power supply is in critical state','',0,0,3,0,'Current state: {ITEM.LASTVALUE1}\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15720,'{17870}=1','System status is in critical state','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for errors','',NULL,0,0,0,0,'',0,'',0),(15721,'{17871}=1 or {17872}=1','System status is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for warnings','',NULL,0,0,0,0,'',0,'',0),(15722,'{17873}=1','System status is in critical state','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for errors','',NULL,0,0,0,0,'',0,'',0),(15723,'{17874}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(15724,'{17875}>{$ICMP_LOSS_WARN} and {17875}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(15725,'{17876}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(15726,'{17877}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15727,'{17878}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15728,'{17879}=1','System is in unrecoverable state!','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,0,0,'',0,'',0),(15729,'{17880}=1','System status is in critical state','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for errors','',NULL,0,0,0,0,'',0,'',0),(15730,'{17881}=1','System status is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for warnings','',NULL,0,0,0,0,'',0,'',0),(15731,'{17882}=1 and {17883}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(15732,'{17884}=1 and {17885}>0','Firmware has changed','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nFirmware version has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(15733,'{17886}>{$TEMP_WARN:\"CPU\"}\r\nor\r\n{17887}={$TEMP_WARN_STATUS}','{#SENSOR_LOCALE}: Temperature is above warning threshold: >{$TEMP_WARN:\"CPU\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17888}<{$TEMP_WARN:\"CPU\"}-3',0,'',0),(15734,'{17889}>{$TEMP_CRIT:\"CPU\"}\r\nor\r\n{17890}={$TEMP_CRIT_STATUS}\r\nor\r\n{17890}={$TEMP_DISASTER_STATUS}','{#SENSOR_LOCALE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"CPU\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17891}<{$TEMP_CRIT:\"CPU\"}-3',0,'',0),(15735,'{17892}<{$TEMP_CRIT_LOW:\"CPU\"}','{#SENSOR_LOCALE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"CPU\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17893}>{$TEMP_CRIT_LOW:\"CPU\"}+3',0,'',0),(15736,'{17894}>{$TEMP_WARN:\"Ambient\"}\r\nor\r\n{17895}={$TEMP_WARN_STATUS}','{#SENSOR_LOCALE}: Temperature is above warning threshold: >{$TEMP_WARN:\"Ambient\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17896}<{$TEMP_WARN:\"Ambient\"}-3',0,'',0),(15737,'{17897}>{$TEMP_CRIT:\"Ambient\"}\r\nor\r\n{17898}={$TEMP_CRIT_STATUS}\r\nor\r\n{17898}={$TEMP_DISASTER_STATUS}','{#SENSOR_LOCALE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"Ambient\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17899}<{$TEMP_CRIT:\"Ambient\"}-3',0,'',0),(15738,'{17900}<{$TEMP_CRIT_LOW:\"Ambient\"}','{#SENSOR_LOCALE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"Ambient\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17901}>{$TEMP_CRIT_LOW:\"Ambient\"}+3',0,'',0),(15739,'{17902}=1 or {17903}=1','{#PSU_DESCR}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15740,'{17904}=1','{#PSU_DESCR}: Power supply is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15741,'{17905}=1 or {17906}=1 or {17907}=1 or {17908}=1 or {17909}=1','{#FAN_DESCR}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15742,'{17910}=1 or {17911}=1','{#FAN_DESCR}: Fan is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15743,'{17912}=1 or {17913}=1','{#DISK_NAME}: Physical disk failed','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check physical disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0),(15744,'{17914}=1','{#DISK_NAME}: Physical disk is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check physical disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0),(15745,'{17915}=1 and {17916}>0','{#DISK_NAME}: Disk has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDisk serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1),(15746,'{17917}=1','{#DISK_NAME}: Physical disk S.M.A.R.T. failed','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nDisk probably requires replacement.','',NULL,0,0,2,0,'',0,'',0),(15747,'{17918}=1','Disk {#SNMPVALUE}({#DISK_NAME}): Virtual disk failed','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check virtual disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0),(15748,'{17919}=1','Disk {#SNMPVALUE}({#DISK_NAME}): Virtual disk is in warning state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check virtual disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0),(15749,'{17920}=1','{#CNTLR_NAME}: Disk array controller is in unrecoverable state!','',0,0,5,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0),(15750,'{17921}=1','{#CNTLR_NAME}: Disk array controller is in critical state','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0),(15751,'{17922}=1','{#CNTLR_NAME}: Disk array controller is in warning state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0),(15752,'{17923}=1','Battery {#BATTERY_NUM}: Disk array cache controller battery is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0),(15753,'{17924}=1','Battery {#BATTERY_NUM}: Disk array cache controller battery is not in optimal state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0),(15754,'{17925}=1','Battery {#BATTERY_NUM}: Disk array cache controller battery is in critical state!','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0),(15755,'{17926}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(15756,'{17927}>{$ICMP_LOSS_WARN} and {17927}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(15757,'{17928}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(15758,'{17929}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15759,'{17930}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15762,'{17933}=1 and {17934}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(15763,'{17935}>{$TEMP_WARN:\"{#SNMPINDEX}\"}','{#SNMPINDEX}: Temperature is above warning threshold: >{$TEMP_WARN:\"{#SNMPINDEX}\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17936}<{$TEMP_WARN:\"{#SNMPINDEX}\"}-3',0,'',0),(15764,'{17937}>{$TEMP_CRIT:\"{#SNMPINDEX}\"}','{#SNMPINDEX}: Temperature is above critical threshold: >{$TEMP_CRIT:\"{#SNMPINDEX}\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17938}<{$TEMP_CRIT:\"{#SNMPINDEX}\"}-3',0,'',0),(15765,'{17939}<{$TEMP_CRIT_LOW:\"{#SNMPINDEX}\"}','{#SNMPINDEX}: Temperature is too low: <{$TEMP_CRIT_LOW:\"{#SNMPINDEX}\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17940}>{$TEMP_CRIT_LOW:\"{#SNMPINDEX}\"}+3',0,'',0),(15766,'{17941}>{$TEMP_WARN:\"Ambient\"}','Ambient: Temperature is above warning threshold: >{$TEMP_WARN:\"Ambient\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17942}<{$TEMP_WARN:\"Ambient\"}-3',0,'',0),(15767,'{17943}>{$TEMP_CRIT:\"Ambient\"}','Ambient: Temperature is above critical threshold: >{$TEMP_CRIT:\"Ambient\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17944}<{$TEMP_CRIT:\"Ambient\"}-3',0,'',0),(15768,'{17945}<{$TEMP_CRIT_LOW:\"Ambient\"}','Ambient: Temperature is too low: <{$TEMP_CRIT_LOW:\"Ambient\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17946}>{$TEMP_CRIT_LOW:\"Ambient\"}+3',0,'',0),(15769,'{17947}>{$TEMP_WARN:\"CPU\"}','CPU-{#SNMPINDEX}: Temperature is above warning threshold: >{$TEMP_WARN:\"CPU\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17948}<{$TEMP_WARN:\"CPU\"}-3',0,'',0),(15770,'{17949}>{$TEMP_CRIT:\"CPU\"}','CPU-{#SNMPINDEX}: Temperature is above critical threshold: >{$TEMP_CRIT:\"CPU\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17950}<{$TEMP_CRIT:\"CPU\"}-3',0,'',0),(15771,'{17951}<{$TEMP_CRIT_LOW:\"CPU\"}','CPU-{#SNMPINDEX}: Temperature is too low: <{$TEMP_CRIT_LOW:\"CPU\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17952}>{$TEMP_CRIT_LOW:\"CPU\"}+3',0,'',0),(15772,'{17953}>{$TEMP_WARN:\"Memory\"}','Memory-{#SNMPINDEX}: Temperature is above warning threshold: >{$TEMP_WARN:\"Memory\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17954}<{$TEMP_WARN:\"Memory\"}-3',0,'',0),(15773,'{17955}>{$TEMP_CRIT:\"Memory\"}','Memory-{#SNMPINDEX}: Temperature is above critical threshold: >{$TEMP_CRIT:\"Memory\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17956}<{$TEMP_CRIT:\"Memory\"}-3',0,'',0),(15774,'{17957}<{$TEMP_CRIT_LOW:\"Memory\"}','Memory-{#SNMPINDEX}: Temperature is too low: <{$TEMP_CRIT_LOW:\"Memory\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17958}>{$TEMP_CRIT_LOW:\"Memory\"}+3',0,'',0),(15775,'{17959}>{$TEMP_WARN:\"PSU\"}','PSU-{#SNMPINDEX}: Temperature is above warning threshold: >{$TEMP_WARN:\"PSU\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17960}<{$TEMP_WARN:\"PSU\"}-3',0,'',0),(15776,'{17961}>{$TEMP_CRIT:\"PSU\"}','PSU-{#SNMPINDEX}: Temperature is above critical threshold: >{$TEMP_CRIT:\"PSU\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17962}<{$TEMP_CRIT:\"PSU\"}-3',0,'',0),(15777,'{17963}<{$TEMP_CRIT_LOW:\"PSU\"}','PSU-{#SNMPINDEX}: Temperature is too low: <{$TEMP_CRIT_LOW:\"PSU\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17964}>{$TEMP_CRIT_LOW:\"PSU\"}+3',0,'',0),(15778,'{17965}>{$TEMP_WARN:\"Device\"}','System-{#SNMPINDEX}: Temperature is above warning threshold: >{$TEMP_WARN:\"Device\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17966}<{$TEMP_WARN:\"Device\"}-3',0,'',0),(15779,'{17967}>{$TEMP_CRIT:\"Device\"}','System-{#SNMPINDEX}: Temperature is above critical threshold: >{$TEMP_CRIT:\"Device\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{17968}<{$TEMP_CRIT:\"Device\"}-3',0,'',0),(15780,'{17969}<{$TEMP_CRIT_LOW:\"Device\"}','System-{#SNMPINDEX}: Temperature is too low: <{$TEMP_CRIT_LOW:\"Device\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{17970}>{$TEMP_CRIT_LOW:\"Device\"}+3',0,'',0),(15781,'{17971}=1','Chassis {#CHASSIS_NUM}, bay {#BAY_NUM}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15782,'{17972}=1','Chassis {#CHASSIS_NUM}, bay {#BAY_NUM}: Power supply is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15783,'{17973}=1','Fan {#SNMPINDEX}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15784,'{17974}=1','Fan {#SNMPINDEX}: Fan is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15785,'{17975}=1','{#CNTLR_LOCATION}: Disk array controller is in critical state','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0),(15786,'{17976}=1','{#CNTLR_LOCATION}: Disk array controller is in warning state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0),(15787,'{17977}=1','#{#CACHE_CNTRL_INDEX}: Disk array cache controller is in critical state!','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0),(15788,'{17978}=1 or {17979}=1 or {17980}=1 or {17981}=1','#{#CACHE_CNTRL_INDEX}: Disk array cache controller is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0),(15789,'{17982}=1','#{#CACHE_CNTRL_INDEX}: Disk array cache controller is not in optimal state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0),(15790,'{17983}=1 or {17984}=1','#{#CACHE_CNTRL_INDEX}: Disk array cache controller battery is in critical state!','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0),(15791,'{17985}=1 or {17986}=1','#{#CACHE_CNTRL_INDEX}: Disk array cache controller battery is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0),(15792,'{17987}=1','{#DISK_LOCATION}: Physical disk failed','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check physical disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0),(15793,'{17988}=1','{#DISK_LOCATION}: Physical disk is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check physical disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0),(15794,'{17989}=1 or {17990}=1','{#DISK_LOCATION}: Physical disk S.M.A.R.T. failed','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nDisk probably requires replacement.','',NULL,0,0,2,0,'',0,'',0),(15795,'{17991}=1 and {17992}>0','{#DISK_LOCATION}: Disk has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDisk serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1),(15796,'{17993}=1','Disk {#SNMPINDEX}({#DISK_NAME}): Virtual disk failed','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check virtual disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0),(15797,'{17994}=1','Disk {#SNMPINDEX}({#DISK_NAME}): Virtual disk is not in OK state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check virtual disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0),(15798,'{17995}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14288,0,0,0,0,'',0,'',0),(15799,'{17996}>{$ICMP_LOSS_WARN} and {17996}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14289,0,0,0,0,'',0,'',0),(15800,'{17997}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14290,0,0,0,0,'',0,'',0),(15801,'{17998}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15642,0,0,0,0,'',0,'',1),(15802,'{17999}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15161,0,0,0,0,'',0,'',0),(15803,'{18000}=1','System is in unrecoverable state!','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,0,0,'',0,'',0),(15804,'{18001}=1','System status is in critical state','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for errors','',NULL,0,0,0,0,'',0,'',0),(15805,'{18002}=1','System status is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for warnings','',NULL,0,0,0,0,'',0,'',0),(15806,'{18003}=1 and {18004}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(15807,'{18005}>{$TEMP_WARN:\"\"}','{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18006}<{$TEMP_WARN:\"\"}-3',0,'',0),(15808,'{18007}>{$TEMP_CRIT:\"\"}','{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18008}<{$TEMP_CRIT:\"\"}-3',0,'',0),(15809,'{18009}<{$TEMP_CRIT_LOW:\"\"}','{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{18010}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(15810,'{18011}>{$TEMP_WARN:\"Ambient\"}','Ambient: Temperature is above warning threshold: >{$TEMP_WARN:\"Ambient\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18012}<{$TEMP_WARN:\"Ambient\"}-3',0,'',0),(15811,'{18013}>{$TEMP_CRIT:\"Ambient\"}','Ambient: Temperature is above critical threshold: >{$TEMP_CRIT:\"Ambient\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18014}<{$TEMP_CRIT:\"Ambient\"}-3',0,'',0),(15812,'{18015}<{$TEMP_CRIT_LOW:\"Ambient\"}','Ambient: Temperature is too low: <{$TEMP_CRIT_LOW:\"Ambient\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{18016}>{$TEMP_CRIT_LOW:\"Ambient\"}+3',0,'',0),(15813,'{18017}>{$TEMP_WARN:\"CPU\"}','CPU: Temperature is above warning threshold: >{$TEMP_WARN:\"CPU\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18018}<{$TEMP_WARN:\"CPU\"}-3',0,'',0),(15814,'{18019}>{$TEMP_CRIT:\"CPU\"}','CPU: Temperature is above critical threshold: >{$TEMP_CRIT:\"CPU\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18020}<{$TEMP_CRIT:\"CPU\"}-3',0,'',0),(15815,'{18021}<{$TEMP_CRIT_LOW:\"CPU\"}','CPU: Temperature is too low: <{$TEMP_CRIT_LOW:\"CPU\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{18022}>{$TEMP_CRIT_LOW:\"CPU\"}+3',0,'',0),(15816,'{18023}=1','{#PSU_DESCR}: Power supply is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15817,'{18024}=1','{#FAN_DESCR}: Fan is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15818,'{18025}=1','{#SNMPINDEX}: Physical disk is not in OK state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check physical disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0),(15819,'{18026}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(15820,'{18027}>{$ICMP_LOSS_WARN} and {18027}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(15821,'{18028}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(15822,'{18029}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15823,'{18030}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15824,'{18031}=1','System is in unrecoverable state!','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,0,0,'',0,'',0),(15825,'{18032}=1','System status is in critical state','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for errors','',NULL,0,0,0,0,'',0,'',0),(15826,'{18033}=1','System status is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for warnings','',NULL,0,0,0,0,'',0,'',0),(15827,'{18034}=1 and {18035}>0','Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,0,2,'',0,'',1),(15828,'{18036}>{$TEMP_WARN:\"\"}','{#SNMPVALUE}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18037}<{$TEMP_WARN:\"\"}-3',0,'',0),(15829,'{18038}>{$TEMP_CRIT:\"\"}','{#SNMPVALUE}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18039}<{$TEMP_CRIT:\"\"}-3',0,'',0),(15830,'{18040}<{$TEMP_CRIT_LOW:\"\"}','{#SNMPVALUE}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{18041}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(15831,'{18042}>{$TEMP_WARN:\"Ambient\"}','Ambient: Temperature is above warning threshold: >{$TEMP_WARN:\"Ambient\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18043}<{$TEMP_WARN:\"Ambient\"}-3',0,'',0),(15832,'{18044}>{$TEMP_CRIT:\"Ambient\"}','Ambient: Temperature is above critical threshold: >{$TEMP_CRIT:\"Ambient\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18045}<{$TEMP_CRIT:\"Ambient\"}-3',0,'',0),(15833,'{18046}<{$TEMP_CRIT_LOW:\"Ambient\"}','Ambient: Temperature is too low: <{$TEMP_CRIT_LOW:\"Ambient\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{18047}>{$TEMP_CRIT_LOW:\"Ambient\"}+3',0,'',0),(15834,'{18048}>{$TEMP_WARN:\"CPU\"}','CPU: Temperature is above warning threshold: >{$TEMP_WARN:\"CPU\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18049}<{$TEMP_WARN:\"CPU\"}-3',0,'',0),(15835,'{18050}>{$TEMP_CRIT:\"CPU\"}','CPU: Temperature is above critical threshold: >{$TEMP_CRIT:\"CPU\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18051}<{$TEMP_CRIT:\"CPU\"}-3',0,'',0),(15836,'{18052}<{$TEMP_CRIT_LOW:\"CPU\"}','CPU: Temperature is too low: <{$TEMP_CRIT_LOW:\"CPU\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{18053}>{$TEMP_CRIT_LOW:\"CPU\"}+3',0,'',0),(15837,'{18054}=1','{#PSU_DESCR}: Power supply is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15838,'{18055}=1','{#FAN_DESCR}: Fan is not in normal state','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15839,'{18056}=1','{#SNMPINDEX}: Physical disk is not in OK state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check physical disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0),(15840,'{18057}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(15841,'{18058}>{$ICMP_LOSS_WARN} and {18058}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(15842,'{18059}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(15843,'{18060}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15844,'{18061}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15845,'{18062}>{$TEMP_WARN:\"\"}','{#SENSOR_DESCR}: Temperature is above warning threshold: >{$TEMP_WARN:\"\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18063}<{$TEMP_WARN:\"\"}-3',0,'',0),(15846,'{18064}>{$TEMP_CRIT:\"\"}','{#SENSOR_DESCR}: Temperature is above critical threshold: >{$TEMP_CRIT:\"\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18065}<{$TEMP_CRIT:\"\"}-3',0,'',0),(15847,'{18066}<{$TEMP_CRIT_LOW:\"\"}','{#SENSOR_DESCR}: Temperature is too low: <{$TEMP_CRIT_LOW:\"\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{18067}>{$TEMP_CRIT_LOW:\"\"}+3',0,'',0),(15848,'{18068} > ({18069} * 0.7)','70% http-8080 worker threads busy on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(15849,'{18070} > ({18071} * 0.7)','70% http-8443 worker threads busy on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(15850,'{18072} > ({18073}  *0.7)','70% jk-8009 worker threads busy on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(15851,'{18074} = 1','gzip compression is off for connector http-8080 on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(15852,'{18075} = 1','gzip compression is off for connector http-8443 on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(15853,'{18076}>75','More than 75% used in the configuration cache','',0,0,3,0,'Consider increasing CacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0),(15854,'{18077}>75','More than 75% used in the history cache','',0,0,3,0,'Consider increasing HistoryCacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0),(15855,'{18078}>75','More than 75% used in the history index cache','',0,0,3,0,'Consider increasing HistoryIndexCacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0),(15856,'{18079}>75','More than 75% used in the trends cache','',0,0,3,0,'Consider increasing TrendCacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0),(15857,'{18080}>75','More than 75% used in the vmware cache','',0,0,3,0,'Consider increasing VMwareCacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0),(15858,'{18081}>95','More than 95% used in the value cache','',0,0,3,0,'Consider increasing ValueCacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0),(15859,'{18082}>100','More than 100 items having missing data for more than 10 minutes','',0,0,2,0,'zabbix[stats,{$IP},{$PORT},queue,10m] item is collecting data about how many items are missing data for more than 10 minutes (next parameter)','',NULL,0,0,0,0,'',0,'',0),(15860,'{18083}>75','Zabbix alerter processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18083}<65',0,'',0),(15861,'{18084}>75','Zabbix alert manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18084}<65',0,'',0),(15862,'{18085}>75','Zabbix configuration syncer processes more than 75% busy','',0,0,3,0,'Zabbix configuration syncer processes more than 75% busy','',NULL,0,0,0,1,'{18085}<65',0,'',0),(15863,'{18086}>75','Zabbix discoverer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18086}<65',0,'',0),(15864,'{18087}>75','Zabbix escalator processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18087}<65',0,'',0),(15865,'{18088}>75','Zabbix history syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18088}<65',0,'',0),(15866,'{18089}>75','Zabbix housekeeper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18089}<65',0,'',0),(15867,'{18090}>75','Zabbix http poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18090}<65',0,'',0),(15868,'{18091}>75','Zabbix icmp pinger processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18091}<65',0,'',0),(15869,'{18092}>75','Zabbix ipmi manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18092}<65',0,'',0),(15870,'{18093}>75','Zabbix ipmi poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18093}<65',0,'',0),(15871,'{18094}>75','Zabbix java poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18094}<65',0,'',0),(15872,'{18095}>75','Zabbix poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18095}<65',0,'',0),(15873,'{18096}>75','Zabbix preprocessing manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18096}<65',0,'',0),(15874,'{18097}>75','Zabbix preprocessing worker processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18097}<65',0,'',0),(15875,'{18098}>75','Zabbix proxy poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18098}<65',0,'',0),(15876,'{18099}>75','Zabbix self-monitoring processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18099}<65',0,'',0),(15877,'{18100}>75','Zabbix snmp trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18100}<65',0,'',0),(15878,'{18101}>75','Zabbix task manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18101}<65',0,'',0),(15879,'{18102}>75','Zabbix timer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18102}<65',0,'',0),(15880,'{18103}>75','Zabbix trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18103}<65',0,'',0),(15881,'{18104}>75','Zabbix unreachable poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18104}<65',0,'',0),(15882,'{18105}=1','Zabbix value cache working in low memory mode','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(15883,'{18106}>75','Zabbix vmware collector processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18106}<65',0,'',0),(15884,'{18107}>75','More than 75% used in the configuration cache','',0,0,3,0,'Consider increasing CacheSize in the zabbix_proxy.conf configuration file','',NULL,0,0,0,0,'',0,'',0),(15885,'{18108}>75','More than 75% used in the history cache','',0,0,3,0,'Consider increasing HistoryCacheSize in the zabbix_proxy.conf configuration file','',NULL,0,0,0,0,'',0,'',0),(15886,'{18109}>75','More than 75% used in the history index cache','',0,0,3,0,'Consider increasing HistoryIndexCacheSize in the zabbix_proxy.conf configuration file','',NULL,0,0,0,0,'',0,'',0),(15887,'{18110}>75','More than 75% used in the vmware cache','',0,0,3,0,'Consider increasing VMwareCacheSize in the zabbix_proxy.conf configuration file','',NULL,0,0,0,0,'',0,'',0),(15888,'{18111}>100','More than 100 items having missing data for more than 10 minutes','',0,0,2,0,'zabbix[stats,{$IP},{$PORT},queue,10m] item is collecting data about how many items are missing data for more than 10 minutes (next parameter)','',NULL,0,0,0,0,'',0,'',0),(15889,'{18112}>75','Zabbix configuration syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18112}<65',0,'',0),(15890,'{18113}>75','Zabbix data sender processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18113}<65',0,'',0),(15891,'{18114}>75','Zabbix discoverer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18114}<65',0,'',0),(15892,'{18115}>75','Zabbix heartbeat sender processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18115}<65',0,'',0),(15893,'{18116}>75','Zabbix history syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18116}<65',0,'',0),(15894,'{18117}>75','Zabbix housekeeper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18117}<65',0,'',0),(15895,'{18118}>75','Zabbix http poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18118}<65',0,'',0),(15896,'{18119}>75','Zabbix icmp pinger processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18119}<65',0,'',0),(15897,'{18120}>75','Zabbix ipmi manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18120}<65',0,'',0),(15898,'{18121}>75','Zabbix ipmi poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18121}<65',0,'',0),(15899,'{18122}>75','Zabbix java poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18122}<65',0,'',0),(15900,'{18123}>75','Zabbix poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18123}<65',0,'',0),(15901,'{18124}>75','Zabbix self-monitoring processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18124}<65',0,'',0),(15902,'{18125}>75','Zabbix snmp trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18125}<65',0,'',0),(15903,'{18126}>75','Zabbix task manager processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18126}<65',0,'',0),(15904,'{18127}>75','Zabbix trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18127}<65',0,'',0),(15905,'{18128}>75','Zabbix unreachable poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18128}<65',0,'',0),(15906,'{18129}>75','Zabbix vmware collector processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,1,'{18129}<65',0,'',0),(15907,'{18130}>{$CPU_UTIL_MAX}','{#SNMPVALUE}: High CPU utilization','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,0,'',0,'',0),(15908,'{18131}=0','Unavailable by ICMP ping','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nLast three attempts returned timeout.  Please check device connectivity.','',14293,0,0,0,0,'',0,'',0),(15909,'{18132}>{$ICMP_LOSS_WARN} and {18132}<100','High ICMP ping loss','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14294,0,0,0,0,'',0,'',0),(15910,'{18133}>{$ICMP_RESPONSE_TIME_WARN}','High ICMP ping response time','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.','',14295,0,0,0,0,'',0,'',0),(15911,'{18134}<10m','{HOST.NAME} has been restarted','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThe device uptime is less than 10 minutes','',15645,0,0,0,0,'',0,'',1),(15912,'{18135}=0','No SNMP data collection','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nSNMP is not available for polling. Please check device connectivity and SNMP settings.','',15170,0,0,0,0,'',0,'',0),(15913,'{18136}>{$TEMP_WARN:\"Ambient\"}','{#SENSOR_LOCATION}.Ambient: Temperature is above warning threshold: >{$TEMP_WARN:\"Ambient\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18137}<{$TEMP_WARN:\"Ambient\"}-3',0,'',0),(15914,'{18138}>{$TEMP_CRIT:\"Ambient\"}','{#SENSOR_LOCATION}.Ambient: Temperature is above critical threshold: >{$TEMP_CRIT:\"Ambient\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18139}<{$TEMP_CRIT:\"Ambient\"}-3',0,'',0),(15915,'{18140}<{$TEMP_CRIT_LOW:\"Ambient\"}','{#SENSOR_LOCATION}.Ambient: Temperature is too low: <{$TEMP_CRIT_LOW:\"Ambient\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{18141}>{$TEMP_CRIT_LOW:\"Ambient\"}+3',0,'',0),(15916,'{18142}>{$TEMP_WARN:\"Ambient\"}','{#SENSOR_LOCATION}.Front: Temperature is above warning threshold: >{$TEMP_WARN:\"Ambient\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18143}<{$TEMP_WARN:\"Ambient\"}-3',0,'',0),(15917,'{18144}>{$TEMP_CRIT:\"Ambient\"}','{#SENSOR_LOCATION}.Front: Temperature is above critical threshold: >{$TEMP_CRIT:\"Ambient\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18145}<{$TEMP_CRIT:\"Ambient\"}-3',0,'',0),(15918,'{18146}<{$TEMP_CRIT_LOW:\"Ambient\"}','{#SENSOR_LOCATION}.Front: Temperature is too low: <{$TEMP_CRIT_LOW:\"Ambient\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{18147}>{$TEMP_CRIT_LOW:\"Ambient\"}+3',0,'',0),(15919,'{18148}>{$TEMP_WARN:\"Ambient\"}','{#SENSOR_LOCATION}.Rear: Temperature is above warning threshold: >{$TEMP_WARN:\"Ambient\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18149}<{$TEMP_WARN:\"Ambient\"}-3',0,'',0),(15920,'{18150}>{$TEMP_CRIT:\"Ambient\"}','{#SENSOR_LOCATION}.Rear: Temperature is above critical threshold: >{$TEMP_CRIT:\"Ambient\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18151}<{$TEMP_CRIT:\"Ambient\"}-3',0,'',0),(15921,'{18152}<{$TEMP_CRIT_LOW:\"Ambient\"}','{#SENSOR_LOCATION}.Rear: Temperature is too low: <{$TEMP_CRIT_LOW:\"Ambient\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{18153}>{$TEMP_CRIT_LOW:\"Ambient\"}+3',0,'',0),(15922,'{18154}>{$TEMP_WARN:\"Ambient\"}','{#SENSOR_LOCATION}.IOH: Temperature is above warning threshold: >{$TEMP_WARN:\"Ambient\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18155}<{$TEMP_WARN:\"Ambient\"}-3',0,'',0),(15923,'{18156}>{$TEMP_CRIT:\"Ambient\"}','{#SENSOR_LOCATION}.IOH: Temperature is above critical threshold: >{$TEMP_CRIT:\"Ambient\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18157}<{$TEMP_CRIT:\"Ambient\"}-3',0,'',0),(15924,'{18158}<{$TEMP_CRIT_LOW:\"Ambient\"}','{#SENSOR_LOCATION}.IOH: Temperature is too low: <{$TEMP_CRIT_LOW:\"Ambient\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{18159}>{$TEMP_CRIT_LOW:\"Ambient\"}+3',0,'',0),(15925,'{18160}>{$TEMP_WARN:\"CPU\"}','{#SENSOR_LOCATION}: Temperature is above warning threshold: >{$TEMP_WARN:\"CPU\"}','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18161}<{$TEMP_WARN:\"CPU\"}-3',0,'',0),(15926,'{18162}>{$TEMP_CRIT:\"CPU\"}','{#SENSOR_LOCATION}: Temperature is above critical threshold: >{$TEMP_CRIT:\"CPU\"}','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nThis trigger uses temperature sensor values as well as temperature sensor status if available','',NULL,0,0,2,1,'{18163}<{$TEMP_CRIT:\"CPU\"}-3',0,'',0),(15927,'{18164}<{$TEMP_CRIT_LOW:\"CPU\"}','{#SENSOR_LOCATION}: Temperature is too low: <{$TEMP_CRIT_LOW:\"CPU\"}','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.','',NULL,0,0,2,1,'{18165}>{$TEMP_CRIT_LOW:\"CPU\"}+3',0,'',0),(15928,'{18166}=1','{#PSU_LOCATION}: Power supply is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15929,'{18167}=1','{#PSU_LOCATION}: Power supply is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the power supply unit for errors','',NULL,0,0,2,0,'',0,'',0),(15930,'{18168}=1 or {18169}=1 or {18170}=1 or {18171}=1','{#UNIT_LOCATION}: System status is in critical state','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for errors','',NULL,0,0,2,0,'',0,'',0),(15931,'{18172}=1 or {18173}=1 or {18174}=1 or {18175}=1 or {18176}=1','{#UNIT_LOCATION}: System status is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for warnings','',NULL,0,0,2,0,'',0,'',0),(15932,'{18177}=1 and {18178}>0','{#UNIT_LOCATION}: Device has been replaced (new serial number received)','',0,0,1,0,'Last value: {ITEM.LASTVALUE1}.\r\nDevice serial number has changed. Ack to close','',NULL,0,0,2,2,'',0,'',1),(15933,'{18179}=1','{#FAN_LOCATION}: Fan is in critical state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15934,'{18180}=1','{#FAN_LOCATION}: Fan is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the fan unit','',NULL,0,0,2,0,'',0,'',0),(15935,'{18181}=1','{#DISK_LOCATION}: Physical disk failed','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check physical disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0),(15936,'{18182}=1 or {18183}=1','{#DISK_LOCATION}: Physical disk error','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check physical disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0),(15937,'{18184}=1','{#VDISK_LOCATION}: Virtual disk is not in OK state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check virtual disk for warnings or errors','',NULL,0,0,2,0,'',0,'',0),(15938,'{18185}=1','{#DISKARRAY_LOCATION}: Disk array controller is in critical state','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0),(15939,'{18186}=1','{#DISKARRAY_LOCATION}: Disk array controller is in warning state','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0),(15940,'{18187}=1','{#DISKARRAY_LOCATION}: Disk array controller is not in optimal state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0),(15941,'{18188}=1','{#DISKARRAY_CACHE_LOCATION}: Disk array cache controller battery is in critical state!','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0),(15942,'{18189}=1','{#DISKARRAY_CACHE_LOCATION}: Disk array cache controller battery is not in optimal state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for faults','',NULL,0,0,2,0,'',0,'',0),(15943,'{18190}=1','System status is in critical state','',0,0,4,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for errors','',NULL,0,0,0,0,'',0,'',0),(15944,'{18191}=1','System status is in warning state','',0,0,2,0,'Last value: {ITEM.LASTVALUE1}.\r\nPlease check the device for warnings','',NULL,0,0,0,0,'',0,'',0),(15946,'{18193}>{$CPU.UTIL.CRIT}','High CPU utilization (over {$CPU.UTIL.CRIT}% for 5m)','',0,0,2,0,'Current utilization: {ITEM.LASTVALUE1}\r\nCPU utilization is too high. The system might be slow to respond.','',NULL,0,0,0,0,'',0,'',0),(15947,'{18194}>{$CPU.UTIL.CRIT}','High CPU utilization (over {$CPU.UTIL.CRIT}% for 5m)','',0,0,2,0,'Current utilization: {ITEM.LASTVALUE1}\r\nCPU utilization is too high. The system might be slow to respond.','',15946,0,0,0,0,'',0,'',0),(15948,'{18195}>{$CPU.UTIL.CRIT}','High CPU utilization (over {$CPU.UTIL.CRIT}% for 5m)','',0,0,2,0,'Current utilization: {ITEM.LASTVALUE1}\r\nCPU utilization is too high. The system might be slow to respond.','',15947,0,0,0,0,'',0,'',0),(15949,'{18196}>{$CPU.UTIL.CRIT}','High CPU utilization (over {$CPU.UTIL.CRIT}% for 5m)','',0,0,2,0,'Current utilization: {ITEM.LASTVALUE1}\r\nCPU utilization is too high. The system might be slow to respond.','',15947,0,0,0,0,'',0,'',0),(15950,'{18197}>{$CPU.UTIL.CRIT}','High CPU utilization (over {$CPU.UTIL.CRIT}% for 5m)','',0,0,2,0,'Current utilization: {ITEM.LASTVALUE1}\r\nCPU utilization is too high. The system might be slow to respond.','',15947,0,0,0,0,'',0,'',0),(15951,'{18198}>{$CPU.UTIL.CRIT}','High CPU utilization (over {$CPU.UTIL.CRIT}% for 5m)','',0,0,2,0,'Current utilization: {ITEM.LASTVALUE1}\r\nCPU utilization is too high. The system might be slow to respond.','',15947,0,0,0,0,'',0,'',0),(15952,'{18199}>{$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"} and\r\n(({18200}-{18201})<5G or {18202}<1d)','{#FSNAME}: Disk space is critically low (used > {$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"}%)','',0,0,3,0,'Space used: {ITEM.LASTVALUE3} of {ITEM.LASTVALUE2} ({ITEM.LASTVALUE1})\r\nTwo conditions should match: First, space utilization should be above {$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"}.\r\n Second condition should be one of the following:\r\n - The disk free space is less than 5G.\r\n - The disk will be full in less than 24 hours.','',NULL,0,0,2,0,'',0,'',1),(15953,'{18203}>{$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"} and\r\n(({18204}-{18205})<10G or {18206}<1d)','{#FSNAME}: Disk space is low (used > {$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"}%)','',0,0,2,0,'Space used: {ITEM.LASTVALUE3} of {ITEM.LASTVALUE2} ({ITEM.LASTVALUE1})\r\nTwo conditions should match: First, space utilization should be above {$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"}.\r\n Second condition should be one of the following:\r\n - The disk free space is less than 10G.\r\n - The disk will be full in less than 24 hours.','',NULL,0,0,2,0,'',0,'',1),(15954,'{18207}>{$MEMORY.UTIL.MAX}','{#MEMNAME}: High memory utilization ( >{$MEMORY.UTIL.MAX}% for 5m)','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}\r\nThe system is running out of free memory.','',NULL,0,0,2,0,'',0,'',0),(15955,'{18208}>{$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"} and\r\n(({18209}-{18210})<5G or {18211}<1d)','{#FSNAME}: Disk space is critically low (used > {$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"}%)','',0,0,3,0,'Space used: {ITEM.LASTVALUE3} of {ITEM.LASTVALUE2} ({ITEM.LASTVALUE1})\r\nTwo conditions should match: First, space utilization should be above {$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"}.\r\n Second condition should be one of the following:\r\n - The disk free space is less than 5G.\r\n - The disk will be full in less than 24 hours.','',15952,0,0,2,0,'',0,'',1),(15956,'{18212}>{$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"} and\r\n(({18213}-{18214})<5G or {18215}<1d)','{#FSNAME}: Disk space is critically low (used > {$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"}%)','',0,0,3,0,'Space used: {ITEM.LASTVALUE3} of {ITEM.LASTVALUE2} ({ITEM.LASTVALUE1})\r\nTwo conditions should match: First, space utilization should be above {$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"}.\r\n Second condition should be one of the following:\r\n - The disk free space is less than 5G.\r\n - The disk will be full in less than 24 hours.','',15955,0,0,2,0,'',0,'',1),(15957,'{18216}>{$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"} and\r\n(({18217}-{18218})<5G or {18219}<1d)','{#FSNAME}: Disk space is critically low (used > {$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"}%)','',0,0,3,0,'Space used: {ITEM.LASTVALUE3} of {ITEM.LASTVALUE2} ({ITEM.LASTVALUE1})\r\nTwo conditions should match: First, space utilization should be above {$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"}.\r\n Second condition should be one of the following:\r\n - The disk free space is less than 5G.\r\n - The disk will be full in less than 24 hours.','',15955,0,0,2,0,'',0,'',1),(15958,'{18220}>{$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"} and\r\n(({18221}-{18222})<5G or {18223}<1d)','{#FSNAME}: Disk space is critically low (used > {$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"}%)','',0,0,3,0,'Space used: {ITEM.LASTVALUE3} of {ITEM.LASTVALUE2} ({ITEM.LASTVALUE1})\r\nTwo conditions should match: First, space utilization should be above {$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"}.\r\n Second condition should be one of the following:\r\n - The disk free space is less than 5G.\r\n - The disk will be full in less than 24 hours.','',15955,0,0,2,0,'',0,'',1),(15959,'{18224}>{$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"} and\r\n(({18225}-{18226})<5G or {18227}<1d)','{#FSNAME}: Disk space is critically low (used > {$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"}%)','',0,0,3,0,'Space used: {ITEM.LASTVALUE3} of {ITEM.LASTVALUE2} ({ITEM.LASTVALUE1})\r\nTwo conditions should match: First, space utilization should be above {$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"}.\r\n Second condition should be one of the following:\r\n - The disk free space is less than 5G.\r\n - The disk will be full in less than 24 hours.','',15955,0,0,2,0,'',0,'',1),(15960,'{18228}>{$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"} and\r\n(({18229}-{18230})<10G or {18231}<1d)','{#FSNAME}: Disk space is low (used > {$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"}%)','',0,0,2,0,'Space used: {ITEM.LASTVALUE3} of {ITEM.LASTVALUE2} ({ITEM.LASTVALUE1})\r\nTwo conditions should match: First, space utilization should be above {$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"}.\r\n Second condition should be one of the following:\r\n - The disk free space is less than 10G.\r\n - The disk will be full in less than 24 hours.','',15953,0,0,2,0,'',0,'',1),(15961,'{18232}>{$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"} and\r\n(({18233}-{18234})<10G or {18235}<1d)','{#FSNAME}: Disk space is low (used > {$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"}%)','',0,0,2,0,'Space used: {ITEM.LASTVALUE3} of {ITEM.LASTVALUE2} ({ITEM.LASTVALUE1})\r\nTwo conditions should match: First, space utilization should be above {$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"}.\r\n Second condition should be one of the following:\r\n - The disk free space is less than 10G.\r\n - The disk will be full in less than 24 hours.','',15960,0,0,2,0,'',0,'',1),(15962,'{18236}>{$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"} and\r\n(({18237}-{18238})<10G or {18239}<1d)','{#FSNAME}: Disk space is low (used > {$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"}%)','',0,0,2,0,'Space used: {ITEM.LASTVALUE3} of {ITEM.LASTVALUE2} ({ITEM.LASTVALUE1})\r\nTwo conditions should match: First, space utilization should be above {$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"}.\r\n Second condition should be one of the following:\r\n - The disk free space is less than 10G.\r\n - The disk will be full in less than 24 hours.','',15960,0,0,2,0,'',0,'',1),(15963,'{18240}>{$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"} and\r\n(({18241}-{18242})<10G or {18243}<1d)','{#FSNAME}: Disk space is low (used > {$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"}%)','',0,0,2,0,'Space used: {ITEM.LASTVALUE3} of {ITEM.LASTVALUE2} ({ITEM.LASTVALUE1})\r\nTwo conditions should match: First, space utilization should be above {$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"}.\r\n Second condition should be one of the following:\r\n - The disk free space is less than 10G.\r\n - The disk will be full in less than 24 hours.','',15960,0,0,2,0,'',0,'',1),(15964,'{18244}>{$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"} and\r\n(({18245}-{18246})<10G or {18247}<1d)','{#FSNAME}: Disk space is low (used > {$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"}%)','',0,0,2,0,'Space used: {ITEM.LASTVALUE3} of {ITEM.LASTVALUE2} ({ITEM.LASTVALUE1})\r\nTwo conditions should match: First, space utilization should be above {$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"}.\r\n Second condition should be one of the following:\r\n - The disk free space is less than 10G.\r\n - The disk will be full in less than 24 hours.','',15960,0,0,2,0,'',0,'',1),(15965,'{18248}>{$MEMORY.UTIL.MAX}','{#MEMNAME}: High memory utilization ( >{$MEMORY.UTIL.MAX}% for 5m)','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}\r\nThe system is running out of free memory.','',15954,0,0,2,0,'',0,'',0),(15966,'{18249}>{$MEMORY.UTIL.MAX}','{#MEMNAME}: High memory utilization ( >{$MEMORY.UTIL.MAX}% for 5m)','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}\r\nThe system is running out of free memory.','',15965,0,0,2,0,'',0,'',0),(15967,'{18250}>{$MEMORY.UTIL.MAX}','{#MEMNAME}: High memory utilization ( >{$MEMORY.UTIL.MAX}% for 5m)','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}\r\nThe system is running out of free memory.','',15965,0,0,2,0,'',0,'',0),(15968,'{18251}>{$MEMORY.UTIL.MAX}','{#MEMNAME}: High memory utilization ( >{$MEMORY.UTIL.MAX}% for 5m)','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}\r\nThe system is running out of free memory.','',15965,0,0,2,0,'',0,'',0),(15969,'{18252}>{$MEMORY.UTIL.MAX}','{#MEMNAME}: High memory utilization ( >{$MEMORY.UTIL.MAX}% for 5m)','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}\r\nThe system is running out of free memory.','',15965,0,0,2,0,'',0,'',0),(15970,'({18253}>({$IF.UTIL.MAX:\"{#IFNAME}\"}/100)*{18254} or\r\n{18255}>({$IF.UTIL.MAX:\"{#IFNAME}\"}/100)*{18254}) and\r\n{18254}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage ( > {$IF.UTIL.MAX:\"{#IFNAME}\"}% )','',0,0,2,0,'In: {ITEM.LASTVALUE1}, out: {ITEM.LASTVALUE3}, speed: {ITEM.LASTVALUE2}\r\nThe network interface utilization is close to its estimated maximum bandwidth.','',NULL,0,0,2,1,'{18253}<(({$IF.UTIL.MAX:\"{#IFNAME}\"}-3)/100)*{18254} and\r\n{18255}<(({$IF.UTIL.MAX:\"{#IFNAME}\"}-3)/100)*{18254}',0,'',1),(15971,'{18256}>{$IF.ERRORS.WARN:\"{#IFNAME}\"}\r\nor {18257}>{$IF.ERRORS.WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate ( > {$IF.ERRORS.WARN:\"{#IFNAME}\"} for 5m)','',0,0,2,0,'errors in: {ITEM.LASTVALUE1}, errors out: {ITEM.LASTVALUE2}\r\nRecovers when below 80% of {$IF.ERRORS.WARN:\"{#IFNAME}\"} threshold','',NULL,0,0,2,1,'{18258}<{$IF.ERRORS.WARN:\"{#IFNAME}\"}*0.8\r\nand {18259}<{$IF.ERRORS.WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15972,'({18260}>({$IF.UTIL.MAX:\"{#IFNAME}\"}/100)*{18261} or\r\n{18262}>({$IF.UTIL.MAX:\"{#IFNAME}\"}/100)*{18261}) and\r\n{18261}>0','Interface {#IFNAME}({#IFALIAS}): High bandwidth usage ( > {$IF.UTIL.MAX:\"{#IFNAME}\"}% )','',0,0,2,0,'In: {ITEM.LASTVALUE1}, out: {ITEM.LASTVALUE3}, speed: {ITEM.LASTVALUE2}\r\nThe network interface utilization is close to its estimated maximum bandwidth.','',15970,0,0,2,1,'{18260}<(({$IF.UTIL.MAX:\"{#IFNAME}\"}-3)/100)*{18261} and\r\n{18262}<(({$IF.UTIL.MAX:\"{#IFNAME}\"}-3)/100)*{18261}',0,'',1),(15973,'{18263}>{$IF.ERRORS.WARN:\"{#IFNAME}\"}\r\nor {18264}>{$IF.ERRORS.WARN:\"{#IFNAME}\"}','Interface {#IFNAME}({#IFALIAS}): High error rate ( > {$IF.ERRORS.WARN:\"{#IFNAME}\"} for 5m)','',0,0,2,0,'errors in: {ITEM.LASTVALUE1}, errors out: {ITEM.LASTVALUE2}\r\nRecovers when below 80% of {$IF.ERRORS.WARN:\"{#IFNAME}\"} threshold','',15971,0,0,2,1,'{18265}<{$IF.ERRORS.WARN:\"{#IFNAME}\"}*0.8\r\nand {18266}<{$IF.ERRORS.WARN:\"{#IFNAME}\"}*0.8',0,'',1),(15974,'{18267}>{$CPU.UTIL.CRIT}','High CPU utilization (over {$CPU.UTIL.CRIT}% for 5m)','',0,0,2,0,'Current utilization: {ITEM.LASTVALUE1}\r\nCPU utilization is too high. The system might be slow to respond.','',NULL,0,0,0,0,'',0,'',0),(15975,'{18268}>{$CPU.UTIL.CRIT}','High CPU utilization (over {$CPU.UTIL.CRIT}% for 5m)','',0,0,2,0,'Current utilization: {ITEM.LASTVALUE1}\r\nCPU utilization is too high. The system might be slow to respond.','',15974,0,0,0,0,'',0,'',0),(15976,'{18269}>{$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"} and\r\n(({18270}-{18271})<5G or {18272}<1d)','{#FSNAME}: Disk space is critically low (used > {$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"}%)','',0,0,3,0,'Space used: {ITEM.LASTVALUE3} of {ITEM.LASTVALUE2} ({ITEM.LASTVALUE1})\r\nTwo conditions should match: First, space utilization should be above {$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"}.\r\n Second condition should be one of the following:\r\n - The disk free space is less than 5G.\r\n - The disk will be full in less than 24 hours.','',NULL,0,0,2,0,'',0,'',1),(15977,'{18273}>{$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"} and\r\n(({18274}-{18275})<10G or {18276}<1d)','{#FSNAME}: Disk space is low (used > {$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"}%)','',0,0,2,0,'Space used: {ITEM.LASTVALUE3} of {ITEM.LASTVALUE2} ({ITEM.LASTVALUE1})\r\nTwo conditions should match: First, space utilization should be above {$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"}.\r\n Second condition should be one of the following:\r\n - The disk free space is less than 10G.\r\n - The disk will be full in less than 24 hours.','',NULL,0,0,2,0,'',0,'',1),(15978,'{18277}>{$MEMORY.UTIL.MAX}','{#MEMNAME}: High memory utilization ( >{$MEMORY.UTIL.MAX}% for 5m)','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}\r\nThe system is running out of free memory.','',NULL,0,0,2,0,'',0,'',0),(15979,'{18278}>{$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"} and\r\n(({18279}-{18280})<5G or {18281}<1d)','{#FSNAME}: Disk space is critically low (used > {$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"}%)','',0,0,3,0,'Space used: {ITEM.LASTVALUE3} of {ITEM.LASTVALUE2} ({ITEM.LASTVALUE1})\r\nTwo conditions should match: First, space utilization should be above {$VFS.FS.PUSED.MAX.CRIT:\"{#FSNAME}\"}.\r\n Second condition should be one of the following:\r\n - The disk free space is less than 5G.\r\n - The disk will be full in less than 24 hours.','',15976,0,0,2,0,'',0,'',1),(15980,'{18282}>{$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"} and\r\n(({18283}-{18284})<10G or {18285}<1d)','{#FSNAME}: Disk space is low (used > {$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"}%)','',0,0,2,0,'Space used: {ITEM.LASTVALUE3} of {ITEM.LASTVALUE2} ({ITEM.LASTVALUE1})\r\nTwo conditions should match: First, space utilization should be above {$VFS.FS.PUSED.MAX.WARN:\"{#FSNAME}\"}.\r\n Second condition should be one of the following:\r\n - The disk free space is less than 10G.\r\n - The disk will be full in less than 24 hours.','',15977,0,0,2,0,'',0,'',1),(15981,'{18286}>{$MEMORY.UTIL.MAX}','{#MEMNAME}: High memory utilization ( >{$MEMORY.UTIL.MAX}% for 5m)','',0,0,3,0,'Last value: {ITEM.LASTVALUE1}\r\nThe system is running out of free memory.','',15978,0,0,2,0,'',0,'',0);
/*!40000 ALTER TABLE `triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `userid` bigint(20) unsigned NOT NULL,
  `alias` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `surname` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `passwd` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `url` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `autologin` int(11) NOT NULL DEFAULT '0',
  `autologout` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '15m',
  `lang` varchar(5) COLLATE utf8_bin NOT NULL DEFAULT 'en_GB',
  `refresh` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '30s',
  `type` int(11) NOT NULL DEFAULT '1',
  `theme` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT 'default',
  `attempt_failed` int(11) NOT NULL DEFAULT '0',
  `attempt_ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `attempt_clock` int(11) NOT NULL DEFAULT '0',
  `rows_per_page` int(11) NOT NULL DEFAULT '50',
  PRIMARY KEY (`userid`),
  UNIQUE KEY `users_1` (`alias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','Zabbix','Administrator','5fce1b3e34b520afeffb37ce08c7cd66','',1,'0','en_GB','30s',3,'default',0,'',0,50),(2,'guest','','','d41d8cd98f00b204e9800998ecf8427e','',0,'15m','en_GB','30s',1,'default',0,'',0,50);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_groups` (
  `id` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_groups_1` (`usrgrpid`,`userid`),
  KEY `users_groups_2` (`userid`),
  CONSTRAINT `c_users_groups_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_users_groups_1` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
INSERT INTO `users_groups` VALUES (4,7,1),(2,8,2),(3,9,2);
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usrgrp`
--

DROP TABLE IF EXISTS `usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usrgrp` (
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `gui_access` int(11) NOT NULL DEFAULT '0',
  `users_status` int(11) NOT NULL DEFAULT '0',
  `debug_mode` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`usrgrpid`),
  UNIQUE KEY `usrgrp_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usrgrp`
--

LOCK TABLES `usrgrp` WRITE;
/*!40000 ALTER TABLE `usrgrp` DISABLE KEYS */;
INSERT INTO `usrgrp` VALUES (7,'Zabbix administrators',0,0,0),(8,'Guests',1,0,0),(9,'Disabled',0,1,0),(11,'Enabled debug mode',0,0,1),(12,'No access to the frontend',3,0,0);
/*!40000 ALTER TABLE `usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `valuemaps`
--

DROP TABLE IF EXISTS `valuemaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valuemaps` (
  `valuemapid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`valuemapid`),
  UNIQUE KEY `valuemaps_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valuemaps`
--

LOCK TABLES `valuemaps` WRITE;
/*!40000 ALTER TABLE `valuemaps` DISABLE KEYS */;
INSERT INTO `valuemaps` VALUES (4,'APC Battery Replacement Status'),(5,'APC Battery Status'),(28,'CISCO-ENVMON-MIB::CiscoEnvMonState'),(76,'CISCO-UNIFIED-COMPUTING-TC-MIB::CucsEquipmentOperability'),(80,'CISCO-UNIFIED-COMPUTING-TC-MIB::CucsEquipmentPresence'),(77,'CISCO-UNIFIED-COMPUTING-TC-MIB::CucsLsOperState'),(79,'CISCO-UNIFIED-COMPUTING-TC-MIB::CucsStorageLunType'),(78,'CISCO-UNIFIED-COMPUTING-TC-MIB::CucsStoragePDriveStatus'),(55,'CPQHLTH-MIB::cpqHeTemperatureLocale'),(72,'CPQIDA-MIB::cpqDaAccelBattery'),(71,'CPQIDA-MIB::cpqDaAccelStatus'),(56,'CPQIDA-MIB::cpqDaCntlrModel'),(74,'CPQIDA-MIB::cpqDaLogDrvFaultTol'),(75,'CPQIDA-MIB::cpqDaLogDrvStatus'),(73,'CPQIDA-MIB::cpqDaPhyDrvMediaType'),(70,'CPQIDA-MIB::cpqDaPhyDrvSmartStatus'),(57,'CPQIDA-MIB::cpqDaPhyDrvStatus'),(54,'CPQSINFO-MIB::status'),(7,'Dell Open Manage System Status'),(18,'ENTITY-SENSORS-MIB::EntitySensorStatus'),(48,'ENTITY-STATE-MIB::EntityOperState'),(33,'EQUIPMENT-MIB::swFanStatus'),(34,'EQUIPMENT-MIB::swPowerStatus'),(36,'EXTREME-SYSTEM-MIB::extremeFanOperational'),(37,'EXTREME-SYSTEM-MIB::extremeOverTemperatureAlarm'),(38,'EXTREME-SYSTEM-MIB::extremePowerSupplyStatus'),(19,'EtherLike-MIB::dot3StatsDuplexStatus'),(30,'F10-S-SERIES-CHASSIS-MIB::chSysFanTrayOperStatus'),(31,'F10-S-SERIES-CHASSIS-MIB::chSysPowerSupplyOperStatus'),(29,'F10-S-SERIES-CHASSIS-MIB::extremeFanOperational'),(50,'FASTPATH-BOXSERVICES-PRIVATE-MIB::boxServicesFanItemState'),(49,'FASTPATH-BOXSERVICES-PRIVATE-MIB::boxServicesPowSupplyItemState'),(51,'FASTPATH-BOXSERVICES-PRIVATE-MIB::boxServicesTempSensorState'),(27,'FOUNDRY-SN-AGENT-MIB::snChasFanOperStatus'),(26,'FOUNDRY-SN-AGENT-MIB::snChasPwrSupplyOperStatus'),(39,'HH3C-ENTITY-EXT-MIB::hh3cEntityExtErrorStatus'),(6,'HP Insight System Status'),(40,'HP-ICF-CHASSIS::hpicfSensorStatus'),(17,'HTTP response status code'),(41,'HUAWEI-ENTITY-EXTENT-MIB::hwEntityFanState'),(2,'Host availability'),(42,'ICS-CHASSIS-MIB::icsChassisFanOperStatus'),(44,'ICS-CHASSIS-MIB::icsChassisPowerSupplyOperStatus'),(43,'ICS-CHASSIS-MIB::icsChassisSensorSlotOperStatus'),(45,'ICS-CHASSIS-MIB::icsChassisTemperatureStatus'),(62,'IDRAC-MIB-SMIv2::BooleanType'),(59,'IDRAC-MIB-SMIv2::ObjectStatusEnum'),(60,'IDRAC-MIB-SMIv2::StatusProbeEnum'),(64,'IDRAC-MIB-SMIv2::batteryState'),(61,'IDRAC-MIB-SMIv2::physicalDiskComponentStatus'),(63,'IDRAC-MIB-SMIv2::physicalDiskMediaType'),(65,'IDRAC-MIB-SMIv2::virtualDiskLayout'),(66,'IDRAC-MIB-SMIv2::virtualDiskOperationalState'),(68,'IDRAC-MIB-SMIv2::virtualDiskReadPolicy'),(69,'IDRAC-MIB-SMIv2::virtualDiskState'),(67,'IDRAC-MIB-SMIv2::virtualDiskWritePolicy'),(20,'IF-MIB::ifOperStatus'),(21,'IF-MIB::ifType'),(58,'IMM-MIB::systemHealthStat'),(47,'JUNIPER-ALARM-MIB::jnxOperatingState'),(46,'JUNIPER-ALARM-MIB::jnxRedAlarmState'),(32,'MY-SYSTEM-MIB::mySystemFanIsNormal'),(14,'Maintenance status'),(52,'QTECH-MIB::sysFanStatus'),(53,'QTECH-MIB::sysPowerStatus'),(9,'SNMP device status (hrDeviceStatus)'),(11,'SNMP interface status (ifAdminStatus)'),(8,'SNMP interface status (ifOperStatus)'),(25,'SW-MIB::swOperStatus'),(24,'SW-MIB::swSensorStatus'),(1,'Service state'),(23,'TIMETRA-CHASSIS-MIB::TmnxDeviceState'),(35,'TruthValue'),(12,'VMware VirtualMachinePowerState'),(13,'VMware status'),(15,'Value cache operating mode'),(16,'Windows service startup type'),(3,'Windows service state'),(10,'Zabbix agent ping status'),(22,'zabbix.host.available');
/*!40000 ALTER TABLE `valuemaps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widget`
--

DROP TABLE IF EXISTS `widget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widget` (
  `widgetid` bigint(20) unsigned NOT NULL,
  `dashboardid` bigint(20) unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `width` int(11) NOT NULL DEFAULT '1',
  `height` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`widgetid`),
  KEY `widget_1` (`dashboardid`),
  CONSTRAINT `c_widget_1` FOREIGN KEY (`dashboardid`) REFERENCES `dashboard` (`dashboardid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widget`
--

LOCK TABLES `widget` WRITE;
/*!40000 ALTER TABLE `widget` DISABLE KEYS */;
INSERT INTO `widget` VALUES (1,1,'systeminfo','',0,0,4,4),(2,1,'problemsbysv','',4,0,6,4),(3,1,'clock','',10,0,2,4),(4,1,'problems','',0,4,10,10),(5,1,'favmaps','',10,4,2,5),(6,1,'favgraphs','',10,9,2,5),(7,2,'problems','Zabbix server problems',0,0,10,4),(8,2,'clock','Local time',10,0,2,4),(9,2,'svggraph','Values processed per second',0,4,4,5),(10,2,'svggraph','Utilization of data collectors',4,4,4,5),(11,2,'svggraph','Utilization of internal processes',8,4,4,5),(12,2,'svggraph','Cache usage',0,9,4,5),(13,2,'svggraph','Value cache effectiveness',4,9,4,5),(14,2,'svggraph','Queue size',8,9,4,5);
/*!40000 ALTER TABLE `widget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widget_field`
--

DROP TABLE IF EXISTS `widget_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widget_field` (
  `widget_fieldid` bigint(20) unsigned NOT NULL,
  `widgetid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value_int` int(11) NOT NULL DEFAULT '0',
  `value_str` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value_groupid` bigint(20) unsigned DEFAULT NULL,
  `value_hostid` bigint(20) unsigned DEFAULT NULL,
  `value_itemid` bigint(20) unsigned DEFAULT NULL,
  `value_graphid` bigint(20) unsigned DEFAULT NULL,
  `value_sysmapid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`widget_fieldid`),
  KEY `widget_field_1` (`widgetid`),
  KEY `widget_field_2` (`value_groupid`),
  KEY `widget_field_3` (`value_hostid`),
  KEY `widget_field_4` (`value_itemid`),
  KEY `widget_field_5` (`value_graphid`),
  KEY `widget_field_6` (`value_sysmapid`),
  CONSTRAINT `c_widget_field_6` FOREIGN KEY (`value_sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_1` FOREIGN KEY (`widgetid`) REFERENCES `widget` (`widgetid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_2` FOREIGN KEY (`value_groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_3` FOREIGN KEY (`value_hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_4` FOREIGN KEY (`value_itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_5` FOREIGN KEY (`value_graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widget_field`
--

LOCK TABLES `widget_field` WRITE;
/*!40000 ALTER TABLE `widget_field` DISABLE KEYS */;
INSERT INTO `widget_field` VALUES (1,2,0,'hide_empty_groups',1,'',NULL,NULL,NULL,NULL,NULL),(2,4,0,'show',3,'',NULL,NULL,NULL,NULL,NULL),(3,4,0,'show_tags',3,'',NULL,NULL,NULL,NULL,NULL),(4,7,3,'hostids',0,'',NULL,10084,NULL,NULL,NULL),(5,9,0,'ds.axisy.0',0,'',NULL,NULL,NULL,NULL,NULL),(6,9,0,'ds.fill.0',3,'',NULL,NULL,NULL,NULL,NULL),(7,9,0,'ds.missingdatafunc.0',0,'',NULL,NULL,NULL,NULL,NULL),(8,9,0,'ds.transparency.0',0,'',NULL,NULL,NULL,NULL,NULL),(9,9,0,'ds.type.0',0,'',NULL,NULL,NULL,NULL,NULL),(10,9,0,'ds.width.0',1,'',NULL,NULL,NULL,NULL,NULL),(11,9,0,'graph_item_problems',0,'',NULL,NULL,NULL,NULL,NULL),(12,9,0,'legend',0,'',NULL,NULL,NULL,NULL,NULL),(13,9,0,'righty',0,'',NULL,NULL,NULL,NULL,NULL),(14,9,0,'show_problems',1,'',NULL,NULL,NULL,NULL,NULL),(15,9,1,'ds.color.0',0,'00BFFF',NULL,NULL,NULL,NULL,NULL),(16,9,1,'ds.hosts.0.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(17,9,1,'ds.items.0.0',0,'Number of processed *values per second',NULL,NULL,NULL,NULL,NULL),(18,9,1,'ds.timeshift.0',0,'',NULL,NULL,NULL,NULL,NULL),(19,9,1,'lefty_min',0,'0',NULL,NULL,NULL,NULL,NULL),(20,9,1,'problemhosts.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(21,10,0,'ds.axisy.0',0,'',NULL,NULL,NULL,NULL,NULL),(22,10,0,'ds.fill.0',3,'',NULL,NULL,NULL,NULL,NULL),(23,10,0,'ds.missingdatafunc.0',0,'',NULL,NULL,NULL,NULL,NULL),(24,10,0,'ds.transparency.0',0,'',NULL,NULL,NULL,NULL,NULL),(25,10,0,'ds.type.0',0,'',NULL,NULL,NULL,NULL,NULL),(26,10,0,'ds.width.0',1,'',NULL,NULL,NULL,NULL,NULL),(27,10,0,'graph_item_problems',0,'',NULL,NULL,NULL,NULL,NULL),(28,10,0,'legend',0,'',NULL,NULL,NULL,NULL,NULL),(29,10,0,'righty',0,'',NULL,NULL,NULL,NULL,NULL),(30,10,0,'show_problems',1,'',NULL,NULL,NULL,NULL,NULL),(31,10,1,'ds.color.0',0,'E57373',NULL,NULL,NULL,NULL,NULL),(32,10,1,'ds.hosts.0.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(33,10,1,'ds.items.0.0',0,'Utilization of * data collector *',NULL,NULL,NULL,NULL,NULL),(34,10,1,'ds.timeshift.0',0,'',NULL,NULL,NULL,NULL,NULL),(35,10,1,'lefty_max',0,'100',NULL,NULL,NULL,NULL,NULL),(36,10,1,'lefty_min',0,'0',NULL,NULL,NULL,NULL,NULL),(37,10,1,'problemhosts.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(38,11,0,'ds.axisy.0',0,'',NULL,NULL,NULL,NULL,NULL),(39,11,0,'ds.fill.0',3,'',NULL,NULL,NULL,NULL,NULL),(40,11,0,'ds.missingdatafunc.0',0,'',NULL,NULL,NULL,NULL,NULL),(41,11,0,'ds.transparency.0',0,'',NULL,NULL,NULL,NULL,NULL),(42,11,0,'ds.type.0',0,'',NULL,NULL,NULL,NULL,NULL),(43,11,0,'ds.width.0',1,'',NULL,NULL,NULL,NULL,NULL),(44,11,0,'graph_item_problems',0,'',NULL,NULL,NULL,NULL,NULL),(45,11,0,'legend',0,'',NULL,NULL,NULL,NULL,NULL),(46,11,0,'righty',0,'',NULL,NULL,NULL,NULL,NULL),(47,11,0,'show_problems',1,'',NULL,NULL,NULL,NULL,NULL),(48,11,1,'ds.color.0',0,'E57373',NULL,NULL,NULL,NULL,NULL),(49,11,1,'ds.hosts.0.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(50,11,1,'ds.items.0.0',0,'Utilization of * internal *',NULL,NULL,NULL,NULL,NULL),(51,11,1,'ds.timeshift.0',0,'',NULL,NULL,NULL,NULL,NULL),(52,11,1,'lefty_max',0,'100',NULL,NULL,NULL,NULL,NULL),(53,11,1,'lefty_min',0,'0',NULL,NULL,NULL,NULL,NULL),(54,11,1,'problemhosts.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(55,12,0,'ds.axisy.0',0,'',NULL,NULL,NULL,NULL,NULL),(56,12,0,'ds.fill.0',0,'',NULL,NULL,NULL,NULL,NULL),(57,12,0,'ds.missingdatafunc.0',0,'',NULL,NULL,NULL,NULL,NULL),(58,12,0,'ds.transparency.0',0,'',NULL,NULL,NULL,NULL,NULL),(59,12,0,'ds.type.0',0,'',NULL,NULL,NULL,NULL,NULL),(60,12,0,'ds.width.0',2,'',NULL,NULL,NULL,NULL,NULL),(61,12,0,'graph_item_problems',0,'',NULL,NULL,NULL,NULL,NULL),(62,12,0,'legend',0,'',NULL,NULL,NULL,NULL,NULL),(63,12,0,'righty',0,'',NULL,NULL,NULL,NULL,NULL),(64,12,0,'show_problems',1,'',NULL,NULL,NULL,NULL,NULL),(65,12,1,'ds.color.0',0,'4DB6AC',NULL,NULL,NULL,NULL,NULL),(66,12,1,'ds.hosts.0.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(67,12,1,'ds.items.0.0',0,'Zabbix*cache*% used',NULL,NULL,NULL,NULL,NULL),(68,12,1,'ds.timeshift.0',0,'',NULL,NULL,NULL,NULL,NULL),(69,12,1,'lefty_max',0,'100',NULL,NULL,NULL,NULL,NULL),(70,12,1,'lefty_min',0,'0',NULL,NULL,NULL,NULL,NULL),(71,12,1,'problemhosts.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(72,13,0,'ds.axisy.0',0,'',NULL,NULL,NULL,NULL,NULL),(73,13,0,'ds.axisy.1',0,'',NULL,NULL,NULL,NULL,NULL),(74,13,0,'ds.fill.0',3,'',NULL,NULL,NULL,NULL,NULL),(75,13,0,'ds.fill.1',3,'',NULL,NULL,NULL,NULL,NULL),(76,13,0,'ds.missingdatafunc.0',0,'',NULL,NULL,NULL,NULL,NULL),(77,13,0,'ds.missingdatafunc.1',0,'',NULL,NULL,NULL,NULL,NULL),(78,13,0,'ds.transparency.0',0,'',NULL,NULL,NULL,NULL,NULL),(79,13,0,'ds.transparency.1',0,'',NULL,NULL,NULL,NULL,NULL),(80,13,0,'ds.type.0',0,'',NULL,NULL,NULL,NULL,NULL),(81,13,0,'ds.type.1',0,'',NULL,NULL,NULL,NULL,NULL),(82,13,0,'ds.width.0',2,'',NULL,NULL,NULL,NULL,NULL),(83,13,0,'ds.width.1',2,'',NULL,NULL,NULL,NULL,NULL),(84,13,0,'graph_item_problems',0,'',NULL,NULL,NULL,NULL,NULL),(85,13,0,'legend',0,'',NULL,NULL,NULL,NULL,NULL),(86,13,0,'righty',0,'',NULL,NULL,NULL,NULL,NULL),(87,13,0,'show_problems',1,'',NULL,NULL,NULL,NULL,NULL),(88,13,1,'ds.color.0',0,'9CCC65',NULL,NULL,NULL,NULL,NULL),(89,13,1,'ds.color.1',0,'FF465C',NULL,NULL,NULL,NULL,NULL),(90,13,1,'ds.hosts.0.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(91,13,1,'ds.hosts.1.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(92,13,1,'ds.items.0.0',0,'Zabbix value cache hits',NULL,NULL,NULL,NULL,NULL),(93,13,1,'ds.items.1.0',0,'Zabbix value cache misses',NULL,NULL,NULL,NULL,NULL),(94,13,1,'ds.timeshift.0',0,'',NULL,NULL,NULL,NULL,NULL),(95,13,1,'ds.timeshift.1',0,'',NULL,NULL,NULL,NULL,NULL),(96,13,1,'lefty_min',0,'0',NULL,NULL,NULL,NULL,NULL),(97,13,1,'problemhosts.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(98,14,0,'ds.axisy.0',0,'',NULL,NULL,NULL,NULL,NULL),(99,14,0,'ds.axisy.1',0,'',NULL,NULL,NULL,NULL,NULL),(100,14,0,'ds.axisy.2',0,'',NULL,NULL,NULL,NULL,NULL),(101,14,0,'ds.fill.0',0,'',NULL,NULL,NULL,NULL,NULL),(102,14,0,'ds.fill.1',0,'',NULL,NULL,NULL,NULL,NULL),(103,14,0,'ds.fill.2',0,'',NULL,NULL,NULL,NULL,NULL),(104,14,0,'ds.missingdatafunc.0',0,'',NULL,NULL,NULL,NULL,NULL),(105,14,0,'ds.missingdatafunc.1',0,'',NULL,NULL,NULL,NULL,NULL),(106,14,0,'ds.missingdatafunc.2',0,'',NULL,NULL,NULL,NULL,NULL),(107,14,0,'ds.transparency.0',0,'',NULL,NULL,NULL,NULL,NULL),(108,14,0,'ds.transparency.1',0,'',NULL,NULL,NULL,NULL,NULL),(109,14,0,'ds.transparency.2',0,'',NULL,NULL,NULL,NULL,NULL),(110,14,0,'ds.type.0',0,'',NULL,NULL,NULL,NULL,NULL),(111,14,0,'ds.type.1',0,'',NULL,NULL,NULL,NULL,NULL),(112,14,0,'ds.type.2',0,'',NULL,NULL,NULL,NULL,NULL),(113,14,0,'ds.width.0',2,'',NULL,NULL,NULL,NULL,NULL),(114,14,0,'ds.width.1',2,'',NULL,NULL,NULL,NULL,NULL),(115,14,0,'ds.width.2',2,'',NULL,NULL,NULL,NULL,NULL),(116,14,0,'graph_item_problems',0,'',NULL,NULL,NULL,NULL,NULL),(117,14,0,'legend',0,'',NULL,NULL,NULL,NULL,NULL),(118,14,0,'righty',0,'',NULL,NULL,NULL,NULL,NULL),(119,14,0,'show_problems',1,'',NULL,NULL,NULL,NULL,NULL),(120,14,1,'ds.color.0',0,'B0AF07',NULL,NULL,NULL,NULL,NULL),(121,14,1,'ds.color.1',0,'E53935',NULL,NULL,NULL,NULL,NULL),(122,14,1,'ds.color.2',0,'0275B8',NULL,NULL,NULL,NULL,NULL),(123,14,1,'ds.hosts.0.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(124,14,1,'ds.hosts.1.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(125,14,1,'ds.hosts.2.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL),(126,14,1,'ds.items.0.0',0,'Zabbix queue',NULL,NULL,NULL,NULL,NULL),(127,14,1,'ds.items.1.0',0,'Zabbix queue over 10 minutes',NULL,NULL,NULL,NULL,NULL),(128,14,1,'ds.items.2.0',0,'Zabbix preprocessing queue',NULL,NULL,NULL,NULL,NULL),(129,14,1,'ds.timeshift.0',0,'',NULL,NULL,NULL,NULL,NULL),(130,14,1,'ds.timeshift.1',0,'',NULL,NULL,NULL,NULL,NULL),(131,14,1,'ds.timeshift.2',0,'',NULL,NULL,NULL,NULL,NULL),(132,14,1,'lefty_min',0,'0',NULL,NULL,NULL,NULL,NULL),(133,14,1,'problemhosts.0',0,'Zabbix server',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `widget_field` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-27 12:49:33