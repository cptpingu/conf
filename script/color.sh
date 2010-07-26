#!/bin/sh

echo "Reset: \033[0m"
echo

for i in `seq 0 7`; do
    text=$(($i + 30))
    bg=$(($i + 40))
    echo -en '\033[1;'${text}'m'
    echo -n '\033[1;'${text}'m'
    echo -en '\033[0m'
    echo -n "  "
    echo -en '\033[0;;'${bg}'m'
    echo -n '\033[0;;'${bg}'m'
    echo -e '\033[0m'
done
echo

for effect in 1 4 5 7; do
    echo -en '\033['${effect}'m'
    echo -n '\033['${effect}'m'
    echo -en '\033[0m'
    echo -n " "
done
echo
