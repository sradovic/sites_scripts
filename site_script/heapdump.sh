#!/bin/bash
DATE=`date "+%m%d%Y_%H%M"`
SUDO="sudo -i";
SHORT_SITENAME=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "hostname -s" | tr -d '\r' );
free_disk_space=`ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "df -h | grep ^/dev/mapper "`;
free_disk=$( echo $free_disk_space | awk '{print $4}'| sed 's/.$//')
javamem=`ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 " cat /bigmac/conf/node1.properties "`;
Xmx=$( echo $javamem |  tr ' ' '\n' | grep ^-Xmx )
#heap=$(echo ${Xmx:4:2} | sed 's/^....//' | sed 's/.$//')
heap=$(echo ${Xmx:4} | sed 's/.$//')
heapbck=$(echo ${Xmx:4} | sed 's/.$//')
echo $"Java Heap size in node1.properties is ${heap}GB" 
let heap=heap+10
echo $"You will need  ${heap}GB  disk space"
#echo "free_disk=$free_disk"
free_disk="$(echo ${free_disk}| cut -d '.' -f1)";
#echo $SSITENAME

if [[ ${free_disk} -gt ${heap} ]] ; then
        echo "You have enought free disk space to run heapdump for $SHORT_SITENAME I will run heapdump on $SHORT_SITENAME"
else
        echo " I am not sure you have enough free disk space to run heapdump on $SHORT_SITENAME I will exit!!!"
        exit 1;  
fi

active_container=`ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "sudo bash /bigmac/container-setup/history.sh -n ACTIVE"`;
active_container="${active_container%%[[:cntrl:]]}"
java_procces=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t ${1} " ${SUDO} /bigmac/container-setup/runInContainer.sh -c \"${active_container}\" -u bm -qqqq \" ps -ef | grep [D]java  \" || exit 1")
jpid=$(echo "${java_procces}"| grep cpqServer | awk '{print $2}')

ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t ${1} "
		${SUDO} /bigmac/container-setup/runInContainer.sh -c \"${active_container}\" -u bm -qqqq \"
		/usr/java/latest/bin/jmap -dump:format=b,file=/bigmac/weblogic_logs/${SHORT_SITENAME}_${DATE}-heap $jpid
		\" || exit 1;
" || exit 1;

printf "Do you want to restart site ${SHORT_SITENAME}: (y/n) \n";
        read x ;
	if [[ ${x} == 'y' ]]
        	then
                       bash restart_site.sh ${1}
        fi

printf " Do you want to gzip the latest heapdump? /bigmac/weblogic_logs-active/${SHORT_SITENAME}_${DATE}-heap  : (y/n) \n";
        read x ;
        if [[ ${x} == 'y' ]]
                then
                        free_disk_space1=`ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "df -h | grep ^/dev/mapper "`;
                        free_disk1=$( echo $free_disk_space1 | awk '{print $4}'| sed 's/.$//');
#                        echo "free_disk1=$free_disk1"
                        free_disk1="$(echo ${free_disk1}| cut -d '.' -f1)";
#                        echo "free_disk1=$free_disk1" 
#                        echo "Free disk space $free_disk1"
                        if [[ ${free_disk1} -gt ${heapbck} ]] ; then
                                         echo "You have enought free disk space ${free_disk1}GB to gzip heapdump on $SHORT_SITENAME "
                        	else
                                         echo " I am not sure you have enough free disk space ${free_disk1}GB to gzip heapdump on $SHORT_SITENAME I will exit!!!"
                                         exit 1;
                        fi
                        echo ""
                        echo " running gzip /bigmac/weblogic_logs-active/${SHORT_SITENAME}_${DATE}-heap"
                        bash ./lib/gzip.sh ${1}  /bigmac/weblogic_logs-active/${SHORT_SITENAME}_${DATE}-heap
        fi
