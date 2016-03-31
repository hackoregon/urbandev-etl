/*
 * Persons 25 Years and Over by Educational Attainment.
 * Years: 1970, 1980, 1990, 2000, 2008-2012 by Tract. 
 * Nominal Integration.
 * NHGIS Time Series census data.
 * Uses column names specified in the NHGIS codebook.
 */

CREATE TABLE census_educational_attainment (
	ID SERIAL PRIMARY KEY, -- uuid generated automatically.
	NHGISCODE varchar(16),  -- NHGIS Integrated Geographic Unit Code
	GJOIN1970 varchar(16), -- GIS Join Match Code, 1970
	GJOIN1980 varchar(16),  -- GIS Join Match Code, 1980  
	GJOIN1990 varchar(16),  -- GIS Join Match Code, 1990
	GJOIN2000 varchar(16),  -- GIS Join Match Code, 2000
	GJOIN2012 varchar(16),  -- GIS Join Match Code, 2010
	STATE varchar(64),  -- NHGIS Integrated State Name
	STATEFP varchar(8), -- FIPS State Code (2 digits)
	STATENH varchar(8),  -- NHGIS Integrated State Code
	COUNTY varchar(64),  -- NHGIS Integrated County Name
	COUNTYFP varchar(8),  -- FIPS County Code (3 digits)
	COUNTYNH varchar(8),  -- NHGIS Integrated County Code
	TRACTA varchar(16),  -- NHGIS Integrated Census Tract Code
	NAME1970 varchar(64),  -- Area Name, 1970
	NAME1980 varchar(64),  -- Area Name, 1980
	NAME1990 varchar(64),  -- Area Name, 1990
	NAME2000 varchar(64),  -- Area Name, 2000
	NAME2012 varchar(64),  -- Area Name, 2010
	B69AA1970 int, 
	B69AA1980 int, 
	B69AA1990 int, 
	B69AA2000 int, 
	B69AA125 int, 
	B69AA125M int, 
	B69AB1970 int, 
	B69AB1980 int, 
	B69AB1990 int, 
	B69AB2000 int, 
	B69AB125 int, 
	B69AB125M int, 
	B69AC1970 int, 
	B69AC1980 int, 
	B69AC1990 int, 
	B69AC2000 int, 
	B69AC125 int, 
	B69AC125M int,
	DATA_SOURCE_ID integer, -- Foreign key to data_source
	DATE_LOADED timestamp WITH TIME ZONE DEFAULT now() -- when this row was loaded
);
