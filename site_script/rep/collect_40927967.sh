#!/bin/bash
DATE=`date "+%m%d%Y"`
SHORT_SITENAME=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "hostname -s" | tr -d '\r' );
properties=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 " cat /bmfs/cpqShared/conf/application.properties /bmfs/cpqShared/conf/implementation.properties /bmfs/cpqShared/conf/server.properties ");
echo "$properties"  | grep -v "#" | grep -v ldap_binddn_password | grep -v external_mail_server_password | grep -v -e '^$' > /fsnhome/sradovic/aggregate_propperties/tst27/aggregate_propperties_${SHORT_SITENAME}_${DATE}.txt
