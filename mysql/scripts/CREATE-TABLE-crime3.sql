CREATE TABLE `crime3` (
  `record_id` int(11) NOT NULL,
  `report_datetime` datetime NOT NULL,
  `major_offense_type` varchar(25) DEFAULT NULL,
  `address` varchar(70) DEFAULT NULL,
  `neighborhood` varchar(25) DEFAULT NULL,
  `police_precinct` varchar(25) DEFAULT NULL,
  `police_district` int(11) DEFAULT NULL,
  `shape` point NOT NULL,
  `violent` char(1) DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  KEY `idx_reportdt` (`report_datetime`),
  SPATIAL KEY `shape` (`shape`),
  KEY `idx_neighborhood` (`neighborhood`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
