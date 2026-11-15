-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: online_voting_system
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
-- Table structure for table `audit_logs`
--

DROP TABLE IF EXISTS `audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_logs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `action` enum('DUPLICATE_VOTE_ATTEMPT','ELECTION_TIME_MODIFICATION_ATTEMPT','EO_REMOVED','UNAUTHORIZED_ELECTION_ACTION','UNAUTHORIZED_RESULT_RELEASE') NOT NULL,
  `description` varchar(1000) NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKjs4iimve3y0xssbtve5ysyef0` (`user_id`),
  CONSTRAINT `FKjs4iimve3y0xssbtve5ysyef0` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_logs`
--

LOCK TABLES `audit_logs` WRITE;
/*!40000 ALTER TABLE `audit_logs` DISABLE KEYS */;
INSERT INTO `audit_logs` VALUES (2,'DUPLICATE_VOTE_ATTEMPT','User attempted to vote more than once in election ID: 22','2026-09-28 02:06:41.664883',1),(3,'DUPLICATE_VOTE_ATTEMPT','User attempted to vote more than once in election ID: 30','2026-10-05 00:12:11.097363',11),(4,'DUPLICATE_VOTE_ATTEMPT','User attempted to vote more than once in election ID: 31','2026-10-05 10:11:38.112831',8),(5,'DUPLICATE_VOTE_ATTEMPT','User attempted to vote more than once in election ID: 34','2026-11-15 20:03:05.205663',25);
/*!40000 ALTER TABLE `audit_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ballots`
--

DROP TABLE IF EXISTS `ballots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ballots` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cast_at` datetime(6) NOT NULL,
  `encrypted_vote` tinytext NOT NULL,
  `election_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKfxpkv6bligg8f7gyrqcdnoerh` (`election_id`),
  CONSTRAINT `FKfxpkv6bligg8f7gyrqcdnoerh` FOREIGN KEY (`election_id`) REFERENCES `elections` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ballots`
--

LOCK TABLES `ballots` WRITE;
/*!40000 ALTER TABLE `ballots` DISABLE KEYS */;
INSERT INTO `ballots` VALUES (1,'2026-09-27 20:27:29.514588','+yoeEUFgr5Hl3cKGHo/TCdMu1TbzXUY+tSpSlA4=',19),(2,'2026-09-28 02:06:37.805150','u38TSU3FRrbMZ5BfXem1OX+1Ar3IvkW5d3xzZi0=',22),(3,'2026-10-04 18:05:07.024197','N3sklJaVm/VUf6T4un7ncxYPBqCmjO41C+GmsHOW',28),(4,'2026-10-05 00:12:06.558844','uEoflJQaNJMq1S0BCjAk21valxcoG7wplfsxXlwD',30),(5,'2026-10-05 00:13:06.906811','8ffKcNrTk4OMzNK6/Z1ZHKdrOHCXoammrb3hysaQ',30),(6,'2026-10-05 00:13:41.136902','Tf6Zfml0kWcgO2Lr1ob+25LzRllcqWQ7tC/KGXZ0',30),(7,'2026-10-05 10:11:27.850448','7Y+JkVxHC13cm7tk7uAEOCxlfp4o7Q57+hhQorr8',31),(8,'2026-11-15 20:02:56.195827','WOtIZ1Z50mwaLUbQ/akaNWBnOfpcY/pNVf+AmR53',34),(9,'2026-11-15 21:26:50.334145','QxbHb7jkZ7ylOkujJoSRiAXVWm0EQW2947iV3td6',36),(10,'2026-11-15 21:27:46.333515','Tu//J25Hq/2tpG0xduQS+46AFaHhuD+1z6dZt7O7',36),(11,'2026-11-15 21:28:36.610831','kxTNvO3+/YRAazPWQ58ptaWL5r6aCjWtlPGPd7KP',36),(12,'2026-11-15 21:29:08.395781','I4raH2HWGoSc3bgtR3h9tH06wSMcduTcWUd1EpwL',36),(13,'2026-11-15 21:29:40.773028','0K3sy1aCD7Ex+qInWBqOFzukcG77KOpuqtkA3BAm',36),(14,'2026-11-15 21:30:14.092822','Zlrb0VpOeWvK0IDLc8ZE3HgOm3vpJvB879AU7/qg',36);
/*!40000 ALTER TABLE `ballots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidates`
--

DROP TABLE IF EXISTS `candidates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidates` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `approved_at` datetime(6) NOT NULL,
  `election_id` bigint NOT NULL,
  `nomination_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKn1awf3kaerbp88aoqtqc30smv` (`user_id`,`election_id`),
  UNIQUE KEY `UKmeq4kyr98xrig78bk4e8fr1q6` (`nomination_id`),
  KEY `FKmdu3yssghrl36wth97l9b9a9d` (`election_id`),
  CONSTRAINT `FK1gq68a7jhvcayfmif1mvrubjm` FOREIGN KEY (`nomination_id`) REFERENCES `nominations` (`id`),
  CONSTRAINT `FKmdu3yssghrl36wth97l9b9a9d` FOREIGN KEY (`election_id`) REFERENCES `elections` (`id`),
  CONSTRAINT `FKme4fkelukmx2s63tlcrft6hio` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidates`
--

