 /*
 * Years: 1970, 1980, 1990, 2000, 2010 by Tract. 
 * Nominal Integration.
 * NHGIS Time Series census data.
 * Uses column names specified in the NHGIS codebook.
 */

CREATE TABLE census_households_by_income (
  id SERIAL PRIMARY KEY, -- uuid generated automatically.
	NHGISCODE varchar,  -- NHGIS Integrated Geographic Unit Code
	GJOIN1970 varchar, -- GIS Join Match Code, 1970
	GJOIN1980 varchar,  -- GIS Join Match Code, 1980  
	GJOIN1990 varchar,  -- GIS Join Match Code, 1990
	GJOIN2000 varchar,  -- GIS Join Match Code, 2000
	GJOIN2012 varchar,  -- GIS Join Match Code, 2010
	STATE varchar,  -- NHGIS Integrated State Name
	STATEFP INTEGER ,  -- FIPS State Code (2 digits)
	STATENH INTEGER ,  -- NHGIS Integrated State Code
	COUNTY VARCHAR , -- NHGIS Integrated County Name
	COUNTYFP INTEGER ,  -- FIPS County Code (3 digits)
	COUNTYNH INTEGER ,  -- NHGIS Integrated County Code
	TRACTA INTEGER , -- NHGIS Integrated Census Tract Code
	NAME1970 varchar,  -- Area Name, 1970
	NAME1980 varchar,  -- Area Name, 1980
	NAME1990 varchar,  -- Area Name, 1990
	NAME2000 varchar,  -- Area Name, 2000
	NAME2012 varchar,  -- Area Name, 2010
	BS7AA1970 INTEGER, 
	BS7AA1980 INTEGER, 
	BS7AA1990 INTEGER, 
	BS7AA2000 INTEGER, 
	BS7AA125 INTEGER, 
	BS7AA125M INTEGER, 
	BS7AB1970 INTEGER, 
	BS7AB1980 INTEGER, 
	BS7AB1990 INTEGER, 
	BS7AB2000 INTEGER, 
	BS7AB125 INTEGER, 
	BS7AB125M INTEGER, 
	BS7AC1970 INTEGER, 
	BS7AC1980 INTEGER, 
	BS7AC1990 INTEGER, 
	BS7AC2000 INTEGER, 
	BS7AC125 INTEGER, 
	BS7AC125M INTEGER, 
	BS7AD1970 INTEGER, 
	BS7AD1980 INTEGER, 
	BS7AD1990 INTEGER, 
	BS7AD2000 INTEGER, 
	BS7AD125 INTEGER, 
	BS7AD125M INTEGER,
	DATA_SOURCE_ID integer, -- Foreign key to data_source
  DATE_LOADED timestamp WITH TIME ZONE DEFAULT now() -- when this row was loaded
);
