#!/bin/bash
DATE=`date "+%m%d%Y_%H%M"`
SUDO="sudo -i";
SHORT_SITENAME=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "hostname -s" | tr -d '\r' );
free_disk_space=`ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "df -h | grep ^/dev/mapper "`;
free_disk=$( echo $free_disk_space | awk '{print $4}'| sed 's/.$//')
javamem=`ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 " cat /bigmac/conf/node1.properties "`;
Xmx=$( echo $javamem |  tr ' ' '\n' | grep ^-Xmx )
heap=$(echo ${Xmx:4} | sed 's/.$//')
echo $Xmx
echo "Java heap size for $SHORT_SITENAME is $heap"
if [[ ${heap} -lt "9" ]] ; then
        echo "check node 1 property for $SHORT_SITENAME . Java heap is less then 9 GB .it is ${heap}GB "
        echo "check node 1 property for $SHORT_SITENAME . Java heap is less then 9 GB .it is ${heap}GB " >> java_heap_report.txt	
fi
