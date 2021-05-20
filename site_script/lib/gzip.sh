#!/bin/bash
DATE=`date "+%m%d%Y_%H%M"`
SHORT_SITENAME=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "hostname -s" | tr -d '\r' );

ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "sudo chmod 644 $2 ;
                                                                       sudo gzip $2
                                                                          "
echo ""
sleep 1
echo "	The heapdump is gzipped as ${2}.gz"
echo " "
