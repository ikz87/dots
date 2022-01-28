#!/bin/bash

wpcs=""
currwp=$((`xdotool get_desktop`))
total=`xdotool get_num_desktops`
last=$1
self=$2
other=$3
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
	if [[ $last -eq 0 ]] && [[ $currwp -eq $(( total - 1 )) ]] 
	then
		[[ $i < $(( total - 1 )) ]] && echo -n \<span\ size\=\"1000\"\> \<\/span\>$other\<span\ size\=\"1000\"\> \<\/span\>
	elif [[ $last -eq $(( total - 1 )) ]] && [[ $currwp -eq 0 ]]
	then
		[[ $i < $(( total - 1 )) ]] && echo -n \<span\ size\=\"1000\"\> \<\/span\>$other\<span\ size\=\"1000\"\> \<\/span\>
	elif [[ $i -eq $last ]] && [[ $self ==  ]] 
	then
		echo -n \<span\ size\=\"10000\"\> \<\/span\>$self\<span\ size\=\"10000\"\> \<\/span\>
	elif [[ $i -eq $currwp ]] && [[ $self ==  ]]
	then
		echo -n \<span\ size\=\"10000\"\> \<\/span\>$self\<span\ size\=\"10000\"\> \<\/span\>
	elif [[ $i -lt $(( total - 1 )) ]] 
	then
		printf '<span size="95500"> </span>'
	fi;
	#[[ $i < $(( total - 1 )) ]] && printf ""
done


