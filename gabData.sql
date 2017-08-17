CREATE DATABASE  IF NOT EXISTS `gabData` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `gabData`;
-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: localhost    Database: gabData
-- ------------------------------------------------------
-- Server version	5.5.5-10.2.7-MariaDB

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
-- Table structure for table `gabs`
--

DROP TABLE IF EXISTS `gabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gabs` (
  `idgabs` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gab` varchar(140) DEFAULT NULL,
  `userid` int(10) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`idgabs`),
  UNIQUE KEY `idgabs_UNIQUE` (`idgabs`),
  KEY `gab_userFK_idx` (`userid`),
  CONSTRAINT `gab_userFK` FOREIGN KEY (`userid`) REFERENCES `users` (`idusers`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gabs`
--

LOCK TABLES `gabs` WRITE;
/*!40000 ALTER TABLE `gabs` DISABLE KEYS */;
INSERT INTO `gabs` VALUES (1,'hello',1,'2017-08-16 09:47:22'),(2,'hello',5,'2017-08-16 09:47:22'),(3,'akjfbaksjbfaj',1,'2017-08-16 09:47:22'),(4,'ndiownvirjv',1,'2017-08-16 09:47:22'),(5,'osboiufbiwef',1,'2017-08-16 09:47:22'),(6,'kjbvkcfxcg',1,'2017-08-16 09:47:22'),(7,'kjbvkcfxcg',NULL,'2017-08-16 09:47:22'),(8,'kjbvkcfxcg',NULL,'2017-08-16 09:47:22'),(9,'hngrthyjuhtgrfergthjhgrfe',1,'2017-08-16 09:47:22'),(10,'today',1,'2017-08-16 09:47:22'),(11,'dlvhslv',1,'2017-08-16 09:47:22'),(12,'post',1,'2017-08-16 09:47:22'),(13,'most recent',NULL,'2017-08-16 09:47:22'),(14,'most recent',1,'2017-08-16 09:47:22'),(15,'alfjbeuesbjkfd',1,'2017-08-16 09:48:04'),(16,'Chess and Poker rock',4,'2017-08-16 11:09:59'),(17,'asdf\r\n',4,'2017-08-16 11:11:13'),(18,'hftgvjfuyjhvbk',1,'2017-08-16 11:28:41'),(19,'rxdcfgvhbjnk',1,'2017-08-16 13:46:54'),(20,'hello hello hello',1,'2017-08-16 14:15:57'),(21,'',1,'2017-08-16 14:16:10'),(22,'mjhuygvb',1,'2017-08-16 14:16:57'),(23,'lkhgjhcgfx{{gab.user_name}} mn',1,'2017-08-16 15:00:08');
/*!40000 ALTER TABLE `gabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `idlikes` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned DEFAULT NULL,
  `gabid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`idlikes`),
  UNIQUE KEY `idlikes_UNIQUE` (`idlikes`),
  KEY `like_userFK_idx` (`userid`),
  KEY `like_gabFK_idx` (`gabid`),
  CONSTRAINT `like_gabFK` FOREIGN KEY (`gabid`) REFERENCES `gabs` (`idgabs`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `like_userFK` FOREIGN KEY (`userid`) REFERENCES `users` (`idusers`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,4,17),(2,1,17),(3,1,19),(4,1,17),(5,1,21),(6,1,22),(7,1,22),(8,1,22),(9,1,22),(10,1,22),(11,1,22),(12,1,22),(13,1,22);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `idusers` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idusers`),
  UNIQUE KEY `idusers_UNIQUE` (`idusers`),
  UNIQUE KEY `user_name_UNIQUE` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Mila','password','mila'),(4,'mike','password','MIke'),(5,'sasha','password','Sasha');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-08-17 10:49:55
