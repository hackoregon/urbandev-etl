-- U.S. Census Educational Attainment 1990 by Zillow Region with category
-- values given as a percentage of the total population that is 25 years old
-- and over.
-- The educational attainment totals come from the U.S. Decennial Census
-- aggregated by Block Groups. The numbers given here for
-- Zillow Regions are estimated by calculating the percentage overlap of
-- area covered by the Block Groups intersecting the Regions.
SELECT
   regionid,
   1990 as year,
   round(
       ((sum(intersect_pct * 
           (E33001 + E33002)) 
           / sum(intersect_pct * (E33001 + E33002 + E33003 + E33004 + E33005 + E33006 + E33007))) * 100.0)
       ::numeric, 2)
       AS no_highschool_diploma,
   round(
       ((sum(intersect_pct * 
           (E33003)) 
           / sum(intersect_pct * (E33001 + E33002 + E33003 + E33004 + E33005 + E33006 + E33007))) * 100.0)
       ::numeric, 2)
       AS highschool_and_ged_diploma,
   round(
       ((sum(intersect_pct * (E33004 + E33005)) 
          / sum(intersect_pct * (E33001 + E33002 + E33003 + E33004 + E33005 + E33006 + E33007))) * 100.0)
       ::numeric, 2)
       AS some_college,
   round(
       ((sum(intersect_pct * (E33006)) 
          / sum(intersect_pct * (E33001 + E33002 + E33003 + E33004 + E33005 + E33006 + E33007))) * 100.0)
       ::numeric, 2)
       AS bachelors_degree,
   round(
       ((sum(intersect_pct * (E33007)) 
          / sum(intersect_pct * (E33001 + E33002 + E33003 + E33004 + E33005 + E33006 + E33007))) * 100.0)
       ::numeric, 2)
       AS graduate_plus
FROM nbo_blocks AS nbo JOIN census_educational_attainment_1990_blkgrp AS eda 
ON nbo.gisjoin = eda.gisjoin
GROUP BY regionid
ORDER BY regionid;