#!/bin/bash
SUDO="sudo -i";
g_target=$1
active_container=`ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "sudo bash /bigmac/container-setup/history.sh -n ACTIVE"`;
active_container="${active_container%%[[:cntrl:]]}"
echo "$active_container"

g_editionName=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t ${1}  " ${SUDO} /bigmac/container-setup/runInContainer.sh -c \"${active_container}\" -u bm -qqqq \" cat /bigmac/cpq/bigmachines/WEB-INF/src/sql/oracle/editions/editionVersion.properties | grep editionName | cut -d '=' -f2 \" || exit 1") || return 1;




#g_editionName=$(ssh -t -t ${g_target} " ${SUDO} /bigmac/container-setup/runInContainer.sh -c \"${g_active_container_name}\" -u bm -qqqq \" cat /bigmac/cpq/bigmachines/WEB-INF/src/sql/oracle/editions/editionVersion.properties | grep editionName | cut -d '=' -f2 \" || exit 1") || return 1;
echo "Edition of $g_target is $g_editionName"
