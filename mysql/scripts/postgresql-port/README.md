Port Spatial Tables from MySQL to PostgreSQL
============================================


### Dependencies

You must have PostGIS installed on the database you will be running the `build`
script against.


### Summary
The `build` and `load` scripts were used to load data exported from the MySQL
instance into a PostgreSQL instance. After loading, the tables are exported
as sql files using `pg_dump`, which are then added to the `build_db` script.

### Export from MySQL

To export the data from MySQL I first copied the `export.sh` script onto the
ubuntu machine hosting the database using `scp`. I also copied each `SELECT-*.sql`
script onto the machine. The `SELECT-*.sql` scripts make sure to convert the
shape field to WKT (Well Known Text) format which PostGIS can consume.

Example `export.sh` usage:

```
# ./export <SELECT file> <output tsv>
./export SELECT-crime.sql crime.tsv
```

This will create a tab separated file that can be copied back to local machine
using `scp`.


Each tsv file copied from the server should be placed in the `postgresql-port/data`
directory.


### Load into PostgreSQL

After copying each `*.tsv` file from the server to your local machine you can
run the `build` script. This will create temp tables for each tsv with `varchar`
fields and copy the tsv into them. Then a `INSERT` file will select and insert the fields
(performing casts as required) into the final table, then drops the temp table.

To run
```
./build
```


### Dump SQL files

SQL files for each table are dumped from the database and used for rebuilding the db

```
 pg_dump -f CREATE-TABLE-permits.sql -x -O -t permits urbandev
 pg_dump -f CREATE-TABLE-crime.sql -x -O -t crime urbandev
 pg_dump -f CREATE-TABLE-demolitions.sql -x -O -t demolitions urbandev
```
