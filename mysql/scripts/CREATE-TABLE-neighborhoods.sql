CREATE TABLE `neighborhoods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shape` geometry NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `area` double(25,5) DEFAULT NULL,
  `in_portland` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  SPATIAL KEY `idx_shape` (`shape`),
  KEY `idx_name` (`area`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=443 DEFAULT CHARSET=utf8;
