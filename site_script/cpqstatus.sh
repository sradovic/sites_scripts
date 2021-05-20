#!/bin/bash
SUDO="sudo -i";
active_container=`ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o LogLevel=QUIET -t -t $1 "sudo bash /bigmac/container-setup/history.sh -n ACTIVE"`;
active_container="${active_container%%[[:cntrl:]]}"

ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o LogLevel=QUIET -t -t ${1} " ${SUDO} /bigmac/container-setup/runInContainer.sh -c \"${active_container}\" -u bm -qqqq \" /bigmac/bin/cpqctl status  \" || exit 1"
