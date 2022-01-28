#!/bin/bash

printf "" > ~/.ricing/currwinds

width=$(( `xrandr --current | grep primary | cut -c24-27` ))
height=$(( `xrandr --current | grep primary | cut -c29-36` ))
if [[ $# -gt 0 ]];
then
    sp=$(( `cat ~/.ricing/spacing` + $1 ))
    [[ sp -lt 0 ]] && sp=0
    [[ sp -gt 70 ]] && sp=70

    echo $sp > ~/.ricing/spacing
fi;
midwidth=$(( width /2 ))

current=`wmctrl -d | grep '*' | cut -d ' ' -f1`
counter=0
filecounter=0
wmctrl -l > ~/.ricing/allwinds
focusid=`xdotool getwindowfocus`


while read line; do
    if [[ `echo $line | awk '{print $2}'` -eq $current ]] && [ "$filecounter" -lt 6 ]
    then
        filecounter=$(( filecounter + 1 ))
        echo `echo $line | awk '{print $1}'` >> ~/.ricing/currwinds
    fi;
done < ~/.ricing/allwinds

total=`grep -c x ~/.ricing/currwinds`

sidewinds=$(( total - 1 ))
bar=0
windheight=$(( (height - bar) / sidewinds ))
counter=0
finalf=""

for i in `cat ~/.ricing/currwinds`; do
    #echo $i
    #echo $focusid
    wmctrl -i -r $i -b remove,maximized_vert
    wmctrl -i -r $i -b remove,maximized_horz
    wmctrl -i -a $i
    
    #if [ $(( `python3 ~/Programs/Python/dec.py $i` )) -eq $focusid ]
    if [ $(( `python -c "print($i)"` )) -eq $focusid ]
    then
        [[ $total -eq 1 ]] && wmctrl -i -r $i -b toggle,maximized_vert && wmctrl -i -r $i -b toggle,maximized_horz || wmctrl -i -r $i -e 0,$((2 * sp)),$((2 * sp)),$(( midwidth - 3 * sp )),$(( height - 4 * sp ))
        finalf=$i
    elif [[ sidewinds -eq 1 ]]
    then
        wmctrl -i -r $i -e "0,$((midwidth + sp)),$((2 * sp)),$((midwidth - 3 * sp)),$((windheight - 4 * sp))"
    else
    if [[ counter -eq 0 ]]
    then
        wmctrl -i -r $i -e "0,$((midwidth + sp)),$((2 * sp)),$((midwidth - 3 * sp)),$((windheight - 3 * sp))"
    elif [[ counter -eq $((sidewinds -1)) ]]
    then
        wmctrl -i -r $i -e "0,$((midwidth + sp)),$(( ( windheight * $counter + bar ) + sp)),$((midwidth - 3 * sp)),$(( windheight - 3 * sp))"
    else
        wmctrl -i -r $i -e "0,$((midwidth + sp)),$(( ( windheight * $counter + bar ) + sp)),$((midwidth - 3 * sp)),$(( windheight - 2 * sp))"
    fi;
        counter=$(( counter + 1 ))
    fi;

done
wmctrl -i -a $finalf
