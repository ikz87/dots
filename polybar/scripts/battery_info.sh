#!/bin/bash

source "${HOME}/.cache/wal/colors.sh"
#charging = 3, high = 2, mid = 1,  low = 0

notify()
{
    case $1 in 
        charging)
            if  [[ $lstate -ne 3 ]]
            then
                echo 3 > /tmp/batstate 
                pop_report -d 800 -m "<span style=\"font-family: CartographCF;\">Charging</span><font size=\"-1\"> ﮣ</font>$icon" -t battery_charging -o "font-size: 70px" "font-family: CaskaydiaCoveNerdFont" "padding-right: 30px"
            fi;       
        ;;
        high)
            echo 2 > /tmp/batstate
        ;;
        mid)
            if  [[ $lstate -gt 1 ]] 
            then
                echo 1 > /tmp/batstate
                ~/.ricing/notify-send.sh "Warning: $BAT_LEVEL% Battery left" -i "~/Pictures/Important/icons/other/battery_mid.png" -t 10000 --replace=550 -u critical
            fi;
        ;;
        low)
            if [[ $lstate -gt 0 ]] 
            then 
                echo 0 > /tmp/batstate
                pop_report -m "Battery is critically low" -d 3000 -t battery_low
            fi;
        ;;
    esac
}

# Set necessary info
fg="$color14"
lstate=`cat /tmp/batstate`
ACPI_RES=$(acpi -b)
BAT_LEVEL_ALL=$(echo "$ACPI_RES" | grep -v "unavailable" | grep -E -o "[0-9][0-9]?[0-9]?%")
BAT_LEVEL=$(echo "$BAT_LEVEL_ALL" | awk -F"%" 'BEGIN{tot=0;i=0} {i++; tot+=$1} END{printf("%d%%\n", tot/i)}')
BAT_LEVEL=`printf ${BAT_LEVEL%?}`
Discharging=$(echo "$ACPI_RES" | grep -w 0: | grep -c Discharging)

[[ $BAT_LEVEL -ne 100 ]] && BAT_LEVEL=" $BAT_LEVEL"

# Select an icon
if [[ $BAT_LEVEL -ge 90 ]] 
    then
        icon=
        [[ $Discharging -eq 1 ]] && notify high
    elif [[ $BAT_LEVEL -ge 80 ]]
    then
        icon=
        [[ $Discharging -eq 1 ]] && notify high
    elif [[ $BAT_LEVEL -ge 70 ]]    
    then    
        icon=
        [[ $Discharging -eq 1 ]] && notify high
    elif [[ $BAT_LEVEL -ge 60 ]]    
    then    
        icon=
        [[ $Discharging -eq 1 ]] && notify high
    elif [[ $BAT_LEVEL -ge 50 ]] 
    then
        icon=
        [[ $Discharging -eq 1 ]] && notify high
    elif [[ $BAT_LEVEL -ge 40 ]]    
    then    
        icon=
        [[ $Discharging -eq 1 ]] && notify high
    elif [[ $BAT_LEVEL -ge 30 ]]    
    then    
        icon=
        [[ $Discharging -eq 1 ]] && notify high
    elif [[ $BAT_LEVEL -ge 20 ]]    
    then    
        icon=
        [[ $Discharging -eq 1 ]] && notify high
    elif [[ $BAT_LEVEL -ge 10 ]]    
    then    
        icon=
        [[ $Discharging -eq 1 ]] && notify mid
    elif [[ $BAT_LEVEL -gt 5 ]]
    then 
       icon=
       fg="#FFC139"
       [[ $Discharging -eq 1 ]] && notify mid
    else
       fg="#FF3939"
       icon=
       [[ $Discharging -eq 1 ]] && notify low
fi;
    
[[ $Discharging -eq 0 ]] && icon=

[[ $Discharging -eq 1 ]] && echo "%{F$fg}$BAT_LEVEL% $icon%{F-}"  || ( echo "%{F$fg}$BAT_LEVEL% $icon" && notify charging )



