/*
 * Craigslist Neighborhood listings
 * for craigslist_neighborhood_average_rental.csv
 */

CREATE TABLE craigslist_neighborhood_average_rental (
  id SERIAL PRIMARY KEY, -- uuid generated automatically.

  REGIONID numeric(10, 0), -- Zillow neighborhood id
  NAME varchar,  -- commonly used name for this Portland neighborhood.

  NUM_OF_STUDIO numeric, -- Number of studios
  AVG_PRICE_STUDIO numeric, -- Average studio price

  NUM_OF_1_BR numeric, -- Number of 1 bedroom listing
  AVG_PRICE_1_BR numeric, -- Average 1 bedroom price

  NUM_OF_2_BR numeric, -- Number of 2 bedroom listing
  AVG_PRICE_2_BR numeric, -- Average 2 bedroom price

  NUM_OF_3_BR numeric, -- Number of 3 bedroom listing
  AVG_PRICE_3_BR numeric, -- Average 3 bedroom price

  AVG_PRICE numeric, -- Average price of all listings

  RENTABILITY numeric, --  How many standard deviations the neighborhood average is away from Portland’s average

  LISTING_COUNT integer, -- # of listings total in this neighborhood

  DATA_SOURCE_ID integer, -- Foreign key to data_source
  DATE_LOADED timestamp WITH TIME ZONE DEFAULT now() -- when this row was loaded
);
