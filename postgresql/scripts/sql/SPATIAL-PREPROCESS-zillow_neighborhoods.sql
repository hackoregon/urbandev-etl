-- keep only Portland Metro neighborhoods
DELETE FROM zillow_neighborhoods
WHERE city IN ('Eugene', 'Salem');


-- make sure geometries are valid
UPDATE zillow_neighborhoods SET geom = ST_MakeValid(geom)
WHERE ST_IsValid(geom) = 'f';



-- add additional geometry columns that will be populated through
-- UPDATE statements
ALTER TABLE zillow_neighborhoods ADD COLUMN geom_no_streampark geometry;
ALTER TABLE zillow_neighborhoods ADD COLUMN geom4326 geometry;


WITH zillow_nopark AS (
    -- take difference from neighborhoods and open spaces dataset
    SELECT
        zillow.regionid, zillow.name,
        CASE WHEN ST_Difference(zillow.geom, ST_Union(orca.geom)) IS NULL
            THEN zillow.geom
            ELSE ST_MakeValid(ST_Difference(zillow.geom, ST_Union(orca.geom)))
        END AS geom
    FROM zillow_neighborhoods AS zillow
    LEFT OUTER JOIN orca ON ST_Intersects(orca.geom, zillow.geom)
    GROUP BY zillow.regionid, zillow.name, zillow.geom
), zillow_nostream AS (
    -- take difference from neighborhoods and streams dataset
    SELECT
        zillow.regionid, zillow.name,
        CASE WHEN ST_Difference(zillow.geom, ST_Union(stm_fill.geom)) IS NULL
            THEN zillow.geom
            ELSE ST_MakeValid(ST_Difference(zillow.geom, ST_Union(stm_fill.geom)))
        END AS geom
    FROM zillow_neighborhoods AS zillow
    LEFT OUTER JOIN stm_fill ON ST_Intersects(stm_fill.geom, zillow.geom)
    GROUP BY zillow.regionid, zillow.name, zillow.geom
)
-- update field by taking intersection between no-streams and no-parks neighborhoods
UPDATE zillow_neighborhoods AS zillow
SET geom_no_streampark = ST_MakeValid(ST_Intersection(nostream.geom, nopark.geom))
FROM zillow_nopark AS nopark, zillow_nostream AS nostream
WHERE
    zillow.regionid = nopark.regionid AND
    zillow.regionid = nostream.regionid;


-- update and reproject geometry for web mapping
UPDATE zillow_neighborhoods SET geom4326 = ST_Transform(geom, 4326);


-- create spatial indexes on new geometry fields
CREATE INDEX ON zillow_neighborhoods USING gist (geom_no_streampark);
CREATE INDEX ON zillow_neighborhoods USING gist (geom4326);
