# compton
pkill compton
compton -cCzG -t-3 -l-5 -r4 -b \
 --config /dev/null --backend xrender \
 --unredir-if-possible -i 0.85  
#screensaver
pkill xss-lock
pkill xscreensaver
xscreensaver -no-splash &
xss-lock -- xscreensaver-command -lock &

#udiskie
pkill udiskie
udiskie -0 -A -s &

herbstclient --wait '^(quit_panel|reload).*'
pkill xss-lock
pkill xscreensaver
pkill compton
pkill udiskie

exit 0
