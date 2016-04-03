# [Hack Oregon](http://www.hackoregon.org/) - Urban Development project
# Data Book for Table: census\_total\_population\_blkgrp

**Table of Contents**

1. <a href="#datasource">Data Source</a><br>
2. <a href="#extraction">Extraction</a><br>
3. <a href="#transformation">Transformation</a><br>
4. <a href="#loading">Loading</a><br>

## <a name="datasource">1. Data Source</a>
The [code book](https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/census_total_population_blkgrp-codebook-NHGIS.txt), which explains the meaning of each of the fields, was obtained with the data from the National Historical Geographic Information System ([NHGIS](https://www.nhgis.org/)).

## <a name="extraction">2. Extraction</a>
Data was downloaded as a CSV file from NHGIS [Time Series Tables](https://www.nhgis.org/documentation/time-series). In the NHGIS [Data Finder](https://data2.nhgis.org/main), we filtered for:

*  'Geographic Levels' > 'Block Group'

then found the table named: "Total Population" for 2000, 2010 at the Block Group level. We downloaded that table as a single CSV file.

## <a name="transformation">3. Transformation</a>

### Extracted data for Oregon and Washington.
On our local workstation, we opened the CSV file in a text editor and deleted all lines for states other than Oregon and Washington. The data is sorted by state, so it was easy to delete find the lines with records from those states.

### Built the DEOID10 key
We ran a script, [geoid10.sh](https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/scripts/bin/geoid10.sh), to construct the GEOID10 column that is used to link a row of data to a Block Group `shp` file.

## <a name="loading">4. Loading</a>
We used [pgloader](http://pgloader.io/) to load the CSV file into a PostgreSQL database. The scripts, data, and instructions are located here: [https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/scripts/data-loaders](https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/scripts/data-loaders)
