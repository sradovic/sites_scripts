#!/bin/bash
#DATE=`date "+%m%d%Y_%H%M"`
#SHORT_SITENAME=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "hostname -s" | tr -d '\r' );
#active_container=`ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "sudo bash /bigmac/container-setup/history.sh -n ACTIVE"`;
#active_container="${active_container%%[[:cntrl:]]}"
#ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 " sudo cp  /bigmac/weblogic_logs-active/javagc.log  /bigmac/weblogic_logs-active/${SHORT_SITENAME}_javagc_${DATE}.log;"
bash ./lib/backup_javalogs.sh $1

