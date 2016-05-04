#!/bin/bash
# Usage:
# $ ogr2ogr myDbUserName myDbPassword
echo "Loading ..."
ogr2ogr -f "PostgreSQL" PG:"host=localhost dbname=urbandev user=$1 password=$2" data/BlockGroups-2010-OR-shape/OR_blck_grp_2010.shp -nln shp_2010_blkgrp -skipfailures -overwrite &> load_shp_2010_blkgrp.log
echo "Done. See load_shp_2010_blkgrp.log"
