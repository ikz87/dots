#!/bin/bash

printf "" > /home/kz87/.ricing/currwinds
current=`wmctrl -d | grep '*' | cut -d ' ' -f1`
wmctrl -l > /home/kz87/.ricing/allwinds
focusid=`xdotool getwindowfocus`


while read line; do
    wid=`echo $line | awk '{print $1}'`
    wid=`python3 ~/Programs/Python/dec.py $wid`
    if [[ `echo $line | awk '{print $2}'` -eq $current ]] #&& [[ $(( $wid )) -ne $focusid ]]
    then
        xdotool windowclose $wid
    fi;
done < /home/kz87/.ricing/allwinds
