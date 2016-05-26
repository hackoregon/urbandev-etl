-- U.S. Census Persons by Race 2000, 2010 by Zillow Region with category
-- values given as a percentage of the total population.
-- The race categories and values come from the U.S. Decennial Census
-- aggregated by Block Groups. The numbers given here for
-- Zillow Regions are estimated by calculating the percentage overlap of
-- area covered by the Block Groups intersecting the Regions.
SELECT
   name as region,
   regionid,
   2000 as year_2000,
   round(((sum(intersect_pct * cm1aa2000) 
     / (sum(intersect_pct * (cm1aa2000 + cm1ab2000 + cm1ac2000 + cm1ad2000 + cm1ae2000 + cm1af2000 + cm1ag2000))))
     * 100.0)::numeric, 2) AS white,
   round(((sum(intersect_pct * cm1ab2000) 
     / (sum(intersect_pct * (cm1aa2000 + cm1ab2000 + cm1ac2000 + cm1ad2000 + cm1ae2000 + cm1af2000 + cm1ag2000))))
     * 100.0)::numeric, 2) AS black,
   round(((sum(intersect_pct * cm1ac2000) 
     / (sum(intersect_pct * (cm1aa2000 + cm1ab2000 + cm1ac2000 + cm1ad2000 + cm1ae2000 + cm1af2000 + cm1ag2000))))
     * 100.0)::numeric, 2) AS amerindian_alaskan,
   round(((sum(intersect_pct * cm1ad2000) 
     / (sum(intersect_pct * (cm1aa2000 + cm1ab2000 + cm1ac2000 + cm1ad2000 + cm1ae2000 + cm1af2000 + cm1ag2000))))
     * 100.0)::numeric, 2) AS asian,
   round(((sum(intersect_pct * cm1ae2000) 
     / (sum(intersect_pct * (cm1aa2000 + cm1ab2000 + cm1ac2000 + cm1ad2000 + cm1ae2000 + cm1af2000 + cm1ag2000))))
     * 100.0)::numeric, 2) AS hawaiian_pacific_islander,
   round(((sum(intersect_pct * cm1af2000) 
     / (sum(intersect_pct * (cm1aa2000 + cm1ab2000 + cm1ac2000 + cm1ad2000 + cm1ae2000 + cm1af2000 + cm1ag2000))))
     * 100.0)::numeric, 2) AS other,
   round(((sum(intersect_pct * cm1ag2000) 
     / (sum(intersect_pct * (cm1aa2000 + cm1ab2000 + cm1ac2000 + cm1ad2000 + cm1ae2000 + cm1af2000 + cm1ag2000))))
     * 100.0)::numeric, 2) AS two_or_more_race,

   2010 as year_2010,
   round(((sum(intersect_pct * cm1aa2010) 
     / (sum(intersect_pct * (cm1aa2010 + cm1ab2010 + cm1ac2010 + cm1ad2010 + cm1ae2010 + cm1af2010 + cm1ag2010))))
     * 100.0)::numeric, 2) AS white,
   round(((sum(intersect_pct * cm1ab2010) 
     / (sum(intersect_pct * (cm1aa2010 + cm1ab2010 + cm1ac2010 + cm1ad2010 + cm1ae2010 + cm1af2010 + cm1ag2010))))
     * 100.0)::numeric, 2) AS black,
   round(((sum(intersect_pct * cm1ac2010) 
     / (sum(intersect_pct * (cm1aa2010 + cm1ab2010 + cm1ac2010 + cm1ad2010 + cm1ae2010 + cm1af2010 + cm1ag2010))))
     * 100.0)::numeric, 2) AS amerindian_alaskan,
   round(((sum(intersect_pct * cm1ad2010) 
     / (sum(intersect_pct * (cm1aa2010 + cm1ab2010 + cm1ac2010 + cm1ad2010 + cm1ae2010 + cm1af2010 + cm1ag2010))))
     * 100.0)::numeric, 2) AS asian,
   round(((sum(intersect_pct * cm1ae2010) 
     / (sum(intersect_pct * (cm1aa2010 + cm1ab2010 + cm1ac2010 + cm1ad2010 + cm1ae2010 + cm1af2010 + cm1ag2010))))
     * 100.0)::numeric, 2) AS hawaiian_pacific_islander,
   round(((sum(intersect_pct * cm1af2010) 
     / (sum(intersect_pct * (cm1aa2010 + cm1ab2010 + cm1ac2010 + cm1ad2010 + cm1ae2010 + cm1af2010 + cm1ag2010))))
     * 100.0)::numeric, 2) AS other,
   round(((sum(intersect_pct * cm1ag2010) 
     / (sum(intersect_pct * (cm1aa2010 + cm1ab2010 + cm1ac2010 + cm1ad2010 + cm1ae2010 + cm1af2010 + cm1ag2010))))
     * 100.0)::numeric, 2) AS two_or_more_race

FROM nbo_blocks AS nbo JOIN census_persons_by_race_blkgrp AS c
ON nbo.gisjoin = c.gisjoin
GROUP by name, regionid
ORDER BY regionid;