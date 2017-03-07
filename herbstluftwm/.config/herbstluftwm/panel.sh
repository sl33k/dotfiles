#!/usr/bin/env bash
script_path="`dirname \"$0\"`"
source "$script_path/solarized_rc"

for monitor in "$@"; do
    herbstclient pad $monitor 24
done
~/.config/herbstluftwm/wallpaper.sh & 
yabar 2>&1 > /dev/null &
color=
trayer --edge top --align right --width 150 --widthtype pixel --height 20 --monitor 1 --tint "0x${sol_base03:1}" --alpha 0  --SetDockType true
eval $var
herbstclient --wait '^(quit_panel|reload).*'

pkill yabar
pkill trayer
pkill wallpaper.sh
exit 0
