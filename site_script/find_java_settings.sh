#!/bin/bash
SHORT_SITENAME=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "hostname -s" | tr -d '\r' );
echo "$SHORT_SITENAME"
node1_properties=$(ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 "sudo cat /bigmac/conf/node1.properties")
java_settings=$(echo "$node1_properties" | tr ' ' '\n' | grep X |grep -v Xl)
echo ""
echo "Java settings in node1.properties for $SHORT_SITENAME are:"
echo ""
echo $java_settings | tr ' ' '\n'
