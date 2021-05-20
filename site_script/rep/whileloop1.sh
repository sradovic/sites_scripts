#!/bin/bash
for line in `cat List.txt`
do
   echo $line
   Host=$(ssh -t ${line} "hostname -s")
   bash collect_bmfs_prop.sh $line
done

