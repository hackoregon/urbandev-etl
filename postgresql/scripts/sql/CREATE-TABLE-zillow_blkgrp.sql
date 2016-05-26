-- Compute percentage of block group in each zillow neighborhood
-- across multiple years


CREATE TABLE zillow_blkgrps AS
SELECT
    z.name, z.regionid, '1990'::varchar AS year, c.gisjoin,
    ST_Area(ST_Intersection(z.geom, c.geom)) /
    ST_Area(c.geom) AS intersect_pct
FROM zillow_neighborhoods AS z
JOIN OR_blck_grp_1990 AS c ON ST_Intersects(z.geom, c.geom)
UNION
SELECT
    z.name, z.regionid, '2000'::varchar AS year, c.gisjoin,
    ST_Area(ST_Intersection(z.geom, c.geom)) /
    ST_Area(c.geom) AS intersect_pct
FROM zillow_neighborhoods AS z
JOIN OR_blck_grp_2000 AS c ON ST_Intersects(z.geom, c.geom)
UNION
SELECT
    z.name, z.regionid, '2009'::varchar AS year, c.gisjoin,
    ST_Area(ST_Intersection(z.geom, c.geom)) /
    ST_Area(c.geom) AS intersect_pct
FROM zillow_neighborhoods AS z
JOIN OR_blck_grp09_2000 c ON ST_Intersects(z.geom, c.geom)
UNION
SELECT
    z.name, z.regionid, '2010'::varchar AS year, c.gisjoin,
    ST_Area(ST_Intersection(z.geom, c.geom)) /
    ST_Area(c.geom) AS intersect_pct
FROM zillow_neighborhoods AS z
JOIN OR_blck_grp_2010 AS c ON ST_Intersects(z.geom, c.geom)
UNION
SELECT
    z.name, z.regionid, '2014'::varchar AS year, c.gisjoin,
    ST_Area(ST_Intersection(z.geom, c.geom)) /
    ST_Area(c.geom) AS intersect_pct
FROM zillow_neighborhoods AS z
JOIN OR_blck_grp_2014 c ON ST_Intersects(z.geom, c.geom);

