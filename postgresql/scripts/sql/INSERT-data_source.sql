/*
 * Creates an entry for the source of data for each of
 * the data tables.
 */
-- census_housing_units_tenure
insert into 
data_source (table_name, source_name, brief_description, source_url, databook_url, date_extracted, last_modified)
values (
  'census_housing_units_tenure',
  'Occupied Housing Units by Tenure [2], Years: 1970, 1980, 1990, 2000, 2010 by Tract. Nominal Integration.',
  'Owner occupied and Renter occupied Housing units. NHGIS Time Series links together comparable statistics from multiple U.S. censuses in one table.',
  'https://www.nhgis.org/documentation/time-series',
  'https://github.com/hackoregon/urbandev-backend/tree/master/db/postgresql/doc/census_housing_units_tenure-codebook.txt',
  make_timestamptz(2016, 3, 13, 0, 0, 0, 'UTC'),
  now()
);