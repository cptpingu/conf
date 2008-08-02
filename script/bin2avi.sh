#!/bin/sh

if [ $# -ne 2 ];then
    echo "Usage : $0 file.bin file.avi"
    exit
fi

mencoder -o $2 -of avi -ffourcc DX50 -lavcopts vbitrate=900:vhq -ovc lavc -oac mp3lame -vf pp=lb $1
