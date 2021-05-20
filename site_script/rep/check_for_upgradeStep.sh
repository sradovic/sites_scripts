#!/bin/bash
DEST_SITE=$1
DATE=`date "+%m%d%Y_%H%M"`
SUDO="sudo -i";
SHORT_SITENAME=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "hostname -s" | tr -d '\r' );
ssh  -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t ${1}  " 
                          if sudo test  -f "/bigmac/bin/upgradeStep.log" 
                          then
                                echo "/bigmac/bin/upgradeStep.log exists on ${DEST_SITE}"
                                exit 254
                          else
                                echo "  ${DEST_SITE} is OK "
                                exit 255
                          fi
						"
file_exist="$?"
if [ ${file_exist} -eq "254" ]
                        then
                                echo " update step log exist on ${DEST_SITE}" >> ./upgrade_step_exist.txt
                       
                        fi;
