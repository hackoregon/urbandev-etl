BEGIN;


CREATE TEMP TABLE blkgrp_income AS
SELECT
    gisjoin,
    '2009'::varchar AS year,
    RNGE001 AS total,
    RNGE002 AS income_less_10000,
    RNGE003 + RNGE004 AS income_10000_19999,
    RNGE005 + RNGE006 AS income_20000_29999,
    RNGE007 + RNGE008 AS income_30000_39999,
    RNGE009 + RNGE010 AS income_40000_49999,
    RNGE011 AS income_50000_59999,
    RNGE012 AS income_60000_74999,
    RNGE013 AS income_75000_99999,
    RNGE014 + RNGE015 + RNGE016 AS income_100000_199999,
    RNGE017 AS income_200000_more
FROM acs_household_income_2009_blkgrp
UNION ALL
SELECT
    gisjoin,
    '2014'::varchar AS year,
    -- total
    ABDOE001,
    -- less $10000
    ABDOE002,
    -- $10000 - $19999
    ABDOE003 + ABDOE004,
    -- $20000 - $29999
    ABDOE005 + ABDOE006,
    -- $30000 - $39999
    ABDOE007 + ABDOE008,
    -- $40000 - $49999
    ABDOE009 + ABDOE010,
    -- $50000 - $59999
    ABDOE011,
    -- $60000 - $74999
    ABDOE012,
    -- $75000 - $99999
    ABDOE013,
    -- $100000 - $199999
    ABDOE014 + ABDOE015 + ABDOE016,
    -- $200000 more
    ABDOE017
FROM acs_household_income_2014_blkgrp;


CREATE TABLE zillow_income AS
SELECT
    z.name,
    z.regionid,
    z.year,
    sum(z.intersect_pct * e.total) AS total,
    sum(z.intersect_pct * e.income_less_10000) AS income_less_10000,
    sum(z.intersect_pct * e.income_10000_19999) AS income_10000_19999,
    sum(z.intersect_pct * e.income_20000_29999) AS income_20000_29999,
    sum(z.intersect_pct * e.income_30000_39999) AS income_30000_39999,
    sum(z.intersect_pct * e.income_40000_49999) AS income_40000_49999,
    sum(z.intersect_pct * e.income_50000_59999) AS income_50000_59999,
    sum(z.intersect_pct * e.income_60000_74999) AS income_60000_74999,
    sum(z.intersect_pct * e.income_75000_99999) AS income_75000_99999,
    sum(z.intersect_pct * e.income_100000_199999) AS income_100000_199999,
    sum(z.intersect_pct * e.income_200000_more) AS income_200000_more
FROM zillow_blkgrps AS z
JOIN blkgrp_income AS e
    ON z.year = e.year AND z.gisjoin = e.gisjoin
GROUP BY z.name, z.regionid, z.year
ORDER BY name, year;


COMMIT;
