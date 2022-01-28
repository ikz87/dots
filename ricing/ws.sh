#!/bin/bash
printf "" > /home/kz87/.ricing/currwinds
printf "" > ~/.ricing/winord

#width=$(( `xrandr --current | grep primary | cut -c24-27` ))
#height=$(( `xrandr --current | grep primary | cut -c29-36` ))
#midwidth=$(( width /2 ))

current=`wmctrl -d | grep '*' | cut -d ' ' -f1`
filecounter=0
currentid=""
wmctrl -l -G > /home/kz87/.ricing/allwinds

while read line; do
    if [[ `echo $line | awk '{print $2}'` -eq $current ]]
    then
        printf "$(( `echo $line | awk '{print $3}'` + `echo $line | awk '{print $4}'` )) `echo $line | awk '{print $1}'`\n" >> ~/.ricing/winord
    fi;
done < /home/kz87/.ricing/allwinds
sort -n ~/.ricing/winord -o ~/.ricing/winord
wmctrl -i -a `sed -n $(($1))p ~/.ricing/winord | awk '{print $2}'`
#~/.ricing/wd.sh
