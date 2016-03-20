/*
 * Creates all of the indexes for all of the census tables.
 */
-- data_source
CREATE UNIQUE INDEX idx_data_source_id ON data_source USING btree (id);

-- census_educational_attainment
CREATE INDEX idx_census_educational_attainment_statefp ON census_educational_attainment USING btree (statefp);
CREATE INDEX idx_census_educational_attainment_countyfp ON census_educational_attainment USING btree (countyfp);
CREATE INDEX idx_census_educational_attainment_tracta ON census_educational_attainment USING btree (tracta);

-- census_households_by_income
CREATE INDEX idx_census_households_by_income_statefp ON census_households_by_income USING btree (statefp);
CREATE INDEX idx_census_households_by_income_countyfp ON census_households_by_income USING btree (countyfp);
CREATE INDEX idx_census_households_by_income_tracta ON census_households_by_income USING btree (tracta);

-- census_housing_units_tenure
CREATE INDEX idx_census_housing_units_tenure_statefp ON census_housing_units_tenure USING btree (statefp);
CREATE INDEX idx_census_housing_units_tenure_countyfp ON census_housing_units_tenure USING btree (countyfp);
CREATE INDEX idx_census_housing_units_tenure_tracta ON census_housing_units_tenure USING btree (tracta);

-- census_persons_by_race
CREATE INDEX idx_census_persons_by_race_statefp ON census_persons_by_race USING btree (statefp);
CREATE INDEX idx_census_persons_by_race_countyfp ON census_persons_by_race USING btree (countyfp);
CREATE INDEX idx_census_persons_by_race_tracta ON census_persons_by_race USING btree (tracta);

-- census_total_population
CREATE INDEX idx_census_total_population_statefp ON census_total_population USING btree (statefp);
CREATE INDEX idx_census_total_population_countyfp ON census_total_population USING btree (countyfp);
CREATE INDEX idx_census_total_population_tracta ON census_total_population USING btree (tracta);
