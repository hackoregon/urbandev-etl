/*
 * Creates all of the indexes for all of the census tables.
 */
-- data_source
CREATE UNIQUE INDEX idx_data_source_id ON data_source USING btree (id);

-- census_housing_units_tenure
CREATE INDEX idx_census_housing_units_tenure_statefp ON census_housing_units_tenure USING btree (statefp);
CREATE INDEX idx_census_housing_units_tenure_countyfp ON census_housing_units_tenure USING btree (countyfp);
CREATE INDEX idx_census_housing_units_tenure_tracta ON census_housing_units_tenure USING btree (tracta);
