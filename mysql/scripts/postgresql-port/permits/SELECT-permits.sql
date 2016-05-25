SELECT
  caseno,
  AsWKT(shape) AS geom,
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
FROM permits2;
