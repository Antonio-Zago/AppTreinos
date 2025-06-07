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
-- Table structure for table `dados_treino_exercicios`
--

DROP TABLE IF EXISTS `dados_treino_exercicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dados_treino_exercicios` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `DadoTreino` int DEFAULT NULL,
  `Exercicio` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `DadoTreino` (`DadoTreino`),
  KEY `Exercicio` (`Exercicio`),
  CONSTRAINT `dados_treino_exercicios_ibfk_1` FOREIGN KEY (`DadoTreino`) REFERENCES `dados_treino` (`Id`),
  CONSTRAINT `dados_treino_exercicios_ibfk_2` FOREIGN KEY (`Exercicio`) REFERENCES `exercicios` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dados_treino_exercicios`
--

LOCK TABLES `dados_treino_exercicios` WRITE;
/*!40000 ALTER TABLE `dados_treino_exercicios` DISABLE KEYS */;
INSERT INTO `dados_treino_exercicios` VALUES (3,3,41),(4,3,42),(5,4,41),(6,4,42),(7,5,41),(8,5,42),(9,6,41),(10,6,42),(11,7,41),(12,7,42),(13,8,41),(14,8,42),(15,9,41),(16,9,42),(17,10,41),(18,10,42),(19,11,41),(20,11,42),(21,12,41),(22,12,42),(23,13,41),(24,13,42),(25,14,41),(26,14,42),(27,15,41),(28,15,42),(29,16,41),(30,17,41),(31,18,41),(32,16,42),(33,17,42),(34,19,41),(35,20,41),(36,18,42),(37,21,41),(38,19,42),(39,22,41),(40,20,42),(41,23,41),(42,24,41),(43,21,42),(44,22,42),(45,23,42),(46,24,42),(47,25,41),(48,25,42),(49,26,41),(50,26,42),(51,27,41),(52,27,42),(53,28,41),(54,28,42),(55,29,41),(56,29,42),(57,30,41),(58,30,42),(59,31,41),(60,31,42),(61,32,41),(62,32,42),(63,33,41),(64,33,42),(65,34,41),(66,34,42),(67,35,41),(68,35,42),(69,36,43),(70,36,44),(71,36,45),(72,36,46),(73,37,8),(74,37,42),(75,37,46),(76,38,8),(77,38,42),(78,38,46),(79,39,8),(80,39,42),(81,39,46),(82,40,8),(83,40,42),(84,40,46),(85,41,8),(86,41,42),(87,41,46),(88,42,8),(89,42,42),(90,42,46),(91,43,8),(92,43,42),(93,43,46),(94,44,8),(95,44,42),(96,44,46),(97,45,8),(98,45,42),(99,45,46),(100,46,8),(101,46,42),(102,47,8),(103,47,42),(104,48,8),(105,48,42),(106,49,8),(107,49,42),(108,50,8),(109,50,42),(110,51,8),(111,51,42),(112,52,8),(113,52,42),(114,53,8),(115,53,42),(116,54,8),(117,54,42),(118,55,8),(119,55,42),(120,56,8),(121,56,42),(122,57,8),(123,57,42),(124,58,8),(125,58,42),(126,59,8),(127,59,42),(128,60,8),(129,60,42),(130,61,8),(131,61,42),(132,62,8),(133,62,42),(134,63,8),(135,63,42),(136,64,8),(137,64,42),(138,65,8),(139,66,8);
/*!40000 ALTER TABLE `dados_treino_exercicios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-07 18:53:51
