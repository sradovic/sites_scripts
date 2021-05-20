#!/bin/bash
SSITENAME="$(echo ${1}| cut -d '.' -f1)";
echo "$SSITENAME"
SUDO="sudo -i";
active_container=`ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "sudo bash /bigmac/container-setup/history.sh -n ACTIVE"`;
active_container="${active_container%%[[:cntrl:]]}"
echo $active_container
wmIntegrateUsers=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t ${1}  " ${SUDO} /bigmac/container-setup/runInContainer.sh -c \"${active_container}\" -u bm -qqqq \" grep -E "wmIntegrateUsers="  /bmfsweb/$SSITENAME/global/wmIntegration.ini \" || exit 1") || return 1;
wmConnectionMethod=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t ${1}  " ${SUDO} /bigmac/container-setup/runInContainer.sh -c \"${active_container}\" -u bm -qqqq \" grep -E "wmConnectionMethod="  /bmfsweb/$SSITENAME/global/wmIntegration.ini \" || exit 1") || return 1;
SSITENAME="${SSITENAME%%[[:cntrl:]]}"
wmIntegrateUsers="${wmIntegrateUsers%%[[:cntrl:]]}"
wmConnectionMethod="${wmConnectionMethod%%[[:cntrl:]]}"
echo "${SSITENAME},${wmIntegrateUsers},${wmConnectionMethod}" >> ./wmIntegrate.csv
#echo " ${wmIntegrateUsers}"
#echo " ${wmConnectionMethod}"
