# [Hack Oregon](http://www.hackoregon.org/) - Urban Development project
# Data Book for Table: census\_housing\_units\_tenure

**Table of Contents**

1. <a href="#datasource">Data Source</a><br>
2. <a href="#extraction">Extraction</a><br>
3. <a href="#transformation">Transformation</a><br>
4. <a href="#loading">Loading</a><br>

## <a name="datasource">1. Data Source</a>
The [code book](https://github.com/hackoregon/urbandev-backend/tree/master/db/postgresql/doc/census_housing_units_tenure-codebook-NHGIS.txt), which explains the meaning of each of the fields, was obtained with the data from the National Historical Geographic Information System ([NHGIS](https://www.nhgis.org/)).

## <a name="extraction">2. Extraction</a>
Data was downloaded as a CSV file from NHGIS [Time Series Tables](https://www.nhgis.org/documentation/time-series). In the NHGIS [Data Finder](https://data2.nhgis.org/main), we filtered for:

*  'Geographic Levels' > 'Census Tract'
*  'Years' > Decennial Years > 2010, 2000, 1990

then found the table named: "Occupied Housing Units by Tenure [2]". We downloaded that table as a single file.

## <a name="transformation">3. Transformation</a>
On our local workstation, we opened the CSV file in a text editor and deleted all lines for states other than Oregon. The data is sorted by state, so it was easy to delete all the lines before Oregon records and then delete all lines after Oregon records. If we need to do this often, it would be easy to write a grep script to do this filtering.

## <a name="loading">4. Loading</a>
We used [pgloader](http://pgloader.io/) to load the CSV file into a PostgreSQL database. The scripts, data, and instructions are located here: [https://github.com/hackoregon/urbandev-backend/tree/master/db/postgresql/scripts/data-loaders](https://github.com/hackoregon/urbandev-backend/tree/master/db/postgresql/scripts/data-loaders)
