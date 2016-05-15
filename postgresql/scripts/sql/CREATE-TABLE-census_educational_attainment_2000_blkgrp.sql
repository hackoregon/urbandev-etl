/*
 * Persons 25 Years and Over by Educational Attainment.
 * 2000 Census: SF 3b - Sample-Based Data
 * Geographic level: Block Group 
 * Uses column names specified in the NHGIS codebook.
 */

CREATE TABLE census_educational_attainment_2000_blkgrp (
  ID SERIAL PRIMARY KEY, -- uuid generated automatically.

  -- Context Fields
  GISJOIN varchar, -- GIS Join Match Code
  YEAR int, -- Data File Year
  STATE varchar, -- State Name
  STATEA int, -- State Code
  COUNTY varchar, -- County Name
  COUNTYA int, -- County Code
  CTY_SUBA int, -- County Subdivision Code
  PLACEA int, -- Place Code
  TRACTA int, -- Census Tract Code
  BLCK_GRPA int, -- Block Group Code
  AIANHHA int, -- American Indian Area/Alaska Native Area/Hawaiian Home Land Code
  URBRURALA int, -- Urban/Rural Code
  NAME varchar, -- Area Name-Legal/Statistical Area Description (LSAD) Term-Part Indicator

  -- Population 25 Years and Over by Sex by Educational Attainment
  HD1001 int, -- Male >> No schooling completed
  HD1002 int, -- Male >> Nursery to 4th grade
  HD1003 int, -- Male >> 5th and 6th grade
  HD1004 int, -- Male >> 7th and 8th grade
  HD1005 int, -- Male >> 9th grade
  HD1006 int, -- Male >> 10th grade
  HD1007 int, -- Male >> 11th grade
  HD1008 int, -- Male >> 12th grade, no diploma
  HD1009 int, -- Male >> High school graduate (includes equivalency)
  HD1010 int, -- Male >> Some college, less than 1 year
  HD1011 int, -- Male >> Some college, 1 or more years, no degree
  HD1012 int, -- Male >> Associate degree
  HD1013 int, -- Male >> Bachelor's degree
  HD1014 int, -- Male >> Master's degree
  HD1015 int, -- Male >> Professional school degree
  HD1016 int, -- Male >> Doctorate degree
  HD1017 int, -- Female >> No schooling completed
  HD1018 int, -- Female >> Nursery to 4th grade
  HD1019 int, -- Female >> 5th and 6th grade
  HD1020 int, -- Female >> 7th and 8th grade
  HD1021 int, -- Female >> 9th grade
  HD1022 int, -- Female >> 10th grade
  HD1023 int, -- Female >> 11th grade
  HD1024 int, -- Female >> 12th grade, no diploma
  HD1025 int, -- Female >> High school graduate (includes equivalency)
  HD1026 int, -- Female >> Some college, less than 1 year
  HD1027 int, -- Female >> Some college, 1 or more years, no degree
  HD1028 int, -- Female >> Associate degree
  HD1029 int, -- Female >> Bachelor's degree
  HD1030 int, -- Female >> Master's degree
  HD1031 int, -- Female >> Professional school degree
  HD1032 int, -- Female >> Doctorate degree

  DATA_SOURCE_ID integer, -- Foreign key to data_source
  DATE_LOADED timestamp WITH TIME ZONE DEFAULT now() -- when this row was loaded
);
