# Educational Attainiment 2010-2014
SELECT
   name,
   regionid,
   sum(intersect_pct * (abc4e002 + abc4e003 + abc4e004 + abc4e005 + abc4e006+ abc4e007 + abc4e008 + abc4e009 + abc4e010 + abc4e011 + abc4e012 + abc4e013 + abc4e014 + abc4e015 + abc4e016))::integer 
       AS no_highschool_diploma_2014,

   sum(intersect_pct * (abc4e017 + abc4e018 ))::integer 
       AS highschool_and_ged_diploma_2014,

   sum(intersect_pct * (ABC4E019 + abc4e020 + abc4e021))::integer 
       AS some_college_2014,


   sum(intersect_pct * ABC4e022)::integer 
       AS bachelors_degree_2014,

   sum(intersect_pct * (ABC4e023 + abc4e024 + abc4e025))::integer 
       AS graduate_plus_2014

FROM nbo_blocks AS nbo
JOIN acs_educational_attainment_2010_2014_blkgrp AS c ON nbo.gisjoin = c.gisjoin
GROUP by name, regionid
ORDER BY name;