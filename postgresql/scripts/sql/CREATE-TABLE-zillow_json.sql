CREATE TABLE zillow_json AS
WITH median_value_sqft_json AS (
    SELECT
        regionid,
        json_build_object(
            'Months', json_agg(month),
            'Values', json_agg(MedianValue_sqft)
        ) AS data
    FROM (
        SELECT regionid, month, MedianValue_sqft
        FROM zillow_1996_2016
        ORDER BY month
    ) AS sq
    GROUP BY regionid
), median_sold_sqft_json AS (
    SELECT
        regionid,
        json_build_object(
            'Months', json_agg(month),
            'Values', json_agg(MedianSold_sqft)
        ) AS data
    FROM (
        SELECT regionid, month, MedianSold_sqft
        FROM zillow_1996_2016
        ORDER BY month
    ) AS sq
    GROUP BY regionid
), zri_sqft_json AS (
    SELECT
        regionid,
        json_build_object(
            'Months', json_agg(month),
            'Values', json_agg(ZRI_sqft)
        ) AS data
    FROM (
        SELECT regionid, month, ZRI_sqft
        FROM zillow_1996_2016
        ORDER BY month
    ) AS sq
    GROUP BY regionid
), craigslist_json AS (
    SELECT
        regionid,
        json_build_object(
            'Values', json_build_object(
                'num_of_studio', num_of_studio,
                'avg_price_studio', avg_price_studio,
                'num_of_1_br', num_of_1_br,
                'avg_price_1_br', avg_price_1_br,
                'num_of_2_br', num_of_2_br,
                'avg_price_2_br', avg_price_2_br,
                'num_of_3_br', num_of_3_br,
                'avg_price_3_br', avg_price_3_br,
                'avg_price', avg_price,
                'rentability', rentability,
                'listing_count', listing_count
            )
        ) AS data
    FROM craigslist_neighborhood_average_rental AS c
), demolitions_json AS (
    SELECT
        regionid,
        json_build_object(
            'Years', json_agg(year),
            'Values', json_agg(demolitions)
        ) AS data
    FROM zillow_demolitions
    GROUP BY regionid
), violent_crime_json AS (
    SELECT
        regionid,
        json_build_object(
            'Years', json_agg(year),
            'Values', json_agg(violent)
        ) AS data
    FROM (
        SELECT regionid, year, json_build_object(
            'violent', violent,
            'nonviolent', nonviolent
        ) AS violent
        FROM zillow_violent_crime
        ORDER BY year
    ) AS sq
    GROUP BY regionid
), crime_json AS (
    SELECT
        regionid,
        json_build_object(
            'Years', json_agg(year),
            'Values', json_agg(offense)
        ) AS data
    FROM (
        SELECT regionid, year, json_build_object(
            'aggravated_assault', aggravated_assault,
            'arson', arson,
            'assault_simple', assault_simple,
            'burglary', burglary,
            'curfew', curfew,
            'disorderly_conduct', disorderly_conduct,
            'drugs', drugs,
            'duii', duii,
            'embezzlement', embezzlement,
            'forgery', forgery,
            'fraud', fraud,
            'gambling', gambling,
            'homicide', homicide,
            'kidnap', kidnap,
            'larceny', larceny,
            'liquor_laws', liquor_laws,
            'motor_vehicle_theft', motor_vehicle_theft,
            'offenses_against_family', offenses_against_family,
            'prostitution', prostitution,
            'rape', rape,
            'robbery', robbery,
            'runaway', runaway,
            'sex_offenses', sex_offenses,
            'stolen_property', stolen_property,
            'trespass', trespass,
            'vandalism', vandalism,
            'weapons', weapons
        ) AS offense
        FROM zillow_crime
        ORDER BY year
    ) AS sq
    GROUP BY regionid
), race_json AS (
    SELECT
        regionid,
        json_build_object(
            'Years', json_agg(year),
            'Values', json_agg(race)
        ) AS data
    FROM (
        SELECT regionid, year, json_build_object(
            'total', total,
            'white', white,
            'black', black,
            'american_indian', american_indian,
            'asian', asian,
            'hawaiian', hawaiian,
            'other', other,
            'multiple', multiple
        ) AS race
        FROM zillow_race
        ORDER BY year
    ) AS sq
    GROUP BY regionid
), income_json AS (
    SELECT
        regionid,
        json_build_object(
            'Years', json_agg(year),
            'Values', json_agg(income)
        ) AS data
    FROM (
        SELECT regionid, year, json_build_object(
            'total', total,
            'income_less_10000', income_less_10000,
            'income_10000_19999', income_10000_19999,
            'income_20000_29999', income_20000_29999,
            'income_30000_39999', income_30000_39999,
            'income_40000_49999', income_40000_49999,
            'income_50000_59999', income_50000_59999,
            'income_60000_74999', income_60000_74999,
            'income_75000_99999', income_75000_99999,
            'income_100000_199999', income_100000_199999,
            'income_200000_more', income_200000_more
        ) AS income
        FROM zillow_income
        ORDER BY year
    ) AS sq
    GROUP BY regionid
), education_json AS (
    SELECT
        regionid,
        json_build_object(
            'Years', json_agg(year),
            'Values', json_agg(education)
        ) AS data
    FROM (
        SELECT regionid, year, json_build_object(
            'total', total,
            'no_diploma', no_diploma,
            'diploma', diploma,
            'some_college', some_college,
            'bachelor', bachelor,
            'advanced', advanced
        ) AS education
        FROM zillow_education
        ORDER BY year
    ) AS sq
    GROUP BY regionid
)
SELECT
    nbo.name,
    nbo.regionid,
    json_build_object(
        'RegionID', nbo.regionid,
        'RegionName', nbo.name,
        'Overview', o.overview,
        'Craigslist', cr.data,
        'Demolitions', d.data,
        'ViolentCrime', v.data,
        'Crime', c.data,
        'Race', r.data,
        'Income', i.data,
        'Education', e.data,
        'Zillow', json_build_object(
            'MedianValue_sqft', mv.data,
            'MedianSold_sqft', ms.data,
            'ZRI_sqft', zr.data
        )
    ) AS json
FROM (
    SELECT DISTINCT name, regionid
    FROM zillow_neighborhoods
) AS nbo
LEFT OUTER JOIN zillow_overview AS o ON nbo.regionid::text = o.regionid::text
LEFT OUTER JOIN median_value_sqft_json AS mv ON nbo.regionid::text = mv.regionid::text
LEFT OUTER JOIN median_sold_sqft_json AS ms ON nbo.regionid::text = ms.regionid::text
LEFT OUTER JOIN zri_sqft_json AS zr ON nbo.regionid::text = zr.regionid::text
LEFT OUTER JOIN craigslist_json AS cr ON nbo.regionid::text = cr.regionid::text
LEFT OUTER JOIN demolitions_json AS d ON nbo.regionid::text = d.regionid::text
LEFT OUTER JOIN violent_crime_json AS v ON nbo.regionid::text = v.regionid::text
LEFT OUTER JOIN crime_json AS c ON nbo.regionid::text = c.regionid::text
LEFT OUTER JOIN race_json AS r ON nbo.regionid::text = r.regionid::text
LEFT OUTER JOIN income_json AS i ON nbo.regionid::text = i.regionid::text
LEFT OUTER JOIN education_json AS e ON nbo.regionid::text = e.regionid::text
ORDER BY nbo.name, nbo.regionid;

