#!/bin/sh

iso_file="/media/sda5/iso/BroodWar.nrg"
mount_point="/media/cdrom0"
game_location="/media/sda5/Games/Starcraft/StarCraft.exe"

test -f "${mount_point}/install.exe"
if [ $? -ne 0 ]; then
    cmd="mount -t iso9660 -o loop $iso_file $mount_point"
    if [ "$1" = "winmode" ]; then
	gksudo "$cmd"
    else
	sudo $cmd
    fi
fi
if [ $? -eq 0 ]; then
    #setxkbmap us
    setxkbmap starcraft
    nice -n 20 wine $game_location
    setxkbmap fr
fi
