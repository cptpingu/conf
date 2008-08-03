#!/bin/bash
## mygcc-config.sh for  in /home/pingu
##
## Made by berard_a
## Login   <pingu@epita.fr>
##
## Started on  Tue Jun 19 19:55:59 2007 berard_a
## Last update Tue Jun 19 20:53:10 2007 berard_a
##

echo "*** My GCC Config for Ubuntu ***
"

flag_help=0
flag_list=0
flag_change=0
flag_error=0
param=""

if [ $# -eq 0 ]; then
    flag_help=1
fi

for i in $@ ; do
    case $1 in
	-l )
	    flag_list=1
	    ;;
	-c )
	    flag_change=1
	    param="$2"
	    ;;
	--help )
            flag_help=1
            ;;
        -h )
            flag_help=1
            ;;
    esac
    shift 1
done

if [ $flag_help -eq 0 ]; then
    if [ $flag_change -eq 1 ]; then
	if [ $flag_list -eq 1 ]; then
	    flag_help=1
	    echo "Argument conflict !"
	else

	    test -z $param
	    if [ $? -ne 1 ]; then
		flag_help=1
		echo "Argument Missing !"
	    fi
	fi
    fi
fi

if [ $flag_help -ne 0 ]; then
    echo "Usage: $0 [option] gcc_version
  -h: Display this usage
  -l: List all available GCC
  -c: Change gcc version"
    exit 1
fi

list_available_gcc=`\ls /usr/bin | grep "^gcc-"`

valid=1
if [ $flag_change -eq 1 ]; then
    valid=0
    for i in $list_available_gcc; do
	if [ "$i" = "$param" ]; then
	    valid=1
	    flag_error=1
	fi
    done
    if [ $valid -ne 1 ]; then
	flag_list=1
    else
	sudo rm -rf /usr/bin/gcc
	if [ $? -ne 0 ]; then
	    echo "You must be root to change gcc version !"
	    exit 4
	else
	    sudo ln -s /usr/bin/$param /usr/bin/gcc
	    echo "Successfully changed version of GCC to $param"
	fi
    fi
fi

if [ $flag_list -eq 1 ]; then
    echo "Available gcc is :"
    for i in $list_available_gcc; do
	echo "  - $i"
    done
    if [ $flag_error -eq 1 ]; then
	exit 2
    fi
    if [ $valid -eq 0 ]; then
	echo
	echo "Can't found asked gcc: \"$param\", Trying to install a gcc version."
	echo "Press CTRL+C to abort, or hit any key to continue"
	read
	sudo aptitude install $param
    fi
fi

exit 0
