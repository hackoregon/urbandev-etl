/* 
 * Total Population per U.S. Census Block Group.
 * Years: 2000, 2010 by Block Group. 
 * Standardized to 2010.
 * NHGIS Time Series census data.
 * Uses column names specified in the NHGIS codebook.
 */
CREATE TABLE census_total_population_blkgrp (
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

  -- Time series AA: Persons: Total
  CL8AA2000 real, -- 2000: Persons: Total
  CL8AA2000L int, -- Lower bound: 2000: Persons: Total
  CL8AA2000U int, -- Upper bound: 2000: Persons: Total
  CL8AA2010 int, -- 2010: Persons: Total

  DATA_SOURCE_ID integer, -- Foreign key to data_source
  DATE_LOADED timestamp WITH TIME ZONE DEFAULT now() -- when this row was loaded
);
