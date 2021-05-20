#!/bin/bash
for line in `cat List.txt`
do
   echo $line
   Host=$(ssh -t ${line} "hostname -s")
   bash checkjavaheapsize.sh $line
#   Crm=$(ssh -t ${WORD} "if [[ -e /bmfs/cpqShared/conf/application.properties ]] ; then grep 'crm_partner' /bmfs/cpqShared/conf/application.properties; else grep 'crm_partner' /bigmac/conf/application.properties; fi")
#echo -n "${Host}"  >> text.txt
#echo "${Crm}" >> text.txt
done

