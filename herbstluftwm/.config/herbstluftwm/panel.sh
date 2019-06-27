#!/usr/bin/env bash
script_path="`dirname \"$0\"`"
source "$script_path/colors_rc"

for monitor in "$@"; do
    herbstclient pad $monitor 20
done
~/.config/herbstluftwm/wallpaper.sh & 
$(/bin/bash -c 'yabar 2>&1 > /dev/null &')
(sleep 3 && stalonetray -bg "#${base03:1}" --dockapp-mode simple --icon-size 20 --geometry "5x1+2250+0" --icon-gravity NE --window-strut right) &
herbstclient --wait '^(quit_panel|reload).*'

pkill yabar
pkill trayer
pkill stalonetray
pkill wallpaper.sh
exit 0
