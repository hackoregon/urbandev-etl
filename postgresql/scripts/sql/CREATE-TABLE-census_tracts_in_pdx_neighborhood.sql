/*
 * Associative table relates U.S. Census Tracts to Portland Neighborhoods.
 */

CREATE TABLE census_tracts_in_pdx_neighborhood (
  NEIGHBORHOOD_ID integer, -- foreign key to a Portland Neighborhood.
  TRACT_ID varchar, -- foreign key to a Tract entity. This property is used in census data tables obtained from NHGIS.org
  TRACT_YEAR integer, -- year that this Tract was defined by the Census Bureau.
  PERCENT_INSIDE numeric(7,3), -- percentage of the Tract that lies within the Neighborhood.

  DATA_SOURCE_ID integer, -- Foreign key to data_source
  DATE_LOADED timestamp WITH TIME ZONE DEFAULT now(), -- when this row was loaded
  
  PRIMARY KEY (NEIGHBORHOOD_ID, TRACT_ID, TRACT_YEAR)
);
