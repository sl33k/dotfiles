#!/bin/bash
execOnTag=/home/sl33k/.config/herbstluftwm/exec_on_tag.sh

####TMUX
#start base tmux
#$execOnTag 'Term' termite -e "/usr/bin/bash -c '/home/sl33k/.tmx.sh term'" &
#start 3 more termite clients each with tmux and a new tmux window
#sleep .2
#for t in {0..2}; do
#   $execOnTag 'Term' termite -e "/usr/bin/bash -c '/home/sl33k/.tmx.sh term 1'" &
#   sleep .2
#done

###BROWSER
$execOnTag 'browser' firefox



