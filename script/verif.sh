#!/bin/sh
## verif.sh for  in /u/a1/berard_a/script
##
## Made by axel berardino
## Login   <berard_a@epita.fr>
##
## Started on  Sun Sep 24 14:40:53 2006 axel berardino
## Last update Sun Sep 24 14:52:40 2006 axel berardino
##

IFS="
"
listing_dir=`find ~/rendu -ls -type d`
listing_file=`find ~/rendu -ls -type f`

#echo "$listing_file" | sed -E -e "/-rw-r-----/!d"
#echo "$listing_dir"  | sed -E -e "/drwxr-x---/!d"

for line in $listing_file; do
    echo "$line" | sed -E -e "/-rw-r-----/d"
done
