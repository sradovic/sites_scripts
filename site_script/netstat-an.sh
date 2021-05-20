#!/bin/bash
DATE=`date "+%m-%d-%Y_%H:%M:%S"`
SUDO="sudo -i";
SHORT_SITENAME=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o LogLevel=QUIET -t -t $1 "hostname -s" | tr -d '\r' );
active_container=`ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o LogLevel=QUIET -t -t $1 "sudo bash /bigmac/container-setup/history.sh -n ACTIVE"`;
active_container="${active_container%%[[:cntrl:]]}"

ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o LogLevel=QUIET -t -t ${1} " ${SUDO} /bigmac/container-setup/runInContainer.sh -c \"${active_container}\" -u bm -qqqq \" netstat -an | grep 5000  \" || exit 1"
echo ""
echo "Number of db connections is:"
no_conn=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o LogLevel=QUIET -t -t ${1} " ${SUDO} /bigmac/container-setup/runInContainer.sh -c \"${active_container}\" -u bm -qqqq \" netstat -an | grep 5000 | wc \" || exit 1") 
echo $no_conn | awk '{print $1}'
