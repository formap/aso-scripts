#!/bin/bash

if [ $# -ne 1 ]; then
	echo "You have to provide a username"
	exit 1
fi

home=`cat /etc/passwd | grep "^$1\>" | cut -d: -f6`
homeOut="Home: $home"
echo $homeOut

size=`du -hs $home | cut -f1`
sizeOut="Home size: $size"
echo $sizeOut

otherDir=`find / -type d -user $1 2>/dev/null | grep -v $1`
otherDir="Other dirs: $otherDir"
echo $otherDir

numProc=`ps -ao user | grep $1 | wc -l`
numProc="Active processes: $numProc"
echo $numProc


