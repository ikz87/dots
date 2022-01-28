#!/bin/bash
source "${HOME}/.cache/wal/colors.sh" 
killall rofi
color0=\#$alpha`echo $color0 | sed 's/\#//g'`
width=$(( `xrandr --current | grep primary | cut -c 25-28` )) 

if [[ $width -eq $(( 1920 )) ]];
then

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
    resolution)
        option=`printf "720\n1080" | rofi -dmenu -color-normal "#00000000,$color15,#00000000,$color9,$color0" -color-window "$color0,$color9,$color9" -p "Select Resolution:                                                                                 " -lines 1 -columns 2`; [[ $option -eq 720 ]] && (cp ~/.config/bspwm/bspwmrc1k ~/.config/bspwm/bspwmrc && cp ~/.config/polybar/config1k ~/.config/polybar/config && xrandr --output eDP-1 --mode 1280x720 && bspc wm -r && cp ~/.config/kitty/kitty.conf1k ~/.config/kitty/kitty.conf && cp ~/.config/dunst/dunstrc1k ~/.config/dunst/dunstrc) || (cp ~/.config/bspwm/bspwmrc2k ~/.config/bspwm/bspwmrc && cp ~/.config/polybar/config2k ~/.config/polybar/config && xrandr --output eDP-1 --mode 1920x1080 && bspc wm -r && cp ~/.config/kitty/kitty.conf2k ~/.config/kitty/kitty.conf && cp ~/.config/dunst/dunstrc2k ~/.config/dunst/dunstrc)
    ;;
esac
   
else

case $1 in     
    drun)        
    rofi -show drun -color-normal "#00000000,$color15,#00000000,$color9,$color0" -color-window "$color0,$color9,$color9" -font "CartographCF 9" -show-icons -location 2 -lines 10 -width 613 -yoffset 37 -bw 3 -padding 7 -line-margin 3 -hide-scrollbar true
    ;;    
    window)    
    rofi -show window -color-normal "#00000000,$color15,#00000000,$color9,$color0" -color-window "$color0,$color9,$color9" -font "CartographCF 9" -show-icons -location 1 -lines 5 -width 277 -yoffset 37 -xoffset 23 -bw 3 -padding 7 -line-margin 3 -hide-scrollbar true -window-format "{c} {t}"
    ;;    
    config)    
    program=`cat ~/.config/programlist | rofi -dmenu -color-normal "#00000000,$color15,#00000000,$color9,$color0" -color-window "$color0,$color9,$color9" -font "CartographCF 9" -show-icons -location 2 -lines 10 -width 613 -yoffset 37 -bw 3 -padding 7 -line-margin 3 -hide-scrollbar true` && kitty config $program             
    ;;    
    outopts)    
    option=`printf " Restart bspwm\n Quit bspwm\n Reboot\n Shutdown\n" | rofi -dmenu -color-normal "#00000000,$color15,#00000000,$color9,$color0" -color-window "$color0,$color9,$color9"  -lines 4 -p "   Select action:                             " -theme-str 'entry { placeholder: ""; } inputbar { children: [prompt, textbox-prompt-colon, entry];}' -location 3 -yoffset 37 -xoffset -23 -width 277 -font "CartographCF 9" -bw 3`
    case $option in    
        " Restart bspwm")    
            bspc wm -r        
        ;;                    
        " Quit bspwm")    
            ~/.config/bspwm/quit.sh    
        ;;
        " Reboot")
            confirm=`printf " No\n Yes" | rofi -dmenu -color-normal "#00000000,$color15,#00000000,$color9,$color0" -color-window "$color0,$color9,$color9"  -lines 2 -p "   Are you sure?                             " -theme-str 'entry { placeholder: ""; } inputbar { children: [prompt, textbox-prompt-colon, entry];}' -location 3 -yoffset 37 -xoffset -23 -width 277 -font "CartographCF 9" -bw 3`
            [[ $confirm == " Yes" ]] && reboot
        ;;
        " Shutdown")
            confirm=`printf " No\n Yes" | rofi -dmenu -color-normal "#00000000,$color15,#00000000,$color9,$color0" -color-window "$color0,$color9,$color9"  -lines 2 -p "   Are you sure?                             " -theme-str 'entry { placeholder: ""; } inputbar { children: [prompt, textbox-prompt-colon, entry];}' -location 3 -yoffset 37 -xoffset -23 -width 277 -font "CartographCF 9" -bw 3`
            [[ $confirm == " Yes" ]] && shutdown now
        ;;
    esac
    ;;
    resolution)
        option=`printf "720\n1080" | rofi -dmenu -color-normal "#00000000,$color15,#00000000,$color9,$color0" -color-window "$color0,$color9,$color9" -p "Select Resolution:                                                                                 " -lines 1 -columns 2`; [[ $option -eq 720 ]] && (cp ~/.config/bspwm/bspwmrc1k ~/.config/bspwm/bspwmrc && cp ~/.config/polybar/config1k ~/.config/polybar/config && xrandr --output eDP-1 --mode 1280x720 && cp ~/.config/kitty/kitty.conf1k ~/.config/kitty/kitty.conf && cp ~/.config/dunst/dunstrc1k ~/.config/dunst/dunstrc && sed 's/gtk-font-name=Cartograph\ CF,\ Bold\ 13/gtk-font-name=Cartograph CF,\ Bold\ 9/g' -i ~/.config/gtk-3.0/settings.ini && bspc wm -r) || (cp ~/.config/bspwm/bspwmrc2k ~/.config/bspwm/bspwmrc && cp ~/.config/polybar/config2k ~/.config/polybar/config && xrandr --output eDP-1 --mode 1920x1080 && cp ~/.config/kitty/kitty.conf2k ~/.config/kitty/kitty.conf && cp ~/.config/dunst/dunstrc2k ~/.config/dunst/dunstrc && sed 's/gtk-font-name=Cartograph\ CF,\ Bold\ 9/gtk-font-name=Cartograph CF,\ Bold\ 13/g' -i ~/.config/gtk-3.0/settings.ini && bspc wm -r)
    ;;
esac
   

fi;
