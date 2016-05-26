-- Household Income  NOT WORKING
-- Gisjoin varies, using just 2012 data

SELECT
   name,
   regionid,
   sum(intersect_pct * bs7aa2000)::integer AS income_less_than_10k_in_2000,
   sum(intersect_pct * bs7ab2000)::integer AS income_10_to_15k_in_2000,
   sum(intersect_pct * bs7ac2000)::integer AS income_15k_to_25k_in_2000,
   sum(intersect_pct * bs7ad2000)::integer AS income_25k_plus_in_2000

FROM nbo_blocks AS nbo
JOIN census_households_by_income AS c ON nbo.gisjoin = c.nhgiscode
GROUP by name, regionid
ORDER BY name;