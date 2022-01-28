#!/bin/bash

total=`xdotool get_num_desktops`    
icon1=○
icon2=◎
icon3=●


bspc subscribe desktop_focus node_add node_remove | while read line; do
	currwp=$((`xdotool get_desktop`))    
	for (( i = 0; i < $total; i++));    
	do    
	    if [[ $i -eq $currwp ]]    
	    then    
	        echo -n $icon3    
	    else    
	        [[ `wmctrl -l | awk '{printf $2 }' | grep -c $i` -gt 0 ]] &&  echo -n $icon2 || echo -n $icon1     
	    fi;    
	    [[ $i < $(( total - 1 )) ]] && echo -n "  " || echo " "     
	done
done
