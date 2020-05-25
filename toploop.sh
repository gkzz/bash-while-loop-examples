#!/bin/bash

# your monitored process, e.g. dockerd
process=$1

starttime=`date +"%Y%m%d_%H%M%S"`
filename=`echo "log/top.log.$process.$starttime"`

while true
do
  sleep 5
  output=`top -n 1| grep $process`
  val=`echo $output | awk '{print $13}'`
  if [ "$val" == "$process" ]; then
    num=`echo "$output" | grep -oP "[S|R]\s+[0-9]*[.]?[0-9]" | awk '{print $2}'`
    date +"%Y%m%d_%H%M%S" >> $filename
    echo "$process:  $num%" >> $filename
  else
    date +"%Y%m%d_%H%M%S" >> $filename
    echo "$process: notfound" >> $filename
  fi
done