LOCK TABLES `candidates` WRITE;
/*!40000 ALTER TABLE `candidates` DISABLE KEYS */;
INSERT INTO `candidates` VALUES (1,'2026-09-27 16:40:03.860284',11,1,5),(2,'2026-09-27 18:24:33.857051',15,3,9),(3,'2026-09-27 19:34:52.949961',18,4,2),(4,'2026-09-27 20:13:46.973102',19,5,2),(5,'2026-09-28 00:32:36.340717',20,6,2),(6,'2026-09-28 01:38:09.998017',21,7,11),(7,'2026-09-28 01:38:15.623261',21,8,2),(8,'2026-09-28 02:01:35.497821',22,9,2),(9,'2026-09-28 02:01:44.516985',22,10,11),(10,'2026-09-28 15:33:22.141571',20,12,1),(11,'2026-10-04 17:47:42.056232',28,16,1),(12,'2026-10-04 18:42:10.972742',29,17,1),(13,'2026-10-05 00:07:59.033823',30,18,23),(14,'2026-10-05 00:08:00.355954',30,19,2),(15,'2026-10-05 10:10:08.483583',31,20,8),(16,'2026-10-05 12:40:43.926204',33,22,1),(17,'2026-11-15 20:00:23.707428',34,23,25),(18,'2026-11-15 21:01:35.922600',35,24,2),(19,'2026-11-15 21:01:37.527238',35,25,26),(20,'2026-11-15 21:01:39.552096',35,26,25),(21,'2026-11-15 21:23:23.938854',36,28,2),(22,'2026-11-15 21:23:25.253985',36,29,25),(23,'2026-11-15 21:23:26.829746',36,30,26);
/*!40000 ALTER TABLE `candidates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `election_officer_assignments`
--

DROP TABLE IF EXISTS `election_officer_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `election_officer_assignments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `assigned_at` datetime(6) NOT NULL,
  `status` enum('ACTIVE','ENDED') NOT NULL,
  `assigned_by` bigint NOT NULL,
  `election_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKm23034pbtjr49n5no2ewpt2sq` (`user_id`,`election_id`),
  KEY `FKtggqm65lm4qi3oshs0y14pahs` (`assigned_by`),
  KEY `FKiqhrn1j3dfsnlfl7dbx07u10q` (`election_id`),
  CONSTRAINT `FKiqhrn1j3dfsnlfl7dbx07u10q` FOREIGN KEY (`election_id`) REFERENCES `elections` (`id`),
  CONSTRAINT `FKnok457pk6wq8p79ntlxb4uag7` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKtggqm65lm4qi3oshs0y14pahs` FOREIGN KEY (`assigned_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `election_officer_assignments`
--

LOCK TABLES `election_officer_assignments` WRITE;
/*!40000 ALTER TABLE `election_officer_assignments` DISABLE KEYS */;
INSERT INTO `election_officer_assignments` VALUES (1,'2026-09-27 12:05:37.578483','ENDED',3,3,1),(2,'2026-09-27 13:26:00.725138','ENDED',3,4,1),(3,'2026-09-27 13:38:31.812623','ENDED',3,5,1),(4,'2026-09-27 13:59:16.826425','ENDED',3,7,1),(5,'2026-09-27 14:14:31.154469','ENDED',3,8,1),(6,'2026-09-27 15:19:09.676397','ENDED',3,9,2),(7,'2026-09-27 15:47:23.440121','ENDED',3,10,2),(8,'2026-09-27 15:57:25.259675','ENDED',3,33,2),(9,'2026-09-27 16:15:46.586113','ENDED',3,11,6),(10,'2026-09-27 17:28:39.367436','ENDED',3,14,7),(11,'2026-09-27 18:03:47.763228','ENDED',3,30,1),(12,'2026-09-27 18:09:30.273399','ENDED',3,15,8),(13,'2026-09-27 18:45:12.885502','ENDED',3,16,8),(14,'2026-09-27 19:08:20.023535','ENDED',3,17,4),(15,'2026-09-27 19:15:41.667850','ENDED',3,18,4),(16,'2026-09-27 20:11:15.033016','ENDED',3,19,4),(17,'2026-09-28 00:28:23.930515','ENDED',3,20,4),(18,'2026-09-28 01:26:31.953865','ACTIVE',3,NULL,5),(19,'2026-09-28 01:29:30.798165','ENDED',3,21,8),(20,'2026-09-28 01:57:02.527073','ENDED',3,22,7),(21,'2026-09-28 12:30:58.120520','ENDED',3,23,7),(22,'2026-09-28 13:25:10.847616','ENDED',3,24,9),(23,'2026-09-28 13:52:13.219469','ENDED',3,25,11),(24,'2026-10-04 16:42:31.184835','ACTIVE',3,NULL,4),(25,'2026-10-04 16:42:47.119955','ACTIVE',3,NULL,7),(26,'2026-10-04 16:44:19.463859','ACTIVE',3,NULL,11),(27,'2026-10-04 16:50:13.495896','ACTIVE',3,NULL,18),(28,'2026-10-04 16:58:15.457154','ENDED',3,26,19),(29,'2026-10-04 17:23:30.009569','ENDED',3,27,19),(30,'2026-10-04 17:42:17.946426','ENDED',3,28,19),(31,'2026-10-04 18:37:29.456481','ENDED',3,29,21),(32,'2026-10-05 10:03:58.127010','ACTIVE',3,NULL,14),(33,'2026-10-05 10:06:44.917609','ENDED',3,31,1),(34,'2026-10-05 11:28:19.689839','ENDED',3,32,1),(35,'2026-11-15 19:39:00.651598','ENDED',3,34,1),(36,'2026-11-15 20:40:57.579469','ENDED',3,35,1),(37,'2026-11-15 21:19:10.543670','ENDED',3,36,1);
/*!40000 ALTER TABLE `election_officer_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elections`
--

DROP TABLE IF EXISTS `elections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elections` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `department` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `end_date` datetime(6) NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `status` enum('COMPLETED','ONGOING','UPCOMING') NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_by` bigint NOT NULL,
  `post_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKncm1jn0m42hvnikns41yprhfn` (`created_by`),
  KEY `FKfdmqon0754w905pjg81hbh76k` (`post_id`),
  CONSTRAINT `FKfdmqon0754w905pjg81hbh76k` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `FKncm1jn0m42hvnikns41yprhfn` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elections`
--

LOCK TABLES `elections` WRITE;
/*!40000 ALTER TABLE `elections` DISABLE KEYS */;
INSERT INTO `elections` VALUES (1,'2026-09-27 12:37:53.401281','MCA','Election for student council representative','2026-10-05 18:00:00.000000','2026-10-01 10:00:00.000000','COMPLETED','Student Council Election',1,1),(2,'2026-09-27 13:00:25.669480','Computer Applications','Test election for automatic status changes','2026-09-27 23:01:05.000000','2026-09-27 23:01:02.000000','COMPLETED','Student Council Election 2026',1,1),(3,'2026-09-27 13:05:11.625565','Computer Applications','Testing automatic election status','2026-09-27 13:11:00.000000','2026-09-27 13:10:00.000000','COMPLETED','Automatic Status Test',1,1),(4,'2026-09-27 13:27:50.051212','Computer Applications','Testing automatic election status','2026-09-27 13:31:00.000000','2026-09-27 13:30:00.000000','COMPLETED','Test Election 2',1,1),(5,'2026-09-27 13:39:00.444484','Computer Applications','Testing automatic election status','2026-09-27 13:41:00.000000','2026-09-27 13:40:00.000000','COMPLETED','Test Election 2',1,1),(6,'2026-09-27 13:59:41.835357','Computer Applications','Election for MCA second year students','2026-09-27 14:05:00.000000','2026-09-27 14:00:00.000000','COMPLETED','MCA 2nd Year Student Council Election',1,1),(7,'2026-09-27 14:02:27.002032','Computer Applications','Election for MCA second year students','2026-09-27 14:10:00.000000','2026-09-27 14:03:00.000000','COMPLETED','MCA 2nd Year Student Council Election',1,1),(8,'2026-09-27 14:15:35.207637','Computer Applications','Election for MCA second year students','2026-09-27 14:21:00.000000','2026-09-27 14:20:00.000000','COMPLETED','MCA 2nd Year Student Council Election',1,1),(9,'2026-09-27 15:42:35.924116','Computer Applications','Election for MCA second year students','2026-09-27 15:31:00.000000','2026-09-27 15:30:00.000000','COMPLETED','MCA 2nd Year Student Council Election',2,1),(10,'2026-09-27 15:47:45.532314','Computer Applications','Election for MCA second year students','2026-09-27 15:51:00.000000','2026-09-27 15:50:00.000000','COMPLETED','MCA 2nd Year Student Council Election',2,1),(11,'2026-09-27 16:16:22.987087','Computer Applications','Election for MCA second year students','2026-09-27 18:51:00.000000','2026-09-27 16:50:00.000000','COMPLETED','MCA 2nd Year Student Council Election',6,1),(12,'2026-09-27 17:30:01.647819','Computer Applications','Election for MCA second year students','2026-09-27 17:50:00.000000','2026-09-27 17:45:00.000000','COMPLETED','MCA 2nd Year Student Council Election',7,2),(13,'2026-09-27 17:35:06.964390','Computer Applications','Election for MCA second year students','2026-09-27 17:50:00.000000','2026-09-27 17:45:00.000000','COMPLETED','MCA 2nd Year Student Council Election',7,3),(14,'2026-09-27 17:38:01.950255','Computer Applications','Election for MCA second year students','2026-09-27 18:05:00.000000','2026-09-27 18:00:00.000000','COMPLETED','MCA 2nd Year Student Council Election',7,4),(15,'2026-09-27 18:12:27.479518','Computer Applications','Election for MCA second year students','2026-09-27 18:40:00.000000','2026-09-27 18:35:00.000000','COMPLETED','MCA 2nd Year Student Council Election',8,3),(16,'2026-09-27 18:49:09.793554','Computer Applications','Election for MCA second year students','2026-09-27 18:00:00.000000','2026-09-27 16:00:00.000000','COMPLETED','MCA 2nd Year Classs Representativen',8,4),(17,'2026-09-27 19:10:43.583467','Computer Applications','Election for MCA second year students','2026-09-27 17:30:00.000000','2026-09-27 17:25:00.000000','COMPLETED','MCA 2nd Year Student Council Election',4,5),(18,'2026-09-27 19:16:34.581667','Computer Applications','Election for MCA second year students','2026-09-27 19:40:00.000000','2026-09-27 19:35:00.000000','COMPLETED','MCA 2nd Year Student Council Election',4,6),(19,'2026-09-27 20:12:11.264461','Computer Applications','Election for MCA second year students','2026-09-27 20:30:00.000000','2026-09-27 20:25:00.000000','COMPLETED','MCA 2nd Year Student Council Election',4,6),(20,'2026-09-28 00:28:57.929125','Computer Applications','Election for MCA second year students','2026-09-28 20:30:00.000000','2026-09-28 20:25:00.000000','COMPLETED','MCA 2nd Year Student Council Election',4,6),(21,'2026-09-28 01:31:08.895235','Computer Applications','Election for MCA second year students','2026-09-29 01:55:00.000000','2026-09-29 01:45:00.000000','COMPLETED','MCA 2nd Year  Election',8,4),(22,'2026-09-28 01:59:55.199147','Computer Applications','Election for MCA second year students','2026-09-28 02:10:00.000000','2026-09-28 02:05:00.000000','COMPLETED','MCA 2nd Year  Election',7,2),(23,'2026-09-28 13:18:10.918370','Computer Applications','Election for MCA second year students','2026-09-30 02:10:00.000000','2026-09-30 02:05:00.000000','COMPLETED','MCA 2nd Year  Election',7,2),(24,'2026-09-28 13:35:17.863037','MBC','Class Representative elections','2026-10-01 13:35:00.000000','2026-10-01 13:34:00.000000','COMPLETED','MCA 1st Year',9,6),(25,'2026-09-28 13:55:09.576936','Computer Applications','Election for MCA second year students','2026-09-28 02:10:00.000000','2026-09-28 02:05:00.000000','COMPLETED','MCA 2nd Year  Election',11,2),(26,'2026-10-04 17:00:18.768367','MBC','Election for appointing CR for MCA 2nd year','2026-10-04 17:10:00.000000','2026-10-04 17:05:00.000000','COMPLETED','CR elections',19,2),(27,'2026-10-04 17:25:18.859753','MBC','cr','2026-10-04 17:35:00.000000','2026-10-04 17:30:00.000000','COMPLETED','mca',19,2),(28,'2026-10-04 17:45:10.361012','mbc','cr','2026-10-04 18:05:00.000000','2026-10-04 18:00:00.000000','COMPLETED','mca',19,1),(29,'2026-10-04 18:40:10.399179','Computer Applications','President','2026-10-04 18:43:00.000000','2026-10-04 18:41:00.000000','COMPLETED','MCA',21,1),(30,'2026-10-05 00:05:56.433464','Computer Applications','Cultural Secretary','2026-10-05 00:15:00.000000','2026-10-05 00:10:00.000000','COMPLETED','MCA Election',1,6),(31,'2026-10-05 10:08:10.665424','Computer Applications','cr election','2026-10-05 10:13:00.000000','2026-10-05 10:10:00.000000','COMPLETED','mca',1,1),(32,'2026-10-05 12:36:57.083164','Computer Applications','PRESIDENT','2026-10-05 12:39:00.000000','2026-10-05 12:37:00.000000','COMPLETED','MCA',1,1),(33,'2026-10-05 12:39:39.420238','Computer Applications','president','2026-10-05 12:44:00.000000','2026-10-05 12:42:00.000000','COMPLETED','mca',2,2),(34,'2026-11-15 19:55:37.688355','Computer Applications','ELECTION FOR PRESIDENT','2026-11-15 20:05:00.000000','2026-11-15 20:00:00.000000','COMPLETED','MCA 2ND YEAR ELECTION',1,1),(35,'2026-11-15 20:57:27.037327','Computer Applications','vice president','2026-11-15 21:10:00.000000','2026-11-15 21:05:00.000000','COMPLETED','Mca 2nd year',1,1),(36,'2026-11-15 21:20:48.309943','Computer Applications','VICE PRESIDENT','2026-11-15 21:30:00.000000','2026-11-15 21:25:00.000000','COMPLETED','MCA VICE PRESIDENT ELECTIONS',1,2);
/*!40000 ALTER TABLE `elections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eligibility_criteria`
--

DROP TABLE IF EXISTS `eligibility_criteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eligibility_criteria` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `course` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `election_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKoxt0gbxkwdxvxt2f7fxbf8j5i` (`election_id`),
  CONSTRAINT `FKddo3te4icl2u6n0abb4nb3pw1` FOREIGN KEY (`election_id`) REFERENCES `elections` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eligibility_criteria`
--

LOCK TABLES `eligibility_criteria` WRITE;
/*!40000 ALTER TABLE `eligibility_criteria` DISABLE KEYS */;
INSERT INTO `eligibility_criteria` VALUES (1,'MCA','Computer Applications',2,7),(2,'MCA','Computer Applications',2,8),(3,'MCA','Computer Applications',1,9),(4,'MCA','Computer Applications',1,10),(5,'MCA','Computer Applications',1,11),(6,'MCA','Computer Applications',1,12),(7,'MCA','Computer Applications',2,13),(8,'MCA','Computer Applications',2,14),(9,'MCA','Computer Applications',2,15),(10,'MCA','Computer Applications',2,16),(11,'MCA','Computer Applications',2,17),(12,'MCA','Computer Applications',2,18),(13,'MCA','Computer Applications',2,19),(14,'MCA','Computer Applications',2,20),(15,'MCA','Computer Applications',2,21),(16,'MCA','Computer Applications',2,22),(17,'MCA','Computer Applications',2,23),(18,'MCA','MBC',6,24),(19,'MCA','Computer Applications',2,25),(20,'MCA','MBC',2,26),(21,'Computer Applications','MBC',2,27),(22,'MCA','Computer Applications',2,28),(23,'MCA','Computer Applications',2,29),(24,'MCA','Computer Applications',2,30),(25,'MCA','Computer Applications',2,31),(26,'MCA','Computer Applications',2,32),(27,'MCA','Computer Applications',2,33),(28,'MCA','Computer Applications',2,34),(29,'MCA','Computer Applications',2,35),(30,'MCA','Computer Applications',2,36);
/*!40000 ALTER TABLE `eligibility_criteria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nominations`
--

DROP TABLE IF EXISTS `nominations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nominations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `position` varchar(255) NOT NULL,
  `reviewed_at` datetime(6) DEFAULT NULL,
  `status` enum('APPROVED','PENDING','REJECTED') NOT NULL,
  `submitted_at` datetime(6) NOT NULL,
  `election_id` bigint NOT NULL,
  `reviewed_by` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK6cbw5r3yqrb92lof7l8svoi5y` (`user_id`,`election_id`),
  KEY `FKdqb1nd3ca3ghrd8w3o4eiwoew` (`election_id`),
  KEY `FKgyllibp5istpcj1ttyyyf4qda` (`reviewed_by`),
  CONSTRAINT `FKdqb1nd3ca3ghrd8w3o4eiwoew` FOREIGN KEY (`election_id`) REFERENCES `elections` (`id`),
  CONSTRAINT `FKgyllibp5istpcj1ttyyyf4qda` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FKq5fxs4dlwmelyg0y2oornceo` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nominations`
--

LOCK TABLES `nominations` WRITE;
/*!40000 ALTER TABLE `nominations` DISABLE KEYS */;
INSERT INTO `nominations` VALUES (1,'President','2026-09-27 16:40:03.812509','APPROVED','2026-09-27 16:29:46.926535',11,6,5),(2,'General Secretary',NULL,'PENDING','2026-09-27 18:16:50.891214',15,NULL,8),(3,'General Secretary','2026-09-27 18:24:33.852045','APPROVED','2026-09-27 18:22:46.992180',15,8,9),(4,'Cultural Secretary','2026-09-27 19:34:52.870397','APPROVED','2026-09-27 19:27:57.260203',18,4,2),(5,'Cultural Secretary','2026-09-27 20:13:46.972096','APPROVED','2026-09-27 20:13:21.391999',19,4,2),(6,'Cultural Secretary','2026-09-28 00:32:36.338684','APPROVED','2026-09-28 00:32:06.159274',20,4,2),(7,'Treasurer','2026-09-28 01:38:09.987897','APPROVED','2026-09-28 01:34:32.854773',21,8,11),(8,'Treasurer','2026-09-28 01:38:15.623261','APPROVED','2026-09-28 01:35:48.266413',21,8,2),(9,'Vice President','2026-09-28 02:01:35.496203','APPROVED','2026-09-28 02:00:32.161854',22,7,2),(10,'Vice President','2026-09-28 02:01:44.516985','APPROVED','2026-09-28 02:00:44.423209',22,7,11),(11,'Cultural Secretary',NULL,'PENDING','2026-09-28 03:03:48.066147',20,NULL,7),(12,'Cultural Secretary','2026-09-28 15:33:22.125564','APPROVED','2026-09-28 03:09:21.376042',20,4,1),(13,'Treasurer','2026-09-28 03:24:13.888166','REJECTED','2026-09-28 03:22:32.286140',21,8,1),(14,'Vice President',NULL,'PENDING','2026-10-04 17:03:01.491510',26,NULL,16),(15,'Vice President',NULL,'PENDING','2026-10-04 17:28:00.558757',27,NULL,20),(16,'President','2026-10-04 17:47:42.054295','APPROVED','2026-10-04 17:46:51.323179',28,19,1),(17,'President','2026-10-04 18:42:10.972742','APPROVED','2026-10-04 18:40:52.843427',29,21,1),(18,'Cultural Secretary','2026-10-05 00:07:59.032705','APPROVED','2026-10-05 00:06:24.870571',30,1,23),(19,'Cultural Secretary','2026-10-05 00:08:00.354973','APPROVED','2026-10-05 00:07:03.041973',30,1,2),(20,'President','2026-10-05 10:10:08.482534','APPROVED','2026-10-05 10:08:36.637901',31,1,8),(21,'President',NULL,'PENDING','2026-10-05 12:37:23.901443',32,NULL,24),(22,'Vice President','2026-10-05 12:40:43.926204','APPROVED','2026-10-05 12:40:13.289138',33,2,1),(23,'President','2026-11-15 20:00:23.706198','APPROVED','2026-11-15 19:59:41.581898',34,1,25),(24,'President','2026-11-15 21:01:35.921399','APPROVED','2026-11-15 20:58:33.591864',35,1,2),(25,'President','2026-11-15 21:01:37.527238','APPROVED','2026-11-15 20:59:15.286579',35,1,26),(26,'President','2026-11-15 21:01:39.552096','APPROVED','2026-11-15 21:00:04.050336',35,1,25),(27,'President','2026-11-15 21:01:47.453034','REJECTED','2026-11-15 21:00:49.545498',35,1,7),(28,'Vice President','2026-11-15 21:23:23.935853','APPROVED','2026-11-15 21:21:11.152024',36,1,2),(29,'Vice President','2026-11-15 21:23:25.253985','APPROVED','2026-11-15 21:21:51.116022',36,1,25),(30,'Vice President','2026-11-15 21:23:26.829746','APPROVED','2026-11-15 21:23:03.307296',36,1,26);
/*!40000 ALTER TABLE `nominations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `is_read` bit(1) NOT NULL,
  `message` varchar(1000) NOT NULL,
  `type` enum('NOMINATION_APPROVED','NOMINATION_REJECTED','EO_ASSIGNED') NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9y21adhxn0ayjhfocscqox7bh` (`user_id`),
  CONSTRAINT `FK9y21adhxn0ayjhfocscqox7bh` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,'2026-09-27 16:40:03.953084',_binary '\0','Your nomination for President has been approved. You are now a candidate.','NOMINATION_APPROVED',5),(2,'2026-09-27 18:24:33.904930',_binary '','Your nomination for General Secretary has been approved. You are now a candidate.','NOMINATION_APPROVED',9),(3,'2026-09-27 19:34:53.014092',_binary '','Your nomination for Cultural Secretary has been approved. You are now a candidate.','NOMINATION_APPROVED',2),(4,'2026-09-27 20:13:46.988020',_binary '','Your nomination for Cultural Secretary has been approved. You are now a candidate.','NOMINATION_APPROVED',2),(5,'2026-09-28 00:32:36.364857',_binary '','Your nomination for Cultural Secretary has been approved. You are now a candidate.','NOMINATION_APPROVED',2),(6,'2026-09-28 01:38:10.029268',_binary '','Your nomination for Treasurer has been approved. You are now a candidate.','NOMINATION_APPROVED',11),(7,'2026-09-28 01:38:15.626307',_binary '','Your nomination for Treasurer has been approved. You are now a candidate.','NOMINATION_APPROVED',2),(8,'2026-09-28 02:01:35.516580',_binary '','Your nomination for Vice President has been approved. You are now a candidate.','NOMINATION_APPROVED',2),(9,'2026-09-28 02:01:44.524694',_binary '','Your nomination for Vice President has been approved. You are now a candidate.','NOMINATION_APPROVED',11),(10,'2026-09-28 03:24:13.933281',_binary '','Your nomination for Treasurer has been rejected.','NOMINATION_REJECTED',1),(11,'2026-09-28 15:33:22.330986',_binary '','Your nomination for Cultural Secretary has been approved. You are now a candidate.','NOMINATION_APPROVED',1),(12,'2026-10-04 16:58:15.475912',_binary '','You have been assigned as an Election Officer.','EO_ASSIGNED',19),(13,'2026-10-04 17:23:30.079282',_binary '','You have been assigned as an Election Officer.','EO_ASSIGNED',19),(14,'2026-10-04 17:42:18.044071',_binary '','You have been assigned as an Election Officer.','EO_ASSIGNED',19),(15,'2026-10-04 17:47:42.125074',_binary '','Your nomination for President has been approved. You are now a candidate.','NOMINATION_APPROVED',1),(16,'2026-10-04 18:37:29.470454',_binary '\0','You have been assigned as an Election Officer.','EO_ASSIGNED',21),(17,'2026-10-04 18:42:10.982670',_binary '','Your nomination for President has been approved. You are now a candidate.','NOMINATION_APPROVED',1),(18,'2026-10-05 00:07:59.046835',_binary '','Your nomination for Cultural Secretary has been approved. You are now a candidate.','NOMINATION_APPROVED',23),(19,'2026-10-05 00:08:00.359811',_binary '\0','Your nomination for Cultural Secretary has been approved. You are now a candidate.','NOMINATION_APPROVED',2),(20,'2026-10-05 10:03:58.299215',_binary '\0','You have been assigned as an Election Officer.','EO_ASSIGNED',14),(21,'2026-10-05 10:06:44.932572',_binary '','You have been assigned as an Election Officer.','EO_ASSIGNED',1),(22,'2026-10-05 10:10:08.494036',_binary '','Your nomination for President has been approved. You are now a candidate.','NOMINATION_APPROVED',8),(23,'2026-10-05 11:28:19.729408',_binary '','You have been assigned as an Election Officer.','EO_ASSIGNED',1),(24,'2026-10-05 12:40:43.935495',_binary '','Your nomination for Vice President has been approved. You are now a candidate.','NOMINATION_APPROVED',1),(25,'2026-11-15 19:39:00.772129',_binary '','You have been assigned as an Election Officer.','EO_ASSIGNED',1),(26,'2026-11-15 20:00:23.730589',_binary '\0','Your nomination for President has been approved. You are now a candidate.','NOMINATION_APPROVED',25),(27,'2026-11-15 20:40:57.650109',_binary '','You have been assigned as an Election Officer.','EO_ASSIGNED',1),(28,'2026-11-15 21:01:35.939187',_binary '\0','Your nomination for President has been approved. You are now a candidate.','NOMINATION_APPROVED',2),(29,'2026-11-15 21:01:37.532338',_binary '\0','Your nomination for President has been approved. You are now a candidate.','NOMINATION_APPROVED',26),(30,'2026-11-15 21:01:39.555013',_binary '\0','Your nomination for President has been approved. You are now a candidate.','NOMINATION_APPROVED',25),(31,'2026-11-15 21:01:47.455497',_binary '\0','Your nomination for President has been rejected.','NOMINATION_REJECTED',7),(32,'2026-11-15 21:19:10.588628',_binary '\0','You have been assigned as an Election Officer.','EO_ASSIGNED',1),(33,'2026-11-15 21:23:23.986477',_binary '\0','Your nomination for Vice President has been approved. You are now a candidate.','NOMINATION_APPROVED',2),(34,'2026-11-15 21:23:25.257750',_binary '\0','Your nomination for Vice President has been approved. You are now a candidate.','NOMINATION_APPROVED',25),(35,'2026-11-15 21:23:26.832734',_binary '\0','Your nomination for Vice President has been approved. You are now a candidate.','NOMINATION_APPROVED',26);
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKpnvtwliis6p05pn6i3ndjrqt2` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'View available elections','VIEW_ELECTION'),(2,'Cast a vote in an election','CAST_VOTE'),(3,'View election results','VIEW_RESULT'),(4,'Submit a nomination','SUBMIT_NOMINATION'),(5,'Create an election','CREATE_ELECTION'),(6,'View election nominations','VIEW_NOMINATIONS'),(7,'Approve a nomination','APPROVE_NOMINATION'),(8,'Reject a nomination','REJECT_NOMINATION'),(9,'Assign election officers','ASSIGN_ELECTION_OFFICER'),(10,'View audit logs','VIEW_AUDIT_LOG'),(11,'View registered users','VIEW_USERS');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(1000) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKjjhk5q12091gpef0xu20n6xfv` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'Head of the student council and primary representative of the student body','President'),(2,'Assists the president and steps in when the president is unavailable','Vice President'),(3,'Manages official records communications and administrative duties','General Secretary'),(4,'Oversees student council funds budgets and financial reporting','Treasurer'),(5,'Organizes and oversees university sports events and athletic programs','Sports Secretary'),(6,'Coordinates cultural events festivals and student activities','Cultural Secretary'),(7,'Acts as a liaison between students and faculty regarding academic matters','Academic Representative');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `result_vote_counts`
--

DROP TABLE IF EXISTS `result_vote_counts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `result_vote_counts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `vote_count` int NOT NULL,
  `candidate_id` bigint NOT NULL,
  `result_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKohibtdpuyjp66irso8kgw2tio` (`result_id`,`candidate_id`),
  KEY `FKbfqxtk2m1pft1abuj2rnhdd8r` (`candidate_id`),
  CONSTRAINT `FKbfqxtk2m1pft1abuj2rnhdd8r` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`id`),
  CONSTRAINT `FKoto9jkc00629g9uwnf7dl9iaj` FOREIGN KEY (`result_id`) REFERENCES `results` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `result_vote_counts`
--

LOCK TABLES `result_vote_counts` WRITE;
/*!40000 ALTER TABLE `result_vote_counts` DISABLE KEYS */;
INSERT INTO `result_vote_counts` VALUES (1,1,4,1),(2,1,8,2),(3,0,9,2),(4,0,3,3),(5,1,11,4),(6,0,6,5),(7,0,7,5),(8,2,13,6),(9,1,14,6),(10,0,2,7),(11,1,15,8),(12,1,17,9),(13,3,21,10),(14,3,22,10),(15,0,23,10);
/*!40000 ALTER TABLE `result_vote_counts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `results`
--

DROP TABLE IF EXISTS `results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `results` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `released_at` datetime(6) NOT NULL,
  `election_id` bigint NOT NULL,
  `released_by` bigint NOT NULL,
  `winner_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK3mvrow6qbuggfw4v10ivgp1ph` (`election_id`),
  KEY `FK4e3fafuqkhl56lr8hjghkqfvi` (`released_by`),
  KEY `FKjppbtiexiohkvgjxaivadqehh` (`winner_id`),
  CONSTRAINT `FK4e3fafuqkhl56lr8hjghkqfvi` FOREIGN KEY (`released_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FKc4u2w8wi8slh0k23fmeuoy3r6` FOREIGN KEY (`election_id`) REFERENCES `elections` (`id`),
  CONSTRAINT `FKjppbtiexiohkvgjxaivadqehh` FOREIGN KEY (`winner_id`) REFERENCES `candidates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `results`
--

LOCK TABLES `results` WRITE;
/*!40000 ALTER TABLE `results` DISABLE KEYS */;
INSERT INTO `results` VALUES (1,'2026-09-27 20:48:21.855624',19,4,4),(2,'2026-09-28 02:32:36.696289',22,7,8),(3,'2026-09-28 14:16:28.270535',18,4,3),(4,'2026-10-04 18:14:01.223500',28,19,11),(5,'2026-10-04 18:29:33.240761',21,8,NULL),(6,'2026-10-05 00:16:28.626202',30,1,13),(7,'2026-10-05 10:12:19.626869',15,8,2),(8,'2026-10-05 10:15:14.256871',31,1,15),(9,'2026-11-15 20:10:53.096935',34,1,17),(10,'2026-11-15 21:31:44.343504',36,1,NULL);
/*!40000 ALTER TABLE `results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role` enum('ADMIN','ELECTION_OFFICER','VOTER') NOT NULL,
  `permission_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKriljgn66b857jm4uffdqtcsmy` (`role`,`permission_id`),
  KEY `FKegdk29eiy7mdtefy5c7eirr6e` (`permission_id`),
  CONSTRAINT `FKegdk29eiy7mdtefy5c7eirr6e` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (13,'ADMIN',9),(14,'ADMIN',10),(15,'ADMIN',11),(5,'ELECTION_OFFICER',1),(6,'ELECTION_OFFICER',2),(7,'ELECTION_OFFICER',3),(8,'ELECTION_OFFICER',4),(9,'ELECTION_OFFICER',5),(10,'ELECTION_OFFICER',6),(11,'ELECTION_OFFICER',7),(12,'ELECTION_OFFICER',8),(1,'VOTER',1),(2,'VOTER',2),(3,'VOTER',3),(4,'VOTER',4);
/*!40000 ALTER TABLE `role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `course` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `department` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('ADMIN','ELECTION_OFFICER','VOTER') NOT NULL,
  `student_id` varchar(255) NOT NULL,
  `year` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`),
  UNIQUE KEY `UKqh3otyipv2k9hqte4a1abcyhq` (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'MCA','2026-09-26 19:12:08.930308','Computer Applications','25204031106@manit.ac.in','Aditi','Chandna','$2a$10$JJ4y8OoDngMrornOjue9A.xIsA8rmhqekoFhikFeJfe1D/e.010b6','VOTER','25204031106',2),(2,'MCA','2026-09-26 20:01:49.180668','Computer Applications','25204031105@manit.ac.in','Rashi','Gupta','$2a$10$TZz7oJHoh9z1kqeMhduha.rQOdwzZIrnbVcnm3wCnoXFkKpVW4vOq','VOTER','25204031105',2),(3,'Administration','2026-09-26 22:21:54.849665','Administration','admin@voting.com','System','Admin','$2a$10$vm9ypAz0HsiCg5yOAQkqSOICyyuNrkxbYF8RRy5tn93lba7FC8l/K','ADMIN','ADMIN001',1),(4,'MCA','2026-09-27 03:16:19.421329','Computer Applications','25204031103@manit.ac.in','Vatsala','Srivastav','$2a$10$Bzj0js2Bn0chzieBC63WWuSoxTlywAkWSkVh.YQI6GLmIWawi6Ffe','VOTER','25204031103',2),(5,'MCA','2026-09-27 14:36:13.177690','Computer Applications','25204031113@manit.ac.in','vishali','vishali','$2a$10$/1MAQ/mLaRM.8E9qYnwj8.WooXPnAqYimOmGRhtwzSqwJV3e.SVyW','VOTER','25204031113',1),(6,'MCA','2026-09-27 16:14:45.174656','Computer Applications','25204031116@manit.ac.in','Mythli','Raj','$2a$10$mKFi/PLm77mNNZBAK.qo1.80wLE8N08s5M0cBcPS4gnYlxa2c3yHW','VOTER','25204031116',2),(7,'MCA','2026-09-27 17:27:10.950007','Computer Applications','25204031118@manit.ac.in','Nikhil','Idiculla','$2a$10$rOM5fuzUTvsVb.REcsw2..l7pqpoF6leP7xQi.IRva/nszKFtsDZu','VOTER','25204031118',2),(8,'MCA','2026-09-27 18:07:28.264482','Computer Applications','25204031131@manit.ac.in','Apoorv','Trivedi','$2a$10$26/wH0xNwrM8BryXxTJ4COcYLHll2EDimV7Bnpk6KsercgOo4uu9e','VOTER','25204031131',2),(9,'MCA','2026-09-27 18:19:44.328377','Computer Applications','25204031127@manit.ac.in','Hardik ','Katiyar','$2a$10$44oj/L9LatMfoSs/HgMYuelDC10LDCE177VS8k1v9XNyiptgAQUs2','VOTER','25204031127',2),(10,'MCA','2026-09-27 18:43:30.843722','Computer Applications','25204031123@manit.ac.in','Jyoti','Kumari','$2a$10$c2NZuwpI0UqXuUaRZGlhF.bEW22q6BvKqNy1jnyasrNFv4I8sjUPy','VOTER','25204031123',2),(11,'MCA','2026-09-27 19:05:16.240529','Computer Applications','25204031110@manit.ac.in','Apoorvi','Gupta','$2a$10$c/PW58rnL2xmkUmsEkhj4uWc6WMkWbdltxCalgr0YsVd36xTB0aJS','VOTER','25204031110',2),(12,'MCA','2026-09-27 23:25:27.277832','MBC','25204031108@manit.ac.in','Kavya','Niar','$2a$10$a8GUyGsBRfVfKwv2NM0.b.BAdt6kUJswRbftNb8ZZBHewa3Tat94a','VOTER','25204031108',2),(13,'MCA','2026-09-28 03:42:32.519591','MBC','25204031109@manit.ac.in','Ram','Sankar','$2a$10$Fo/hh53m2emIUSTcTphUWe9Zu85S0zI8mvi2m47hNIvFEjj25nQ2y','VOTER','25204031109',2),(14,'MCA','2026-09-28 15:42:23.435836','Computer Application','25204031119@manit.ac.in','Vanshita','Vanshita','$2a$10$s6pXdX7nypcXXQ8icacYuO8cRppnTvmQFOm.9k90FVDETuPvaPEBm','VOTER','25204031119',2),(15,'MCA','2026-09-28 15:47:54.707656','Computer Application','25204031101@manit.ac.in','Nishit','Nishit','$2a$10$mhi7u9CaWkXCPmLwglnDB.5tnqjEyX6XfA/EXGtvJ9Ss8YedlGsMy','VOTER','25204031101',2),(16,'MCA','2026-09-28 21:23:55.955505','MBC','25204031121@manit.ac.in','Abhijeet','Sain','$2a$10$EfY09Ps1KsQn3CdCn/R99ev1FPxMPART0JWAvpWawh4hrSjXI4P9i','VOTER','25204031121',2),(17,'MCA','2026-09-29 15:55:17.108740','Computer Applications','25204031136@manit.ac.in','Prabhakar','Kant','$2a$10$vYoyx2XVWjx4NOPNrUyIbOwrsvocQZJGmGkfk2KcLq.sOO3zNqyHS','VOTER','25204031136',2),(18,'PhD','2026-10-04 16:30:08.067648','MBC','24204031106@manit.ac.in','testuser','testuser','$2a$10$jcS7pz.HFAc.Kk3FNmZV0.h9GIdtrmOBy8N1QyUnU68IYxIA.GlnW','VOTER','24204031106',4),(19,'PhD','2026-10-04 16:57:34.459712','MBC','24204031136@manit.ac.in','testuser1','testuser1','$2a$10$/pkiMiE84bTRtntskemf6uh8PJcBiwMJt2G.6XYcMc/3U8ZIFPCK.','VOTER','24204031136',2),(20,'Computer Applications','2026-10-04 17:27:41.327739','MBC','25204031156@manit.ac.in','Abhijeet','Dhillon','$2a$10$1A039Pab1y7YJ8fHDYSFgOe3OUuR4wbmza5PyUqa3VvdJRyNQ3N56','VOTER','25204031156',2),(21,'MCA','2026-10-04 18:31:46.096372','Computer Applications','25204031189@manit.ac.in','Rahul','Sharma','$2a$10$Of3jQ/.qPz/2edz4.UMRie.pf1ipPAwbk/4gFTlKJvpvSbMDrHsLu','VOTER','25204031189',2),(22,'MCA','2026-10-04 23:49:13.024945','Computer Applications','25204031206@stu.manit.ac.in','himanshi','sharma','$2a$10$EB7IVBLzLNwosNZ6nJwuAe3xneH/s8dMT3ol10/fpirMdGTj3jjCm','VOTER','25204031206',2),(23,'MCA','2026-10-05 00:03:04.732597','Computer Applications','25204031289@stu.manit.ac.in','Nishit','Tiwari','$2a$10$3wHLf7095rZoX3yfrch.9ehmU/bZ8awVqG6vdfzQAzHMBO4a1HuQC','VOTER','25204031289',2),(24,'MCA','2026-10-05 11:22:57.245500','Computer Applications','25204031128@stu.manit.ac.in','Sahil','Mishra','$2a$10$R2dcGIXDQCKCPmoqjx9xbeLud602J4i/.qFq5RS47AvWd6ii6rsCC','VOTER','25204031128',2),(25,'MCA','2026-11-15 19:18:31.091034','Computer Applications','25204031107@stu.manit.ac.in','Rohan','Roy','$2a$10$WwiXACYBDjuhp3AAuRAw6u/9uL1KCIwEXkBkAjtu8JXJXUDGqmLpW','VOTER','25204031107',2),(26,'MCA','2026-11-15 20:33:36.392664','Computer Applications','25204031205@stu.manit.ac.in','Himanshu','Himanshu','$2a$10$6ybUiZag15pFy3l.qTj8auZE0a8yQKsxPTVZiUZW37rFB7wPqvdhG','VOTER','25204031205',2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vote_participation`
--

DROP TABLE IF EXISTS `vote_participation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vote_participation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `voted_at` datetime(6) NOT NULL,
  `election_id` bigint NOT NULL,
  `voter_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKdek4dtw63023yxpa1rygoajye` (`voter_id`,`election_id`),
  KEY `FKdl96roq5vcoq7lnm8bq9at89m` (`election_id`),
  CONSTRAINT `FKbgdkjkd1whcvj1db48kcm3xwb` FOREIGN KEY (`voter_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKdl96roq5vcoq7lnm8bq9at89m` FOREIGN KEY (`election_id`) REFERENCES `elections` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vote_participation`
--

LOCK TABLES `vote_participation` WRITE;
/*!40000 ALTER TABLE `vote_participation` DISABLE KEYS */;
INSERT INTO `vote_participation` VALUES (1,'2026-09-27 20:27:29.539455',19,11),(2,'2026-09-28 02:06:37.825085',22,1),(3,'2026-10-04 18:05:07.076421',28,2),(4,'2026-10-05 00:12:06.570723',30,11),(5,'2026-10-05 00:13:06.912512',30,9),(6,'2026-10-05 00:13:41.139557',30,8),(7,'2026-10-05 10:11:27.862691',31,8),(8,'2026-11-15 20:02:56.211070',34,25),(9,'2026-11-15 21:26:50.351955',36,1),(10,'2026-11-15 21:27:46.337151',36,2),(11,'2026-11-15 21:28:36.615048',36,7),(12,'2026-11-15 21:29:08.399691',36,25),(13,'2026-11-15 21:29:40.775157',36,8),(14,'2026-11-15 21:30:14.099070',36,9);
/*!40000 ALTER TABLE `vote_participation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voting_challenges`
--

DROP TABLE IF EXISTS `voting_challenges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voting_challenges` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `attempts` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `expires_at` datetime(6) NOT NULL,
  `otp_hash` varchar(255) NOT NULL,
  `used` bit(1) NOT NULL,
  `verified` bit(1) NOT NULL,
  `election_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKi42eb7i5ycovo7i6xbdsg1qe2` (`election_id`),
  KEY `FKb8gia9fdhesxohxm5tx96uqvm` (`user_id`),
  CONSTRAINT `FKb8gia9fdhesxohxm5tx96uqvm` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKi42eb7i5ycovo7i6xbdsg1qe2` FOREIGN KEY (`election_id`) REFERENCES `elections` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voting_challenges`
--

LOCK TABLES `voting_challenges` WRITE;
/*!40000 ALTER TABLE `voting_challenges` DISABLE KEYS */;
INSERT INTO `voting_challenges` VALUES (1,0,'2026-09-27 19:38:51.577848','2026-09-27 19:43:51.577848','$2a$10$da8jTThIrRwNHbTbxRLI1uSpCWL0Q1yNgE3yefUChun4MLILhEVBa',_binary '\0',_binary '\0',18,11),(2,1,'2026-09-27 20:26:04.451997','2026-09-27 20:31:04.451997','$2a$10$/HkO6lkFnWa5w133886iBuOUwkbe.56BvReUhZ104VH9si/PrPkb.',_binary '',_binary '',19,11),(3,1,'2026-09-28 02:06:28.511192','2026-09-28 02:11:28.511192','$2a$10$IUYH8PCeljy5Dv/NWdFT/.bJR7CmSzgxE75JN/THKTdFPZZgMK0Re',_binary '',_binary '',22,1),(4,1,'2026-10-04 18:04:54.651016','2026-10-04 18:09:54.650039','$2a$10$TPy7EKP9augZC44/yvvJzOfwDmcXNOfoXKtMXbV0SvaCLVxHvWjqS',_binary '',_binary '',28,2),(5,2,'2026-10-05 00:11:30.609870','2026-10-05 00:16:30.609870','$2a$10$sXixk7Eb5WyGEO7KnmuoE.jMElWD7ZckRJ/DCW1zo1KXAF499UZ..',_binary '',_binary '',30,11),(6,1,'2026-10-05 00:12:57.313713','2026-10-05 00:17:57.313713','$2a$10$kb/czke30tBZxfGkYVrt9ORhON/49hcyz6eUeyEh0tYapVada.Nri',_binary '',_binary '',30,9),(7,1,'2026-10-05 00:13:35.711607','2026-10-05 00:18:35.711607','$2a$10$Dv6q8nvKlOjEay27MLk7r.wjmOPbn18jRD0q0MgjjDf8hqzLg19PC',_binary '',_binary '',30,8),(8,1,'2026-10-05 10:11:09.543612','2026-10-05 10:16:09.543612','$2a$10$dZP/TIpB/k4wCU.tZbxU4OjjGyYMKWE7CsjM.YZunY7LaSE13nzpi',_binary '',_binary '',31,8),(9,1,'2026-11-15 20:02:49.441324','2026-11-15 20:07:49.441324','$2a$10$auMBTlVJRSSaGywikAMqvu1WOxLJY6w7GcQZOYfIVP0jxF9wnhp5y',_binary '',_binary '',34,25),(10,1,'2026-11-15 21:26:43.757552','2026-11-15 21:31:43.757552','$2a$10$tP4/yMgA6ujijIOjUETd6eOVLb2Sy/ETmzzvAX0ydVjn6SEzqseH2',_binary '',_binary '',36,1),(11,1,'2026-11-15 21:27:36.097465','2026-11-15 21:32:36.097465','$2a$10$fYABvp4xaPF2H78tNFIvfurD3Z2QvSWdrLtAhTHPZ7VEP6QnuiphC',_binary '',_binary '',36,2),(12,1,'2026-11-15 21:28:30.984270','2026-11-15 21:33:30.983271','$2a$10$xerGmyE6Aop4DwAlTutCfucq14hOjBDB9COXyjluo.C6biGtRkCcO',_binary '',_binary '',36,7),(13,1,'2026-11-15 21:29:02.869009','2026-11-15 21:34:02.869009','$2a$10$MppqldhrblhNfFiQKLwBqegTt6nDVlrrxLNC7mJUPzaPOWOclYhxO',_binary '',_binary '',36,25),(14,1,'2026-11-15 21:29:35.164338','2026-11-15 21:34:35.164338','$2a$10$Yv4DS3hNWDcDWisD21xOiOjZa91qt4Km2xtOdG37eN4Jm2AnS3fV2',_binary '',_binary '',36,8),(15,1,'2026-11-15 21:30:08.960162','2026-11-15 21:35:08.959159','$2a$10$G4jd8cYwYDqMN6Ia9P0aIOoRy6HKtUqnuTA/pXQ2Kkj61wjmHod1a',_binary '',_binary '',36,9);
/*!40000 ALTER TABLE `voting_challenges` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-15 23:26:16
