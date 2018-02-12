/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.1.49-community : Database - db_onlinemusic
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_onlinemusic` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `db_onlinemusic`;

/*Table structure for table `tb_manager` */

DROP TABLE IF EXISTS `tb_manager`;

CREATE TABLE `tb_manager` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `manager` varchar(30) DEFAULT NULL,
  `pwd` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `tb_manager` */

insert  into `tb_manager`(`id`,`manager`,`pwd`) values (1,'mr','mrsoft');

/*Table structure for table `tb_song` */

DROP TABLE IF EXISTS `tb_song`;

CREATE TABLE `tb_song` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `songName` varchar(50) DEFAULT NULL,
  `singer` varchar(30) DEFAULT NULL,
  `specialName` varchar(30) DEFAULT NULL,
  `fileSize` varchar(10) DEFAULT NULL,
  `fileURL` varchar(100) DEFAULT NULL,
  `format` varchar(10) DEFAULT NULL,
  `hits` int(11) DEFAULT NULL,
  `download` int(11) DEFAULT NULL,
  `upTime` datetime DEFAULT NULL,
  `songType` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

/*Data for the table `tb_song` */

insert  into `tb_song`(`id`,`songName`,`singer`,`specialName`,`fileSize`,`fileURL`,`format`,`hits`,`download`,`upTime`,`songType`) values (1,'至少还有你','lyl','儿歌','2.3M','xbt.mp3','MP3',26,1,'2013-08-17 11:43:30',2),(2,'改变自己','王力宏','改变自己','6M','gbzj.mp3','MP3',56,7,'2013-08-17 11:43:30',1),(3,'红遍全球','张学友','红遍全球','4.8M','hbqq.mp3','MP3',55,26,'2013-08-17 11:43:30',1),(4,'城里的月光','sss','城里的月光','2.6M','cldyg.mp3','MP3',4,0,'2013-08-17 11:43:30',2),(5,'有多少爱可以重来','迪克牛仔','有多少爱可以重来','3.6M','ydsakycl.mp3','MP3',23,0,'2013-08-17 11:43:30',1),(6,'小白兔','qpg','儿歌','2.6M','xbt.mp3','MP3',2,1,'2013-08-17 11:43:30',5),(7,'回家','匿名','萨克斯','3.2M','hj.mp3','MP3',7,0,'2013-08-17 11:43:30',6),(8,'火辣辣','匿名','火辣辣','4.2M','hll.mp3','MP3',5,0,'2013-08-17 11:43:30',3),(9,'just One Last Dance','sarah connor','key to my soul','3.7M','justonelastdance.mp3','MP3',5,0,'2013-08-17 11:43:31',4),(10,'外婆的澎湖湾','匿名','经典老歌','3.4M','wpdphw.mp3','MP3',5,1,'2013-08-17 11:43:31',2),(26,'伙伴','孙悦','伙伴','4.21M','1215657654765.mp3','mp3',7,3,'2013-08-17 11:43:31',2),(31,'同一个世界同一个梦想','匿名','同一个世界同一个梦想','4.21M','1223288102375.mp3','mp3',3,0,'2013-08-17 11:43:31',1),(32,'朋友','周华健','朋友','2.96M','1223533185937.mp3','mp3',2,0,'2013-08-17 11:43:31',2),(33,'红装','徐良','犯贱','3.8M','1376715906945.mp3','mp3',NULL,NULL,NULL,1),(34,'212','21','21','3.8M','1376716227362.mp3','mp3',NULL,NULL,'2013-08-17 13:10:35',1);

/*Table structure for table `tb_songtype` */

DROP TABLE IF EXISTS `tb_songtype`;

CREATE TABLE `tb_songtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typeName` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `tb_songtype` */

insert  into `tb_songtype`(`id`,`typeName`) values (1,'流行金曲'),(2,'经典老歌'),(3,'热舞DJ'),(4,'欧美金曲'),(5,'少儿歌曲'),(6,'轻音乐');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
