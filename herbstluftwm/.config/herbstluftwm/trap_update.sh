#!/bin/bash

herbstclient --idle 2>/dev/null | {
while true; do
    read hook || exit
    case "$hook" in
        tag*) $(pkill --signal 12 conky);;
        quit_panel*) exit;;
    esac
done;
}
