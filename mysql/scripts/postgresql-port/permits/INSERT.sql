BEGIN;

INSERT INTO permits (
  caseno,
  geom,
  address,
  new_class,
  new_type,
  usetype,
  units,
  description,
  value,
  issuedate,
  nbrhood,
  sqft
)
SELECT
  caseno,
  ST_GeomFromText(geom),
  address,
  new_class,
  new_type,
  usetype,
  units::integer,
  description,
  value::double precision,
  issuedate::date,
  nbrhood,
  sqft::integer
FROM tmppermits;

DROP TABLE tmppermits;

SELECT UpdateGeometrySRID('public', 'permits', 'geom', 4326);

CREATE INDEX ON permits USING GIST (geom);

COMMIT;
