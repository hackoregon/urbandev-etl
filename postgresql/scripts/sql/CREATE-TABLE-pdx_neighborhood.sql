/*
 * Portland Neighborhoods.
 */

CREATE TABLE pdx_neighborhood (
  ID integer,  -- uuid for this Portland Neighborhood.
  NAME varchar,  -- commonly used name for this Portland neighborhood.
  AREA numeric(12, 2),  -- size of neighborhood. What units are used?
  IN_PORTLAND boolean,  -- true when this neighborhood is in Portland.

  DATA_SOURCE_ID integer, -- Foreign key to data_source
  DATE_LOADED timestamp WITH TIME ZONE DEFAULT now(), -- when this row was loaded

  PRIMARY KEY (ID)
);
