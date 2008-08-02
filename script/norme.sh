#!/usr/pkg/bin/bash
## norme.sh for NORME in /u/a1/berard_a/script
##
## Made by axel berardino
## Login   <berard_a@epita.fr>
##
## Started on  Sun Nov 12 04:21:03 2006 axel berardino
## Last update Sat Dec 23 02:01:23 2006 axel berardino
##

ROUGE=$'\E[01;31m'
VERT=$'\E[01;32m'
BLANC=$'\E[0m'
JAUNE=$'\E[01;33m'

if [ $# -lt 1 ]; then
    dir='.'
fi
if [ $# -lt 2 ]; then
    type=0
else
    type=$2
fi

case $type in
    "1" )
    ~/script/shaker $1/*.c
    ;;
    "2" )
    echo $JAUNE
    python2.0 ~/script/norme.py $1 -score
    ;;
    "3" )
    echo $VERT
    ~/script/norme.py $1
    ;;
    * )
    ~/script/shaker $1/*.c
    echo $JAUNE
    python2.0 ~/script/norme.py $1 -score
    echo $VERT
    ~/script/norme.py $1
    ;;
esac
echo $BLANC

exit 0
