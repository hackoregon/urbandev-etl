CREATE TABLE crime (
    record_id int PRIMARY KEY,
    report_datetime timestamp NOT NULL,
    major_offense_type varchar DEFAULT NULL,
    address varchar DEFAULT NULL,
    neighborhood varchar DEFAULT NULL,
    police_precinct varchar DEFAULT NULL,
    police_district int DEFAULT NULL,
    geom geometry NOT NULL,
    violent char DEFAULT NULL
);

CREATE TABLE tmpcrime (
    record_id varchar,
    report_datetime varchar,
    major_offense_type varchar,
    address varchar,
    neighborhood varchar,
    police_precinct varchar,
    police_district varchar,
    geom varchar,
    violent varchar
);
