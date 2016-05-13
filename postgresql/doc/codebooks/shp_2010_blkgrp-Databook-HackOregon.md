# [Hack Oregon](http://www.hackoregon.org/) - Urban Development project
# Data Book for Table: shp\_2010\_blkgrp

**Table of Contents**

1. <a href="#datasource">Data Source</a><br>
2. <a href="#extraction">Extraction</a><br>
3. <a href="#transformation">Transformation</a><br>
4. <a href="#loading">Loading</a><br>

## <a name="datasource">1. Data Source</a>
The data was obtained from the National Historical Geographic Information System ([NHGIS](https://www.nhgis.org/)).

## <a name="extraction">2. Extraction</a>
Data was downloaded as a zip file from [NHGIS](https://www.nhgis.org/). In the NHGIS [Data Finder](https://data2.nhgis.org/main), we filtered for:

*  'Geographic Levels' > 'blck_grp'
*  'Years' = 2010

then selected the '474 GIS Boundary Files' tab. From the filtered list of files, we selected the file for 'Oregon', which is specified as a '2010 TIGER/Line +' format. We downloaded that table as a zip file.

## <a name="transformation">3. Transformation</a>
There was no data transformation. We unzipped the download file, which resulted in a [folder of 7 files](https://github.com/hackoregon/urbandev-etl/tree/master/postgresql/scripts/data-loaders/data/BlockGroups-2010-OR-shape/), which is in the source tree.

The shape file has two fields that can be used to associate the shapes with the census data files: <code>gisjoin</code> (varchar 15) and <code>geoid10</code> (varchar 12).

## <a name="loading">4. Loading</a>
Use ogr2ogr to load the shape file into the database.
