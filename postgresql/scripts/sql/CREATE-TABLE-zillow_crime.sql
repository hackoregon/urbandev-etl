-- add new geometry field for crime datapoints
-- in NAD 83 Oregon North HARN (EPSG:2913)
CREATE TEMP TABLE crime2913 AS
SELECT *, ST_Transform(geom, 2913) AS geom2913
FROM crime;


-- build indexes on new geometry fields
CREATE INDEX ON crime2913 USING gist (geom2913);


-- aggregate count of crime offenses for each zillow neighborhood
CREATE TEMP TABLE zillow_crime_data AS
WITH groups AS (
    -- make sure that even if data does not exist for a given
    -- group there will still be a row with a null count, by using
    -- cross product (NEIGHBORHOODS * YEARS * OFFENSE_TYPE)
    SELECT name, regionid, year, major_offense_type
    FROM (
        SELECT name, regionid
        FROM zillow_neighborhoods
        GROUP BY name, regionid
    ) AS neighborhoods, (
        SELECT to_char(report_datetime, 'YYYY') AS year
        FROM crime
        GROUP BY year
    ) AS years, (
        SELECT major_offense_type
        FROM crime
        GROUP BY major_offense_type
    ) AS offense_types
)
SELECT
    groups.name,
    groups.regionid,
    groups.year,
    groups.major_offense_type,
    z.count
FROM groups
LEFT OUTER JOIN (
    SELECT
        z.name,
        z.regionid,
        c.major_offense_type,
        to_char(report_datetime, 'YYYY') AS year,
        count(*)
    FROM zillow_neighborhoods AS z
    JOIN crime2913 AS c ON ST_Intersects(c.geom2913, z.geom)
    GROUP BY major_offense_type, name, regionid, to_char(report_datetime, 'YYYY')
) AS z ON
    groups.name = z.name AND
    groups.regionid = z.regionid AND
    groups.year = z.year AND
    groups.major_offense_type = z.major_offense_type
ORDER BY groups.name, groups.year, groups.major_offense_type;


CREATE TABLE zillow_crime AS
SELECT
    name,
    regionid,
    year,
    -- major_offense_type fields
    -- the spaces where converted to undercores 's/ /_/'
    -- and a comma was removed 's/,//'
    aggravated_assault,
    arson,
    assault_simple,
    burglary,
    curfew,
    disorderly_conduct,
    drugs,
    duii,
    embezzlement,
    forgery,
    fraud,
    gambling,
    homicide,
    kidnap,
    larceny,
    liquor_laws,
    motor_vehicle_theft,
    offenses_against_family,
    prostitution,
    rape,
    robbery,
    runaway,
    sex_offenses,
    stolen_property,
    trespass,
    vandalism,
    weapons
FROM crosstab (
    $$SELECT
        -- unique key for each crosstab row
        regionid::text || year::text AS rowkey,
        name,
        regionid::text,
        year,
        -- this field will be expaned into columns with
        -- the count as the field
        major_offense_type,
        count::int
    FROM zillow_crime_data
    ORDER BY 1$$,
    -- columns
    $$SELECT DISTINCT major_offense_type
    FROM zillow_crime_data
    ORDER BY 1$$
) crosstab_row (
    rowkey text,
    name text,
    regionid text,
    year text,
    -- these fields must be in the same order as when running the query
    -- 'SELECT DISTINCT major_offense_type FROM ... ORDER BY 1'
    aggravated_assault int,
    arson int,
    assault_simple int,
    burglary int,
    curfew int,
    disorderly_conduct int,
    drugs int,
    duii int,
    embezzlement int,
    forgery int,
    fraud int,
    gambling int,
    homicide int,
    kidnap int,
    larceny int,
    liquor_laws int,
    motor_vehicle_theft int,
    offenses_against_family int,
    prostitution int,
    rape int,
    robbery int,
    runaway int,
    sex_offenses int,
    stolen_property int,
    trespass int,
    vandalism int,
    weapons int
)
ORDER BY regionid, year;
