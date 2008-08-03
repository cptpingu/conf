#!/bin/sh

script="tumsoul_0.3.3.py"

root=`dirname $0`
script="$root/$script"

while [ true ]; do
    test -f $script
    if [ $? -ne 0 ]; then
	echo "$script not found !"
	exit 1
    fi
    python2.5 $script
done
