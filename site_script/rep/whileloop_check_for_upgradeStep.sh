#!/bin/bash
for line in `cat List.txt`
do
   echo $line
   Host=$(ssh -t ${line} "hostname -s")
   bash check_for_upgradeStep.sh $line
done

