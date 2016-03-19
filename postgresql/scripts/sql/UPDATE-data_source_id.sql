/*
 * After loading data tables, set the data_source_id 
 * foreign key field to the corresponding data source.
 * For now, all rows in a table are obtained from the same
 * source, so just update the whole table with no WHERE-clause.
 */
update census_housing_units_tenure set data_source_id=(select id from data_source where table_name like 'census_housing_units_tenure');
