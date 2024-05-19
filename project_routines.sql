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
-- Dumping events for database 'project'
--

--
-- Dumping routines for database 'project'
--
/*!50003 DROP PROCEDURE IF EXISTS `application_stage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `application_stage`(
    IN ap_username VARCHAR(30),
    IN ap_jobid INT(11),
    IN ap_char VARCHAR(2),
    OUT message_ap VARCHAR(50)
)
BEGIN
    DECLARE state_app VARCHAR(10);
    DECLARE evaluator_1 VARCHAR(30);
    DECLARE evaluator_2 VARCHAR(30);

    SELECT state, evaluator1, evaluator2 
    INTO state_app, evaluator_1, evaluator_2
    FROM applications
    WHERE cand_id = ap_username AND job_id = ap_jobid;



    CASE 
        WHEN ap_char = 'i' THEN
            IF state_app IS NOT NULL THEN
                SET message_ap = "APPLICATION IS LIVE!";
            ELSE
                SELECT username INTO evaluator_1 FROM evaluator ORDER BY RAND() LIMIT 1;
                SELECT username INTO evaluator_2 FROM evaluator ORDER BY RAND() LIMIT 1;
                INSERT INTO applications (state, jobid, cand_id, date_applied, evaluator1, evaluator2)
                VALUES ('ACTIVE', ap_jobid, ap_username, CURDATE(), evaluator_1, evaluator_2);
            END IF;

        WHEN ap_char = 'c' THEN
            IF state_app = 'CANCELED' THEN
                SET message_ap = "ALREADY CANCELED";
            ELSEIF state_app IS NULL THEN
                SET message_ap = "APPLICATION DOES NOT EXIST!";
            ELSE
                UPDATE applications SET state = 'CANCELED'
                WHERE cand_id = ap_username AND job_id = ap_jobid;
            END IF;

        WHEN ap_char = 'a' THEN
            IF state_app = 'ACTIVE' THEN
                SET message_ap = "ALREADY ACTIVE";
            ELSEIF state_app IS NULL THEN
                SET message_ap = "APPLICATION DOES NOT EXIST!";
            ELSE
                UPDATE applications SET state = 'ACTIVE'
                WHERE cand_id = ap_username AND job_id = ap_jobid;
            END IF;
    END CASE;

    SELECT message_ap;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `checkEval` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkEval`(
    IN chevaluator VARCHAR(30),
    IN chemployee VARCHAR(30),
    IN chjob_id INT,
    OUT chvathmos INT
)
BEGIN
    DECLARE chappId INT(11);
    DECLARE chevaluator1 VARCHAR(30);
    DECLARE chevaluator2 VARCHAR(30);
    DECLARE chscore1 INT(3);
    DECLARE chscore2 INT(3);
    DECLARE chscore INT(3);

    SELECT evaluator1, evaluator2, score1, score2, score
    INTO chevaluator1, chevaluator2, chscore1, chscore2, chscore
    FROM applications
    WHERE chjob_id = job_id AND chemployee = cand_id;

    IF (chevaluator != chevaluator1) AND (chevaluator != chevaluator2) THEN
        SET chvathmos = 0;
    ELSEIF (chevaluator = chevaluator1) AND (chscore1 IS NULL) THEN
        SELECT COUNT(*) +
               (SELECT COUNT(*) FROM languages WHERE chemployee = candid) +
               (SELECT COUNT(*) FROM has_degree INNER JOIN degree ON degree.titlos = has_degree.degr_title AND degree.idryma = has_degree.degr_idryma WHERE chemployee = cand_username AND  bathmida = 'BSc') +
               ((SELECT COUNT(*) FROM has_degree INNER JOIN degree ON degree.titlos = has_degree.degr_title AND degree.idryma = has_degree.degr_idryma WHERE chemployee = cand_username AND bathmida = 'MSc') * 2) +
               ((SELECT COUNT(*) FROM has_degree INNER JOIN degree ON degree.titlos = has_degree.degr_title AND degree.idryma = has_degree.degr_idryma  WHERE chemployee = cand_username AND bathmida = 'PhD') * 3)
        INTO chvathmos FROM project WHERE chemployee = candid;
    ELSEIF (chevaluator = chevaluator2) AND (chscore2 IS NULL) THEN
        SELECT COUNT(*) +
               (SELECT COUNT(*) FROM languages WHERE chemployee = candid) +
               (SELECT COUNT(*) FROM has_degree INNER JOIN degree ON degree.titlos = has_degree.degr_title AND degree.idryma = has_degree.degr_idryma  WHERE chemployee = cand_username AND bathmida = 'BSc') +
               ((SELECT COUNT(*) FROM has_degree INNER JOIN degree ON degree.titlos = has_degree.degr_title AND degree.idryma = has_degree.degr_idryma WHERE chemployee = cand_username AND bathmida = 'MSc') * 2) +
               ((SELECT COUNT(*) FROM has_degree INNER JOIN degree ON degree.titlos = has_degree.degr_title AND degree.idryma = has_degree.degr_idryma WHERE chemployee = cand_username AND bathmida = 'PhD') * 3)
        INTO chvathmos FROM project WHERE chemployee = candid;
    ELSEIF chevaluator = chevaluator1 THEN SET chvathmos = chscore1;
    ELSE SET chvathmos = chscore2;
    END IF;

SELECT chvathmos;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `employee_range` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `employee_range`(
    IN thahmos1 INT,
    IN thahmos2 INT,
    OUT employee_user VARCHAR(30),
    OUT employee_jobid INT(11)
)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE thahmos FLOAT;
    DECLARE employ_user VARCHAR(30);
    DECLARE employ_jobid INT;

    DECLARE cur CURSOR FOR
        SELECT score, job_id, cand_id
        FROM applications_log
        WHERE score BETWEEN LEAST(thahmos2, thahmos1) AND GREATEST(thahmos2, thahmos1);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO thahmos, employ_jobid, employ_user;

        IF done THEN
            LEAVE read_loop;
        END IF;

        SET employee_user = employ_user;
        SET employee_jobid = employ_jobid;

        SELECT employee_user, employee_jobid;

    END LOOP;

    CLOSE cur;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EvaluateApplications` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EvaluateApplications`()
BEGIN
    DECLARE appId INT(11);
    DECLARE finishedFlag INT DEFAULT 0;
    DECLARE bathmida_procedure VARCHAR(30);
    DECLARE SCORE_1 INT(3);
    DECLARE SCORE_2 INT(3);
    DECLARE candidateId VARCHAR(30);
    DECLARE scoreAvg FLOAT;
    DECLARE SubmissionDate DATE;
    DECLARE degreePoints INT; 

    DECLARE appCursor CURSOR FOR 
        SELECT application_id, cand_id FROM applications WHERE state = 'ACTIVE';
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlag = 1;

    OPEN appCursor;

    appLoop: LOOP
        IF finishedFlag THEN
            LEAVE appLoop;
        END IF;
        
        FETCH appCursor INTO appId, candidateId;
        
    SELECT bathmida INTO bathmida_procedure FROM has_degree INNER JOIN degree ON degree.titlos = has_degree.degr_title AND degree.idryma = has_degree.degr_idryma WHERE candidateId = cand_username;
        
      SELECT COUNT(*) +
      (SELECT COUNT(*) FROM languages WHERE candidateId = candid) +
               (SELECT COUNT(*) FROM has_degree INNER JOIN degree ON degree.titlos = has_degree.degr_title AND degree.idryma = has_degree.degr_idryma WHERE candidateId = cand_username AND  bathmida_procedure = 'BSc') +
               ((SELECT COUNT(*) FROM has_degree INNER JOIN degree ON degree.titlos = has_degree.degr_title AND degree.idryma = has_degree.degr_idryma WHERE candidateId = cand_username AND bathmida_procedure = 'MSc') * 2) +
               ((SELECT COUNT(*) FROM has_degree INNER JOIN degree ON degree.titlos = has_degree.degr_title AND degree.idryma = has_degree.degr_idryma  WHERE candidateId = cand_username AND bathmida_procedure = 'PhD') * 3)
      INTO degreePoints FROM project WHERE candidateId = candid;
      
      SELECT score1, score2, score INTO SCORE_1, SCORE_2, scoreAvg FROM applications WHERE application_id = appId;

        SET SCORE_1 = IFNULL(SCORE_1, degreePoints),
        SCORE_2 = IFNULL(SCORE_2, degreePoints);
        
        SELECT (SCORE_1 + SCORE_2) / 2 INTO scoreAvg;
    
        UPDATE applications SET score = scoreAvg, state = 'COMPLETE' WHERE application_id = appId;

    
    END LOOP;

    CLOSE appCursor;
    
CALL FIND_WINNING_APPLICATION();
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `evaluator_applies` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `evaluator_applies`(
    IN evaluator_username VARCHAR(30),
    OUT employee_user VARCHAR(30),
    OUT employee_jobid INT(11)
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR
        SELECT cand_id, job_id
        FROM applications_log
        WHERE evaluator1 = evaluator_username OR evaluator2 = evaluator_username;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    SET employee_user = '';
    SET employee_jobid = 0;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO employee_user, employee_jobid;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT employee_user;
        SELECT employee_jobid;
    END LOOP;
    CLOSE cur;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FIND_WINNING_APPLICATION` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FIND_WINNING_APPLICATION`()
BEGIN
DECLARE appId INT(11);
    DECLARE finishedFlag INT DEFAULT 0;
    DECLARE score_final INT(3);
    DECLARE candidateId VARCHAR(30);
    DECLARE SubmissionDate DATE;
    DECLARE winningAppId INT(11);
    DECLARE earlySubmissionDate DATE;
    DECLARE maxScore INT(3);
    
    DECLARE appCursor CURSOR FOR 
        SELECT application_id, score, application_date FROM applications WHERE state = 'COMPLETE';
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlag = 1;

    OPEN appCursor;

  SET maxScore = 0;

    appLoop: LOOP
        IF finishedFlag THEN
            LEAVE appLoop;
        END IF;
        
        FETCH appCursor INTO appId, score_final, SubmissionDate;
        
         IF (score_final > maxScore) OR (score_final = maxScore AND SubmissionDate < earlySubmissionDate) THEN
            SET maxScore = score_final;
            SET winningAppId = appId;
            SET earlySubmissionDate = SubmissionDate;
        END IF;
        
        INSERT INTO applications_log (state, evaluator1,appId, evaluator2, cand_id, score, job_id) SELECT state, evaluator1, application_id, evaluator2, cand_id, score, application_id 
FROM applications WHERE application_id = appId AND (state = 'COMPLETE' OR state = 'WIN');
DELETE FROM applications WHERE application_id = appId AND (state = 'COMPLETE' OR state = 'WIN');
        
END LOOP;

UPDATE applications_log SET state = 'WIN' WHERE winningAppId = job_id;
SELECT winningAppId;

CLOSE appCursor;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_application_logs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_application_logs`()
BEGIN
  DECLARE i INT DEFAULT 1;

  WHILE i <= 60000 DO
    INSERT INTO applications_log (
      state,
      job_id,
      appId,
      score,
      cand_id,
      evaluator1,
      evaluator2
    ) VALUES (
      CASE WHEN i % 2 = 0 THEN 'WIN'
           WHEN i % 3 = 0 THEN 'COMPLETE'
	   ELSE 'CANCELED'
      END,
      FLOOR(RAND() * 100) + 1,  
      i,
      RAND() * 20,  
      CONCAT('user', i),  
      CONCAT('evaluator', i),
      CONCAT('SideEvaluator', i + 1)
    );
    
    SET i = i + 1;
  END WHILE;
END ;;
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

-- Dump completed on 2024-01-21 17:32:32
