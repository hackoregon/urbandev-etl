CREATE TABLE permits (
  id serial primary key,
  caseno varchar NOT NULL,
  geom geometry NOT NULL,
  address varchar DEFAULT NULL,
  new_class varchar DEFAULT NULL,
  new_type varchar DEFAULT NULL,
  usetype varchar NOT NULL,
  units int DEFAULT NULL,
  description varchar DEFAULT NULL,
  value double precision DEFAULT NULL,
  issuedate date NOT NULL,
  nbrhood varchar DEFAULT NULL,
  sqft int DEFAULT NULL
);

CREATE TABLE tmppermits (
    id varchar,
    caseno varchar,
    geom varchar,
    address varchar,
    new_class varchar,
    new_type varchar,
    usetype varchar,
    units varchar,
    description varchar,
    value varchar,
    issuedate varchar,
    nbrhood varchar,
    sqft varchar
);
