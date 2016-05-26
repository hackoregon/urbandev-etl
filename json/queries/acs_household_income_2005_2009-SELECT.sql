-- ACS Household Income 2009 by Zillow Region with category values
-- given as a percentage.
-- The Household Income totals come from the American Community
-- Survey (ACS) for U.S. Census Block Groups. The numbers given here for
-- Zillow Regions are estimated by calculating the percentage overlap of
-- area covered by the Block Groups intersecting the Regions.
SELECT
   nbo.name as region,
   nbo.regionid,
   2009 as year,
   round(((sum(intersect_pct * (RNGE002)) / sum(intersect_pct * RNGE001)) * 100.0)::numeric, 2)
       AS "0-9,999",
   round(((sum(intersect_pct * (RNGE003)) / sum(intersect_pct * RNGE001)) * 100.0)::numeric, 2)
       AS "10,000-14,999",
   round(((sum(intersect_pct * (RNGE004)) / sum(intersect_pct * RNGE001)) * 100.0)::numeric, 2)
       AS "15,000-19,999",
   round(((sum(intersect_pct * (RNGE005)) / sum(intersect_pct * RNGE001)) * 100.0)::numeric, 2)
       AS "20,000-24,999",
   round(((sum(intersect_pct * (RNGE006)) / sum(intersect_pct * RNGE001)) * 100.0)::numeric, 2)
       AS "25,000-29,999",
   round(((sum(intersect_pct * (RNGE007)) / sum(intersect_pct * RNGE001)) * 100.0)::numeric, 2)
       AS "30,000-34,999",
   round(((sum(intersect_pct * (RNGE008)) / sum(intersect_pct * RNGE001)) * 100.0)::numeric, 2)
       AS "35,000-39,999",
   round(((sum(intersect_pct * (RNGE009)) / sum(intersect_pct * RNGE001)) * 100.0)::numeric, 2)
       AS "40,000-44,999",
   round(((sum(intersect_pct * (RNGE010)) / sum(intersect_pct * RNGE001)) * 100.0)::numeric, 2)
       AS "45,000-49,999",
   round(((sum(intersect_pct * (RNGE011)) / sum(intersect_pct * RNGE001)) * 100.0)::numeric, 2)
       AS "50,000-59,999",
   round(((sum(intersect_pct * (RNGE012)) / sum(intersect_pct * RNGE001)) * 100.0)::numeric, 2)
       AS "60,000-74,999",
   round(((sum(intersect_pct * (RNGE013)) / sum(intersect_pct * RNGE001)) * 100.0)::numeric, 2)
       AS "75,000-99,999",
   round(((sum(intersect_pct * (RNGE014)) / sum(intersect_pct * RNGE001)) * 100.0)::numeric, 2)
       AS "100,000-124,999",
   round(((sum(intersect_pct * (RNGE015)) / sum(intersect_pct * RNGE001)) * 100.0)::numeric, 2)
       AS "125,000-149,999",
   round(((sum(intersect_pct * (RNGE016)) / sum(intersect_pct * RNGE001)) * 100.0)::numeric, 2)
       AS "150,000-199,999",
   round(((sum(intersect_pct * (RNGE017)) / sum(intersect_pct * RNGE001)) * 100.0)::numeric, 2)
       AS "200,000+"
FROM nbo_blocks AS nbo JOIN acs_household_income_2009_blkgrp AS c 
ON nbo.gisjoin = c.gisjoin
GROUP by nbo.regionid, nbo.name
ORDER BY nbo.regionid;