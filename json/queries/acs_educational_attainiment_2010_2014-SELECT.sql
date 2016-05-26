-- ACS Educational Attainment 2010-2014 by Zillow Region with category values
-- given as a percentage of the total population that is 25 years old and
-- over.
-- The educational attainment totals come from the American Community
-- Survey (ACS) for U.S. Census Block Groups. The numbers given here for
-- Zillow Regions are estimated by calculating the percentage overlap of
-- area covered by the Block Groups intersecting the Regions.
SELECT
   regionid,
   2014 as year,
   round(
       ((sum(intersect_pct * (abc4e002 + abc4e003 + abc4e004 + abc4e005 + abc4e006+ abc4e007 + abc4e008 + abc4e009 
       + abc4e010 + abc4e011 + abc4e012 + abc4e013 + abc4e014 + abc4e015 + abc4e016)) / sum(intersect_pct * abc4e001)) * 100.0)
       ::numeric, 2)
       AS no_highschool_diploma,
   round(
       ((sum(intersect_pct * (abc4e017 + abc4e018)) / sum(intersect_pct * abc4e001)) * 100.0)
       ::numeric, 2)
       AS highschool_and_ged_diploma,
   round(
       ((sum(intersect_pct * (abc4e019 + abc4e020 + abc4e021)) / sum(intersect_pct * abc4e001)) * 100.0)
       ::numeric, 2)
       AS some_college,
   round(
       ((sum(intersect_pct * abc4e022) / sum(intersect_pct * abc4e001)) * 100.0)
       ::numeric, 2)
       AS bachelors_degree,
   round(
       ((sum(intersect_pct * (abc4e023 + abc4e024 + abc4e025)) / sum(intersect_pct * abc4e001)) * 100.0) 
       ::numeric, 2)
       AS graduate_plus
FROM nbo_blocks AS nbo JOIN acs_educational_attainment_2010_2014_blkgrp AS eda 
ON nbo.gisjoin = eda.gisjoin
GROUP BY regionid
ORDER BY regionid;