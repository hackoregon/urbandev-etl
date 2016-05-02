# [Hack Oregon](http://www.hackoregon.org/) - Urban Development project
# Data Book for Tables: acs\_household\_income\_2009\_blkgrp and acs\_household\_income\_2014\_blkgrp

**Table of Contents**

1. <a href="#datasource">Data Source</a><br>
2. <a href="#extraction">Extraction</a><br>
3. <a href="#transformation">Transformation</a><br>
4. <a href="#loading">Loading</a><br>

## <a name="datasource">1. Data Source</a>
The code books, [acs_household_income_2009_blkgrp_codebook.txt](https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/acs_household_income_2009_blkgrp_codebook.txt) and [acs_household_income_2014_blkgrp_codebook.txt](https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/doc/codebooks/acs_household_income_2014_blkgrp_codebook.txt), which explain the meaning of each of the fields, were obtained with the data from the National Historical Geographic Information System ([NHGIS](https://www.nhgis.org/)).

## <a name="extraction">2. Extraction</a>
Data was downloaded as a CSV file from NHGIS [Time Series Tables](https://www.nhgis.org/documentation/time-series). In the NHGIS [Data Finder](https://data2.nhgis.org/main), we filtered for:

*  'Geographic Levels' > 'Block Group'

then found the tables from the American Community Survey (ACS) 5-Year Data named: "Household Income in the Past 12 Months" for 2004-2009 and 2010-2015 at the Block Group level. We downloaded those tables as separate CSV files with data for Oregon and Washington.

## <a name="transformation">3. Transformation</a>

### Built the GEOID10 key
We ran a script, [geoid10.sh](https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/scripts/bin/geoid10.sh), to construct the GEOID10 column that is used to link a row of data to a Block Group `shp` file.

## <a name="loading">4. Loading</a>
We used [pgloader](http://pgloader.io/) to load the CSV file into a PostgreSQL database. The scripts, data, and instructions are located here: [https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/scripts/data-loaders](https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/scripts/data-loaders)
