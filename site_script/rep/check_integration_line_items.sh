#!/bin/bash
DATE=`date "+%m%d%Y"`
Site_url=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "grep ^site_url /bmfs/cpqShared/conf/server.properties | cut -f2 -d=" );
Site_url="${Site_url%%[[:cntrl:]]}"
integration_line_items=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 " grep integration_line_items /bmfs/cpqShared/conf/* | cut -d= -f2
")
Vm_name=$(echo $1 | cut -f1 -d.)
integration_line_items="${integration_line_items%%[[:cntrl:]]}"
echo $integration_line_items

echo "$Vm_name,$Site_url,${integration_line_items}" >> ./integration_line_items.csv
