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
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applications` (
  `state` enum('WIN','COMPLETE','CANCELED','ACTIVE') DEFAULT NULL,
  `job_id` int NOT NULL DEFAULT '0',
  `cand_id` varchar(30) NOT NULL,
  `application_date` date NOT NULL,
  `application_id` int NOT NULL,
  `evaluator1` varchar(30) DEFAULT NULL,
  `evaluator2` varchar(30) DEFAULT NULL,
  `score1` int DEFAULT NULL,
  `score2` int DEFAULT NULL,
  `score` float DEFAULT NULL,
  PRIMARY KEY (`application_id`),
  KEY `APPJOBID` (`job_id`),
  KEY `APPEVAL1` (`evaluator1`),
  KEY `APPEVAL2` (`evaluator2`),
  KEY `APPCAND` (`cand_id`),
  CONSTRAINT `APPCAND` FOREIGN KEY (`cand_id`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `APPEVAL1` FOREIGN KEY (`evaluator1`) REFERENCES `evaluator` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `APPEVAL2` FOREIGN KEY (`evaluator2`) REFERENCES `evaluator` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `APPJOBID` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applications`
--

LOCK TABLES `applications` WRITE;
/*!40000 ALTER TABLE `applications` DISABLE KEYS */;
INSERT INTO `applications` VALUES ('ACTIVE',1,'john_doe','2023-01-29',1,'jane_smith','bob_jones',85,90,NULL),('ACTIVE',2,'john_doe','2022-02-02',2,'bob_jones','alice_wilson',92,88,NULL),('ACTIVE',3,'john_doe','2022-02-03',3,'alice_wilson','peter_brown',NULL,NULL,NULL);
/*!40000 ALTER TABLE `applications` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `application_limitations` BEFORE INSERT ON `applications` FOR EACH ROW BEGIN
  DECLARE job_start_date DATE;
  DECLARE active_applications INT;

  SELECT start_date INTO job_start_date FROM JOB WHERE id = NEW.job_id;
  IF DATEDIFF(job_start_date, NEW.application_date) < 15 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'New applications can only be created up to 15 days before the start date of the job.';
  END IF;

  SELECT COUNT(*) INTO active_applications FROM applications
  WHERE cand_id = NEW.cand_id AND state = 'ACTIVE';
  IF active_applications >= 3 AND NEW.state = 'ACTIVE' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'An applicant cannot have more than 3 active applications.';
  END IF;

  IF NEW.state = 'CANCELED' AND DATEDIFF(NEW.application_date, job_start_date) < 10 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'An applicant can only cancel an application up to 10 days before the start date of the job.';
  END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `application_limitations_EXT` BEFORE UPDATE ON `applications` FOR EACH ROW BEGIN
  DECLARE job_start_date DATE;
  DECLARE active_applications INT;

  SELECT start_date INTO job_start_date FROM JOB WHERE id = NEW.job_id;
  IF DATEDIFF(job_start_date, NEW.application_date) < 15 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'New applications can only be created up to 15 days before the start date of the job.';
  END IF;

  SELECT COUNT(*) INTO active_applications FROM applications
  WHERE cand_id = NEW.cand_id AND state = 'ACTIVE';
  IF active_applications >= 3 AND NEW.state = 'ACTIVE' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'An applicant cannot have more than 3 active applications.';
  END IF;

  IF NEW.state = 'CANCELED' AND DATEDIFF(NEW.application_date, job_start_date) < 10 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'An applicant can only cancel an application up to 10 days before the start date of the job.';
  END IF;


END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-21 17:32:31
