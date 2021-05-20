#!/bin/bash
site=$1
bash ./lib/ch_running_task.sh $1
bash ./lib/killtask.sh $1
