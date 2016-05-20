 /*
 * Years: 1970, 1980, 1990, 2000, 2010 by Tract. 
 * Nominal Integration.
 * NHGIS Time Series census data.
 * Uses column names specified in the NHGIS codebook.
 */

CREATE TABLE census_households_by_income (
  -- Context Fields
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
  
  -- Households by Income* in Previous Year
  -- Time series AA: Households: Income less than $10,000
  BS7AA1970 integer,  -- 1970: Households: Income less than $10,000
  BS7AA1980 integer,  -- 1980: Households: Income less than $10,000
  BS7AA1990 integer,  -- 1990: Households: Income less than $10,000
  BS7AA2000 integer,  -- 2000: Households: Income less than $10,000
  BS7AA125 integer,  -- 2008-2012: Households: Income less than $10,000
  BS7AA125M integer,  -- Margin of error: 2008-2012: Households: Income less than $10,000

  -- Time series AB: Households: Income $10,000 to $14,999
  BS7AB1970 integer,  -- 1970: Households: Income $10,000 to $14,999
  BS7AB1980 integer,  -- 1980: Households: Income $10,000 to $14,999
  BS7AB1990 integer,  -- 1990: Households: Income $10,000 to $14,999
  BS7AB2000 integer,  -- 2000: Households: Income $10,000 to $14,999
  BS7AB125 integer,  -- 2008-2012: Households: Income $10,000 to $14,999
  BS7AB125M integer,  -- Margin of error: 2008-2012: Households: Income $10,000 to $14,999

  -- Time series AC: Households: Income $15,000 to $24,999
  BS7AC1970 integer,  -- 1970: Households: Income $15,000 to $24,999
  BS7AC1980 integer,  -- 1980: Households: Income $15,000 to $24,999
  BS7AC1990 integer,  -- 1990: Households: Income $15,000 to $24,999
  BS7AC2000 integer,  -- 2000: Households: Income $15,000 to $24,999
  BS7AC125 integer,  -- 2008-2012: Households: Income $15,000 to $24,999
  BS7AC125M integer,  -- Margin of error: 2008-2012: Households: Income $15,000 to $24,999

  -- Time series AD: Households: Income $25,000 or more
  BS7AD1970 integer,  -- 1970: Households: Income $25,000 or more
  BS7AD1980 integer,  -- 1980: Households: Income $25,000 or more
  BS7AD1990 integer,  -- 1990: Households: Income $25,000 or more
  BS7AD2000 integer,  -- 2000: Households: Income $25,000 or more
  BS7AD125 integer,  -- 2008-2012: Households: Income $25,000 or more
  BS7AD125M integer,  -- Margin of error: 2008-2012: Households: Income $25,000 or more

  DATA_SOURCE_ID integer, -- Foreign key to data_source
  DATE_LOADED timestamp WITH TIME ZONE DEFAULT now() -- when this row was loaded
);
