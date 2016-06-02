/*
Create `blkgrps` table. This will be a combination of multiple
Oregon block group shapefiles sourced for NHGIS for many different
years (1990, 2000, 2009, 2010, 2014)

The `blkgrps` table will have multiple geometry fields
+   geom: field will be in NAD 83 Oregon North (EPSG:2913)
+   geom_no_streampark: streams and parks removed for pct neighborhood analysis
+   geom4326: reprojected into WGS 84 for web maps

*/

-- blkgrps that intersect with the zillow neighborhoods
-- union multiple years together into one table
CREATE TABLE blkgrps AS
SELECT blk.gisjoin, min(blk.geom)::geometry AS geom, '1990'::text AS year
FROM OR_blck_grp_1990 AS blk
JOIN zillow_neighborhoods AS z ON ST_Intersects(blk.geom, z.geom)
GROUP BY gisjoin, year
UNION
SELECT blk.gisjoin, min(blk.geom)::geometry AS geom, '2000'::text AS year
FROM OR_blck_grp_2000 AS blk
JOIN zillow_neighborhoods AS z ON ST_Intersects(blk.geom, z.geom)
GROUP BY gisjoin, year
UNION
SELECT blk.gisjoin, min(blk.geom)::geometry AS geom, '2009'::text AS year
FROM OR_blck_grp09_2000 AS blk
JOIN zillow_neighborhoods AS z ON ST_Intersects(blk.geom, z.geom)
GROUP BY gisjoin, year
UNION
SELECT blk.gisjoin, min(blk.geom)::geometry AS geom, '2010'::text AS year
FROM OR_blck_grp_2010 AS blk
JOIN zillow_neighborhoods AS z ON ST_Intersects(blk.geom, z.geom)
GROUP BY gisjoin, year
UNION
SELECT blk.gisjoin, min(blk.geom)::geometry AS geom, '2014'::text AS year
FROM OR_blck_grp_2014 AS blk
JOIN zillow_neighborhoods AS z ON ST_Intersects(blk.geom, z.geom)
GROUP BY gisjoin, year;


CREATE INDEX ON blkgrps USING gist (geom);


-- make sure geometries are valid
UPDATE blkgrps SET geom = ST_MakeValid(geom)
WHERE ST_IsValid(geom) = 'f';


-- add additional geometry columns that will be populated through
-- UPDATE statements
ALTER TABLE blkgrps ADD COLUMN geom_no_streampark geometry;
ALTER TABLE blkgrps ADD COLUMN geom4326 geometry;


-- update `geom_no_streampark` field by removing parks and streams
-- this will make the areal interpolation (percentage of blkgrp in
-- each zillow neighborhood) a little more accurate
WITH blkgrp_nopark AS (
    -- take difference from blkgrp and open spaces dataset
    SELECT
        blk.gisjoin, blk.year,
        CASE WHEN ST_Difference(blk.geom, ST_Union(orca.geom)) IS NULL
            THEN blk.geom
            ELSE ST_MakeValid(ST_Difference(blk.geom, ST_Union(orca.geom)))
        END AS geom
    FROM blkgrps AS blk
    LEFT OUTER JOIN orca ON ST_Intersects(orca.geom, blk.geom)
    GROUP BY blk.gisjoin, blk.year, blk.geom
), blkgrp_nostream AS (
    -- take difference from blkgrp and streams dataset
    SELECT
        blk.gisjoin, blk.year,
        CASE WHEN ST_Difference(blk.geom, ST_Union(stm_fill.geom)) IS NULL
            THEN blk.geom
            ELSE ST_MakeValid(ST_Difference(blk.geom, ST_Union(stm_fill.geom)))
        END AS geom
    FROM blkgrps AS blk
    LEFT OUTER JOIN stm_fill ON ST_Intersects(stm_fill.geom, blk.geom)
    GROUP BY blk.gisjoin, blk.year, blk.geom
)
-- update field by taking intersection between no-streams and no-parks blkgrps
UPDATE blkgrps AS blk
SET geom_no_streampark = ST_MakeValid(ST_Intersection(nostream.geom, nopark.geom))
FROM
    blkgrp_nopark AS nopark,
    blkgrp_nostream AS nostream
WHERE
    blk.gisjoin = nopark.gisjoin AND
    blk.year = nopark.year AND
    blk.gisjoin = nostream.gisjoin AND
    blk.year = nostream.year;


-- update and reproject geometry for web mapping
UPDATE blkgrps SET geom4326 = ST_Transform(geom, 4326);


-- create spatial indexes on new geometry fields
CREATE INDEX ON blkgrps USING gist (geom_no_streampark);
CREATE INDEX ON blkgrps USING gist (geom4326);
