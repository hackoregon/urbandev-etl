-- ACS Educational Attainment 2005-2009 by Zillow Region with category values
-- given as a percentage of the total population that is 25 years old and
-- over.
-- The educational attainment totals come from the American Community
-- Survey (ACS) for U.S. Census Block Groups. The numbers given here for
-- Zillow Regions are estimated by calculating the percentage overlap of
-- area covered by the Block Groups intersecting the Regions.
SELECT
   regionid,
   2009 as year,
   round(
       ((sum(intersect_pct * (RM8E003 + RM8E004 + RM8E005 + RM8E006 + RM8E007+ RM8E008 + RM8E009 + RM8E010 
         + RM8E020 + RM8E021 + RM8E022 + RM8E023 + RM8E024 + RM8E025 + RM8E026 + RM8E027)) 
         / sum(intersect_pct * RM8E001)) * 100.0)
       ::numeric, 2)
       AS no_highschool_diploma,
   round(
       ((sum(intersect_pct * (RM8E011 + RM8E028)) 
         / sum(intersect_pct * RM8E001)) * 100.0)
       ::numeric, 2)
       AS highschool_and_ged_diploma,
   round(
       ((sum(intersect_pct * (RM8E012 + RM8E013 + RM8E014 + RM8E029 + RM8E030 + RM8E031)) 
         / sum(intersect_pct * RM8E001)) * 100.0)
       ::numeric, 2)
       AS some_college,
   round(
       ((sum(intersect_pct * (RM8E015 + RM8E032)) 
         / sum(intersect_pct * RM8E001)) * 100.0)
       ::numeric, 2)
       AS bachelors_degree,
   round(
       ((sum(intersect_pct * (RM8E016 + RM8E017 + RM8E018 + RM8E033 + RM8E034 + RM8E035)) 
         / sum(intersect_pct * RM8E001)) * 100.0) 
       ::numeric, 2)
       AS graduate_plus
FROM nbo_blocks AS nbo JOIN acs_educational_attainment_2005_2009_blkgrp AS eda 
ON nbo.gisjoin = eda.gisjoin
GROUP BY regionid
ORDER BY regionid;