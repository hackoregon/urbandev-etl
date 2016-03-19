CREATE TABLE `permits2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `caseno` varchar(24) NOT NULL,
  `shape` point NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `new_class` varchar(24) DEFAULT NULL,
  `new_type` varchar(24) DEFAULT NULL,
  `usetype` varchar(36) NOT NULL,
  `units` int(11) DEFAULT NULL,
  `description` varchar(125) DEFAULT NULL,
  `value` double DEFAULT NULL,
  `issuedate` date NOT NULL,
  `nbrhood` varchar(70) DEFAULT NULL,
  `sqft` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  SPATIAL KEY `shape` (`shape`),
  KEY `idx_issuedate` (`issuedate`)
) ENGINE=MyISAM AUTO_INCREMENT=24953 DEFAULT CHARSET=utf8;
