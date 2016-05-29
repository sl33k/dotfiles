#!/bin/sh
#this script runs on exit of autostart
tmux new-session -d -s tmux_base

tmux new-window -t tmux_base:1 -n 'home' 'cd /home/sl33k'
tmux new-window -t tmux_base:2 -n 'root' 'cd /'
tmux new-window -t tmux_base:3 -n 'misc' 'cd ~/'
tmux select-window -t tmux_base:1
tmux -2 attach-session -t tmux_base
#termite -e "tmux select-window -t tmux_base:2;tmux -2 attach-session -t tmux_base"

