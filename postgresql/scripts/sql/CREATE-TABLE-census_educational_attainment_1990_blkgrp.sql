/*
 * Persons 25 Years and Over by Educational Attainment.
 * 1990 Census: STF 3 - Sample-Based Data
 * Geographic level: Block Group 
 * Uses column names specified in the NHGIS codebook.
 */

CREATE TABLE census_educational_attainment_1990_blkgrp (
	ID SERIAL PRIMARY KEY, -- uuid generated automatically.
  GISJOIN varchar(16), -- GIS Join Match Code
  YEAR int, -- Data File Year
  ANRCA varchar, -- Alaska Native Regional Corporation Code
  RES_ONLYA varchar, -- American Indian Reservation [excluding trust lands] Code
  TRUSTA varchar, -- American Indian Reservation [trust lands only] Code
  AIANHHA varchar, -- American Indian Area/Alaska Native Area/Hawaiian Home Land Code
  RES_TRSTA varchar, -- Reservation/Trust Lands Code
  BLCK_GRPA int, -- Block Group Code
  TRACTA int, -- Census Tract Code
  CDA varchar, -- Congressional District (101st) Code
  C_CITYA varchar, -- Consolidated City Code
  COUNTY varchar, -- County Name
  COUNTYA int, -- County Code
  CTY_SUBA int, -- County Subdivision Code
  DIVISIONA int, -- Division Code
  MSA_CMSAA int, -- Metropolitan Statistical Area/Consolidated Metropolitan Statistical Area Code
  PLACEA int, -- Place Code
  PMSAA int, -- Primary Metropolitan Statistical Area Code
  REGIONA int, -- Region Code
  STATE varchar, -- State Name
  STATEA int, -- State Code
  URBRURALA int, -- Urban/Rural Code
  URB_AREAA int, -- Urban Area Code
  ZIPA varchar, -- 5-Digit ZIP Code Code
  CD103A int, -- Congressional District (103rd) Code
  ANPSADPI varchar, -- Area Name/PSAD Term/Part Indicator
  E33001 int, -- Less than 9th grade
  E33002 int, -- 9th to 12th grade, no diploma
  E33003 int, -- High school graduate (includes equivalency)
  E33004 int, -- Some college, no degree
  E33005 int, -- Associate degree
  E33006 int, -- Bachelor's degree
  E33007 int, -- Graduate or professional degree
	DATA_SOURCE_ID integer, -- Foreign key to data_source
	DATE_LOADED timestamp WITH TIME ZONE DEFAULT now() -- when this row was loaded
);
