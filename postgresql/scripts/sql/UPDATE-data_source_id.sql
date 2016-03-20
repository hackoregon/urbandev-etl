/*
 * After loading data tables, set the data_source_id 
 * foreign key field to the corresponding data source.
 * For now, all rows in a table are obtained from the same
 * source, so just update the whole table without using
 * a WHERE-clause.
 */
update census_educational_attainment set data_source_id=(select id from data_source where table_name like 'census_educational_attainment');
update census_households_by_income set data_source_id=(select id from data_source where table_name like 'census_households_by_income');
update census_housing_units_tenure set data_source_id=(select id from data_source where table_name like 'census_housing_units_tenure');
update census_persons_by_race set data_source_id=(select id from data_source where table_name like 'census_persons_by_race');
update census_total_population set data_source_id=(select id from data_source where table_name like 'census_total_population');
