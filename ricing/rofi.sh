#!/bin/bash
source "${HOME}/.cache/wal/colors.sh" 
killall rofi
color0=\#$alpha`echo $color0 | sed 's/\#//g'`

case $1 in 
    drun)    
    rofi -show drun -color-normal "#00000000,$color15,#00000000,$color9,$color0" -color-window "$color0,$color9,$color9" -font "CartographCF 14" -show-icons -location 2 -lines 10 -width 920 -yoffset 55 -bw 5 -padding 10 -line-margin 5 -hide-scrollbar true
    ;;
    window)
    rofi -show window -color-normal "#00000000,$color15,#00000000,$color9,$color0" -color-window "$color0,$color9,$color9" -font "CartographCF 14" -show-icons -location 1 -lines 5 -width 415 -yoffset 55 -xoffset 35 -bw 5 -padding 10 -line-margin 5 -hide-scrollbar true -window-format "{c} {t}"
    ;;
    config)
    program=`cat ~/.config/programlist | rofi -color-normal "#00000000,$color15,#00000000,$color9,$color0" -color-window "$color0,$color9,$color9" -font "CartographCF 14" -show-icons -location 2 -lines 10 -width 920 -yoffset 55 -bw 5 -padding 10 -line-margin 5 -hide-scrollbar true -dmenu -i -p "Select program to config"` && kitty config $program 
    ;;
    outopts)
    option=`printf " Restart bspwm\n Quit bspwm\n Reboot\n Shutdown\n" | rofi -dmenu -color-normal "#00000000,$color15,#00000000,$color9,$color0" -color-window "$color0,$color9,$color9"  -lines 4 -p "   Select action:                             " -theme-str 'entry { placeholder: ""; } inputbar { children: [prompt, textbox-prompt-colon, entry];}' -location 3 -yoffset 55 -xoffset -35 -width 415`
    case $option in
        " Restart bspwm")
            bspc wm -r
        ;;
        " Quit bspwm")
            ~/.config/bspwm/quit.sh
        ;;
        " Reboot")
            confirm=`printf " No\n Yes" | rofi -dmenu -color-normal "#00000000,$color15,#00000000,$color9,$color0" -color-window "$color0,$color9,$color9"  -lines 2 -location 3 -yoffset 55 -xoffset -35 -width 415 -p "   Are you sure?                              " -theme-str 'entry { placeholder: ""; } inputbar { children: [prompt, textbox-prompt-colon, entry];}'`
            [[ $confirm == " Yes" ]] && reboot
        ;;
        " Shutdown")
            confirm=`printf " No\n Yes" | rofi -dmenu -color-normal "#00000000,$color15,#00000000,$color9,$color0" -color-window "$color0,$color9,$color9"  -lines 2 -location 3 -yoffset 55 -xoffset -35 -width 415 -p "   Are you sure?                                  " -theme-str 'entry { placeholder: ""; } inputbar { children: [prompt, textbox-prompt-colon, entry];}'`
            [[ $confirm == " Yes" ]] && shutdown now
        ;;
    esac
    ;;
esac
