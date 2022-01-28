#!/bin/bash

wpcs=""
currwp=$((`xdotool get_desktop`))
total=`xdotool get_num_desktops`
icon1=    
icon2= 

for (( i = 0; i < $total; i++));
do
	if [[ $i -eq $currwp ]]
	then
	    echo -n $icon1  
	else
	    echo -n $icon2
	fi;
    [[ $i < $(( total - 1 )) ]] && printf '<span size="99600"> </span>' 
done


