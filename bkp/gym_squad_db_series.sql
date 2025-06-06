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
-- Table structure for table `series`
--

DROP TABLE IF EXISTS `series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `series` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `TreinoExercicio` int DEFAULT NULL,
  `Repeticoes` int DEFAULT NULL,
  `Carga` double DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `TreinoExercicio` (`TreinoExercicio`),
  CONSTRAINT `series_ibfk_1` FOREIGN KEY (`TreinoExercicio`) REFERENCES `treinos_exercicios` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=469 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `series`
--

LOCK TABLES `series` WRITE;
/*!40000 ALTER TABLE `series` DISABLE KEYS */;
INSERT INTO `series` VALUES (149,75,20,200),(150,75,15,10),(151,76,32,413),(152,76,31,653),(153,77,32,413),(154,77,31,653),(155,78,32,413),(156,78,31,653),(157,79,0,0),(158,80,0,0),(159,81,13,23),(160,81,23,12),(161,82,12,150),(162,83,10,50),(163,83,10,50),(164,84,10,25),(165,84,10,25),(166,85,10,50),(167,85,15,40),(168,86,1,1),(169,87,19,20),(170,87,19,30),(171,88,1,1),(188,73,20,200),(189,73,15,10),(190,74,32,413),(191,74,31,653),(192,89,32,413),(193,89,31,653),(194,90,32,413),(195,90,31,653),(196,91,10,20),(197,91,10,30),(198,92,10,30),(199,92,10,50),(200,93,9,3),(201,94,1,1),(253,98,10,10),(254,99,14,14),(255,100,15,25),(316,95,14,260),(317,96,10,100),(319,101,10,20),(320,102,1,1),(321,103,1,1),(349,104,2,2),(350,104,4,4),(351,107,1,2),(352,107,12,12),(353,105,1,2),(354,106,1,2),(355,106,3,5),(394,113,1,1),(402,112,1,1),(409,110,23,12),(410,108,1,1),(411,108,2,2),(412,108,3,3),(413,109,3,3),(414,109,4,4),(415,111,11,1),(416,114,2,2),(417,115,1,1),(418,116,1,1),(419,117,1,1),(420,118,1,1),(421,119,1,1),(422,120,1,1),(427,122,1,1),(437,125,1,1),(438,123,3,3),(439,124,1,1),(441,127,1,1),(444,126,1,1),(446,128,1,1),(448,129,1,1),(449,131,1,1),(451,130,1,1),(452,132,1,1),(453,133,1,1),(454,134,1,1),(456,136,1,1),(457,135,1,1),(461,137,1,1),(462,138,1,1),(466,139,1,1),(467,140,6,8),(468,141,1,1);
/*!40000 ALTER TABLE `series` ENABLE KEYS */;
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
