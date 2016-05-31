#!/bin/bash
# first parameter: IP range; second parameter: PORT(S)
# ./scanPorts.sh 192.168.1.45 80
usage="Usage: scanPorts.sh [IP range] [ports]"

if [ $# -ne 2 ]; then
  echo $usage;
  exit 1
fi

echo `nmap $1 -p $2 --open | awk '/is up/ {print up}; {gsub (/\(|\)/,""); up = $NF}'`;
