#! /bin/bash
# Appends a GEOID10 column to the end of an NHGIS CSV file, by
# concatenating the STATEA + COUNTYA + TRACTA + BLCK_GRPA fields.
# A GEOID10 property appears in Block Group *.shp files, so this new
# column in the CSV file can be used to select data by Block Group.
# Other clean-up:
#  Removes the decimal point from the first data column, so that
#  it will be treated as an integer.
# Limitations:
#   This script only works for CSV files that were downloaded from nhgis.com
#   with only 'Block Group' selected as the 'Geographic Level'.
# Usage:
#   Reads from stdin
#   Writes to stdout
# Example:
#   $ geoid10.sh < population_by_blkgrp.csv > population_by_blkgrp-geoid10.csv
awk -F, '{printf("%s,%s%s%s%s\n", $0, $4, $6, $7, $8)}' | sed 's/""//g' | sed 's/STATEACOUNTYATRACTABLCK_GRPA/GEOID10/g'
