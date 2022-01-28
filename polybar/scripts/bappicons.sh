#!/bin/bash

source "${HOME}/.cache/wal/colors.sh"
icondir="/home/kz87/Pictures/Important/icons"
rm $icondir/buffer/*
width=$(( `xrandr --current | grep primary | cut -c25-28` )) # Screenwidth
last_class="none"

# Resolution stuff 
[[ $width -eq 1920 ]] && \
x=53 && y=30 && res=2k && bw=5
[[ $width -eq 1280 ]] && \
x=36 && y=20 && res=1k && bw=3

thumbrender (){
    convert "$icon" -resize $y\x$y\^ -background "$color8" \
    -gravity center -extent $x\x$y -matte ~/Pictures/Important/maskin$res.png \
    -compose Dstin -composite /tmp/tmpthumb.png
    
    convert /tmp/tmpthumb.png -bordercolor "$color9" -border $bw $b_icon
}

bspc subscribe node_focus desktop_focus node_remove | while read line;
do
    echo cycle
    # Get full properties (tname) and class name    
    tname=`xprop -id $(xdotool getwindowfocus)`    
    class=`xwinfo -i $(xdotool getwindowfocus)`
    
    # Only run if no media is playing
    if [[ `playerctl status 2> /dev/null` != "Playing" && $class != $last_class ]]
    then
        if [[ $class = "N/A" ]]
        then
            class=arch
            tname=arch
        fi;
        last_class=$class
        not_empty=0
        for i in `ls $icondir | sed 's/.png//g'`; do

            if [[ `echo $tname | grep -i -c $i` -ne 0 ]]
            then 
                not_empty=1
                icon=$icondir/$i.png
                b_icon=$icondir/buffer/$i$res.png
                
                # Use a buffer to not render already rendered icons
                [[ -f $b_icon ]] && (echo "icon in buffer, will only copy") || \
                                    (echo "icon not in buffer, rendering for the first time..." && \
                                        thumbrender)
                    
                cp $b_icon /tmp/thumbnail.png

                [[ $width -eq 1920 ]] && \
                    (pgrep pqiv || pqiv -c /tmp/thumbnail.png -P 256,20&) \
                || \
                    (pgrep pqiv || pqiv -c /tmp/thumbnail.png -P 171,13&)
                break
            fi;
        done;
     fi;
done; 
