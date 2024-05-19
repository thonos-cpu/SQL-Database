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
-- Table structure for table `has_degree`
--

DROP TABLE IF EXISTS `has_degree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `has_degree` (
  `degr_title` varchar(150) NOT NULL DEFAULT 'unknown',
  `degr_idryma` varchar(150) NOT NULL DEFAULT 'unknown',
  `cand_username` varchar(30) NOT NULL,
  `etos` year NOT NULL,
  `grade` float NOT NULL,
  PRIMARY KEY (`cand_username`),
  KEY `DGR` (`degr_title`,`degr_idryma`),
  CONSTRAINT `DGR` FOREIGN KEY (`degr_title`, `degr_idryma`) REFERENCES `degree` (`titlos`, `idryma`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `has_degree`
--

LOCK TABLES `has_degree` WRITE;
/*!40000 ALTER TABLE `has_degree` DISABLE KEYS */;
INSERT INTO `has_degree` VALUES ('Business Administration','University D','alice_wilson',2021,4),('Electrical Engineering','University C','bob_jones',2018,3.5),('Physics','University G','david_green',2020,4.1),('Psychology','University H','emily_davis',2018,3.6),('Data Science','University B','jane_smith',2019,4.2),('Computer Science','University A','john_doe',2020,3.8),('Environmental Science','University I','michael_smith',2017,4.3),('Economics','University J','olivia_jones',2019,3.8),('Mathematics','University E','peter_brown',2017,3.9),('Chemistry','University F','susan_white',2019,3.7);
/*!40000 ALTER TABLE `has_degree` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-21 17:32:31
