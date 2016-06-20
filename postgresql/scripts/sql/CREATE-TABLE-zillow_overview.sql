CREATE TEMP TABLE pop AS
SELECT
    z.regionid,
    z.name,
    sum(z.intersect_pct * c.cl8aa2010) AS pop2010
FROM zillow_blkgrps AS z
LEFT OUTER JOIN census_total_population_blkgrp AS c
ON z.gisjoin = c.gisjoin
WHERE z.year = '2010'
GROUP BY z.regionid, z.name
ORDER BY z.name;


CREATE TABLE zillow_overview AS
WITH violent_data AS (
    SELECT
        z.name,
        z.regionid,
        rank() OVER (
            ORDER BY coalesce(z.violent::float, 0) / p.pop2010::float DESC
        ) AS rank,
        coalesce(z.violent::float, 0) / p.pop2010::float AS violent_pp
    FROM zillow_violent_crime AS z
    JOIN pop AS p ON z.regionid::text = p.regionid::text
    WHERE year = '2014'
), demolitions_data AS (
    WITH demolitions AS (
        SELECT
            z.name,
            z.regionid,
            sum(coalesce(demolitions, 0)) AS demolitions_pp
        FROM zillow_demolitions AS z
        GROUP BY z.name, z.regionid
    )
    SELECT
        d.name,
        d.regionid,
        rank() OVER (
            ORDER BY coalesce(d.demolitions_pp::float, 0) / p.pop2010::float DESC
        ) AS rank,
        coalesce(d.demolitions_pp::float, 0) /
            p.pop2010::float AS demolitions_pp
    FROM demolitions AS d
    JOIN pop AS p ON p.regionid = d.regionid
), medianvalue_data AS (
    SELECT
        z.regionname,
        z.regionid,
        rank() OVER (
            ORDER BY sum(z.medianvalue_sqft)::float / count(*)::float DESC
        ) AS rank,
        sum(z.medianvalue_sqft)::float / count(*)::float AS medianvalue_sqft
    FROM zillow_neighborhoods AS nbo
    JOIN zillow_1996_2016 AS z ON nbo.regionid = z.regionid
    WHERE z.month LIKE '2015%'
    GROUP BY z.regionname, z.regionid
), avgrental_data AS (
    SELECT
        c.name,
        c.regionid,
        rank() OVER (ORDER BY avg_price DESC) AS rank,
        c.avg_price AS avg_rental
    FROM craigslist_neighborhood_average_rental AS c
)
SELECT
    nbo.name,
    nbo.regionid,
    json_build_object(
        'Violent', json_build_object(
            'rank', v.rank,
            'count', (SELECT max(rank) FROM violent_data),
            'violent_pp', round(v.violent_pp::numeric, 4)
        ),
        'Demolitions', json_build_object(
            'rank', d.rank,
            'count', (SELECT max(rank) FROM demolitions_data),
            'demolitions_pp', round(d.demolitions_pp::numeric, 4)
        ),
        'MedianValue', json_build_object(
            'rank', m.rank,
            'count', (SELECT max(rank) FROM medianvalue_data),
            'median_value', round(m.medianvalue_sqft::numeric, 4)
        ),
        'AvgRental', json_build_object(
            'rank', p.rank,
            'count', (SELECT max(rank) FROM avgrental_data),
            'avg_rental', round(p.avg_rental::numeric, 4)
        )
    ) AS overview
FROM (
    SELECT DISTINCT name, regionid
    FROM zillow_neighborhoods
) AS nbo
LEFT OUTER JOIN violent_data AS v ON nbo.regionid::text = v.regionid::text
LEFT OUTER JOIN demolitions_data AS d ON nbo.regionid::text = d.regionid::text
LEFT OUTER JOIN medianvalue_data AS m ON nbo.regionid::text = m.regionid::text
LEFT OUTER JOIN avgrental_data AS p ON nbo.regionid::text = p.regionid::text
ORDER BY nbo.name, nbo.regionid;
