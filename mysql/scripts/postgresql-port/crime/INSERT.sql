BEGIN;

INSERT INTO crime (
    record_id,
    report_datetime,
    major_offense_type,
    address,
    neighborhood,
    police_precinct,
    police_district,
    geom,
    violent
)
SELECT
    record_id::integer,
    report_datetime::timestamp,
    major_offense_type,
    address,
    neighborhood,
    police_precinct,
    police_district::integer,
    ST_GeomFromText(geom),
    violent::char
FROM tmpcrime;

DROP TABLE tmpcrime;

SELECT UpdateGeometrySRID('public', 'crime', 'geom', 4326);

CREATE INDEX ON crime USING GIST (geom);

COMMIT;
