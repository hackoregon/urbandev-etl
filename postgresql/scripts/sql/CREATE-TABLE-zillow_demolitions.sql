-- add new geometry field for crime, demolitions and permit datapoints
-- in NAD 83 Oregon North HARN (EPSG:2913)
CREATE TEMP TABLE demolitions2913 AS
SELECT *, ST_Transform(geom, 2913) AS geom2913
FROM demolitions;


-- build indexes on new geometry fields
CREATE INDEX ON demolitions2913 USING gist (geom2913);


-- aggregate count of demolitions for each zillow neighborhood
CREATE TEMP TABLE zillow_demolitions_data AS
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
    JOIN demolitions2913 AS c ON ST_Intersects(c.geom2913, z.geom)
    GROUP BY name, regionid, to_char(demolition_date, 'YYYY')
) AS z ON
    groups.name = z.name AND
    groups.regionid = z.regionid AND
    groups.year = z.year
ORDER BY groups.name, groups.year;


CREATE TABLE zillow_demolitions AS
SELECT name, regionid, year, count AS demolitions
FROM zillow_demolitions_data
ORDER BY regionid, year;
