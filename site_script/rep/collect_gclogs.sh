#!/bin/bash
for line in `cat List.txt`
do
#   echo $line
#   Host=$(ssh -t ${line} "hostname -s")
   bash ../backup_javalogs_new.sh $line
done

