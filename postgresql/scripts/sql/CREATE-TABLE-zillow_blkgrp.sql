-- Compute percentage of block group in each zillow neighborhood
-- across multiple years


/*
Example:


Block Group 1 (BLKGRP 1) has twice as much area in Neighborhood 1 (NBO 1)
than it does Neighborhood 2 (NBO 2). When a value for BLKGRP 1 is provided
in census data (such as total population of that block group), this value
needs to be shared between NBO 1 and NBO 2.

In this case if, if BLKGRP 1 had a population of 100 people, we can interpolate
that 67 (2/3) live in NBO 1 and that 33 (1/3) live in NBO 2.
     ________________________________________________
    |                           |                    |
    |   NBO 1                   |   NBO 2            |
    |       ____________________|__________          |
    |      |                    |          |         |
    |      |  BLKGRP 1          |          |         |
    |      |                    |          |         |
    |      |____________________|__________|         |
    |                           |                    |
    |                           |                    |
    |___________________________|____________________|

The rows for BLKGRP 1 in a simplified zillow_blkgrps table will look like...

neighborhood    blkgrp  intersect_pct
------------    ------  -------------
1               1       0.66666667
2               1       0.33333333

This table will be joined with the census data, and each census value will
be multiplied by intersect_pct. You will then be abled to sum the values
while grouping on neighborhood.

                area of intersection between NBO 1 and BLKGRP 1
intersect_pct = -----------------------------------------------
                            total area of BLKGRP 1

*/




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
