#!/bin/sh

list=""
nb=0
for i in "$@"; do
    if [ -f "$i" ]; then
	list="$list TRUE '$i'"
	nb=$(($nb + 1))
    fi
done

zen="zenity --list --width 500 --height 400 --text \"Mp3 à convertir\" --checklist --column \"Convertir ?\" --column \"Mp3\" --separator=\":\" $list"
ans=$(eval $zen)

(
    OLD_IFS=$IFS
    IFS=":"
    count=0
    echo "0"
    for i in $ans; do
	if [ -f "$i" ]; then
	    notify-send -t 1000 -u low -i gtk-dialog-info \
		"Mp3 to Wav" "<b>Converting</b> <i>`basename $i`</i>..."
	    ffmpeg -i "$i" "${i%.mp3}.wav"
	    count=$(($count + 1))
	    echo "scale=2;($count /$nb) * 100" | bc
	fi
    done
    IFS=$OLD_IFS
) | zenity --progress --title="Convertion des mp3 en wav..." --auto-close
