-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: gym_squad_db
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `treinos_exercicios`
--

DROP TABLE IF EXISTS `treinos_exercicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `treinos_exercicios` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Treino` int DEFAULT NULL,
  `Exercicio` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `Exercicio` (`Exercicio`),
  KEY `Treino` (`Treino`),
  CONSTRAINT `treinos_exercicios_ibfk_2` FOREIGN KEY (`Exercicio`) REFERENCES `exercicios` (`Id`),
  CONSTRAINT `treinos_exercicios_ibfk_3` FOREIGN KEY (`Treino`) REFERENCES `treinos` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treinos_exercicios`
--

LOCK TABLES `treinos_exercicios` WRITE;
/*!40000 ALTER TABLE `treinos_exercicios` DISABLE KEYS */;
INSERT INTO `treinos_exercicios` VALUES (63,24,8),(73,23,41),(74,23,42),(75,26,43),(76,26,44),(77,26,45),(78,26,46),(79,27,8),(80,28,8),(81,29,8),(82,32,8),(83,33,8),(84,34,8),(85,34,42),(86,35,42),(87,39,8),(88,40,8),(89,23,45),(90,23,46),(91,41,8),(92,41,44),(93,42,8),(94,43,8),(95,44,8),(96,44,42),(98,45,42),(99,45,46),(100,46,42),(101,47,8),(102,48,8),(103,49,8),(104,50,8),(105,51,8),(106,51,41),(107,50,42),(108,52,8),(109,52,43),(110,53,43),(111,52,45),(112,54,43),(113,55,42),(114,56,41),(115,57,8),(116,58,8),(117,59,8),(118,60,8),(119,61,8),(120,62,8),(122,64,41),(123,63,43),(124,63,44),(125,65,8),(126,66,41),(127,67,8),(128,68,8),(129,69,8),(130,70,8),(131,71,8),(132,72,8),(133,73,41),(134,74,41),(135,75,42),(136,76,41),(137,77,8),(138,78,42),(139,79,43),(140,80,43),(141,81,43);
/*!40000 ALTER TABLE `treinos_exercicios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-07 18:53:50
