#!/bin/sh
#TEMP=$(sensors | grep 'Package id 0:\|Tdie' | grep ':[ ]*+[0-9]*.[0-9]*°C' -o | grep '+[0-9]*.[0-9]*°C' -o)
source "${HOME}/.cache/wal/colors.sh"
CPU_USAGE=$(mpstat 1 1 | awk '/Average:/ {printf("%s\n", $(NF-9))}')

cpuwhole=`printf ${CPU_USAGE%.*}`
#tempn=`echo $TEMP | tr -dc '0-9'`
#tempn=`printf ${tempn%.*}`

#echo $cpuwhole $tempn

if [[ $cpuwhole -ge 80 ]]
then
    fg="#FF3939"
elif [[ $cpuwhole -ge 70 ]]
then
    fg="#FFC139"
else
    fg="$color15"
fi;

[[ $cpuwhole -lt 10 ]] && echo "%{F$fg} $CPU_USAGE% %{T4}%{T-}%{F-}" || echo "%{F$fg}$CPU_USAGE% %{T4}%{T-}%{F-}" 
