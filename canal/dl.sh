#!/bin/sh

if [ $# -lt 1 ];then
    echo "Usage: $0 DaysBefore"
    exit 1
fi

for i in `seq $1`; do
    ./canal $(($i - 1))
done
