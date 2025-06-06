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
-- Table structure for table `dados_treino_exercicios_series`
--

DROP TABLE IF EXISTS `dados_treino_exercicios_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dados_treino_exercicios_series` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Repeticoes` int NOT NULL,
  `Carga` decimal(5,2) DEFAULT NULL,
  `DadoTreinoExercicio` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `DadoTreinoExercicio` (`DadoTreinoExercicio`),
  CONSTRAINT `dados_treino_exercicios_series_ibfk_1` FOREIGN KEY (`DadoTreinoExercicio`) REFERENCES `dados_treino_exercicios` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dados_treino_exercicios_series`
--

LOCK TABLES `dados_treino_exercicios_series` WRITE;
/*!40000 ALTER TABLE `dados_treino_exercicios_series` DISABLE KEYS */;
INSERT INTO `dados_treino_exercicios_series` VALUES (1,10,50.00,3),(2,20,60.00,3),(3,12,55.00,3),(4,12,54.00,4),(5,21,30.00,4),(6,17,51.00,4),(7,10,50.00,5),(8,20,60.00,5),(9,12,55.00,5),(10,12,54.00,6),(11,21,30.00,6),(12,17,51.00,6),(13,10,50.00,7),(14,20,60.00,7),(15,12,55.00,7),(16,12,54.00,8),(17,21,30.00,8),(18,17,51.00,8),(19,10,50.00,9),(20,20,60.00,9),(21,12,55.00,9),(22,12,54.00,10),(23,21,30.00,10),(24,17,51.00,10),(25,20,200.00,11),(26,15,10.00,11),(27,32,413.00,12),(28,31,653.00,12),(29,20,200.00,13),(30,15,10.00,13),(31,32,413.00,14),(32,31,653.00,14),(33,20,200.00,15),(34,15,10.00,15),(35,32,413.00,16),(36,31,653.00,16),(37,20,200.00,17),(38,15,10.00,17),(39,32,413.00,18),(40,31,653.00,18),(41,20,200.00,19),(42,15,10.00,19),(43,32,413.00,20),(44,31,653.00,20),(45,20,200.00,21),(46,15,10.00,21),(47,32,413.00,22),(48,31,653.00,22),(49,20,200.00,23),(50,15,10.00,23),(51,32,413.00,24),(52,31,653.00,24),(53,20,200.00,25),(54,15,10.00,25),(55,32,413.00,26),(56,31,653.00,26),(57,20,200.00,27),(58,15,10.00,27),(59,32,413.00,28),(60,31,653.00,28),(61,20,200.00,29),(62,20,200.00,30),(63,15,10.00,29),(64,15,10.00,30),(65,20,200.00,31),(66,32,413.00,32),(67,32,413.00,33),(68,20,200.00,34),(69,15,10.00,31),(70,31,653.00,32),(71,15,10.00,34),(72,20,200.00,35),(73,31,653.00,33),(74,32,413.00,36),(75,15,10.00,35),(76,31,653.00,36),(77,20,200.00,37),(78,32,413.00,38),(79,15,10.00,37),(80,20,200.00,39),(81,32,413.00,40),(82,31,653.00,38),(83,15,10.00,39),(84,20,200.00,41),(85,31,653.00,40),(86,15,10.00,41),(87,20,200.00,42),(88,32,413.00,43),(89,15,10.00,42),(90,32,413.00,44),(91,31,653.00,43),(92,32,413.00,45),(93,31,653.00,44),(94,31,653.00,45),(95,32,413.00,46),(96,31,653.00,46),(97,20,200.00,47),(98,15,10.00,47),(99,32,413.00,48),(100,31,653.00,48),(101,20,200.00,49),(102,15,10.00,49),(103,32,413.00,50),(104,31,653.00,50),(105,20,200.00,51),(106,15,10.00,51),(107,32,413.00,52),(108,31,653.00,52),(109,20,200.00,53),(110,15,10.00,53),(111,32,413.00,54),(112,31,653.00,54),(113,20,200.00,55),(114,15,10.00,55),(115,32,413.00,56),(116,31,653.00,56),(117,20,200.00,57),(118,15,10.00,57),(119,32,413.00,58),(120,31,653.00,58),(121,20,200.00,59),(122,15,10.00,59),(123,32,413.00,60),(124,31,653.00,60),(125,20,200.00,61),(126,15,10.00,61),(127,32,413.00,62),(128,31,653.00,62),(129,20,200.00,63),(130,15,10.00,63),(131,32,413.00,64),(132,31,653.00,64),(133,20,200.00,65),(134,15,10.00,65),(135,32,413.00,66),(136,31,653.00,66),(137,20,200.00,67),(138,15,10.00,67),(139,32,413.00,68),(140,31,653.00,68),(141,20,200.00,69),(142,15,10.00,69),(143,32,413.00,70),(144,31,653.00,70),(145,32,413.00,71),(146,31,653.00,71),(147,32,413.00,72),(148,31,653.00,72),(149,10,50.00,73),(150,20,60.00,73),(151,12,55.00,73),(152,12,54.00,74),(153,21,30.00,74),(154,12,54.00,75),(155,10,20.00,76),(156,10,20.00,76),(157,30,20.00,76),(158,10,10.00,77),(159,10,10.00,77),(160,20,20.00,78),(161,10,20.00,79),(162,10,20.00,79),(163,30,20.00,79),(164,10,10.00,80),(165,10,10.00,80),(166,20,20.00,81),(167,10,20.00,82),(168,10,20.00,82),(169,30,20.00,82),(170,10,10.00,83),(171,10,10.00,83),(172,20,20.00,84),(173,200,200.00,85),(174,10,20.00,85),(175,30,20.00,85),(176,10,10.00,86),(177,10,10.00,86),(178,20,20.00,87),(179,200,200.00,88),(180,10,10.00,89),(181,10,10.00,89),(182,20,20.00,90),(183,200,200.00,91),(184,200,120.00,92),(185,10,10.00,92),(186,20,20.00,93),(187,500,200.00,94),(188,200,120.00,95),(189,10,10.00,95),(190,20,20.00,96),(191,500,260.00,97),(192,200,120.00,98),(193,10,10.00,98),(194,20,20.00,99),(195,500,260.00,100),(196,200,120.00,101),(197,500,260.00,102),(198,200,120.00,103),(199,10,260.00,104),(200,10,120.00,105),(201,10,260.00,106),(202,10,120.00,107),(203,10,260.00,108),(204,10,120.00,109),(205,12,260.00,110),(206,10,130.00,111),(207,12,260.00,112),(208,10,130.00,113),(209,12,260.00,114),(210,10,100.00,115),(211,12,260.00,116),(212,10,100.00,117),(213,12,260.00,118),(214,10,100.00,119),(215,12,260.00,120),(216,10,100.00,121),(217,13,260.00,122),(218,10,100.00,123),(219,13,260.00,124),(220,10,100.00,125),(221,13,260.00,126),(222,10,100.00,127),(223,13,260.00,128),(224,10,100.00,129),(225,13,260.00,130),(226,10,100.00,131),(227,14,260.00,132),(228,10,100.00,133),(229,14,260.00,134),(230,10,100.00,135),(231,14,260.00,136),(232,10,100.00,137),(233,10,10.00,138),(234,10,20.00,139);
/*!40000 ALTER TABLE `dados_treino_exercicios_series` ENABLE KEYS */;
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
