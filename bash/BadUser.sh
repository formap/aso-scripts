#!/bin/bash

p=0

usage="Usage: BadUser.sh [-p]"
# detecció de opcions d'entrada: només son vàlids: sense paràmetres i -p
if [ $# -ne 0 ]; then
    if  [ $# -eq 1 ] || [ $# -eq 2 ]; then
        if [ $1 == "-p" ] || [ $1 == "-t" ]; then 
            p=1
        else
            echo $usage; exit 1
        fi 
    else 
        echo $usage; exit 1
    fi
fi
# afegiu una comanda per llegir el fitxer de password i només agafar el camp de # nom de l'usuari
if [ $1 == "-p" ]; then 
	for user in `cat /etc/passwd | cut -d: -f1`; do
	    home=`cat /etc/passwd | grep "^$user\>" | cut -d: -f6`
	    if [ -d $home ]; then
		num_fich=`find $home -type f -user $user | wc -l`
	    else
		num_fich=0
	    fi
	    if [ $num_fich -eq 0 ] ; then
		if [ $p -eq 1 ]; then
	# afegiu una comanda per detectar si l'usuari te processos en execució, 
	# si no te ningú la variable $user_proc ha de ser 0
		    user_proc=`ps --no-headers -u $user | wc -l`
		    if [ $user_proc -eq 0 ]; then
		        echo "$user"
		    fi
		else
		    echo "$user"
		fi
	    fi    
	done
fi

if [ $1 == "-t" ]; then 
	len=${#2}
	num=${2:0:len-1}
	letter=${2: -1}
	if [ $letter == "m" ]; then
		num=$(( $num * 30 ))
	fi
	cont=0
	num=$(( $num * 24 ))
	for user in `lastlog -b $num | awk '{print $1}'`; do
		if [ $cont -ne 0 ]; then
			files=`find /home -user $user -mtime +$num | wc -l`
			if [ $files -eq 0 ]; then
				echo $user;
			fi
		fi
	cont=$(( $cont + 1 ))
	done
fi

exit 0

