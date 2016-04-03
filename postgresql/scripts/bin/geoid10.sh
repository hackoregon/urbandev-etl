#! /bin/bash
# Appends a GEOID10 column to the end of an NHGIS CSV file, by
# concatenating the STATEA + COUNTYA + TRACTA + BLCK_GRPA fields.
# A GEOID10 property appears in Block Group *.shp files, so this new
# column in the CSV file can be used to select data by Block Group.
# Limitations:
#   This script only works for CSV files that were downloaded from nhgis.com
#   with only 'Block Group' selected for the 'Geographic Level'.
# Usage:
#   Reads from stdin
#   Writes to stdout
# Example:
#   $ geoid10.sh < nhgis0008_ts_geog2010_blckgrp.csv > census_total_population_blkgrp.csv
awk -F, '{printf("%s,%s%s%s%s\n", $0, $4, $6, $7, $8)}' | sed 's/""//g' | sed 's/STATEACOUNTYATRACTABLCK_GRPA/GEOID10/g'
