#!/bin/bash
./cpqstatus.sh $1
echo ""
echo ""
./netstat-an.sh $1
echo ""
echo ""
./netstat-ohs.sh $1
echo ""
echo ""
printf "Do yo want to tail java gc logs of ${SHORT_SITENAME}for 10 sec?: (y/n) \n";
        read x ;
        if [[ ${x} == 'y' ]]
                then
                       ./lib/javalogs_tail-f_10Sec.sh $1
        fi
echo ""

printf "Do yo want to tail java var_log_messages of ${SHORT_SITENAME} 200 lines?: (y/n) \n";
        read x ;
        if [[ ${x} == 'y' ]]
                then
                       ./lib/var_log_messages_tail.sh $1
        fi

