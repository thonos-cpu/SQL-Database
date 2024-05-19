-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: project
-- ------------------------------------------------------
-- Server version	8.0.35

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
-- Table structure for table `etairia`
--

DROP TABLE IF EXISTS `etairia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etairia` (
  `AFM` char(9) NOT NULL,
  `DOY` varchar(30) NOT NULL DEFAULT 'unknown',
  `name` varchar(35) NOT NULL DEFAULT 'unknown',
  `tel` varchar(10) NOT NULL DEFAULT '0',
  `street` varchar(15) NOT NULL DEFAULT 'unknown',
  `num` int NOT NULL DEFAULT '0',
  `city` varchar(45) NOT NULL DEFAULT 'unknown',
  `country` varchar(15) NOT NULL DEFAULT 'unknown',
  PRIMARY KEY (`AFM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etairia`
--

LOCK TABLES `etairia` WRITE;
/*!40000 ALTER TABLE `etairia` DISABLE KEYS */;
INSERT INTO `etairia` VALUES ('123456789','DOY1','Company A','1234567890','Main Street',0,'City A','Country A'),('234567890','DOY2','Company B','2345678901','Broadway',0,'City B','Country B'),('345678901','DOY3','Company C','3456789012','High Street',0,'City C','Country C'),('456789012','DOY4','Company D','4567890123','Park Avenue',0,'City D','Country D'),('567890123','DOY5','Company E','5678901234','Oak Street',0,'City E','Country E');
/*!40000 ALTER TABLE `etairia` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-21 17:32:30
