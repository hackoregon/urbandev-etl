/* 
 * Number of owner occupied and renter occupied housing units
 * per U.S. Census Tract.
 * Occupied Housing Units by Tenure [2], 
 * Years: 1970, 1980, 1990, 2000, 2010 by Tract. 
 * Nominal Integration.
 * NHGIS Time Series census data.
 * Uses column names specified in the NHGIS codebook.
 */
CREATE TABLE census_housing_units_tenure (
  id SERIAL PRIMARY KEY, -- uuid generated automatically.
  NHGISCODE varchar(16), -- NHGIS Integrated Geographic Unit Code
  GJOIN1970 varchar(16), -- GIS Join Match Code, 1970
  GJOIN1980 varchar(16), -- GIS Join Match Code, 1980
  GJOIN1990 varchar(16), -- GIS Join Match Code, 1990
  GJOIN2000 varchar(16), -- GIS Join Match Code, 2000
  GJOIN2010 varchar(16), -- GIS Join Match Code, 2010
  STATE varchar(64), -- NHGIS Integrated State Name
  STATEFP varchar(8), -- FIPS State Code (2 digits)
  STATENH varchar(8), -- NHGIS Integrated State Code
  COUNTY varchar(64), -- NHGIS Integrated County Name
  COUNTYFP varchar(8), -- FIPS County Code (3 digits)
  COUNTYNH varchar(8), -- NHGIS Integrated County Code
  TRACTA varchar(16), -- NHGIS Integrated Census Tract Code
  NAME1970 varchar(64), -- Area Name, 1970
  NAME1980 varchar(64), -- Area Name, 1980
  NAME1990 varchar(64), -- Area Name, 1990
  NAME2000 varchar(64), -- Area Name, 2000
  NAME2010 varchar(64), -- Area Name, 2010
  B37AA1970 int, -- 1970: Housing units: Owner occupied
  B37AA1980 int, -- 1980: Housing units: Owner occupied
  B37AA1990 int, -- 1990: Housing units: Owner occupied
  B37AA2000 int, -- 2000: Housing units: Owner occupied
  B37AA2010 int, -- 2010: Housing units: Owner occupied
  B37AB1970 int, -- 1970: Housing units: Renter occupied
  B37AB1980 int, -- 1980: Housing units: Renter occupied
  B37AB1990 int, -- 1990: Housing units: Renter occupied
  B37AB2000 int, -- 2000: Housing units: Renter occupied
  B37AB2010 int, -- 2010: Housing units: Renter occupied
  DATA_SOURCE_ID integer, -- Foreign key to data_source
  DATE_LOADED timestamp WITH TIME ZONE DEFAULT now() -- when this row was loaded
);
