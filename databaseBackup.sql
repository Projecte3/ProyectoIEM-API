-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: containers-us-west-39.railway.app    Database: railway
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
-- Table structure for table `connexions`
--

DROP TABLE IF EXISTS `connexions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connexions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ip_origen` varchar(100) DEFAULT NULL,
  `hora_conexion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `connexions`
--

LOCK TABLES `connexions` WRITE;
/*!40000 ALTER TABLE `connexions` DISABLE KEYS */;
INSERT INTO `connexions` VALUES (2,'::ffff:192.168.0.3','2023-05-05 15:44:21'),(3,'::ffff:192.168.0.2','2023-05-05 15:46:08');
/*!40000 ALTER TABLE `connexions` ENABLE KEYS */;
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
  `nom` varchar(400) DEFAULT NULL,
  `cicle` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cicle` (`cicle`),
  CONSTRAINT `ocupacions_ibfk_1` FOREIGN KEY (`cicle`) REFERENCES `cicles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ocupacions`
--

LOCK TABLES `ocupacions` WRITE;
/*!40000 ALTER TABLE `ocupacions` DISABLE KEYS */;
INSERT INTO `ocupacions` VALUES (1,'Personal tècnic de suport informàtic',1),(2,'Personal tècnic de xarxes de dades',1),(3,'Personal reparador de perifèrics de sistemes microinformàtics',1),(4,'Comercials de microinformàtica',1),(5,'Personal operador de teleassistència',1),(6,'Personal operador de sistemes',1),(7,'Personal auxiliar administratiu',2),(8,'Personal ajudant d’oficina',2),(9,'Personal auxiliar administratiu de cobraments i pagaments',2),(10,'Personal administratiu comercial',2),(11,'Personal auxiliar administratiu de gestió de personal',2),(12,'Personal auxiliar administratiu de les administracions públiques',2),(13,'Recepcionista',2),(14,'Personal empleat d’atenció al client',2),(15,'Personal empleat de tresoreria',2),(16,'Personal empleat de mitjans de pagament',2),(17,'Electronicistes de vehicles',3),(18,'Electricistes electrònics de manteniment i reparació en automoció',3),(19,'Personal mecànic d’automòbils',3),(20,'Electricistes d’automòbils',3),(21,'Personal electromecànic d’automòbils',3),(22,'Personal mecànic de motors i els seus sistemes auxiliars d’automòbils i motocicletes',3),(23,'Personal reparador de sistemes pneumàtics i hidràulics',3),(24,'Personal reparador de sistemes de transmissió i de frens',3),(25,'Personal reparador de sistemes de direcció i suspensió',3),(26,'Personal operari d\'ITV.',3),(27,'Personal instal·lador d’accessoris en vehicles.',3),(28,'Personal operari d’empreses dedicades a la fabricació de recanvis.',3),(29,'Personal electromecànic de motocicletes.',3),(30,'Personal venedor/distribuïdor de recanvis i d’equips de diagnosi.',3),(31,'Mecànic de manteniment',4),(32,'Muntador industrial',4),(33,'Muntador d\'equips elèctrics',4),(34,'Muntador d\'equips electrònics',4),(35,'Mantenidor de línia automatitzada',4),(36,'Muntador de béns d\'equip',4),(37,'Muntador d\'automatismes pneumàtics i hidràulics',4),(38,'Instal·lador electricista industrial',4),(39,'Electricista de manteniment i reparació d\'equips de control, mesura i precisió',4),(40,'Personal ajustador operari de màquines eina',5),(41,'Personal polidor de metalls i afilador d’eines',5),(42,'Personal operador de màquines per treballar metalls',5),(43,'Personal operador de màquines eina',5),(44,'Personal operador de robots industrials',5),(45,'Personal treballador de la fabricació d’eines, mecànic i ajustador, modelista matricer i similars',5),(46,'Personal torner, fresador i mandrinador',5),(47,'Personal tècnic en administració de sistemes',6),(48,'Responsable d’informàtica',6),(49,'Personal tècnic en serveis d’Internet',6),(50,'Personal tècnic en serveis de missatgeria electrònica',6),(51,'Personal de recolzament i suport tècnic',6),(52,'Personal tècnic en teleassistència',6),(53,'Personal tècnic en administració de base de dades',6),(54,'Personal tècnic de xarxes',6),(55,'Personal supervisor de sistemes',6),(56,'Personal tècnic en serveis de comunicacions',6),(57,'Personal tècnic en entorns web',6),(58,'Desenvolupar aplicacions informàtiques per a la gestió empresarial i de negoci.',7),(59,'Desenvolupar aplicacions de propòsit general.',7),(60,'Desenvolupar aplicacions en l’àmbit de l’entreteniment i la informàtica mòbil.',7),(61,'Programador web',8),(62,'Programador multimèdia',8),(63,'Desenvolupador d’aplicacions en entorns web',8),(64,'Administratiu d\'oficina',9),(65,'Administratiu comercial',9),(66,'Administratiu financer',9),(67,'Administratiu comptable',9),(68,'Administratiu de logística',9),(69,'Administratiu de banca i d\'assegurances',9),(70,'Administratiu de recursos humans',9),(71,'Administratiu de l\'Administració pública',9),(72,'Administratiu d\'assessories jurídiques, comptables, laborals, fiscals o gestories',9),(73,'Tècnic en gestió de cobraments',9),(74,'Responsable d\'atenció al client',9),(75,'Assistent a la direcció',10),(76,'Assistent personal',10),(77,'Secretari de direcció',10),(78,'Assistent de despatxos i oficines',10),(79,'Assistent jurídic',10),(80,'Assistent en departaments de recursos humans',10),(81,'Assistent en departaments de recursos humans',10),(82,'Cap de l’àrea d’electromecànica',11),(83,'Recepcionista de vehicles',11),(84,'Cap de taller de vehicles de motor',11),(85,'Personal encarregat d’ITV',11),(86,'Personal perit taxador de vehicles',11),(87,'Cap de servei',11),(88,'Personal encarregat d’àrea de recanvis',11),(89,'Personal encarregat d’àrea comercial d’equips relacionats amb els vehicles',11),(90,'Cap de l’àrea de carrosseria: xapa i pintura',11),(91,'Tècnic en planificació i programació de processos de manteniment d\'instal·lacions de maquinària i equip industrial.',12),(92,'Cap d\'equip de muntadors d\'instal·lacions de maquinària i equip industrial.',12),(93,'Cap d\'equip de mantenidors d\'instal·lacions de maquinària i equip industrial.',12),(94,'Tècnic o tècnica en mecànica',13),(95,'Encarregat o encarregada d\'instal·lacions de processament de metalls',13),(96,'Encarregat o encarregada d\'operadors de màquines per treballar metalls',13),(97,'Encarregat o encarregada de muntadors',13),(98,'Programador o programadora de CNC (control numèric amb ordinador)',13),(99,'Programador o programadora de sistemes automatitzats en fabricació mecànica',13),(100,'Programador o programadora de la producció',13),(101,'Encargado de montaje de redes de abastecimiento y distribución de agua.',14),(102,'Encargado de montaje de redes e instalaciones de saneamiento.',14),(103,'Encargado de mantenimiento de redes de agua.',14),(104,'Encargado de mantenimiento de redes de saneamiento.',14),(105,'Operador de planta de tratamiento de agua de abastecimiento.',14),(106,'Operador de planta de tratamiento de aguas residuales.',14),(107,'Técnico en gestión del uso eficiente del agua.',14),(108,'Técnico en sistemas de distribución de agua.',14);
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
  `ip_origen` varchar(100) DEFAULT NULL,
  `dispositiu` varchar(100) DEFAULT NULL,
  `ocult` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ranking`
--

LOCK TABLES `ranking` WRITE;
/*!40000 ALTER TABLE `ranking` DISABLE KEYS */;
INSERT INTO `ranking` VALUES (1,'Edu','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'1234',NULL,1),(2,'Isma','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'5555',NULL,0),(3,'Marc','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'9999',NULL,0),(4,'Marc','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'9999',NULL,0),(5,'Marc','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'9999',NULL,0),(6,'Marc','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'9999',NULL,0),(7,'Marc','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'9999',NULL,0),(8,'Marc','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'9999',NULL,0),(9,'Isma','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'5555',NULL,0),(10,'Isma','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'5555',NULL,0),(11,'Isma','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'5555',NULL,0),(12,'Isma','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'5555',NULL,0),(13,'Isma','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'5555',NULL,0),(14,'Isma','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'5555',NULL,0),(15,'Isma','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'5555',NULL,0),(16,'Edu','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'1234',NULL,1),(17,'Edu','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'1234',NULL,1),(18,'Edu','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'1234',NULL,1),(19,'Edu','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'1234',NULL,1),(20,'Edu','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'1234',NULL,1),(21,'Edu','Desenvolupament d\'Aplicacions Multiplataforma',996.667,30,10,2,'1234',NULL,1);
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

-- Dump completed on 2023-05-05 18:21:39
