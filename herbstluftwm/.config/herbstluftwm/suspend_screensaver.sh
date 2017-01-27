#!/bin/bash
win_id=`xwininfo | egrep -o 'Window id: 0x[[:digit:]]+' | awk '{print $3}'`
echo $win_id
