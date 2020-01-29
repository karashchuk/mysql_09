-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: localhost    Database: shop
-- ------------------------------------------------------
-- Server version	8.0.18

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
-- Table structure for table `catalogs`
--

DROP TABLE IF EXISTS `catalogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Название раздела',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `unique_name` (`name`(10))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Разделы интернет-магазина';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogs`
--

LOCK TABLES `catalogs` WRITE;
/*!40000 ALTER TABLE `catalogs` DISABLE KEYS */;
INSERT INTO `catalogs` VALUES (1,'Процессоры'),(2,'Материнские платы'),(3,'Видеокарты'),(4,'Жесткие диски'),(5,'Оперативная память');
/*!40000 ALTER TABLE `catalogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `label` varchar(32) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES ('moscow','Москва'),('novgorod','Новгород'),('irkutsk','Иркутск'),('omsk','Омск'),('kazan','Казань');
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flights`
--

DROP TABLE IF EXISTS `flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flights` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from` varchar(32) DEFAULT NULL,
  `to` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flights`
--

LOCK TABLES `flights` WRITE;
/*!40000 ALTER TABLE `flights` DISABLE KEYS */;
INSERT INTO `flights` VALUES (1,'moscow','omsk'),(2,'novgorod','kazan'),(3,'irkutsk','moscow'),(4,'omsk','irkutsk'),(5,'moscow','kazan');
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `index_of_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Заказы';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'2020-01-22 19:48:24','2020-01-22 19:48:24'),(2,1,'2020-01-22 19:48:24','2020-01-22 20:08:20'),(3,3,'2020-01-22 19:48:24','2020-01-22 19:48:24'),(4,5,'2020-01-22 19:48:24','2020-01-22 20:08:20'),(5,5,'2020-01-22 19:48:24','2020-01-22 19:48:24'),(6,3,'2020-01-22 19:48:24','2020-01-22 19:48:24'),(7,1,'2020-01-22 19:48:24','2020-01-22 19:48:24'),(8,1,'2020-01-22 19:48:24','2020-01-22 20:08:20'),(9,6,'2020-01-22 19:48:24','2020-01-22 19:49:05'),(10,6,'2020-01-22 19:48:24','2020-01-22 19:49:05'),(11,5,'2020-01-22 19:48:24','2020-01-22 19:48:24'),(12,3,'2020-01-22 19:48:24','2020-01-22 19:48:24');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_products`
--

DROP TABLE IF EXISTS `orders_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `total` int(10) unsigned DEFAULT '1' COMMENT 'Количество заказанных товарных позиций',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Состав заказа';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_products`
--

