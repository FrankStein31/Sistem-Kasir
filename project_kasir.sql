/*
SQLyog Ultimate
MySQL - 8.0.30 : Database - project_kasir
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
USE `project_kasir`;

/*Table structure for table `attributes` */

DROP TABLE IF EXISTS `attributes`;

CREATE TABLE `attributes` (
  `attribute_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `attribute` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`attribute_id`),
  KEY `attributes_user_id_foreign` (`user_id`),
  CONSTRAINT `attributes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `attributes` */

/*Table structure for table `menu_types` */

DROP TABLE IF EXISTS `menu_types`;

CREATE TABLE `menu_types` (
  `menu_type_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `menu_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`menu_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `menu_types` */

insert  into `menu_types`(`menu_type_id`,`menu_type`,`created_at`,`updated_at`) values (1,'Menu','2024-11-29 11:33:00','2024-11-29 11:33:00');
insert  into `menu_types`(`menu_type_id`,`menu_type`,`created_at`,`updated_at`) values (2,'Submenu','2024-11-29 11:33:00','2024-11-29 11:33:00');

/*Table structure for table `menus` */

DROP TABLE IF EXISTS `menus`;

CREATE TABLE `menus` (
  `menu_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `menu` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `menu_slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `menu_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `menu_redirect` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `menu_sort` int NOT NULL DEFAULT '0',
  `menu_type_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`menu_id`),
  KEY `menus_menu_type_id_foreign` (`menu_type_id`),
  CONSTRAINT `menus_menu_type_id_foreign` FOREIGN KEY (`menu_type_id`) REFERENCES `menu_types` (`menu_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `menus` */

insert  into `menus`(`menu_id`,`menu`,`menu_slug`,`menu_icon`,`menu_redirect`,`menu_sort`,`menu_type_id`,`created_at`,`updated_at`) values (1,'users','users','users','/users',1,1,'2024-11-29 11:33:00','2024-11-29 11:33:00');
insert  into `menus`(`menu_id`,`menu`,`menu_slug`,`menu_icon`,`menu_redirect`,`menu_sort`,`menu_type_id`,`created_at`,`updated_at`) values (2,'product','product','box','/product',2,1,'2024-11-29 11:37:36','2024-11-29 11:37:36');
insert  into `menus`(`menu_id`,`menu`,`menu_slug`,`menu_icon`,`menu_redirect`,`menu_sort`,`menu_type_id`,`created_at`,`updated_at`) values (3,'transaction','transaction','shopping-cart','/transaction',3,1,'2024-11-29 12:12:13','2024-11-29 12:12:13');

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values (1,'2019_12_14_000001_create_personal_access_tokens_table',1);
insert  into `migrations`(`id`,`migration`,`batch`) values (2,'2024_07_25_095047_create_roles_table',1);
insert  into `migrations`(`id`,`migration`,`batch`) values (3,'2024_07_25_095511_create_users_table',1);
insert  into `migrations`(`id`,`migration`,`batch`) values (4,'2024_07_30_093021_create_attributes_table',1);
insert  into `migrations`(`id`,`migration`,`batch`) values (5,'2024_08_20_085946_create_role_access_table',1);
insert  into `migrations`(`id`,`migration`,`batch`) values (6,'2024_08_20_092612_create_menu_types_table',1);
insert  into `migrations`(`id`,`migration`,`batch`) values (7,'2024_08_20_092649_create_menus_table',1);
insert  into `migrations`(`id`,`migration`,`batch`) values (8,'2024_08_21_044059_create_submenus_table',1);
insert  into `migrations`(`id`,`migration`,`batch`) values (12,'2024_08_21_044060_create_role_permission_table',2);
insert  into `migrations`(`id`,`migration`,`batch`) values (13,'2024_11_29_113736_create_products_table',2);
insert  into `migrations`(`id`,`migration`,`batch`) values (14,'2024_11_29_121213_create_transactions_table',3);

/*Table structure for table `personal_access_tokens` */

DROP TABLE IF EXISTS `personal_access_tokens`;

CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `personal_access_tokens` */

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `product_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stock` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `variant` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `products` */

/*Table structure for table `role_access` */

DROP TABLE IF EXISTS `role_access`;

CREATE TABLE `role_access` (
  `role_access_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`role_access_id`),
  KEY `role_access_role_id_foreign` (`role_id`),
  KEY `role_access_user_id_foreign` (`user_id`),
  CONSTRAINT `role_access_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE,
  CONSTRAINT `role_access_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `role_access` */

insert  into `role_access`(`role_access_id`,`role_id`,`user_id`,`created_at`,`updated_at`) values (1,1,1,'2024-11-29 11:33:00','2024-11-29 11:33:00');
insert  into `role_access`(`role_access_id`,`role_id`,`user_id`,`created_at`,`updated_at`) values (2,2,2,'2024-11-29 11:33:00','2024-11-29 11:33:00');
insert  into `role_access`(`role_access_id`,`role_id`,`user_id`,`created_at`,`updated_at`) values (3,2,1,'2024-11-29 11:34:03','2024-11-29 11:34:03');
insert  into `role_access`(`role_access_id`,`role_id`,`user_id`,`created_at`,`updated_at`) values (4,3,3,'2024-11-29 12:29:27','2024-11-29 12:29:27');
insert  into `role_access`(`role_access_id`,`role_id`,`user_id`,`created_at`,`updated_at`) values (5,3,2,'2024-11-29 12:29:54','2024-11-29 12:29:54');

/*Table structure for table `role_permission` */

DROP TABLE IF EXISTS `role_permission`;

CREATE TABLE `role_permission` (
  `role_permission_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint unsigned NOT NULL,
  `menu_id` bigint unsigned NOT NULL,
  `can_read` tinyint(1) NOT NULL DEFAULT '0',
  `can_create` tinyint(1) NOT NULL DEFAULT '0',
  `can_update` tinyint(1) NOT NULL DEFAULT '0',
  `can_delete` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`role_permission_id`),
  KEY `role_permission_role_id_foreign` (`role_id`),
  KEY `role_permission_menu_id_foreign` (`menu_id`),
  CONSTRAINT `role_permission_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`menu_id`) ON DELETE CASCADE,
  CONSTRAINT `role_permission_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `role_permission` */

insert  into `role_permission`(`role_permission_id`,`role_id`,`menu_id`,`can_read`,`can_create`,`can_update`,`can_delete`,`created_at`,`updated_at`) values (1,1,2,1,1,1,1,'2024-11-29 12:27:40','2024-11-29 12:27:40');
insert  into `role_permission`(`role_permission_id`,`role_id`,`menu_id`,`can_read`,`can_create`,`can_update`,`can_delete`,`created_at`,`updated_at`) values (2,1,3,1,1,1,1,'2024-11-29 12:27:40','2024-11-29 12:27:40');
insert  into `role_permission`(`role_permission_id`,`role_id`,`menu_id`,`can_read`,`can_create`,`can_update`,`can_delete`,`created_at`,`updated_at`) values (3,1,1,1,1,1,1,'2024-11-29 12:27:40','2024-11-29 12:27:40');
insert  into `role_permission`(`role_permission_id`,`role_id`,`menu_id`,`can_read`,`can_create`,`can_update`,`can_delete`,`created_at`,`updated_at`) values (4,2,2,1,1,1,1,'2024-11-29 12:28:01','2024-11-29 12:28:01');
insert  into `role_permission`(`role_permission_id`,`role_id`,`menu_id`,`can_read`,`can_create`,`can_update`,`can_delete`,`created_at`,`updated_at`) values (5,2,3,1,1,1,1,'2024-11-29 12:28:01','2024-11-29 12:28:01');
insert  into `role_permission`(`role_permission_id`,`role_id`,`menu_id`,`can_read`,`can_create`,`can_update`,`can_delete`,`created_at`,`updated_at`) values (6,2,1,1,1,1,1,'2024-11-29 12:28:01','2024-11-29 12:28:01');
insert  into `role_permission`(`role_permission_id`,`role_id`,`menu_id`,`can_read`,`can_create`,`can_update`,`can_delete`,`created_at`,`updated_at`) values (7,3,2,1,1,1,1,'2024-11-29 12:28:17','2024-11-29 12:28:17');
insert  into `role_permission`(`role_permission_id`,`role_id`,`menu_id`,`can_read`,`can_create`,`can_update`,`can_delete`,`created_at`,`updated_at`) values (8,3,3,1,1,1,1,'2024-11-29 12:28:17','2024-11-29 12:28:17');
insert  into `role_permission`(`role_permission_id`,`role_id`,`menu_id`,`can_read`,`can_create`,`can_update`,`can_delete`,`created_at`,`updated_at`) values (9,3,1,0,0,0,0,'2024-11-29 12:28:17','2024-11-29 16:38:47');

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `role_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `roles_role_name_unique` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `roles` */

insert  into `roles`(`role_id`,`role_name`,`description`,`created_at`,`updated_at`) values (1,'Superadmin','Superadmin role with highest permissions','2024-11-29 11:32:59','2024-11-29 11:32:59');
insert  into `roles`(`role_id`,`role_name`,`description`,`created_at`,`updated_at`) values (2,'Admin','Administrator role with full permissions','2024-11-29 11:32:59','2024-11-29 11:32:59');
insert  into `roles`(`role_id`,`role_name`,`description`,`created_at`,`updated_at`) values (3,'User','Standard user role with limited permissions','2024-11-29 11:32:59','2024-11-29 11:32:59');

/*Table structure for table `submenus` */

DROP TABLE IF EXISTS `submenus`;

CREATE TABLE `submenus` (
  `submenu_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` bigint unsigned NOT NULL,
  `submenu` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submenu_slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submenu_redirect` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `submenu_sort` int NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`submenu_id`),
  UNIQUE KEY `submenus_submenu_slug_unique` (`submenu_slug`),
  KEY `submenus_menu_id_foreign` (`menu_id`),
  CONSTRAINT `submenus_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`menu_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `submenus` */

/*Table structure for table `transactions` */

DROP TABLE IF EXISTS `transactions`;

CREATE TABLE `transactions` (
  `transaction_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qty` int NOT NULL,
  `method_payment` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(15,2) NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `transactions_product_id_foreign` (`product_id`),
  CONSTRAINT `transactions_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `transactions` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `user_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nonce` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_verify` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `users_code_unique` (`code`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`user_id`,`code`,`name`,`phone`,`email`,`password`,`token`,`nonce`,`is_verify`,`created_at`,`updated_at`,`deleted_at`) values (1,'superadmin','superadmin','1234567890','superadmin@yopmail.com','$2y$10$bUsAXFtlluslLbWtv73qou.m8p8hxKIhoLcSuzphLyTXvcXvilMmi','d93b7f40ef114e52b773e9b6308b58c1',NULL,'1','2024-11-29 11:32:59','2024-11-29 16:38:25',NULL);
insert  into `users`(`user_id`,`code`,`name`,`phone`,`email`,`password`,`token`,`nonce`,`is_verify`,`created_at`,`updated_at`,`deleted_at`) values (2,'admin','admin','0987654321','admin@yopmail.com','$2y$10$8Ug2KRxt42mtrHhQ8r4W0OuAbFeOzHgApu5NWHjAlWXL7irEC7CJm','3c58f282cfeb4b429d792d9267226275',NULL,'1','2024-11-29 11:33:00','2024-11-29 16:38:05',NULL);
insert  into `users`(`user_id`,`code`,`name`,`phone`,`email`,`password`,`token`,`nonce`,`is_verify`,`created_at`,`updated_at`,`deleted_at`) values (3,'kasir','kasir','08512345678','kasir@gmail.com','$2y$10$PFfxJmxZHpo0uL9HwhHxoO6uovcGIPp09UT9xBlcL0R8/N9I2cpDu',NULL,NULL,'1','2024-11-29 12:29:16','2024-11-29 12:29:27',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
