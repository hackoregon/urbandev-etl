-- Time series layout:     Time varies by column
-- Geographic level:       Census Tract (by State--County)
-- Geographic integration: Nominal
-- Measurement times:      1970, 1980, 1990, 2000, 2010, 2008-2012

CREATE TABLE census_total_population (
    id SERIAL PRIMARY KEY, -- uuid generated automatically by the database.

    NHGISCODE varchar,
    GJOIN1970 varchar,
    GJOIN1980 varchar,
    GJOIN1990 varchar,
    GJOIN2000 varchar,
    GJOIN2010 varchar,
    GJOIN2012 varchar,

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
    NAME2012 varchar,

    AV0AA1970 int,
    AV0AA1980 int,
    AV0AA1990 int,
    AV0AA2000 int,
    AV0AA2010 int,
    AV0AA125 int,
    AV0AA125M int,
    DATA_SOURCE_ID integer, -- Foreign key to data_source
    DATE_LOADED timestamp WITH TIME ZONE DEFAULT now() -- when this row was loaded
);
