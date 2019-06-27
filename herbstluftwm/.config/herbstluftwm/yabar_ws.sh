#!/usr/bin/env bash

hc() { "${herbstclient_command[@]:-herbstclient}" "$@" ;}
monitor=${1:-0}

###colors
shade_color(){
    local orig=$1
    local new='#'
    for (( i=1; i<${#orig}; i=i+2)); do
        split="${orig:$i:2}"
        num="$((0x$split))"
        new+="$(echo "$num $2" | awk '{
        res = $1 + $1 / 100 * $2;
        if (res < 0) res=0;
        else if ( res > 255) res=255;
            printf "%.2x", res;
        }')"

    done
    echo $new
}
script_path="`dirname \"$0\"`"
source "$script_path/colors_rc"

bgcolor="$dark2" #bar background color
sepcolor="$neutral_red" #seperator color
text_highlight="$light0"
text_normal="$light2"
##tags
#selected
selbg="$bgcolor" #selected tag background color
selfg="$bright_orange"                             #selected tag foreground
#unselected
unselbg="$bgcolor"                           #unselected background color
unselfg="$neutral_yellow"                           #unselected foreground color
#urgent
urgbg="$faded_red"
urgfg="$text_normal"
#empty
emptybg="$bgcolor"
emptyfg="$text_normal"
#non-empty but not focused anywhere
nonemptybg="$bgcolor"
nonemptyfg="$text_highlight"
#modifiers
active_mon_mod="0"
inactive_mon_mod="-25"

{
    hc --idle
} 2> /dev/null | {
IFS=$'\t' read -ra tags <<< "$(hc tag_status $monitor)"
while true ; do
    lastoutput="$output"
    output=""
    ### Output ###
    # This part prints dzen data based on the _previous_ data handling run,
    # and then waits for the next event to happen.

    # draw tags
    for i in "${tags[@]}" ; do
        # . the tag is empty
        # : the tag is not empty
        # + the tag is viewed on the specified MONITOR, but this monitor is not focused.
        # # the tag is viewed on the specified MONITOR and it is focused.
        # - the tag is viewed on a different MONITOR, but this monitor is not focused.
        # % the tag is viewed on a different MONITOR and it is focused.
        # !  the tag contains an urgent window
        #output+="${i:0} "
        case ${i:0:1} in
            '#')
                output+="<span bgcolor=\"$selbg\" fgcolor=\"$selfg\">${i:0}</span>"
                ;;
            '+')
                output+="<span bgcolor=\"$unselbg\" fgcolor=\"$unselfg\">${i:0}</span>"
                ;;
            '-')
                output+="<span bgcolor=\"$unselbg\" fgcolor=\"$(shade_color $unselfg $inactive_mon_mod)\">${i:0}</span>"
                ;;
            '%')
                output+="<span bgcolor=\"$selbg\" fgcolor=\"$(shade_color $selfg $inactive_mon_mod)\">${i:0}</span>"
                ;;
            ':')
                output+="<span bgcolor=\"$nonemptybg\" fgcolor=\"$nonemptyfg\">${i:0}</span>"
                ;;
            '.')
                output+="<span bgcolor=\"$emptybg\" fgcolor=\"$emptyfg\">${i:0}</span>"
                ;;
            '!')
                output+="<span bgcolor=\"$urgbg\" fgcolor=\"$urgfg\">${i:0}</span>"
                ;;
            *)
                output+="<span>$i</span>"
                ;;
        esac
        output+="    ";
    done
    if [ "$lastoutput" != "$output" ] ; then
        echo -ne "$output\n" 
    fi
    # wait for next event
    IFS=$'\t' read -ra cmd || break
    # find out event origin
    case "${cmd[0]}" in
        tag*)
            #echo "resetting tags" >&2
            IFS=$'\t' read -ra tags <<< "$(hc tag_status $monitor)"
            ;;
        quit_panel)
            exit
            ;;
        reload)
            exit
            ;;
    esac
done
} 2> /dev/null

