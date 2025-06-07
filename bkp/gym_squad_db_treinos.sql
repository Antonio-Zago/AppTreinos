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
-- Table structure for table `treinos`
--

DROP TABLE IF EXISTS `treinos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `treinos` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treinos`
--

LOCK TABLES `treinos` WRITE;
/*!40000 ALTER TABLE `treinos` DISABLE KEYS */;
INSERT INTO `treinos` VALUES (23,'Peito 2 teste'),(24,'costas'),(25,'costas'),(26,'Costas'),(27,'heuwh'),(28,'hsusb'),(29,'cguh'),(30,''),(31,''),(32,'hs6sh'),(33,'teste testando'),(34,'testetsbb'),(35,'hsus s'),(36,'jeieb'),(37,'cececece.'),(38,'vevr'),(39,'twste2'),(40,'salvo dispo'),(41,'teste'),(42,'rgtb'),(43,'teste'),(44,'qualquerrwgg'),(45,'qualquer'),(46,'teste testando'),(47,'treino 1'),(48,'novo'),(49,'teste'),(50,'teste2'),(51,'bshs2'),(52,'teste'),(53,'treini online'),(54,'shais'),(55,'online novo'),(56,'on'),(57,'off'),(58,'off'),(59,'off'),(60,'off'),(61,'off'),(62,'off'),(63,'off2'),(64,'offline'),(65,'treino online'),(66,'online'),(67,'offline'),(68,'offline'),(69,'offline'),(70,'offline'),(71,'offline'),(72,'offline'),(73,'online'),(74,'offline'),(75,'online'),(76,'offline'),(77,'gyyy'),(78,'offline 2'),(79,'offline 3'),(80,'offline 4'),(81,'bsuwb');
/*!40000 ALTER TABLE `treinos` ENABLE KEYS */;
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
