#!/bin/bash
DATE=`date "+%m-%d-%Y_%H:%M:%S"`
SUDO="sudo -i";
SHORT_SITENAME=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o LogLevel=QUIET -t -t $1 "hostname -s" | tr -d '\r' );
active_container=`ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o LogLevel=QUIET -t -t $1 "sudo bash /bigmac/container-setup/history.sh -n ACTIVE"`;
active_container="${active_container%%[[:cntrl:]]}"

ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o LogLevel=QUIET -t -t ${1} " ${SUDO} /bigmac/container-setup/runInContainer.sh -c \"${active_container}\" -u bm -qqqq \" netstat -an | egrep ':80|:443' | grep ESTABLISHED | sort -n | uniq -c | sort -nr  \" || exit 1"
echo ""
echo "Number of OHS connections is:"
no_conn=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o LogLevel=QUIET -t -t ${1} " ${SUDO} /bigmac/container-setup/runInContainer.sh -c \"${active_container}\" -u bm -qqqq \" netstat -an | egrep ':80|:443' | grep ESTABLISHED | sort -n | uniq -c | sort -nr | wc  \" ")
echo $no_conn | awk '{print $1}'

