#!/bin/bash
echo "SITENAME,wmIntegrateUsers,wmConnectionMethod" >> ./wmIntegrate.csv
for line in `cat $1`
do
   echo $line
   Host=$(ssh -t ${line} "hostname -s")
   bash collect_wmIntegrateUsers.sh $line
done

