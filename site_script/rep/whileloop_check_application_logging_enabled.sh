#!/bin/bash
echo "site,application_logging_enabled" > ./application_logging_enabled.csv
echo "site,application_logging_enabled" > ./application_logging_disable.csv
for line in `cat $1`
do
   echo $line
   bash check_application_logging_enabled.sh $line
done

