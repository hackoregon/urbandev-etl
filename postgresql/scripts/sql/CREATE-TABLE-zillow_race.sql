BEGIN;


CREATE TEMP TABLE blkgrp_race AS
SELECT
    gisjoin,
    '2000'::varchar AS year,
    CM1AA2000 + CM1AB2000 + CM1AC2000 + CM1AD2000 +
    CM1AE2000 + CM1AF2000 + CM1AG2000 AS total,
    CM1AA2000 AS white,
    CM1AB2000 AS black,
    CM1AC2000 AS american_indian,
    CM1AD2000 AS asian,
    CM1AE2000 AS hawaiian,
    CM1AF2000 AS other,
    CM1AG2000 AS multiple
FROM census_persons_by_race_blkgrp
UNION ALL
SELECT
    gisjoin,
    '2010'::varchar,
    -- total
    CM1AA2010 + CM1AB2010 + CM1AC2010 + CM1AD2010 +
    CM1AE2010 + CM1AF2010 + CM1AG2010,
    -- white
    CM1AA2010,
    -- black
    CM1AB2010,
    -- america indian
    CM1AC2010,
    -- asian
    CM1AD2010,
    -- hawaiian
    CM1AE2010,
    -- other
    CM1AF2010,
    -- 2 or more (multiple)
    CM1AG2010
FROM census_persons_by_race_blkgrp;


CREATE TABLE zillow_race AS
SELECT
    z.name,
    z.regionid,
    z.year,
    sum(z.intersect_pct * e.total) AS total,
    sum(z.intersect_pct * e.white) AS white,
    sum(z.intersect_pct * e.black) AS black,
    sum(z.intersect_pct * e.american_indian) AS american_indian,
    sum(z.intersect_pct * e.asian) AS asian,
    sum(z.intersect_pct * e.hawaiian) AS hawaiian,
    sum(z.intersect_pct * e.other) AS other,
    sum(z.intersect_pct * e.multiple) AS multiple
FROM zillow_blkgrps AS z
JOIN blkgrp_race AS e
    ON z.year = e.year AND z.gisjoin = e.gisjoin
GROUP BY z.name, z.regionid, z.year
ORDER BY name, year;


COMMIT;
