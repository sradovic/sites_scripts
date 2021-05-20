#!/bin/bash
clear
cmdpid=$BASHPID; (sleep 10; kill $cmdpid) & exec ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 " sudo tail -f  /bigmac/weblogic_logs-active/javagc.log ;"

