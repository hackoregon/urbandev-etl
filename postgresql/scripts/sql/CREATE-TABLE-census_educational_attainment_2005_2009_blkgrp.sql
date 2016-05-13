/*
 * Sex by Educational Attainment for the Population 25 Years and Over
 * 2009 American Community Survey: 5-Year Data [2005-2009]
 * Geographic level: Block Group 
 * Uses column names specified in the NHGIS codebook.
 */

CREATE TABLE census_educational_attainment_2005_2009_blkgrp (
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
  TRUSTA int, -- American Indian Area (Off-Reservation Trust Land Only)/Hawaiian Home Land Code
  RES_ONLYA int, -- American Indian Area/Alaska Native Area (Reservation or Statistical Entity Only) Code
  AITSCEA int, -- Tribal Subdivision/Remainder Code
  ANRCA int, -- Alaska Native Regional Corporation Code
  CBSAA int, -- Metropolitan Statistical Area/Micropolitan Statistical Area Code
  CSAA int, -- Combined Statistical Area Code
  METDIVA int, -- Metropolitan Division Code
  NECTAA int, -- New England City and Town Area Code
  CNECTAA int, -- Combined New England City and Town Area Code
  NECTADIVA int, -- New England City and Town Area Division Code
  UAA int, -- Urban Area Code
  CDCURRA int, -- Congressional District (2007-2013, 110th-112th Congress) Code
  SLDUA int, -- State Legislative District (Upper Chamber) Code
  SLDLA int, -- State Legislative District (Lower Chamber) Code
  SUBMCDA int, -- Subminor Civil Division Code
  SDELMA int, -- School District (Elementary)/Remainder Code
  SDSECA int, -- School District (Secondary)/Remainder Code
  SDUNIA int, -- School District (Unified)/Remainder Code
  PUMA5A int, -- Public Use Microdata Sample Area (PUMA) Code

  -- Estimates
  NAME_E varchar, -- Area Name
  RM8E001 int, -- Total
  RM8E002 int, -- Male
  RM8E003 int, -- Male int, -- No schooling completed
  RM8E004 int, -- Male int, -- Nursery to 4th grade
  RM8E005 int, -- Male int, -- 5th and 6th grade
  RM8E006 int, -- Male int, -- 7th and 8th grade
  RM8E007 int, -- Male int, -- 9th grade
  RM8E008 int, -- Male int, -- 10th grade
  RM8E009 int, -- Male int, -- 11th grade
  RM8E010 int, -- Male int, -- 12th grade, no diploma
  RM8E011 int, -- Male int, -- High school graduate, GED, or alternative
  RM8E012 int, -- Male int, -- Some college, less than 1 year
  RM8E013 int, -- Male int, -- Some college, 1 or more years, no degree
  RM8E014 int, -- Male int, -- Associate's degree
  RM8E015 int, -- Male int, -- Bachelor's degree
  RM8E016 int, -- Male int, -- Master's degree
  RM8E017 int, -- Male int, -- Professional school degree
  RM8E018 int, -- Male int, -- Doctorate degree
  RM8E019 int, -- Female
  RM8E020 int, -- Female int, -- No schooling completed
  RM8E021 int, -- Female int, -- Nursery to 4th grade
  RM8E022 int, -- Female int, -- 5th and 6th grade
  RM8E023 int, -- Female int, -- 7th and 8th grade
  RM8E024 int, -- Female int, -- 9th grade
  RM8E025 int, -- Female int, -- 10th grade
  RM8E026 int, -- Female int, -- 11th grade
  RM8E027 int, -- Female int, -- 12th grade, no diploma
  RM8E028 int, -- Female int, -- High school graduate, GED, or alternative
  RM8E029 int, -- Female int, -- Some college, less than 1 year
  RM8E030 int, -- Female int, -- Some college, 1 or more years, no degree
  RM8E031 int, -- Female int, -- Associate's degree
  RM8E032 int, -- Female int, -- Bachelor's degree
  RM8E033 int, -- Female int, -- Master's degree
  RM8E034 int, -- Female int, -- Professional school degree
  RM8E035 int, -- Female int, -- Doctorate degree

  -- Margins of error
  NAME_M varchar, -- Area Name
  RM8M001 int, -- Total
  RM8M002 int, -- Male
  RM8M003 int, -- Male int, -- No schooling completed
  RM8M004 int, -- Male int, -- Nursery to 4th grade
  RM8M005 int, -- Male int, -- 5th and 6th grade
  RM8M006 int, -- Male int, -- 7th and 8th grade
  RM8M007 int, -- Male int, -- 9th grade
  RM8M008 int, -- Male int, -- 10th grade
  RM8M009 int, -- Male int, -- 11th grade
  RM8M010 int, -- Male int, -- 12th grade, no diploma
  RM8M011 int, -- Male int, -- High school graduate, GED, or alternative
  RM8M012 int, -- Male int, -- Some college, less than 1 year
  RM8M013 int, -- Male int, -- Some college, 1 or more years, no degree
  RM8M014 int, -- Male int, -- Associate's degree
  RM8M015 int, -- Male int, -- Bachelor's degree
  RM8M016 int, -- Male int, -- Master's degree
  RM8M017 int, -- Male int, -- Professional school degree
  RM8M018 int, -- Male int, -- Doctorate degree
  RM8M019 int, -- Female
  RM8M020 int, -- Female int, -- No schooling completed
  RM8M021 int, -- Female int, -- Nursery to 4th grade
  RM8M022 int, -- Female int, -- 5th and 6th grade
  RM8M023 int, -- Female int, -- 7th and 8th grade
  RM8M024 int, -- Female int, -- 9th grade
  RM8M025 int, -- Female int, -- 10th grade
  RM8M026 int, -- Female int, -- 11th grade
  RM8M027 int, -- Female int, -- 12th grade, no diploma
  RM8M028 int, -- Female int, -- High school graduate, GED, or alternative
  RM8M029 int, -- Female int, -- Some college, less than 1 year
  RM8M030 int, -- Female int, -- Some college, 1 or more years, no degree
  RM8M031 int, -- Female int, -- Associate's degree
  RM8M032 int, -- Female int, -- Bachelor's degree
  RM8M033 int, -- Female int, -- Master's degree
  RM8M034 int, -- Female int, -- Professional school degree
  RM8M035 int, -- Female int, -- Doctorate degree
  
  DATA_SOURCE_ID integer, -- Foreign key to data_source
  DATE_LOADED timestamp WITH TIME ZONE DEFAULT now() -- when this row was loaded
);
