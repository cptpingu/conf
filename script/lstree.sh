#!/bin/sh

#SHIFTING='\_'
#INCL='|  '

SHIFTING='|---'
INCL='    '

IFS="
"
lstree()
{
    cd $1 > /dev/null 2> /dev/null
    if [ $? -eq 0 ]; then
	for entry in `\ls -p`; do
            echo "$SHIFTING$entry"
            SHIFTING="$INCL$SHIFTING"
            if [ -d $entry ]; then
		lstree "$entry"
		cd ..
            fi
            SHIFTING=${SHIFTING#$INCL}
	done
    fi
}

echo ${1-'.'}
lstree ${1-'.'}
