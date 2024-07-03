-- MariaDB dump 10.19  Distrib 10.11.0-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: allolecture
-- ------------------------------------------------------
-- Server version	10.4.27-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articles` (
  `id_art` int(11) NOT NULL AUTO_INCREMENT,
  `nom_art` varchar(50) NOT NULL,
  `createur_art` varchar(50) NOT NULL,
  `duree` varchar(50) NOT NULL,
  `date_crea` date NOT NULL,
  `date_upload` date DEFAULT NULL,
  `id_cat` int(11) NOT NULL,
  PRIMARY KEY (`id_art`),
  KEY `id_cat` (`id_cat`),
  CONSTRAINT `id_cat` FOREIGN KEY (`id_cat`) REFERENCES `catégories` (`id_cat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles`
--

LOCK TABLES `articles` WRITE;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` VALUES
(1,'Nathan & les assiettes','Laury Nathan','1h37','2024-07-02','0000-00-00',1),
(2,'Nathan & les assiettes','Laury Nathan','1h37','2024-07-02','0000-00-00',1),
(3,'Nathan & les assiettes','Laury Nathan','1h37','2024-07-02','2024-07-03',1),
(4,'Nathan & les assiettes','Laury Nathan','1h37','2024-07-02','2024-07-03',1),
(5,'Nathan & les assiettes','Laury Nathan','1h37','2024-07-02','2024-07-03',1),
(6,'Nathan & les assiettes','Laury Nathan','1h37','2024-07-02','2024-07-03',1),
(7,'Nathan & les assiettes','Laury Nathan','1h37','2024-07-02','2024-07-03',1);
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catégories`
--

DROP TABLE IF EXISTS `catégories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catégories` (
  `id_cat` int(11) NOT NULL AUTO_INCREMENT,
  `nom_cat` varchar(50) NOT NULL,
  PRIMARY KEY (`id_cat`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catégories`
--

LOCK TABLES `catégories` WRITE;
/*!40000 ALTER TABLE `catégories` DISABLE KEYS */;
INSERT INTO `catégories` VALUES
(1,'Films'),
(2,'Livres'),
(3,'Mangas'),
(4,'Séries'),
(5,'Bandes dessinées');
/*!40000 ALTER TABLE `catégories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes` (
  `id_note` int(11) NOT NULL AUTO_INCREMENT,
  `note` int(11) NOT NULL,
  `id_art` int(11) NOT NULL,
  PRIMARY KEY (`id_note`),
  KEY `id_art` (`id_art`),
  CONSTRAINT `id_art` FOREIGN KEY (`id_art`) REFERENCES `articles` (`id_art`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
INSERT INTO `notes` VALUES
(1,5,7),
(2,2,7),
(3,3,7),
(4,3,7),
(5,3,7),
(6,3,7),
(7,1,7),
(8,1,7),
(9,4,7),
(10,5,7),
(11,5,7),
(12,5,7);
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-03 11:58:19
