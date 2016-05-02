/*
 * Creates an entry for the source of data for each of
 * the data tables.
 */
insert into 
data_source (table_name, source_name, brief_description, source_url, databook_url, date_extracted, last_modified)
values (
  'census_educational_attainment',
  'Persons 25 Years and Over by Educational Attainment [3], Years: 1970, 1980, 1990, 2000, 2008-2012 by Tract. Nominal geographic integration.',
  'Level of education attained by persons 25 years and over, aggregated into 3 categories: Less than 9th grade, 9th grade to 3 years of college (until 1980) or to some college or associate's degree (since 1990), and 4 or more years of college (until 1980) or bachelor's degree or higher (since 1990). NHGIS Time Series links together comparable statistics from multiple U.S. censuses in one table.',
  'https://www.nhgis.org/documentation/time-series',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/census_educational_attainment-codebook-NHGIS.txt',
  make_timestamptz(2016, 3, 13, 0, 0, 0, 'UTC'),
  now()
),
values (
  'census_households_by_income',
  'Households by Income* in Previous Year [4], Years: 1970, 1980, 1990, 2000, 2008-2012 by Tract. Nominal geographic integration.',
  'Households are divided into 4 categories according to level of income: < $10,000, $10,000 - $14,999, $15,000 - $24,999, and $25,000 or more. NHGIS Time Series links together comparable statistics from multiple U.S. censuses in one table.',
  'https://www.nhgis.org/documentation/time-series',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/census_households_by_income-codebook-NHGIS.txt',
  make_timestamptz(2016, 3, 11, 0, 0, 0, 'UTC'),
  now()
),
values (
  'census_housing_units_tenure',
  'Occupied Housing Units by Tenure [2], Years: 1970, 1980, 1990, 2000, 2010 by Tract. Nominal geographic integration.',
  'Quantity of Owner occupied and Renter occupied Housing units. NHGIS Time Series links together comparable statistics from multiple U.S. censuses in one table.',
  'https://www.nhgis.org/documentation/time-series',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/census_housing_units_tenure-codebook-NHGIS.txt',
  make_timestamptz(2016, 3, 13, 0, 0, 0, 'UTC'),
  now()
),
values (
  'census_persons_by_race',
  'Persons by Race [5*], Years: 1970, 1980, 1990, 2000, 2010 by Tract. Nominal geographic integration.',
  'Population aggregated by 5 categories of race: White (single race), Black or African American (single race), American Indian and Alaska Native (single race), Asian and Pacific Islander and Other Race (single race), and Two or More Races. NHGIS Time Series links together comparable statistics from multiple U.S. censuses in one table.',
  'https://www.nhgis.org/documentation/time-series',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/census_persons_by_race-codebook-NHGIS.txt',
  make_timestamptz(2016, 3, 13, 0, 0, 0, 'UTC'),
  now()
),
values (
  'census_total_population',
  'Total Population, Years: 1970, 1980, 1990, 2000, 2010, 2008-2012 by Tract. Nominal geographic integration.',
  'Total number of persons per tract. NHGIS Time Series links together comparable statistics from multiple U.S. censuses in one table.',
  'https://www.nhgis.org/documentation/time-series',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/census_total_population-codebook-NHGIS.txt',
  make_timestamptz(2016, 3, 13, 0, 0, 0, 'UTC'),
  now()
),
values (
  'census_total_population_blkgrp',
  'Total Population, Years: 2000, 2010 by Block Group. 2000 Block Data Standardized to 2010 Geography.',
  'Total number of persons per block broup. NHGIS Time Series links together comparable statistics from multiple U.S. censuses in one table.',
  'https://www.nhgis.org/documentation/time-series',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/census_total_population_blkgrp-codebook-NHGIS.txt',
  make_timestamptz(2016, 4, 3, 0, 0, 0, 'UTC'),
  now()
),
values (
  'acs_household_income_2009_blkgrp',
  'Household Income and Median Household Income in the Past 12 Months (in 2009 Inflation-Adjusted Dollars).',
  '2009 American Community Survey: 5-Year Data [2005-2009, Block Groups & Larger Areas].',
  'https://www.nhgis.org/documentation/time-series',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/acs_household_income_2009_blkgrp_codebook.txt',
  make_timestamptz(2016, 4, 3, 0, 0, 0, 'UTC'),
  now()
),
values (
  'acs_household_income_2014_blkgrp',
  'Household Income and Median Household Income in the Past 12 Months (in 2014 Inflation-Adjusted Dollars).',
  '2014 American Community Survey: 5-Year Data [2010-2014, Block Groups & Larger Areas].',
  'https://www.nhgis.org/documentation/time-series',
  'https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/acs_household_income_2014_blkgrp_codebook.txt',
  make_timestamptz(2016, 4, 3, 0, 0, 0, 'UTC'),
  now()
)
;
