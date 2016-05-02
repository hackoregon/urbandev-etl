/* 
 * Household Income in the Past 12 Months (in 2009 Inflation-Adjusted Dollars) per U.S. Census Block Group.
 * Years, --  2009 American Community Survey, --  5-Year Data [2005-2009, Block Groups & Larger Areas].
 * NHGIS Time Series census data.
 * Uses column names specified in the NHGIS codebook.
 */
CREATE TABLE acs_household_income_2009_blkgrp (
  id SERIAL PRIMARY KEY, -- uuid generated automatically by the database.

  -- context fields
  GISJOIN varchar, -- GIS Join Match Code
  YEAR varchar, -- Data File Year
  REGIONA integer, -- Region Code
  DIVISIONA integer, -- Division Code
  STATE varchar, -- State Name
  STATEA integer, -- State Code
  COUNTY varchar, -- County Name
  COUNTYA integer, -- County Code
  COUSUBA integer, -- County Subdivision Code
  PLACEA integer, -- Place Code
  TRACTA integer, -- Census Tract Code
  BLKGRPA integer, -- Block Group Code
  GEOID10 varchar, -- Composite key = STATEA + COUNTYA + TRACTA + BLKGRPA

  CONCITA integer, --  Consolidated City Code
  AIANHHA integer, --  American Indian Area/Alaska Native Area/Hawaiian Home Land Code
  TRUSTA integer, --  American Indian Area (Off-Reservation Trust Land Only)/Hawaiian Home Land Code
  RES_ONLYA integer, --  American Indian Area/Alaska Native Area (Reservation or Statistical Entity Only) Code
  AITSCEA integer, --  Tribal Subdivision/Remainder Code
  ANRCA integer, --  Alaska Native Regional Corporation Code
  CBSAA integer, --  Metropolitan Statistical Area/Micropolitan Statistical Area Code
  CSAA integer, --  Combined Statistical Area Code
  METDIVA integer, --  Metropolitan Division Code
  NECTAA integer, --  New England City and Town Area Code
  CNECTAA integer, --  Combined New England City and Town Area Code
  NECTADIVA integer, --  New England City and Town Area Division Code
  UAA integer, --  Urban Area Code
  CDCURRA integer, --  Congressional District (2007-2013, 110th-112th Congress) Code
  SLDUA integer, --  State Legislative District (Upper Chamber) Code
  SLDLA integer, --  State Legislative District (Lower Chamber) Code
  SUBMCDA integer, --  Subminor Civil Division Code
  SDELMA integer, --  School District (Elementary)/Remainder Code
  SDSECA integer, --  School District (Secondary)/Remainder Code
  SDUNIA integer, --  School District (Unified)/Remainder Code
  PUMA5A integer, --  Public Use Microdata Sample Area (PUMA) Code

  -- Estimates
  NAME_E varchar, -- Area Name
  -- Table 1: Household Income in the Past 12 Months (in 2009 Inflation-Adjusted Dollars)
  RNGE001 integer, --  Total
  RNGE002 integer, --  Less than $10,000
  RNGE003 integer, --  $10,000 to $14,999
  RNGE004 integer, --  $15,000 to $19,999
  RNGE005 integer, --  $20,000 to $24,999
  RNGE006 integer, --  $25,000 to $29,999
  RNGE007 integer, --  $30,000 to $34,999
  RNGE008 integer, --  $35,000 to $39,999
  RNGE009 integer, --  $40,000 to $44,999
  RNGE010 integer, --  $45,000 to $49,999
  RNGE011 integer, --  $50,000 to $59,999
  RNGE012 integer, --  $60,000 to $74,999
  RNGE013 integer, --  $75,000 to $99,999
  RNGE014 integer, --  $100,000 to $124,999
  RNGE015 integer, --  $125,000 to $149,999
  RNGE016 integer, --  $150,000 to $199,999
  RNGE017 integer, --  $200,000 or more
  -- Table 2: Median Household Income in the Past 12 Months (in 2009 Inflation-Adjusted Dollars).
  RNHE001 integer, -- Median household income in the past 12 months (in 2009 inflation-adjusted dollars)
  
  -- Margins of Error
  NAME_M varchar, -- Area Name
  -- Table 1: Household Income in the Past 12 Months (in 2009 Inflation-Adjusted Dollars)
  RNGM001 integer, --  Total
  RNGM002 integer, --  Less than $10,000
  RNGM003 integer, --  $10,000 to $14,999
  RNGM004 integer, --  $15,000 to $19,999
  RNGM005 integer, --  $20,000 to $24,999
  RNGM006 integer, --  $25,000 to $29,999
  RNGM007 integer, --  $30,000 to $34,999
  RNGM008 integer, --  $35,000 to $39,999
  RNGM009 integer, --  $40,000 to $44,999
  RNGM010 integer, --  $45,000 to $49,999
  RNGM011 integer, --  $50,000 to $59,999
  RNGM012 integer, --  $60,000 to $74,999
  RNGM013 integer, --  $75,000 to $99,999
  RNGM014 integer, --  $100,000 to $124,999
  RNGM015 integer, --  $125,000 to $149,999
  RNGM016 integer, --  $150,000 to $199,999
  RNGM017 integer, --  $200,000 or more
  -- Median Household Income in the Past 12 Months (in 2009 Inflation-Adjusted Dollars)
  RNHM001 integer, -- Median household income in the past 12 months (in 2009 inflation-adjusted dollars)

  DATA_SOURCE_ID integer, -- Foreign key to data_source
  DATE_LOADED timestamp WITH TIME ZONE DEFAULT now() -- when this row was loaded
);
