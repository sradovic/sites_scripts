#!/bin/bash
echo "Vm name,Site url,integration_line_items" > ./integration_line_items.csv
for line in `cat $1`
do
   echo $line
   bash check_integration_line_items.sh $line
done

