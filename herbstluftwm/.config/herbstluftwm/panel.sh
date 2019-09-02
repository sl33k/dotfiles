#!/usr/bin/env bash
for monitor in "$@"; do
    herbstclient pad $monitor 24 0 24 0
done

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
killall -q wallpaper.sh
while pgrep -u $UID -x wallpaper.sh >/dev/null; do sleep 1; done

polybar top &
polybar bottom &
~/.config/herbstluftwm/wallpaper.sh & 

herbstclient --wait '^(quit_panel|reload).*'
exit 0
