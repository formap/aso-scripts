#!/bin/bash
if [ $# -ne 1 ]; then
  echo "Wrong parameters"
  exit 1
fi

while true
do
  echo `netstat -i | tail -n +3 | awk '{print $1 ":    " $8}'`
  `sleep $1`
done
