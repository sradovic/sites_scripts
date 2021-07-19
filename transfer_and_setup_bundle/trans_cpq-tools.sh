#!/bin/bash
cpqtools=$1   #cpqtools
#dockerimg=$2 # docker image
SHOPTS="-o StrictHostKeyChecking=no -o PasswordAuthentication=no"
#version=$(echo "${cpqtools}" | cut -d'.' -f1-3)

logging (){
mkdir -m 777 logs 2>/dev/null
exec 2>logs/transfer_cpqtoolss-${version}-`date +'%Y%m%d-%H%M'`.log
set -x
}

logging


#[[ -f /fsnhome/sradovic/transfer/${dockerimg} ]] || exit 1 ;
if [ -f "/fsnhome/sradovic/transfer/${cpqtools}" ]
                        then
                                ssh  172.27.254.80 "cd /fsnhome/sradovic/transfer/; tar -zcvf - ./${cpqtools}" | ssh  172.27.34.215 "cd /fsnhome/sradovic/transfer/; tar -zxvf -"
                                ssh  172.27.254.80 "cd /fsnhome/sradovic/transfer/; tar -zcvf - ./${cpqtools}" | ssh  172.30.41.185 "cd /fsnhome/sradovic/transfer/; tar -zxvf -"
                                ssh  172.27.254.80 "cd /fsnhome/sradovic/transfer/; tar -zcvf - ./${cpqtools}" | ssh  172.30.34.211 "cd /fsnhome/sradovic/transfer/; tar -zxvf -"
                                ssh  172.27.254.80 "cd /fsnhome/sradovic/transfer/; tar -zcvf - ./${cpqtools}" | ssh  172.30.41.185 "cd /fsnhome/sradovic/transfer/; tar -zxvf -"

#                                bastions=("172.27.34.215" "172.27.41.198" "172.27.49.61" "172.30.34.211" "172.30.41.185" "172.30.48.11")

#                                for bastion_ip in ${bastions[*]}; do

#                                                         echo "connecting to $bastion_ip"
#                                   ssh $SSHOPTS -t -t ${bastion_ip} "echo    'installing cpqtools ${bundel} on ${bastion_ip}';
#                                                                     echo ' '
#                                                                     cd /upgrade ;
#                                                                     sudo cp  /fsnhome/sradovic/transfer/${cpqtools} ./ ;
#                                                                     sudo tar -xzvf ${cpqtools} >/dev/null ;
#                                                                     cd /upgrade/${version} ;
#                                                                     sudo ln -s /upgrade/upgrade_bundle/bundle/ components ;
#                                                                     sudo mkdir runEnv tmp ;
#                                                                     sudo chmod -R 777 runEnv tmp ;
#                                                                     echo    'cpqtools ${bundel} instaled on ${bastion_ip}' ;
#                                                                     echo ' '
#                                         "
#                                  done
else
                                echo "file /fsnhome/sradovic/transfer/${cpqtools} does not exists!!!";

fi;

