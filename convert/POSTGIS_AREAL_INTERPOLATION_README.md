Compute percent of block groups in each zillow neighborhood
===========================================================

Starting with the shapefiles in `urbandev-etl/convert/data`
+ `pdx-2010-census-blockgroups.shp`
+ `zillow-neighborhoods.shp`


Both were reprojected into EPSG:2913 in QGIS and exported as shapefiles


The shapefiles were loaded into a PostgreSQL/PostGIS instance
```
# shp2pgsql -I -s 2913 <shapefile> <tablename> | psql -d <database>
shp2pgsql -I -s 2913 nbo nbo | psql -d urbandev
shp2pgsql -I -s 2913 blocks blocks | psql -d urbandev
```

important nbo fields:
+ name
+ regionid
+ geometry


important blocks fields:
+ gisjoin
+ geometry


Perform calculation
```
CREATE TABLE nbo_blocks AS
SELECT
    nbo.name,
    nbo.regionid,
    blocks.gisjoin,
    --blocks.geom AS blocks_geom,
    --nbo.geom AS nbo_geom,
    ST_Area(ST_Intersection(nbo.geom, blocks.geom)) /
    ST_Area(blocks.geom) AS intersect_pct
FROM nbo_valid AS nbo
JOIN blocks_valid AS blocks ON ST_Intersects(nbo.geom, blocks.geom)
ORDER BY blocks.gisjoin, nbo.name;
```

Make sql dump
```
pg_dump -f CREATE-TABLE-nbo_blocks.sql -t nbo_blocks <database>
```

Example query to join to census table and aggregate by neighborhood 
```
SELECT
    name,
    regionid,
    sum(intersect_pct * cl8aa2000) AS total_pop
FROM nbo_blocks AS nbo
JOIN census_total_population_blkgrp AS c ON nbo.gisjoin = c.gisjoin
GROUP by name, regionid
ORDER BY name;
```
