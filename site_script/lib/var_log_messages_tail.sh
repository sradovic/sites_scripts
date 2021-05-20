#!/bin/bash
clear
ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -t -t $1 " sudo tail -200  /var/log/messages ;"

