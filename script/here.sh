#!/bin/sh
## here.sh for WHOIS in /u/a1
##
## Made by axel berardino
## Login   <berard_a@epita.fr>
##
## Started on  Sat Mar 31 18:21:23 2007 axel berardino
## Last update Mon Sep 24 17:05:07 2007 axel berardino
##

nb=0
tot=0
connection=0
for i in `ls /afs/epitech.net/users/epita_2009/`; do
tot=$(( tot + 1 ))
    b=`ns_who $i`
    for a in $b; do
	connection=$(( $connection + 1))
	user=`echo $a | cut -d "@" -f 1`
	host=`echo $a | cut -d "@" -f 2`
	a=`echo $host | cut -d "-" -f 1`
	if [ "$a" = "sm" ]; then
	    echo -e "$user     \t -> \t $host"
	    nb=$(( $nb + 1 ))
	fi
    done
done

echo
res=`echo "scale=2; ($nb / $tot) * 100" | bc`
echo "ING1:"
echo "  $nb/$tot physical presences ($res% of presence)"
echo "  Found $connection active connections"
