#!/bin/bash

number="120";
deley="1";
DATE=`date "+%m-%d-%Y_%H:%M:%S"`
SUDO="sudo -i";


while getopts ":H:N:D:" o ; do
  case "${o}" in
    H)
      HOST_SITE=${OPTARG};
      ;;
    N)
      number=${OPTARG};
      ;;
    D)
      deley=${OPTARG};
      ;;

    *)
      usage;
      ;;
    ?)
      usage;
     ;;
  esac
done
shift $((OPTIND -1))

SHORT_SITENAME=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $HOST_SITE "hostname -s" | tr -d '\r' );
active_container=`ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $HOST_SITE "sudo bash /bigmac/container-setup/history.sh -n ACTIVE"`;
active_container="${active_container%%[[:cntrl:]]}"
java_procces=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t ${HOST_SITE} " ${SUDO} /bigmac/container-setup/runInContainer.sh -c \"${active_container}\" -u bm -qqqq \" ps -ef | grep [D]java  \" || exit 1")
jpid=$(echo "${java_procces}"| grep cpqServer | awk '{print $2}')
hname=$(ssh -t -t ${HOST_SITE} " ${SUDO} hostname | cut -d . -f 1")
td_home=/bigmac/logs
#tstamp=`date +%d-%b-%Y`
#thdStamp=`date +%d-%b-%Y-%H`

hname="${hname%%[[:cntrl:]]}"
echo "Runing tdumps on ${hname}. ${number} times in interval of ${deley} seconds."
ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t ${HOST_SITE} " ${SUDO} /bigmac/container-setup/runInContainer.sh -c \"${active_container}\" -u bm -qqqq \" for ((i = 1 ; i <= $number ; i++)); do  echo '.' ; /usr/java/latest/bin/jstack $jpid >> $td_home/${hname}-${DATE}-tdump.log; sleep $deley; done  \" || exit 1"
echo "Done!";
echo "tdumps are located in /bigmac/logs-active/$td_home/${hname}-${DATE}-tdump.log"
