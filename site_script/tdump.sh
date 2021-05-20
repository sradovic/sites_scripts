#!/bin/bash

number="120";
delay="1";
DATE=`date "+%m%d%Y_%H%M"`
SUDO="sudo -i";

function usage()
{
  echo "Command Syntax: "
  echo
  echo "    $0 -H <fqdn> -D <deley interval> -N <#>"
  echo
  echo "      where: "
  echo "             -H <host fqdn> "
  echo "             -D <delay interval between thread dumps in seconds> "
  echo "             -N <number of thread dumps iterations>"
  echo " "
  echo "      example: "
  echo '             ./tdump.sh  -H cpq-s41-001.web.dem.ch3.bmi  -D 2 -N 60      - 60 times with interval of 2 sec'
  echo
  exit
}

if [[ $1 == "" ]]; then
  usage;
  exit1;
else
  while getopts ":H:N:D:" o ; do
    case "${o}" in
      H)
        HOST_SITE=${OPTARG};
        ;;
      N)
        number=${OPTARG};
        ;;
      D)
        delay=${OPTARG};
        ;;
      *)
        usage;
        ;;
      ?)
        usage;
        ;;
    esac
  done
fi
shift $((OPTIND -1))

SHORT_SITENAME=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $HOST_SITE "hostname -s" | tr -d '\r' );
active_container=`ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $HOST_SITE "sudo bash /bigmac/container-setup/history.sh -n ACTIVE"`;
active_container="${active_container%%[[:cntrl:]]}"
java_procces=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t ${HOST_SITE} " ${SUDO} /bigmac/container-setup/runInContainer.sh -c \"${active_container}\" -u bm -qqqq \" ps -ef | grep [D]java  \" || exit 1")
jpid=$(echo "${java_procces}"| grep cpqServer | awk '{print $2}')
hname=$(ssh -t -t ${HOST_SITE} " ${SUDO} hostname | cut -d . -f 1")
td_home=/bigmac/logs
hname="${hname%%[[:cntrl:]]}"

echo "Runing tdumps on ${hname}. ${number} times in interval of ${delay} seconds."
ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t ${HOST_SITE} "
	${SUDO} /bigmac/container-setup/runInContainer.sh -c \"${active_container}\" -u bm -qqqq \"
		for ((i = 1 ; i <= $number ; i++)); do
			echo tdump number: \\\${i};
			/usr/java/latest/bin/jstack $jpid >> $td_home/${hname}-${DATE}-tdump.log;
			sleep $delay;
		done;
	 \" || exit 1;
" || exit 1;
echo "Done!";

echo "tdumps are located in /bigmac/logs-active/${hname}-${DATE}-tdump.log"
