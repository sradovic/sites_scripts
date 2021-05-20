#!/bin/bash
DATE=`date "+%m%d%Y_%H%M"`
myuser=$(whoami);
ii=$(host $1 | awk '{print $4}')
ii="${ii%%[[:cntrl:]]}"
if [ $ii == "found:" ] 
then
  echo "Site $ii does not exist" >> does_not_exist.txt
else
 SSHOPTS="-o StrictHostKeyChecking=no -o PasswordAuthentication=no"
 SHORT_SITENAME=$(ssh $SSHOPTS  -t -t $1 "hostname -s" | tr -d '\r' );

 DIPETH1=$(ssh $SSHOPTS -t -t ${1} "grep ^IP /etc/sysconfig/network-scripts/ifcfg-eth1 | cut -f2 -d=");
 DIPETH0=$(ssh $SSHOPTS -t -t ${1} "grep ^IP /etc/sysconfig/network-scripts/ifcfg-eth0 | cut -f2 -d=");
       ssh-keygen -R ${1};
       ssh-keygen -R ${DIPETH0};
       ssh-keygen -R ${DIPETH1};
       ssh-keygen -R ${SHORT_SITENAME};
       ssh $SSHOPTS -t -t ${1} "exit";
       ssh $SSHOPTS -t -t ${DIPETH1} "exit" ;
 ssh $SSHOPTS -t -t $1 " sudo cp  /bigmac/weblogic_logs-active/javagc.log  /bigmac/weblogic_logs-active/${SHORT_SITENAME}_javagc.log;
                                                                        sudo chmod 644  /bigmac/weblogic_logs-active/${SHORT_SITENAME}_javagc.log;
                                                                        scp  /bigmac/weblogic_logs-active/${SHORT_SITENAME}_javagc.log  172.27.254.80:/fsnhome/$myuser/gclogs;
"
fi

