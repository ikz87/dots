#!/bin/sh
source "${HOME}/.cache/wal/colors.sh" 
TEMP=$(sensors | grep 'Package id 0:\|Tdie' | grep ':[ ]*+[0-9]*.[0-9]*°C' -o | grep '+[0-9]*.[0-9]*°C' -o)
#out=`echo "$TEMP" | awk '{ printf("$icon%s\n"), $1 }'`
tempn=`echo $TEMP | tr -dc '0-9'`
tempn=`printf ${tempn%.*}`

#echo $cpuwhole $tempn

if [[ $tempn -ge 850 ]];
then
    icon=
    fg="#FF3939"
elif [[ $tempn -ge 700 ]];
then
    icon=
    fg="#FFC139"
else
    icon=
    fg="$color15"
fi;

echo "%{F$fg}$TEMP $icon%{F-}"
