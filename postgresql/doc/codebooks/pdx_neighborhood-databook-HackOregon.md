# [Hack Oregon](http://www.hackoregon.org/) - Urban Development project
# Data Book for Table: pdx\_neighborhood

**Table of Contents**

1. <a href="#datasource">Data Source</a><br>
2. <a href="#fields">Field Definitions</a><br>
3. <a href="#loading">Loading</a><br>

## <a name="datasource">1. Data Source</a>
_Open Issue_: What is the source of neighborhood data? It was obtained during the Fall 2015 Session.

## <a name="fields">2. Field Definitions</a>
ID integer : PRIMARY KEY; uuid for this Portland Neighborhood.

NAME varchar : commonly used name for this Portland neighborhood.

AREA numeric(12, 2) : size of neighborhood. _Open Issue_: What units are used?

IN_PORTLAND boolean : true when this neighborhood is in Portland.

DATA_SOURCE_ID integer : Foreign key to data_source

DATE_LOADED timestamp WITH TIME ZONE DEFAULT now() : when this row was loaded

### Sample query
Displays all of the Block Groups overlapping a neighborhood whose name starts with "Northwest" in which at least 25% of the Block Group is contained within the neighborhood area:

<pre><code>select bg.gisjoin, n.id, bg.percent_inside, n.name 
from census_block_groups_in_pdx_neighborhood bg 
  inner join pdx_neighborhood n 
    on bg.neighborhood_id = n.id 
where n.in_portland = true 
  and n.name like 'Northwest%' 
  and bg.percent_inside > 25.0 
order by n.name, bg.gisjoin;</code></pre>

## <a name="loading">3. Loading</a>
We used [pgloader](http://pgloader.io/) to load the CSV file into a PostgreSQL database. The scripts, data, and instructions are located here: [https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/scripts/data-loaders](https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/scripts/data-loaders)
