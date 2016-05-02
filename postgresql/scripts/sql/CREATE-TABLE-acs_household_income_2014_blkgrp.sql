/* 
 * Household Income in the Past 12 Months (in 2014 Inflation-Adjusted Dollars) per U.S. Census Block Group.
 * Years: 2014 American Community Survey, 5-Year Data [2010-2014, Block Groups & Larger Areas].
 * NHGIS Time Series census data.
 * Uses column names specified in the NHGIS codebook.
 */
CREATE TABLE acs_household_income_2014_blkgrp (
  id SERIAL PRIMARY KEY, -- uuid generated automatically by the database.

  -- context fields
  GISJOIN varchar, --  GIS Join Match Code
  YEAR varchar, --  Data File Year
  REGIONA integer, --  Region Code
  DIVISIONA integer, --  Division Code
  STATE varchar, --  State Name
  STATEA integer, --  State Code
  COUNTY varchar, --  County Name
  COUNTYA integer, --  County Code
  COUSUBA integer, --  County Subdivision Code
  PLACEA integer, --  Place Code
  TRACTA integer, --  Census Tract Code
  BLKGRPA integer, --  Block Group Code
  GEOID10 varchar, --  Composite key = STATEA + COUNTYA + TRACTA + BLCK_GRPA
  CONCITA integer, --  Consolidated City Code
  AIANHHA integer, --  American Indian Area/Alaska Native Area/Hawaiian Home Land Code
  RES_ONLYA integer, --  American Indian Area/Alaska Native Area (Reservation or Statistical Entity Only) Code
  TRUSTA integer, --  American Indian Area (Off-Reservation Trust Land Only)/Hawaiian Home Land Code
  AITSCEA integer, --  Tribal Subdivision/Remainder Code
  ANRCA integer, --  Alaska Native Regional Corporation Code
  CBSAA integer, --  Metropolitan Statistical Area/Micropolitan Statistical Area Code
  CSAA integer, --  Combined Statistical Area Code
  METDIVA integer, --  Metropolitan Division Code
  NECTAA integer, --  New England City and Town Area Code
  CNECTAA integer, --  Combined New England City and Town Area Code
  NECTADIVA integer, --  New England City and Town Area Division Code
  UAA integer, --  Urban Area Code
  CDCURRA integer, --  Congressional District (2013-2017, 113th-114th Congress) Code
  SLDUA integer, --  State Legislative District (Upper Chamber) Code
  SLDLA integer, --  State Legislative District (Lower Chamber) Code
  ZCTA5A integer, --  5-Digit ZIP Code Tabulation Area Code
  SUBMCDA integer, --  Subminor Civil Division Code
  SDELMA integer, --  School District (Elementary)/Remainder Code
  SDSECA integer, --  School District (Secondary)/Remainder Code
  SDUNIA integer, --  School District (Unified)/Remainder Code
  PUMA5A integer, --  Public Use Microdata Sample Area (PUMA) Code
  BTTRA integer, --  Tribal Census Tract Code
  BTBGA integer, --  Tribal Block Group Code

  -- Estimates
  NAME_E varchar, -- Area Name
  -- Household Income in the Past 12 Months (in 2014 Inflation-Adjusted Dollars)
  ABDOE001 integer, --  Total
  ABDOE002 integer, --  Less than $10,000
  ABDOE003 integer, --  $10,000 to $14,999
  ABDOE004 integer, --  $15,000 to $19,999
  ABDOE005 integer, --  $20,000 to $24,999
  ABDOE006 integer, --  $25,000 to $29,999
  ABDOE007 integer, --  $30,000 to $34,999
  ABDOE008 integer, --  $35,000 to $39,999
  ABDOE009 integer, --  $40,000 to $44,999
  ABDOE010 integer, --  $45,000 to $49,999
  ABDOE011 integer, --  $50,000 to $59,999
  ABDOE012 integer, --  $60,000 to $74,999
  ABDOE013 integer, --  $75,000 to $99,999
  ABDOE014 integer, --  $100,000 to $124,999
  ABDOE015 integer, --  $125,000 to $149,999
  ABDOE016 integer, --  $150,000 to $199,999
  ABDOE017 integer, --  $200,000 or more
  -- Median Household Income in the Past 12 Months (in 2014 Inflation-Adjusted Dollars)
  ABDPE001 integer, -- Median household income in the past 12 months (in 2014 inflation-adjusted dollars)

  -- Margins of Error
  NAME_M varchar, -- Area Name
  -- Household Income in the Past 12 Months (in 2014 Inflation-Adjusted Dollars)
  ABDOM001 integer, --  Total
  ABDOM002 integer, --  Less than $10,000
  ABDOM003 integer, --  $10,000 to $14,999
  ABDOM004 integer, --  $15,000 to $19,999
  ABDOM005 integer, --  $20,000 to $24,999
  ABDOM006 integer, --  $25,000 to $29,999
  ABDOM007 integer, --  $30,000 to $34,999
  ABDOM008 integer, --  $35,000 to $39,999
  ABDOM009 integer, --  $40,000 to $44,999
  ABDOM010 integer, --  $45,000 to $49,999
  ABDOM011 integer, --  $50,000 to $59,999
  ABDOM012 integer, --  $60,000 to $74,999
  ABDOM013 integer, --  $75,000 to $99,999
  ABDOM014 integer, --  $100,000 to $124,999
  ABDOM015 integer, --  $125,000 to $149,999
  ABDOM016 integer, --  $150,000 to $199,999
  ABDOM017 integer, --  $200,000 or more
  -- Median Household Income in the Past 12 Months (in 2014 Inflation-Adjusted Dollars)
  ABDPM001 integer, -- Median household income in the past 12 months (in 2014 inflation-adjusted dollars)

  DATA_SOURCE_ID integer, -- Foreign key to data_source
  DATE_LOADED timestamp WITH TIME ZONE DEFAULT now() -- when this row was loaded
);
