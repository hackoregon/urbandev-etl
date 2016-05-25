#!/bin/bash

select=$1
output=$2

cat $select | mysql -p -u urbandevstg_user -D urbandev_stg > $output
