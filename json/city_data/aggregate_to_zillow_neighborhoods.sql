DROP TABLE IF EXISTS zillow_neighborhoods_crime_violent;
CREATE TEMP TABLE zillow_neighborhoods_crime_violent AS
WITH groups AS (
    -- make sure that even if data does not exist for a given
    -- group there will still be a row with a null count, by using
    -- cross product (NEIGHBORHOODS * YEARS * VIOLENT/NON-VIOLENT)
    SELECT name, regionid, year, violent
    FROM (
        SELECT name, regionid
        FROM zillow_neighborhoods
        GROUP BY name, regionid
    ) AS neighborhoods, (
        SELECT to_char(report_datetime, 'YYYY') AS year
        FROM crime
        GROUP BY year
    ) AS years, (
        SELECT violent
        FROM crime
        GROUP BY violent
    ) AS violent_groups
)
SELECT
    groups.name,
    groups.regionid,
    groups.year,
    groups.violent,
    z.count
FROM groups
LEFT OUTER JOIN (
    SELECT
        z.name,
        z.regionid,
        to_char(report_datetime, 'YYYY') AS year,
        c.violent,
        count(*)
    FROM zillow_neighborhoods AS z
    JOIN crime AS c ON ST_Intersects(ST_Transform(c.geom, 2913), z.geom)
    GROUP BY violent, name, regionid, to_char(report_datetime, 'YYYY')
) AS z ON
    groups.name = z.name AND
    groups.regionid = z.regionid AND
    groups.year = z.year AND
    groups.violent = z.violent
ORDER BY groups.name, groups.year, groups.violent;


DROP TABLE IF EXISTS zillow_neighborhoods_crime_offense;
CREATE TEMP TABLE zillow_neighborhoods_crime_offense AS
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
    JOIN crime AS c ON ST_Intersects(ST_Transform(c.geom, 2913), z.geom)
    GROUP BY major_offense_type, name, regionid, to_char(report_datetime, 'YYYY')
) AS z ON
    groups.name = z.name AND
    groups.regionid = z.regionid AND
    groups.year = z.year AND
    groups.major_offense_type = z.major_offense_type
ORDER BY groups.name, groups.year, groups.major_offense_type;


DROP TABLE IF EXISTS zillow_neighborhoods_demolitions;
CREATE TEMP TABLE zillow_neighborhoods_demolitions AS
WITH groups AS (
    -- make sure that even if data does not exist for a given
    -- group there will still be a row with a null count, by using
    -- cross product (NEIGHBORHOODS * YEARS)
    SELECT name, regionid, year
    FROM (
        SELECT name, regionid
        FROM zillow_neighborhoods
        GROUP BY name, regionid
    ) AS neighborhoods, (
        SELECT to_char(demolition_date, 'YYYY') AS year
        FROM demolitions
        GROUP BY year
    ) AS years
)
SELECT
    groups.name,
    groups.regionid,
    groups.year,
    z.count
FROM groups
LEFT OUTER JOIN (
    SELECT
        z.name,
        z.regionid,
        to_char(c.demolition_date, 'YYYY') AS year,
        count(*)
    FROM zillow_neighborhoods AS z
    JOIN demolitions AS c ON ST_Intersects(ST_Transform(c.geom, 2913), z.geom)
    GROUP BY name, regionid, to_char(demolition_date, 'YYYY')
) AS z ON
    groups.name = z.name AND
    groups.regionid = z.regionid AND
    groups.year = z.year
ORDER BY groups.name, groups.year;


-- write to csv
\copy (SELECT * FROM zillow_neighborhoods_crime_violent) TO zillow_neighborhoods_crime_violent.csv CSV HEADER
\copy (SELECT * FROM zillow_neighborhoods_crime_offense) TO zillow_neighborhoods_crime_offense.csv CSV HEADER
\copy (SELECT * FROM zillow_neighborhoods_demolitions) TO zillow_neighborhoods_demolitions.csv CSV HEADER
