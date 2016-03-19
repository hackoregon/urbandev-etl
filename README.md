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
