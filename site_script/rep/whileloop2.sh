#!/bin/bash
for line in `cat List.txt`
do
   echo $line
   Host=$(ssh -t ${line} "hostname -s")
   bash collect_40927967.sh $line
done

