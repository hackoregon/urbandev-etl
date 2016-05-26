-- U.S. Census Educational Attainment 2000 by Zillow Region with category
-- values given as a percentage of the total population that is 25 years old
-- and over.
-- The educational attainment totals come from the U.S. Decennial Census
-- aggregated by Block Groups. The numbers given here for
-- Zillow Regions are estimated by calculating the percentage overlap of
-- area covered by the Block Groups intersecting the Regions.
SELECT
   regionid,
   2000 as year,
   round(
       ((sum(intersect_pct * 
           (HD1001 + HD1002 + HD1003 + HD1004 + HD1005+ HD1006 + HD1007 + HD1008 
             + HD1017 + HD1018 + HD1019 + HD1020 + HD1021 + HD1022 + HD1023 + HD1024)) 
           / sum(intersect_pct * (HD1001 + HD1002 + HD1003 + HD1004 + HD1005 + HD1006 + HD1007 + HD1008
             + HD1009 + HD1010 + HD1011 + HD1012 + HD1013 + HD1014 + HD1015 + HD1016 + HD1017 + HD1018
             + HD1019 + HD1020 + HD1021 + HD1023 + HD1023 + HD1024 + HD1025 + HD1026 + HD1027 + HD1028
             + HD1029 + HD1030 + HD1031 + HD1032))) * 100.0)
       ::numeric, 2)
       AS no_highschool_diploma,
   round(
       ((sum(intersect_pct * 
           (HD1009 + HD1025)) 
           / sum(intersect_pct * (HD1001 + HD1002 + HD1003 + HD1004 + HD1005 + HD1006 + HD1007 + HD1008
             + HD1009 + HD1010 + HD1011 + HD1012 + HD1013 + HD1014 + HD1015 + HD1016 + HD1017 + HD1018
             + HD1019 + HD1020 + HD1021 + HD1023 + HD1023 + HD1024 + HD1025 + HD1026 + HD1027 + HD1028
             + HD1029 + HD1030 + HD1031 + HD1032))) * 100.0)
       ::numeric, 2)
       AS highschool_and_ged_diploma,
   round(
       ((sum(intersect_pct * (HD1010 + HD1011 + HD1012 + HD1026 + HD1027 + HD1028)) 
          / sum(intersect_pct * (HD1001 + HD1002 + HD1003 + HD1004 + HD1005 + HD1006 + HD1007 + HD1008
             + HD1009 + HD1010 + HD1011 + HD1012 + HD1013 + HD1014 + HD1015 + HD1016 + HD1017 + HD1018
             + HD1019 + HD1020 + HD1021 + HD1023 + HD1023 + HD1024 + HD1025 + HD1026 + HD1027 + HD1028
             + HD1029 + HD1030 + HD1031 + HD1032))) * 100.0)
       ::numeric, 2)
       AS some_college,
   round(
       ((sum(intersect_pct * HD1013 + HD1029) 
          / sum(intersect_pct * (HD1001 + HD1002 + HD1003 + HD1004 + HD1005 + HD1006 + HD1007 + HD1008
             + HD1009 + HD1010 + HD1011 + HD1012 + HD1013 + HD1014 + HD1015 + HD1016 + HD1017 + HD1018
             + HD1019 + HD1020 + HD1021 + HD1023 + HD1023 + HD1024 + HD1025 + HD1026 + HD1027 + HD1028
             + HD1029 + HD1030 + HD1031 + HD1032))) * 100.0)
       ::numeric, 2)
       AS bachelors_degree,
   round(
       ((sum(intersect_pct * (HD1014 + HD1015 + HD1016 + HD1030 + HD1031 + HD1032)) 
          / sum(intersect_pct * (HD1001 + HD1002 + HD1003 + HD1004 + HD1005 + HD1006 + HD1007 + HD1008
             + HD1009 + HD1010 + HD1011 + HD1012 + HD1013 + HD1014 + HD1015 + HD1016 + HD1017 + HD1018
             + HD1019 + HD1020 + HD1021 + HD1023 + HD1023 + HD1024 + HD1025 + HD1026 + HD1027 + HD1028
             + HD1029 + HD1030 + HD1031 + HD1032))) * 100.0)
       ::numeric, 2)
       AS graduate_plus
FROM nbo_blocks AS nbo JOIN census_educational_attainment_2000_blkgrp AS eda 
ON nbo.gisjoin = eda.gisjoin
GROUP BY regionid
ORDER BY regionid;