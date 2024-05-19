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
-- Table structure for table `admin_actions_log`
--

DROP TABLE IF EXISTS `admin_actions_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_actions_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `admin_username` varchar(30) NOT NULL,
  `action` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `table_name` varchar(50) NOT NULL,
  `details` text,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=290 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_actions_log`
--

LOCK TABLES `admin_actions_log` WRITE;
/*!40000 ALTER TABLE `admin_actions_log` DISABLE KEYS */;
INSERT INTO `admin_actions_log` VALUES (244,'2024-01-07 13:45:03','root@localhost','DELETE','degree','Record deleted: titlos = Business Administration, idryma = University D'),(245,'2024-01-07 13:45:03','root@localhost','DELETE','degree','Record deleted: titlos = Chemistry, idryma = University F'),(246,'2024-01-07 13:45:03','root@localhost','DELETE','degree','Record deleted: titlos = Computer Science, idryma = University A'),(247,'2024-01-07 13:45:03','root@localhost','DELETE','degree','Record deleted: titlos = Data Science, idryma = University B'),(248,'2024-01-07 13:45:03','root@localhost','DELETE','degree','Record deleted: titlos = Economics, idryma = University J'),(249,'2024-01-07 13:45:03','root@localhost','DELETE','degree','Record deleted: titlos = Electrical Engineering, idryma = University C'),(250,'2024-01-07 13:45:03','root@localhost','DELETE','degree','Record deleted: titlos = Environmental Science, idryma = University I'),(251,'2024-01-07 13:45:03','root@localhost','DELETE','degree','Record deleted: titlos = Mathematics, idryma = University E'),(252,'2024-01-07 13:45:03','root@localhost','DELETE','degree','Record deleted: titlos = Physics, idryma = University G'),(253,'2024-01-07 13:45:03','root@localhost','DELETE','degree','Record deleted: titlos = Psychology, idryma = University H'),(254,'2024-01-07 13:45:04','root@localhost','DELETE','user','User deleted: username = alice_wilson'),(255,'2024-01-07 13:45:04','root@localhost','DELETE','user','User deleted: username = bob_jones'),(256,'2024-01-07 13:45:04','root@localhost','DELETE','user','User deleted: username = david_green'),(257,'2024-01-07 13:45:04','root@localhost','DELETE','user','User deleted: username = emily_davis'),(258,'2024-01-07 13:45:04','root@localhost','DELETE','user','User deleted: username = jane_smith'),(259,'2024-01-07 13:45:04','root@localhost','DELETE','user','User deleted: username = john_doe'),(260,'2024-01-07 13:45:04','root@localhost','DELETE','user','User deleted: username = michael_smith'),(261,'2024-01-07 13:45:04','root@localhost','DELETE','user','User deleted: username = olivia_jones'),(262,'2024-01-07 13:45:04','root@localhost','DELETE','user','User deleted: username = peter_brown'),(263,'2024-01-07 13:45:04','root@localhost','DELETE','user','User deleted: username = susan_white'),(264,'2024-01-07 13:45:14','root@localhost','INSERT','degree','New record added: titlos = Computer Science, idryma = University A'),(265,'2024-01-07 13:45:14','root@localhost','INSERT','degree','New record added: titlos = Data Science, idryma = University B'),(266,'2024-01-07 13:45:14','root@localhost','INSERT','degree','New record added: titlos = Electrical Engineering, idryma = University C'),(267,'2024-01-07 13:45:14','root@localhost','INSERT','degree','New record added: titlos = Business Administration, idryma = University D'),(268,'2024-01-07 13:45:14','root@localhost','INSERT','degree','New record added: titlos = Mathematics, idryma = University E'),(269,'2024-01-07 13:45:14','root@localhost','INSERT','degree','New record added: titlos = Chemistry, idryma = University F'),(270,'2024-01-07 13:45:14','root@localhost','INSERT','degree','New record added: titlos = Physics, idryma = University G'),(271,'2024-01-07 13:45:14','root@localhost','INSERT','degree','New record added: titlos = Psychology, idryma = University H'),(272,'2024-01-07 13:45:14','root@localhost','INSERT','degree','New record added: titlos = Environmental Science, idryma = University I'),(273,'2024-01-07 13:45:14','root@localhost','INSERT','degree','New record added: titlos = Economics, idryma = University J'),(274,'2024-01-07 13:45:14','root@localhost','INSERT','user','New user added: username = john_doe'),(275,'2024-01-07 13:45:14','root@localhost','INSERT','user','New user added: username = jane_smith'),(276,'2024-01-07 13:45:14','root@localhost','INSERT','user','New user added: username = bob_jones'),(277,'2024-01-07 13:45:14','root@localhost','INSERT','user','New user added: username = alice_wilson'),(278,'2024-01-07 13:45:14','root@localhost','INSERT','user','New user added: username = peter_brown'),(279,'2024-01-07 13:45:14','root@localhost','INSERT','user','New user added: username = susan_white'),(280,'2024-01-07 13:45:14','root@localhost','INSERT','user','New user added: username = david_green'),(281,'2024-01-07 13:45:14','root@localhost','INSERT','user','New user added: username = emily_davis'),(282,'2024-01-07 13:45:14','root@localhost','INSERT','user','New user added: username = michael_smith'),(283,'2024-01-07 13:45:14','root@localhost','INSERT','user','New user added: username = olivia_jones'),(284,'2024-01-07 13:45:14','root@localhost','INSERT','job','New job added: id = 1'),(285,'2024-01-07 13:45:14','root@localhost','INSERT','job','New job added: id = 2'),(286,'2024-01-07 13:45:14','root@localhost','INSERT','job','New job added: id = 3'),(287,'2024-01-07 13:45:14','root@localhost','INSERT','job','New job added: id = 4'),(288,'2024-01-07 13:45:14','root@localhost','INSERT','job','New job added: id = 5'),(289,'2024-01-07 16:18:30','root@localhost','UPDATE','job','Job updated: id = 1');
/*!40000 ALTER TABLE `admin_actions_log` ENABLE KEYS */;
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
