/*
 * Zillow data.
 * Years: April 1996 - March 2016.
 * Includes Portland Metro area by neighborhood.
 */
CREATE TABLE zillow_1996_2016 (
  id SERIAL PRIMARY KEY, -- uuid generated automatically by the database.

  RegionID int, -- Zillow Region ID
  RegionName varchar, -- Zillow Neighborhood
  MedianValue_sqft real,
  MedianSold_sqft real,
  ZRI_sqft real,
  Month varchar,

  DATA_SOURCE_ID integer, -- Foreign key to data_source
  DATE_LOADED timestamp WITH TIME ZONE DEFAULT now() -- when this row was loaded
);
