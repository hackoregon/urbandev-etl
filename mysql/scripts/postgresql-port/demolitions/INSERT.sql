BEGIN;

INSERT INTO demolitions (
  city,
  demolition_date,
  geom,
  record_count,
  address,
  neighborhood
)
SELECT
  city,
  demolition_date::date,
  ST_GeomFromText(geom),
  record_count::integer,
  address,
  neighborhood
FROM tmpdemolitions;

DROP TABLE tmpdemolitions;

SELECT UpdateGeometrySRID('public', 'demolitions', 'geom', 4326);

CREATE INDEX ON demolitions USING GIST (geom);

COMMIT;
