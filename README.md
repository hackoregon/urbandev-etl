# [Hack Oregon](http://www.hackoregon.org/) - Urban Development project

Hack Oregon's Urban Development Project consists of [web services](http://ec2-52-88-193-136.us-west-2.compute.amazonaws.com/services/) to retrieve data about activities in Portland neighborhoods, as well as a web site, [PlotPDX](http://www.plotpdx.com/prototype/), which is a [Single-Page Application](https://en.wikipedia.org/wiki/Single-page_application) (SPA), implemented in JavaScript. This ETL repository holds the database design and scripts for the data that supports the other two components. 

## Extract, Transform, and Load (ETL)<br>processes for Urban Development project data

In this repository, you will find:

- Entity relationship diagrams.
- Scripts to create the database schema.
- Scripts for preparing the data and loading it into the database:
    * Extract: Scripts and processes to obtain or update data sets from particular data sources.
    * Transform: Scripts and processes to clean particular data sources.
    * Load: Scripts and processes to load particular data sources into the defined tables.

The implementation is migrating from [MySQL](http://dev.mysql.com/) to [PostgreSQL](http://www.postgresql.org/), so you will find material related to both implementations.


## Build Postgres Database

Under `postgresql/scripts/bin` you will find a `build_db` script.
This bash script will construct a postgres database with tables needed to
generate resources for each neighborhood being analyzed.

To run this script you will need PostgreSQL and PostGIS installed, and
`psql` must be availabled on your path.

One of the required SQL dumps is too large for github so it must be downloaded
from slack separately. See the comments at the top of `build_db` for instructions.


## Generate JSON Assets

Once the database is built you can run the python script `json/generate/generate.py`
to build and load json assets into an S3 bucket to be consumed by frontend.

See the `README` in `json/generate` for further instructions. You will need
to install the python dependencies and have aws credentials set as environment
variables.
