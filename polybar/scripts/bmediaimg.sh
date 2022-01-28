#!/bin/bash
source "${HOME}/.cache/wal/colors.sh"
icondir="/home/kz87/Pictures/Important/icons"
width=$(( `xrandr --current | grep primary | cut -c25-28` )) 
last_img=""
last_cavacolor=""

thumbrender () {
    convert $img -resize $y\x$y\^ -bordercolor "$foreground" -border 0 -background "$cavacolor" \
    -gravity center -extent $x\x$y -background "$cavacolor" -matte ~/Pictures/Important/maskin$res.png \
    -compose Dstin -composite /tmp/tmpthumb.png

    convert /tmp/tmpthumb.png -bordercolor "$color9" -border $bw /tmp/thumbnail.png

}
thumbrenderxpand () {
    convert $img -resize $y\x$y\^ /tmp/utthumb.png
    [[ `identify -format '%w' /tmp/utthumb.png` -lt 53 ]] && ~/Programs/Imagemagick/pstretch.sh 12 /tmp/utthumb.png /tmp/tthumb.png\
        || cp /tmp/utthumb.png /tmp/tthumb.png
    convert /tmp/tthumb.png -matte ~/Pictures/Important/maskin$res.png \
    -compose Dstin -composite /tmp/tmpthumb.png            
    convert /tmp/tmpthumb.png -bordercolor "$color9" -border $bw /tmp/thumbnail.png
}

while :
do
    cavacolor="`cat ~/.ricing/cavacolors | cut -c4-10`"
    if [[ `playerctl status` == "Playing" ]]
    then
        echo playing
        new_img_url=$(playerctl metadata mpris:artUrl |  sed "s/https:\/\/i.ytimg.com\/vi\//https:\/\/img.youtube.com\/vi\//g" | sed "s/hq/maxres/g" 2>/dev/null)
        [[ -z $new_img_url ]] && new_img_url=$icondir/media_general.png
        if [[ "$new_img_url" != "$last_img" ]]
        then
            echo newimg
            # Resolution stuff     
            [[ $width -eq 1920 ]] && \
            x=53 && y=30 && res=2k && bw=5    
            [[ $width -eq 1280 ]] && \
            x=36 && y=20 && res=1k && bw=3
            last_img=$new_img_url
            last_cavacolor=$cavacolor
            if [[ "$new_img_url" == "$icondir/media_general.png" ]]
            then
                img="$new_img_url"
            else
                img=$(mktemp)
                wget "$new_img_url" -O $img -q
            fi;
            thumbrenderxpand
            pgrep pqiv || pqiv /tmp/thumbnail.png -P 256,20&
        fi;
    else
        last_img=""
    fi;
    sleep 1
done;

