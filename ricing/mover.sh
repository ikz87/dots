#/bin/bash

# Exist if last move hasn't finished

#while true; do
#    if [ -z "$(pgrep xdotool)" ]
#    then 
#        break
#    else
#        exit
#    fi;
#done

# Get current window, state and desktop
currwin=`xdotool getwindowfocus`
#for i in `echo "tiled pseudo_tiled floating fullscreen"`; 
#do
#    if [ -z "$(bspc query -N -n focused.$i)" ]
#    then
#        true
#    else
#        currstate=$i && break
#    fi;
#done 
currdesk=`xdotool get_desktop`

# Calculate target desktop
target=$(( currdesk + $1 )) 
[[ $target -eq $(( -1 )) ]] && target=4 
[[ $target -eq $(( 5 )) ]] && target=0

# Put window in floating mode
#bspc node focused -t floating && xdotool windowsize $currwin 850 750 && xdotool windowmove $currwin 535 190 # Resize and move only if window wasn't already floating

# Set it to be sticky
bspc node focused -g sticky=on;


# Get window width and X-position
#currpos=`xdotool getwindowgeometry $currwin | grep Position | awk '{printf $2}'`
#xpos=`echo "${currpos%%,*}"`

#currgeo=`xdotool getwindowfocus $currwin | grep Geometry | awk '{printf $2}'`
#width=`echo "${currgeo%%x*}"`

# Move it (with pseudo animation)
#[[ $1 -eq -1 ]] && xdotool windowmove --sync $currwin -1000 y || xdotool windowmove --sync $currwin 1920 y # Move to the edge of the screen

wmctrl -s $target && wmctrl -R $currwin -i

#xdotool windowmove --sync $currwin $xpos y #Reset position

# Reset state and flag accordingly
#bspc node focused -t $currstate;
bspc node focused -g sticky=off;
