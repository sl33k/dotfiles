#!/bin/bash
active="color3"
used="color4"
urgent="color5"
viewed="color6"
empty="color7"
other_mon="color8"

hc_output=$(herbstclient tag_status);
tag_array=($hc_output);
tag_count=${#tag_array[@]};

for ((i=0;i<tag_count;i++)); do 
    tag=${tag_array[i]};
    color=""
    if [[ $tag =~ ^\. ]]; then
        #empty
        color=$empty;
    elif [[ $tag =~ ^\+ ]]; then
        #viewed
        color=$viewed;
    elif [[ $tag =~ ^\- ]]; then
        #other monitor
        color=$other_mon
    elif [[ $tag =~ ^: ]]; then
        #used
        color=$used;
    elif [[ $tag =~ ^# ]]; then
        #active
        color=$active;
        #this tag needs escaping
        tag="\\$tag";
    elif [[ $tag =~ ^! ]]; then
        #urgent
        color=$urgent;
    fi;
    #add color
    tag_array[i]="\${$color}$tag";
done;
echo ${tag_array[@]};
