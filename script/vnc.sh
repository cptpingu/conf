#!/bin/sh

if [ "$1" = "on" ]; then
    gconftool-2 -s -t bool /desktop/gnome/remote_access/enabled true
    gconftool-2 -s -t bool /desktop/gnome/remote_access/prompt_enabled false
    gconftool-2 -s -t bool /desktop/gnome/remote_access/view_only false
    gconftool-2 -s -t string /desktop/gnome/remote_access/icon_visibility never
elif [ "$1" = "off" ]; then
    gconftool-2 -s -t bool /desktop/gnome/remote_access/enabled false
    gconftool-2 -s -t bool /desktop/gnome/remote_access/prompt_enabled true
    gconftool-2 -s -t bool /desktop/gnome/remote_access/view_only true
    gconftool-2 -s -t string /desktop/gnome/remote_access/icon_visibility client
elif [ "$1" = "view" ]; then
    gconftool-2 -s -t bool /desktop/gnome/remote_access/enabled true
    gconftool-2 -s -t bool /desktop/gnome/remote_access/prompt_enabled true
    gconftool-2 -s -t bool /desktop/gnome/remote_access/view_only true
    gconftool-2 -s -t string /desktop/gnome/remote_access/icon_visibility client
else
    echo "Usage : $0 [on|off|view]"
fi
