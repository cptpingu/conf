#!/bin/sh
## sms.sh for  in /u/a1/berard_a/tp/tpj7
##
## Made by axel berardino
## Login   <berard_a@epita.fr>
##
## Started on  Sat Sep 23 16:08:45 2006 axel berardino
## Last update Tue Mar 13 18:41:50 2007 axel berardino
##
#!/bin/sh

if [ $# = 0 ]; then
    echo "Usage: [Phone number/Person] [Message]"
    exit 1
fi

if [ $# != 2 ]; then
    echo "Must have 2 arguments"
    exit 2
fi

msg=$2
num=0
count=`echo $msg | wc -m`
if [ $count -gt 158 ]; then
    echo "Message must not exceed 160 characters long ($count)"
    exit 3
fi

count=`expr length $1`
if [ $count -ne  8 ]; then
    echo "Just indicate the 8 last numbers"
    exit 4
fi
num="+336${1}";

echo $msg | mail -s $num asterisk@epitech.net

exit 0
