# [Hack Oregon](http://www.hackoregon.org/) - Urban Development data conversion 

For this iteration of Hack Oregon's Urban Development Project, we decided to switch datasets.
We're going with neighborhood boundaries sourced from Zillow and Census data source from the [NHGIS](https://www.nhgis.org/).

This directory contains scripts and data used to convert data from their source form to a custom JSON format for consumption
and visualization by the web front-end.

### Neighborhoods

Neighborhood data was supplied as geojson, but we want to remove any non-Portland Metro shapes. This data processing was done as follows:

1. Load the geojson file [*zillow-neighborhoods-orig.json*](https://github.com/hackoregon/urbandev-etl/blob/master/convert/data/zillow-neighborhoods-orig.json) into [QGIS](http://www.qgis.org)
2. Convert to geojson layer to a shapefile
3. Edit the shapefile to remove all neighborhoods not in Metro Portland (ie: Salem & Eugene)
4. Save the shapefile to: [*zillow-neighborhoods.shp*](https://github.com/hackoregon/urbandev-etl/blob/master/convert/data/zillow-neighborhoods.shp)
5. Export the shapefile back to geojson: [*zillow-neighborhoods.geojson*](https://github.com/hackoregon/urbandev-etl/blob/master/convert/data/zillow-neighborhoods.geojson)



