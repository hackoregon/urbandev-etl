-- add new geometry field for crime, demolitions and permit datapoints
-- in NAD 83 Oregon North HARN (EPSG:2913)
CREATE TEMP TABLE crime2913 AS
SELECT *, ST_Transform(geom, 2913) AS geom2913
FROM crime;


-- build indexes on new geometry fields
CREATE INDEX ON crime2913 USING gist (geom2913);


-- aggregate count of violent crime offenses for each zillow neighborhood
CREATE TEMP TABLE zillow_violent_crime_data AS
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
    JOIN crime2913 AS c ON ST_Intersects(geom2913, z.geom)
    GROUP BY violent, name, regionid, to_char(report_datetime, 'YYYY')
) AS z ON
    groups.name = z.name AND
    groups.regionid = z.regionid AND
    groups.year = z.year AND
    groups.violent = z.violent
ORDER BY groups.name, groups.year, groups.violent;


CREATE TABLE zillow_violent_crime AS
SELECT name, regionid, year, nonviolent, violent
FROM crosstab (
    $$SELECT
        -- unique key for each crosstab row
        regionid::text || year::text AS rowkey,
        name,
        regionid::text,
        year,
        -- this field will be expaned into columns with
        -- the count as the field
        violent,
        count::int
    FROM zillow_violent_crime_data
    ORDER BY 1$$,
    -- field 'nonviolent' and 'violent'
    $$SELECT DISTINCT violent
    FROM zillow_violent_crime_data
    -- when 'violent' field is sorted ..
    -- 'f' is first (nonviolent)
    -- 't' is second (violent)
    ORDER BY 1$$
) AS crosstab_row (
    rowkey text,
    name text,
    regionid text,
    year text,
    nonviolent int,
    violent int
)
ORDER BY regionid, year;
