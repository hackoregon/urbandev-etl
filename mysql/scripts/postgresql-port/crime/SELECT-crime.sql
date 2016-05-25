SELECT
    record_id,
    report_datetime,
    major_offense_type,
    address,
    neighborhood,
    police_precinct,
    police_district,
    ASWKT(shape) AS geom,
    violent
FROM crime3;