LOCK TABLES `orders_products` WRITE;
/*!40000 ALTER TABLE `orders_products` DISABLE KEYS */;
INSERT INTO `orders_products` VALUES (1,4,3,1,'2020-01-22 20:04:54','2020-01-22 20:04:54'),(2,10,7,1,'2020-01-22 20:04:54','2020-01-22 20:04:54'),(3,3,3,1,'2020-01-22 20:04:54','2020-01-22 20:04:54'),(46,3,7,1,'2020-01-22 20:05:17','2020-01-22 20:05:17'),(47,2,5,1,'2020-01-22 20:05:17','2020-01-22 20:05:17'),(48,12,5,1,'2020-01-22 20:05:17','2020-01-22 20:05:17'),(49,8,2,1,'2020-01-22 20:05:17','2020-01-22 20:05:17'),(50,1,5,1,'2020-01-22 20:05:17','2020-01-22 20:05:17'),(51,4,3,1,'2020-01-22 20:05:17','2020-01-22 20:05:17'),(52,3,5,1,'2020-01-22 20:05:17','2020-01-22 20:05:17'),(53,10,1,1,'2020-01-22 20:05:17','2020-01-22 20:05:17'),(54,8,1,1,'2020-01-22 20:05:17','2020-01-22 20:05:17'),(55,4,3,1,'2020-01-22 20:05:17','2020-01-22 20:05:17'),(56,1,2,1,'2020-01-22 20:05:17','2020-01-22 20:05:17'),(57,9,1,1,'2020-01-22 20:05:17','2020-01-22 20:05:17'),(61,11,4,9,'2020-01-22 20:06:15','2020-01-22 20:06:15'),(62,8,5,7,'2020-01-22 20:06:15','2020-01-22 20:06:15'),(63,12,7,7,'2020-01-22 20:06:15','2020-01-22 20:06:15'),(64,7,7,8,'2020-01-22 20:06:15','2020-01-22 20:06:15'),(65,3,5,4,'2020-01-22 20:06:15','2020-01-22 20:06:15'),(66,2,4,9,'2020-01-22 20:06:15','2020-01-22 20:06:15'),(67,12,1,7,'2020-01-22 20:06:15','2020-01-22 20:06:15'),(68,10,2,6,'2020-01-22 20:06:15','2020-01-22 20:06:15'),(69,4,6,3,'2020-01-22 20:06:15','2020-01-22 20:06:15'),(70,10,1,9,'2020-01-22 20:06:15','2020-01-22 20:06:15'),(71,4,6,8,'2020-01-22 20:06:15','2020-01-22 20:06:15'),(72,10,3,9,'2020-01-22 20:06:15','2020-01-22 20:06:15'),(76,11,7,9,'2020-01-22 20:06:17','2020-01-22 20:06:17'),(77,6,7,1,'2020-01-22 20:06:17','2020-01-22 20:06:17'),(78,7,6,9,'2020-01-22 20:06:17','2020-01-22 20:06:17'),(79,3,4,9,'2020-01-22 20:06:17','2020-01-22 20:06:17'),(80,10,2,1,'2020-01-22 20:06:17','2020-01-22 20:06:17'),(81,4,4,4,'2020-01-22 20:06:17','2020-01-22 20:06:17'),(82,6,1,3,'2020-01-22 20:06:17','2020-01-22 20:06:17'),(83,10,3,6,'2020-01-22 20:06:17','2020-01-22 20:06:17'),(84,8,4,7,'2020-01-22 20:06:17','2020-01-22 20:06:17'),(85,10,1,7,'2020-01-22 20:06:17','2020-01-22 20:06:17'),(86,5,5,5,'2020-01-22 20:06:17','2020-01-22 20:06:17'),(87,1,7,6,'2020-01-22 20:06:17','2020-01-22 20:06:17');
/*!40000 ALTER TABLE `orders_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `pr`
--

DROP TABLE IF EXISTS `pr`;
/*!50001 DROP VIEW IF EXISTS `pr`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `pr` AS SELECT 
 1 AS `prod_name`,
 1 AS `cat_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Название',
  `description` text COMMENT 'Описание',
  `price` decimal(11,2) DEFAULT NULL COMMENT 'Цена',
  `catalog_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `index_of_catalog_id` (`catalog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Товарные позиции';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Intel Core i3-8100','Процессор для настольных персональных компьютеров, основанных на платформе Intel.',7890.00,1,'2020-01-22 19:39:22','2020-01-22 19:39:22'),(2,'Intel Core i5-7400','Процессор для настольных персональных компьютеров, основанных на платформе Intel.',12700.00,1,'2020-01-22 19:39:22','2020-01-22 19:39:22'),(3,'AMD FX-8320E','Процессор для настольных персональных компьютеров, основанных на платформе AMD.',4780.00,1,'2020-01-22 19:39:22','2020-01-22 19:39:22'),(4,'AMD FX-8320','Процессор для настольных персональных компьютеров, основанных на платформе AMD.',7120.00,1,'2020-01-22 19:39:22','2020-01-22 19:39:22'),(5,'ASUS ROG MAXIMUS X HERO','Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX',19310.00,2,'2020-01-22 19:39:22','2020-01-22 19:39:22'),(6,'Gigabyte H310M S2H','Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX',4790.00,2,'2020-01-22 19:39:22','2020-01-22 19:39:22'),(7,'MSI B250M GAMING PRO','Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX',5060.00,2,'2020-01-22 19:39:22','2020-01-22 19:39:22');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Имя покупателя',
  `birthday_at` date DEFAULT NULL COMMENT 'Дата рождения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Покупатели';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Геннадий','1990-10-05','2020-01-22 19:38:37','2020-01-22 19:38:37'),(2,'Наталья','1984-11-12','2020-01-22 19:38:37','2020-01-22 19:38:37'),(3,'Александр','1985-05-20','2020-01-22 19:38:37','2020-01-22 19:38:37'),(4,'Сергей','1988-02-14','2020-01-22 19:38:37','2020-01-22 19:38:37'),(5,'Иван','1998-01-12','2020-01-22 19:38:37','2020-01-22 19:38:37'),(6,'Мария','1992-08-29','2020-01-22 19:38:37','2020-01-22 19:38:37'),(7,'Test2','1986-12-12','2020-01-28 19:47:32','2020-01-28 19:47:32');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `w_products`
--

DROP TABLE IF EXISTS `w_products`;
/*!50001 DROP VIEW IF EXISTS `w_products`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `w_products` AS SELECT 
 1 AS `prod_name`,
 1 AS `cat_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'shop'
--

--
-- Final view structure for view `pr`
--

/*!50001 DROP VIEW IF EXISTS `pr`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`natal`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `pr` AS select `p`.`name` AS `prod_name`,`c`.`name` AS `cat_name` from (`products` `p` left join `catalogs` `c` on((`p`.`catalog_id` = `c`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `w_products`
--

/*!50001 DROP VIEW IF EXISTS `w_products`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`natal`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `w_products` AS select `p`.`name` AS `prod_name`,`c`.`name` AS `cat_name` from (`products` `p` left join `catalogs` `c` on((`p`.`catalog_id` = `c`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-28 21:20:42
