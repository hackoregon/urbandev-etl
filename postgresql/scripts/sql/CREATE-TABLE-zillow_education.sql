BEGIN;


CREATE TEMP TABLE blkgrp_education AS
SELECT
    gisjoin,
    '1990'::varchar AS year,
    E33001 + E33002 + E33003 + E33004 + E33005 + E33006 + E33007 AS total,
    E33001 + E33002 AS no_diploma,
    E33003 AS diploma,
    E33004 + E33005 AS some_college,
    E33006 AS bachelor,
    E33007 AS advanced
FROM census_educational_attainment_1990_blkgrp
UNION ALL
SELECT
    gisjoin,
    '2000'::varchar,
    -- total
    HD1001 + HD1017 + HD1002 + HD1018 + HD1003 + HD1019 + HD1004 + HD1020 +
    HD1005 + HD1021 + HD1006 + HD1022 + HD1007 + HD1023 + HD1008 + HD1024 +
    HD1009 + HD1025 + HD1010 + HD1026 + HD1011 + HD1027 + HD1012 + HD1028 +
    HD1013 + HD1029 + HD1014 + HD1030 + HD1015 + HD1031 + HD1016 + HD1032,
    -- no diploma
    HD1001 + HD1017 + HD1002 + HD1018 + HD1003 + HD1019 +
    HD1004 + HD1020 + HD1005 + HD1021 + HD1006 + HD1022 +
    HD1007 + HD1023 + HD1008 + HD1024,
    -- highschool diploma
    HD1009 + HD1025,
    -- some college
    HD1010 + HD1026 + HD1011 + HD1027 + HD1012 + HD1028,
    -- bachelor
    HD1013 + HD1029,
    -- advanced degree
    HD1014 + HD1030 + HD1015 + HD1031 + HD1016 + HD1032
FROM census_educational_attainment_2000_blkgrp
UNION ALL
SELECT
    gisjoin,
    '2009'::varchar,
    -- total
    RM8E001,
    -- no diploma
    RM8E003 + RM8E020 + RM8E004 + RM8E021 + RM8E005 + RM8E022 +
    RM8E006 + RM8E023 + RM8E007 + RM8E024 + RM8E008 + RM8E025 +
    RM8E009 + RM8E026 + RM8E010 + RM8E027,
    -- diploma
    RM8E011 + RM8E028,
    RM8E012 + RM8E029 + RM8E013 + RM8E030 +
    -- some college
    RM8E014 + RM8E031,
    -- bachelor
    RM8E015 + RM8E032,
    -- advanced degree
    RM8E016 + RM8E033 + RM8E017 + RM8E034 +
    RM8E018 + RM8E035
FROM acs_educational_attainment_2005_2009_blkgrp
UNION ALL
SELECT
    gisjoin,
    '2014'::varchar AS year,
    -- total
    ABC4E001,
    -- no diploma
    ABC4E002 + ABC4E003 + ABC4E004 + ABC4E005 + ABC4E006 +
    ABC4E007 + ABC4E008 + ABC4E009 + ABC4E010 + ABC4E011 +
    ABC4E012 + ABC4E013 + ABC4E014 + ABC4E015 + ABC4E016,
    -- diploma
    ABC4E017 + ABC4E018,
    -- some college
    ABC4E019 + ABC4E020 + ABC4E021,
    -- bachelor
    ABC4E022,
    -- advanced degree
    ABC4E023 + ABC4E024 + ABC4E025
FROM acs_educational_attainment_2010_2014_blkgrp;


CREATE TABLE zillow_education AS
SELECT
    z.name,
    z.regionid,
    z.year,
    sum(z.intersect_pct * e.total) AS total,
    sum(z.intersect_pct * e.no_diploma) AS no_diploma,
    sum(z.intersect_pct * e.diploma) AS diploma,
    sum(z.intersect_pct * e.some_college) AS some_college,
    sum(z.intersect_pct * e.bachelor) AS bachelor,
    sum(z.intersect_pct * e.advanced) AS advanced
FROM zillow_blkgrps AS z
JOIN blkgrp_education AS e
    ON z.year = e.year AND z.gisjoin = e.gisjoin
GROUP BY z.name, z.regionid, z.year
ORDER BY name, year;


COMMIT;
