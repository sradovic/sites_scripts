#!/bin/bash
for line in `cat List.txt`
do
   echo $line
   bash restart_oem.sh $line
done

