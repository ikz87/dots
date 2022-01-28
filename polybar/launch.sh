#!/bin/bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done;

polybar -r left&
polybar -r center&
polybar -r right&
polybar -r trayfix&

#while true;
#do
#    lwid=`xdotool search --name polybar-left`
 #   [[ $lwid == "" ]] || break
#done   
#xdo lower $lwid
#xdo lower $lwid
echo "Successfully launched polybar"
