CREATE TABLE demolitions (
  id serial PRIMARY KEY,
  city varchar NOT NULL,
  demolition_date date NOT NULL,
  geom geometry NOT NULL,
  record_count int NOT NULL,
  address varchar NOT NULL,
  neighborhood varchar DEFAULT NULL
);

CREATE TABLE tmpdemolitions (
    id varchar,
    city varchar,
    demolition_date varchar,
    geom varchar,
    record_count varchar,
    address varchar,
    neighborhood varchar
);
