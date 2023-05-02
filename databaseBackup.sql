-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: containers-us-west-67.railway.app    Database: railway
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cicles`
--

DROP TABLE IF EXISTS `cicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cicles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) DEFAULT NULL,
  `familia_profesional` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `familia_profesional` (`familia_profesional`),
  CONSTRAINT `cicles_ibfk_1` FOREIGN KEY (`familia_profesional`) REFERENCES `families_profesionals` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cicles`
--

LOCK TABLES `cicles` WRITE;
/*!40000 ALTER TABLE `cicles` DISABLE KEYS */;
INSERT INTO `cicles` VALUES (1,'Sistemes microinformàtics i xarxes',1),(2,'Gestió administrativa',2),(3,'Electromecànica de vehicles automòbils',3),(4,'Manteniment electromecànics',4),(5,'Mecanització',5),(6,'Administració de sistemes informàtics en xarxa - orientat a Ciberseguretat',1),(7,'Desenvolupament d’aplicacions multiplataforma',1),(8,'Desenvolupament d’aplicacions web',1),(9,'Administració i finances',2),(10,'Assistència a la direcció',2),(11,'Automoció',3),(12,'Mecatrònica industrial',4),(13,'Programació de la producció en fabricació mecànica',5),(14,'Gestió de l’aigua',6);
/*!40000 ALTER TABLE `cicles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `families_profesionals`
--

DROP TABLE IF EXISTS `families_profesionals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `families_profesionals` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `families_profesionals`
--

LOCK TABLES `families_profesionals` WRITE;
/*!40000 ALTER TABLE `families_profesionals` DISABLE KEYS */;
INSERT INTO `families_profesionals` VALUES (1,'Informàtica'),(2,'Administratiu'),(3,'Automoció'),(4,'Manteniment i serveis de producció'),(5,'Fabricació mecànica'),(6,'Aigües');
/*!40000 ALTER TABLE `families_profesionals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ocupacions`
--

DROP TABLE IF EXISTS `ocupacions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ocupacions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) DEFAULT NULL,
  `cicle` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cicle` (`cicle`),
  CONSTRAINT `ocupacions_ibfk_1` FOREIGN KEY (`cicle`) REFERENCES `cicles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ocupacions`
--

LOCK TABLES `ocupacions` WRITE;
/*!40000 ALTER TABLE `ocupacions` DISABLE KEYS */;
INSERT INTO `ocupacions` VALUES (1,'Personal tècnic instal·lador-reparador d’equips informàtics',1),(2,'Personal auxiliar administratiu',2),(3,'Electronicistes de vehicles',3),(4,'Mecànic de manteniment',4),(5,'Personal ajustador operari de màquines eina',5),(6,'Personal supervisor de sistemes',6);
/*!40000 ALTER TABLE `ocupacions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ranking`
--

DROP TABLE IF EXISTS `ranking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ranking` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_jugador` varchar(100) DEFAULT NULL,
  `cicle` varchar(100) DEFAULT NULL,
  `puntuacio` float DEFAULT NULL,
  `temps_emprat` double DEFAULT NULL,
  `items_correctes` int DEFAULT NULL,
  `items_incorrectes` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ranking`
--

LOCK TABLES `ranking` WRITE;
/*!40000 ALTER TABLE `ranking` DISABLE KEYS */;
INSERT INTO `ranking` VALUES (1,'test','Desenvolupament d\'Aplicacions Multiplataforma',0,0,15,15),(2,'test','Desenvolupament d\'Aplicacions Multiplataforma',0,0,15,15),(3,'test','Desenvolupament d\'Aplicacions Multiplataforma',0,0,15,15),(4,'test','Desenvolupament d\'Aplicacions Multiplataforma',0,0,15,15),(5,'test','Desenvolupament d\'Aplicacions Multiplataforma',0,0,15,15),(6,'test','Desenvolupament d\'Aplicacions Multiplataforma',0,0,15,15),(7,'test','Desenvolupament d\'Aplicacions Multiplataforma',0,0,15,15),(8,'test','Desenvolupament d\'Aplicacions Multiplataforma',0,0,15,15),(9,'test','Desenvolupament d\'Aplicacions Multiplataforma',0,0,15,15),(10,'test','Desenvolupament d\'Aplicacions Multiplataforma',0,0,15,15),(11,'test','Desenvolupament d\'Aplicacions Multiplataforma',0,0,15,15),(12,'test','Desenvolupament d\'Aplicacions Multiplataforma',0,0,15,15),(13,'test','Desenvolupament d\'Aplicacions Multiplataforma',0,0,15,15),(14,'test','Desenvolupament d\'Aplicacions Multiplataforma',0,0,15,15),(15,'test','Desenvolupament d\'Aplicacions Multiplataforma',0,0,15,15),(16,'test','Desenvolupament d\'Aplicacions Multiplataforma',147.5,30,15,15),(17,'test','Desenvolupament d\'Aplicacions Multiplataforma',99.5,30,10,3),(18,'test','Desenvolupament d\'Aplicacions Multiplataforma',100,30,10,0),(19,'test','Desenvolupament d\'Aplicacions Multiplataforma',147.5,30,15,15),(20,'ISMA','Desenvolupament d\'Aplicacions Multiplataforma',1497.5,30,150,15);
/*!40000 ALTER TABLE `ranking` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-02 16:10:12
