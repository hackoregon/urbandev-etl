CREATE TABLE `demolitions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city` varchar(50) NOT NULL,
  `demolition_date` date NOT NULL,
  `shape` point NOT NULL,
  `record_count` int(11) NOT NULL,
  `address` varchar(200) NOT NULL,
  `neighborhood` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`),
  SPATIAL KEY `shape` (`shape`)
) ENGINE=MyISAM AUTO_INCREMENT=1985 DEFAULT CHARSET=utf8;
