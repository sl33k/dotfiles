#!/bin/bash
panelfolder=
trap 'herbstclient emit_hook quit_panel' TERM
herbstclient pad 0 30 0 0
herbstclient emit_hook quit_panel
compton &
~/.config/herbstluftwm/conky_patched -c ~/.config/herbstluftwm/conkyrc &
~/.config/herbstluftwm/trap_update.sh &
~/.config/herbstluftwm/wallpaper.sh & 
herbstclient --wait '^(quit_panel|reload).*'

pkill compton
pkill wallpaper.sh
pkill conky_patched
pkill trap_update.sh
exit 0
