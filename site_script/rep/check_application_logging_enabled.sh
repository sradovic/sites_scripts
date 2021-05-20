#!/bin/bash
DATE=`date "+%m%d%Y"`
SHORT_SITENAME=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "hostname -s" | tr -d '\r' );
application_logging_enabled=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 " grep application_logging_enabled /bmfs/cpqShared/conf/* | cut -d= -f2
")
application_logging_enabled="${application_logging_enabled%%[[:cntrl:]]}"
echo $application_logging_enabled
if [[ ${application_logging_enabled} == "false" ]] 
then
 echo "it is false"
 echo "${SHORT_SITENAME},${application_logging_enabled}" >> ./application_logging_disable.csv
else
 echo "it is true"
 echo "${SHORT_SITENAME},${application_logging_enabled}" >> ./application_logging_enable.csv
fi
