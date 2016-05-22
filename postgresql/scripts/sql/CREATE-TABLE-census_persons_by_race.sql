-- Time series layout:     Time varies by column
-- Geographic level:       Census Tract (by State--County)
-- Geographic integration: Nominal
-- Years:                  1970, 1980, 1990, 2000, 2010

CREATE TABLE census_persons_by_race (

    id SERIAL PRIMARY KEY, -- uuid generated automatically by the database.
    NHGISCODE varchar,
    GJOIN1970 varchar,
    GJOIN1980 varchar,
    GJOIN1990 varchar,
    GJOIN2000 varchar,
    GJOIN2010 varchar,
    STATE varchar,
    STATEFP varchar,
    STATENH varchar,
    COUNTY varchar,
    COUNTYFP varchar,
    COUNTYNH varchar,
    TRACTA varchar,
    NAME1970 varchar,
    NAME1980 varchar,
    NAME1990 varchar,
    NAME2000 varchar,
    NAME2010 varchar,

    B18AA1970 int,
    B18AA1980 int,
    B18AA1990 int,
    B18AA2000 int,
    B18AA2010 int,
    B18AB1970 int,
    B18AB1980 int,
    B18AB1990 int,
    B18AB2000 int,
    B18AB2010 int,
    B18AC1970 int,
    B18AC1980 int,
    B18AC1990 int,
    B18AC2000 int,
    B18AC2010 int,
    B18AD1970 int,
    B18AD1980 int,
    B18AD1990 int,
    B18AD2000 int,
    B18AD2010 int,
    B18AE2000 int,
    B18AE2010 int,

    DATA_SOURCE_ID integer, -- Foreign key to data_source
    DATE_LOADED timestamp WITH TIME ZONE DEFAULT now() -- when this row was loaded
);
