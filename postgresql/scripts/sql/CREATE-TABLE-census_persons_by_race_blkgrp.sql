/* 
 * Persons By Race per U.S. Census Block Group.
 * Years: 2000, 2010 by Block Group. 
 * Standardized to 2010.
 * NHGIS Time Series census data.
 * Uses column names specified in the NHGIS codebook.
 */
CREATE TABLE census_persons_by_race_blkgrp (
  id SERIAL PRIMARY KEY, -- uuid generated automatically by the database.

  -- context fields
  GISJOIN varchar, -- GIS Join Match Code
  GEOGYEAR varchar, -- Geography Year
  STATE varchar, -- State Name
  STATEA varchar, -- State Code
  COUNTY varchar, -- County Name
  COUNTYA varchar, -- County Code
  TRACTA varchar, -- Census Tract Code
  BLCK_GRPA varchar, -- Block Group Code
  GEOID10 varchar, -- key to Block Group shp file

  -- Time series AA: Persons: White (single race)
  CM1AA2000 real, -- 2000: Persons: White (single race)
  CM1AA2000L integer, -- Lower bound: 2000: Persons: White (single race)
  CM1AA2000U integer, -- Upper bound: 2000: Persons: White (single race)
  CM1AA2010 integer, -- 2010: Persons: White (single race)
  -- Time series AB: Persons: Black or African American (single race)
  CM1AB2000 real, -- 2000: Persons: Black or African American (single race)
  CM1AB2000L integer, -- Lower bound: 2000: Persons: Black or African American (single race)
  CM1AB2000U integer, -- Upper bound: 2000: Persons: Black or African American (single race)
  CM1AB2010 integer, -- 2010: Persons: Black or African American (single race)
  -- Time series AC: Persons: American Indian and Alaska Native (single race)
  CM1AC2000 real, -- 2000: Persons: American Indian and Alaska Native (single race)
  CM1AC2000L integer, -- Lower bound: 2000: Persons: American Indian and Alaska Native (single race)
  CM1AC2000U integer, -- Upper bound: 2000: Persons: American Indian and Alaska Native (single race)
  CM1AC2010 integer, -- 2010: Persons: American Indian and Alaska Native (single race)
  -- Time series AD: Persons: Asian (single race)
  CM1AD2000 real, -- 2000: Persons: Native Hawaiian and Other Pacific Islander (single race)
  CM1AD2000L integer, -- Lower bound: 2000: Persons: Native Hawaiian and Other Pacific Islander (single race)
  CM1AD2000U integer, -- Upper bound: 2000: Persons: Native Hawaiian and Other Pacific Islander (single race)
  CM1AD2010 integer, -- 2010: Persons: Native Hawaiian and Other Pacific Islander (single race)
  -- Time series AE: Persons: Native Hawaiian and Other Pacific Islander (single race)
  CM1AE2000 real, -- 2000: Persons: Native Hawaiian and Other Pacific Islander (single race)
  CM1AE2000L integer, -- Lower bound: 2000: Persons: Native Hawaiian and Other Pacific Islander (single race)
  CM1AE2000U integer, -- Upper bound: 2000: Persons: Native Hawaiian and Other Pacific Islander (single race)
  CM1AE2010 integer, -- 2010: Persons: Native Hawaiian and Other Pacific Islander (single race)
  -- Time series AF: Persons: Some Other Race (single race)
  CM1AF2000 real, -- 2000: Persons: Some Other Race (single race)
  CM1AF2000L integer, -- Lower bound: 2000: Persons: Some Other Race (single race)
  CM1AF2000U integer, -- Upper bound: 2000: Persons: Some Other Race (single race)
  CM1AF2010 integer, -- 2010: Persons: Some Other Race (single race)
  -- Time series AG: Persons: Two or More Races
  CM1AG2000 real, -- 2000: Persons: Two or More Races
  CM1AG2000L integer, -- Lower bound: 2000: Persons: Two or More Races
  CM1AG2000U integer, -- Upper bound: 2000: Persons: Two or More Races
  CM1AG2010 integer, -- 2010: Persons: Two or More Races

  DATA_SOURCE_ID integer, -- Foreign key to data_source
  DATE_LOADED timestamp WITH TIME ZONE DEFAULT now() -- when this row was loaded
);
