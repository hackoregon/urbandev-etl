SELECT
  city,
  demolition_date,
  AsWKT(shape) AS geom,
  record_count,
  address,
  neighborhood
FROM demolitions;
