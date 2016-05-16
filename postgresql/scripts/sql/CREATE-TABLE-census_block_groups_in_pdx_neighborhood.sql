/*
 * Associative table relates U.S. Census Block Groups to Portland Neighborhoods.
 */

CREATE TABLE census_block_groups_in_pdx_neighborhood (
  NEIGHBORHOOD_ID integer, -- foreign key to a Portland Neighborhood.
  GISJOIN varchar, -- foreign key to a Block Group entity. This key is used in census data tables obtained from NHGIS.org
  BLKGRP_YEAR integer, -- year that this Block Group was defined by the Census Bureau.
  PERCENT_INSIDE numeric(7, 3), -- percentage of the Block Group that lies within the Neighborhood.

  DATA_SOURCE_ID integer, -- Foreign key to data_source
  DATE_LOADED timestamp WITH TIME ZONE DEFAULT now(), -- when this row was loaded
  
  PRIMARY KEY (NEIGHBORHOOD_ID, GISJOIN, BLKGRP_YEAR)
);
