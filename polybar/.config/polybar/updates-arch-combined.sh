#!/bin/bash

if command -v checkupdates ; then
    updates_arch=$(checkupdates 2> /dev/null | wc -l )
else
    updates_arch=0
fi

if ! command -v yay; then
    updates_aur=$(yay -Qum 2> /dev/null | wc -l)
else
    updates_aur=0
fi

updates=$(("$updates_arch" + "$updates_aur"))

if [ "$updates" -gt 0 ]; then
    echo "ﮮ $updates"
else
    echo ""
fi
