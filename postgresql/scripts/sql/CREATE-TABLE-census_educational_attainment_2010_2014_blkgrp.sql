/*
 * Sex by Educational Attainment for the Population 25 Years and Over
 * 2014 American Community Survey: 5-Year Data [2010-2014]
 * Geographic level: Block Group 
 * Uses column names specified in the NHGIS codebook.
 */

CREATE TABLE census_educational_attainment_2010_2014_blkgrp (
  ID SERIAL PRIMARY KEY, -- uuid generated automatically.

  -- Context Fields 
  GISJOIN varchar, -- GIS Join Match Code
  YEAR varchar, -- Data File Year
  REGIONA int, -- Region Code
  DIVISIONA int, -- Division Code
  STATE varchar, -- State Name
  STATEA int, -- State Code
  COUNTY varchar, -- County Name
  COUNTYA int, -- County Code
  COUSUBA int, -- County Subdivision Code
  PLACEA int, -- Place Code
  TRACTA int, -- Census Tract Code
  BLKGRPA int, -- Block Group Code
  CONCITA int, -- Consolidated City Code
  AIANHHA int, -- American Indian Area/Alaska Native Area/Hawaiian Home Land Code
  RES_ONLYA int, -- American Indian Area/Alaska Native Area (Reservation or Statistical Entity Only) Code
  TRUSTA int, -- American Indian Area (Off-Reservation Trust Land Only)/Hawaiian Home Land Code
  AITSCEA int, -- Tribal Subdivision/Remainder Code
  ANRCA int, -- Alaska Native Regional Corporation Code
  CBSAA int, -- Metropolitan Statistical Area/Micropolitan Statistical Area Code
  CSAA int, -- Combined Statistical Area Code
  METDIVA int, -- Metropolitan Division Code
  NECTAA int, -- New England City and Town Area Code
  CNECTAA int, -- Combined New England City and Town Area Code
  NECTADIVA int, -- New England City and Town Area Division Code
  UAA int, -- Urban Area Code
  CDCURRA int, -- Congressional District (2013-2017, 113th-114th Congress) Code
  SLDUA int, -- State Legislative District (Upper Chamber) Code
  SLDLA int, -- State Legislative District (Lower Chamber) Code
  ZCTA5A varchar, -- 5-Digit ZIP Code Tabulation Area Code
  SUBMCDA int, -- Subminor Civil Division Code
  SDELMA int, -- School District (Elementary)/Remainder Code
  SDSECA int, -- School District (Secondary)/Remainder Code
  SDUNIA int, -- School District (Unified)/Remainder Code
  PUMA5A int, -- Public Use Microdata Sample Area (PUMA) Code
  BTTRA int, -- Tribal Census Tract Code
  BTBGA int, -- Tribal Block Group Code

  -- Estimates
  NAME_E varchar, -- Area Name
  ABC4E001 int, -- Total
  ABC4E002 int, -- No schooling completed
  ABC4E003 int, -- Nursery school
  ABC4E004 int, -- Kindergarten
  ABC4E005 int, -- 1st grade
  ABC4E006 int, -- 2nd grade
  ABC4E007 int, -- 3rd grade
  ABC4E008 int, -- 4th grade
  ABC4E009 int, -- 5th grade
  ABC4E010 int, -- 6th grade
  ABC4E011 int, -- 7th grade
  ABC4E012 int, -- 8th grade
  ABC4E013 int, -- 9th grade
  ABC4E014 int, -- 10th grade
  ABC4E015 int, -- 11th grade
  ABC4E016 int, -- 12th grade, no diploma
  ABC4E017 int, -- Regular high school diploma
  ABC4E018 int, -- GED or alternative credential
  ABC4E019 int, -- Some college, less than 1 year
  ABC4E020 int, -- Some college, 1 or more years, no degree
  ABC4E021 int, -- Associate's degree
  ABC4E022 int, -- Bachelor's degree
  ABC4E023 int, -- Master's degree
  ABC4E024 int, -- Professional school degree
  ABC4E025 int, -- Doctorate degree

  -- Margins of error
  NAME_M varchar, -- Area Name
  ABC4M001 int, -- Total
  ABC4M002 int, -- No schooling completed
  ABC4M003 int, -- Nursery school
  ABC4M004 int, -- Kindergarten
  ABC4M005 int, -- 1st grade
  ABC4M006 int, -- 2nd grade
  ABC4M007 int, -- 3rd grade
  ABC4M008 int, -- 4th grade
  ABC4M009 int, -- 5th grade
  ABC4M010 int, -- 6th grade
  ABC4M011 int, -- 7th grade
  ABC4M012 int, -- 8th grade
  ABC4M013 int, -- 9th grade
  ABC4M014 int, -- 10th grade
  ABC4M015 int, -- 11th grade
  ABC4M016 int, -- 12th grade, no diploma
  ABC4M017 int, -- Regular high school diploma
  ABC4M018 int, -- GED or alternative credential
  ABC4M019 int, -- Some college, less than 1 year
  ABC4M020 int, -- Some college, 1 or more years, no degree
  ABC4M021 int, -- Associate's degree
  ABC4M022 int, -- Bachelor's degree
  ABC4M023 int, -- Master's degree
  ABC4M024 int, -- Professional school degree
  ABC4M025 int, -- Doctorate degree

  DATA_SOURCE_ID integer, -- Foreign key to data_source
  DATE_LOADED timestamp WITH TIME ZONE DEFAULT now() -- when this row was loaded
);
