/*
 * Creates an entry for the source of data for each of
 * the data tables.
 */
insert into 
data_source (table_name, source_name, brief_description, source_url, databook_url, date_extracted, last_modified)
values (
  'census_educational_attainment',
  'Persons 25 Years and Over by Educational Attainment [3], Years: 1970, 1980, 1990, 2000, 2008-2012 by Tract. Nominal geographic integration.',
  'Level of education attained by persons 25 years and over, aggregated into 3 categories: Less than 9th grade, 9th grade to 3 years of college (until 1980) or to some college or associate''s degree (since 1990), and 4 or more years of college (until 1980) or bachelor''s degree or higher (since 1990). NHGIS Time Series links together comparable statistics from multiple U.S. censuses in one table.',
  'https://www.nhgis.org/documentation/time-series',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/census_educational_attainment-codebook-NHGIS.txt',
  make_timestamptz(2016, 3, 13, 0, 0, 0, 'UTC'),
  now()
),
(
  'census_households_by_income',
  'Households by Income* in Previous Year [4], Years: 1970, 1980, 1990, 2000, 2008-2012 by Tract. Nominal geographic integration.',
  'Households are divided into 4 categories according to level of income: < $10,000, $10,000 - $14,999, $15,000 - $24,999, and $25,000 or more. NHGIS Time Series links together comparable statistics from multiple U.S. censuses in one table.',
  'https://www.nhgis.org/documentation/time-series',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/census_households_by_income-codebook-NHGIS.txt',
  make_timestamptz(2016, 3, 11, 0, 0, 0, 'UTC'),
  now()
),
(
  'census_housing_units_tenure',
  'Occupied Housing Units by Tenure [2], Years: 1970, 1980, 1990, 2000, 2010 by Tract. Nominal geographic integration.',
  'Quantity of Owner occupied and Renter occupied Housing units. NHGIS Time Series links together comparable statistics from multiple U.S. censuses in one table.',
  'https://www.nhgis.org/documentation/time-series',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/census_housing_units_tenure-codebook-NHGIS.txt',
  make_timestamptz(2016, 3, 13, 0, 0, 0, 'UTC'),
  now()
),
(
  'census_persons_by_race',
  'Persons by Race [5*], Years: 1970, 1980, 1990, 2000, 2010 by Tract. Nominal geographic integration.',
  'Population aggregated by 5 categories of race: White (single race), Black or African American (single race), American Indian and Alaska Native (single race), Asian and Pacific Islander and Other Race (single race), and Two or More Races. NHGIS Time Series links together comparable statistics from multiple U.S. censuses in one table.',
  'https://www.nhgis.org/documentation/time-series',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/census_persons_by_race-codebook-NHGIS.txt',
  make_timestamptz(2016, 3, 13, 0, 0, 0, 'UTC'),
  now()
),
(
  'census_total_population',
  'Total Population, Years: 1970, 1980, 1990, 2000, 2010, 2008-2012 by Tract. Nominal geographic integration.',
  'Total number of persons per tract. NHGIS Time Series links together comparable statistics from multiple U.S. censuses in one table.',
  'https://www.nhgis.org/documentation/time-series',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/census_total_population-codebook-NHGIS.txt',
  make_timestamptz(2016, 3, 13, 0, 0, 0, 'UTC'),
  now()
),
(
  'census_total_population_blkgrp',
  'Total Population, Years: 2000, 2010 by Block Group. 2000 Block Data Standardized to 2010 Geography.',
  'Total number of persons per block broup. NHGIS Time Series links together comparable statistics from multiple U.S. censuses in one table.',
  'https://www.nhgis.org/documentation/time-series',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/census_total_population_blkgrp-codebook-NHGIS.txt',
  make_timestamptz(2016, 4, 3, 0, 0, 0, 'UTC'),
  now()
),
(
  'acs_household_income_2009_blkgrp',
  'Household Income and Median Household Income in the Past 12 Months (in 2009 Inflation-Adjusted Dollars).',
  '2009 American Community Survey: 5-Year Data [2005-2009, Block Groups & Larger Areas].',
  'https://www.nhgis.org/documentation/time-series',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/acs_household_income_2009_blkgrp_codebook.txt',
  make_timestamptz(2016, 4, 3, 0, 0, 0, 'UTC'),
  now()
),
(
  'acs_household_income_2014_blkgrp',
  'Household Income and Median Household Income in the Past 12 Months (in 2014 Inflation-Adjusted Dollars).',
  '2014 American Community Survey: 5-Year Data [2010-2014, Block Groups & Larger Areas].',
  'https://www.nhgis.org/documentation/time-series',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/acs_household_income_2014_blkgrp_codebook.txt',
  make_timestamptz(2016, 4, 3, 0, 0, 0, 'UTC'),
  now()
),
(
  'census_educational_attainment_1990_blkgrp',
  'Educational Attainment, Persons 25 years and over.',
  '1990 Census: STF 3 - Sample-Based Data [1990, Block Group (by State--County--Census Tract)].',
  'https://www.nhgis.org/',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/census_educational_attainment_1990_blkgrp_codebook.txt',
  make_timestamptz(2016, 5, 3, 0, 0, 0, 'UTC'),
  now()
),
(
  'census_educational_attainment_2000_blkgrp',
  'Educational Attainment by Sex, Persons 25 years and over.',
  '2000 Census: SF 3b - Sample-Based Data [2000, Block Group (by State--County--Census Tract)].',
  'https://www.nhgis.org/',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/census_educational_attainment_2000_blkgrp_codebook.txt',
  make_timestamptz(2016, 5, 3, 0, 0, 0, 'UTC'),
  now()
),
(
  'acs_educational_attainment_2005_2009_blkgrp',
  'Educational Attainment by Sex, Persons 25 years and over.',
  '2009 American Community Survey: 5-Year Data [2005-2009, Block Groups & Larger Areas].',
  'https://www.nhgis.org/',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/acs_educational_attainment_2005_2009_blkgrp_codebook.txt',
  make_timestamptz(2016, 5, 3, 0, 0, 0, 'UTC'),
  now()
),
(
  'acs_educational_attainment_2010_2014_blkgrp',
  'Educational Attainment by Sex, Persons 25 years and over.',
  '2014 American Community Survey: 5-Year Data [2010-2014, Block Groups & Larger Areas].',
  'https://www.nhgis.org/',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/acs_educational_attainment_2010_2014_blkgrp_codebook.txt',
  make_timestamptz(2016, 5, 3, 0, 0, 0, 'UTC'),
  now()
),
(
  'census_block_groups_in_pdx_neighborhood',
  'Associative table relates U.S. Census Block Groups to Portland Neighborhoods.',
  'Data generated by Hack Oregon''s Urban Development team gives the percentage of a Block Group''s area that is contained within a Portland Neighborhood.',
  null,
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/census_block_groups_in_pdx_neighborhood-databook-HackOregon.md',
  make_timestamptz(2016, 5, 5, 0, 0, 0, 'UTC'),
  now()
),
(
  'census_tracts_in_pdx_neighborhood',
  'Associative table relates U.S. Census Tracts to Portland Neighborhoods.',
  'Data generated by Hack Oregon''s Urban Development team gives the percentage of a Tract''s area that is contained within a Portland Neighborhood.',
  null,
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/census_tracts_in_pdx_neighborhood-databook-HackOregon.md',
  make_timestamptz(2016, 5, 5, 0, 0, 0, 'UTC'),
  now()
),
(
  'pdx_neighborhood',
  'Name and area size of Portland Neighborhoods.',
  'Unknown source. Copied from the old MySQL database.',
  null,
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/pdx_neighborhood-databook-HackOregon.md',
  make_timestamptz(2016, 5, 5, 0, 0, 0, 'UTC'),
  now()
),
(
  'neighborhood_average_rental',
  'Average apartment rental prices by Portland neighborhood for January - May 2016.',
  'This data is aggregated from individual apartment listings on craigslist.com.',
  null,
  null,
  make_timestamptz(2016, 5, 22, 0, 0, 0, 'UTC'),
  now()
)
;
