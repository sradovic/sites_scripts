#!/bin/bash
SUDO="sudo -i";
runtool_properties=$(cat ./lib/runtool_properties)
echo "$runtool_properties"
sudo scp  ./lib/runtool_properties $1:/bigmac/weblogic_logs-active/;
active_container=`ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "sudo bash /bigmac/container-setup/history.sh -n ACTIVE"`;
active_container="${active_container%%[[:cntrl:]]}"
sitename=$1
username=$2
password=$3
ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t ${sitename} "sudo  systemctl restart rngd"
ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t ${sitename} " ${SUDO} /bigmac/container-setup/runInContainer.sh -c \"${active_container}\" -u bm -qqqq \" rm -rf /bigmac/bin/run_tool.properties ; cat /bigmac/weblogic_logs/runtool_properties >> /bigmac/bin/run_tool.properties  \" || exit 1"
ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t ${sitename} "
                                                                               sudo -i su - --session-command '
                bash /home/bm/.bash_profile; /bigmac/bin/run_tool.sh  -resetpasswd $username@bigmachines.com $password
          ';
"
ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t ${sitename} " ${SUDO} /bigmac/container-setup/runInContainer.sh -c \"${active_container}\" -u bm -qqqq \" rm -rf /bigmac/bin/run_tool.properties ; \" || exit 1"
