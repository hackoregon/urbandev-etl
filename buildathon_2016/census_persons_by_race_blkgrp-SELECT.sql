# Race population by neighborhood

SELECT
   name,
   regionid,
   sum(intersect_pct * cm1aa2000)::integer AS white_pop_2000,
   sum(intersect_pct * cm1aa2010)::integer AS white_pop_2010,
   sum(intersect_pct * cm1ab2000)::integer AS black_pop_2000,
   sum(intersect_pct * cm1ab2010)::integer AS black_pop_2010,
   sum(intersect_pct * cm1ac2000)::integer AS amerindian_alaskan_pop_2000,
   sum(intersect_pct * cm1ac2010)::integer AS amerindian_alaskan_pop_2010,
   sum(intersect_pct * cm1ad2000)::integer AS asian_pop_2000,
   sum(intersect_pct * cm1ad2010)::integer AS asian_pop_2010,
   sum(intersect_pct * cm1ae2000)::integer AS hawaiian_pacific_islander_pop_2000,
   sum(intersect_pct * cm1ae2010)::integer AS hawaiian_pacific_islander_pop_2010,
   sum(intersect_pct * cm1af2000)::integer AS other_pop_2000,
   sum(intersect_pct * cm1af2010)::integer AS other_pop_2010,
   sum(intersect_pct * cm1ag2000)::integer AS two_or_more_race_2000,
   sum(intersect_pct * cm1ag2010)::integer AS two_or_more_race_2010

FROM nbo_blocks AS nbo
JOIN census_persons_by_race_blkgrp AS c ON nbo.gisjoin = c.gisjoin
GROUP by name, regionid
ORDER BY name;