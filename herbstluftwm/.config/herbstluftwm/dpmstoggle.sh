#!/bin/bash
#toggle
if [ -n $(xset q |grep "DPMS is Enabled") ] 
then
xset dpms; xset s on
exit 1
fi
xset -dpms; xset s off
