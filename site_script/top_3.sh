#!/bin/bash
DATE=`date "+%m%d%Y_%H%M"`
SUDO="sudo -i";
SHORT_SITENAME=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o LogLevel=QUIET -t -t $1 "hostname -s" | tr -d '\r' );
clear

active_container=`ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o LogLevel=QUIET -t -t $1 "sudo bash /bigmac/container-setup/history.sh -n ACTIVE"`;
active_container="${active_container%%[[:cntrl:]]}"

ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o LogLevel=QUIET -t -t ${1} " ${SUDO} /bigmac/container-setup/runInContainer.sh -c \"${active_container}\" -u bm -qqqq \"  top -b -n 3 > /bigmac/logs/top_n3_$SHORT_SITENAME_$DATE.log  \" || exit 1"

ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o LogLevel=QUIET -t -t ${1} " ${SUDO}  top  || exit 1"

