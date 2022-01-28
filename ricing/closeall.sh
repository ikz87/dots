#!/bin/bash
 
cw=`wmctrl -d | grep "*" | awk '{printf $1}'`
wmctrl -l > ~/.ricing/currwinds


while read line; do 
    [[ `echo $line | awk '{printf $2}'` -ne $cw ]] && wmctrl -i -c `echo $line | awk '{printf $1}'`
done < ~/.ricing/currwinds

sleep 0.5
~/.wpm/selector.sh 0



