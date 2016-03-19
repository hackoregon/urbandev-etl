/* 
 * Provenance information for data sources used for this database.
 */
CREATE TABLE data_source (
  id SERIAL PRIMARY KEY, -- UUID for this row.
  table_name varchar(64), -- table in this db where data is stored.
  source_name varchar(256), -- human-readable title for the data source.
  brief_description varchar(512), -- additional information about the source data.
  source_url varchar(512), -- link to documentation of the original data source.
  databook_url varchar(512), -- link to databook within the Urban Development project.
  date_extracted timestamp WITH TIME ZONE, -- timestamp of when the data was obtained from the source.
  last_modified timestamp WITH TIME ZONE DEFAULT now() -- timestamp of when this row was last modified.
);
