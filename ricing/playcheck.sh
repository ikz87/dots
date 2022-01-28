#!/bin/bash


img_url=""
last_status=""

while :
do
   [[ $hex == "" ]] && hex="#FFFFFF"
   new_img_url=$(playerctl metadata mpris:artUrl 2>/dev/null | sed s/open.spotify.com/i.scdn.co/)
   new_status=$(playerctl status 2> /dev/null)
   if [[ "$new_img_url" != "$img_url" ]] || [[ "$last_status" != "$new_status" ]] 
   then
      hex="#FFFFFF"
      linktype=$(echo "$new_img_url" | awk -F "://" '{print$1}')
      if [[ "$linktype" == "file" ]]
      then
         direct_file=$(echo "$new_img_url" | sed 's/file\:\/\///')
         img="$direct_file"
      else
         img=$(mktemp)
         wget "$new_img_url" -O $img -q
      fi
      numcol=6
      fuzz=30
      while [[ "$hex" == "#FFFFFF" && "$fuzz" != "60" ]]
      do
         thresh=$((100-fuzz))
         sortedfinalcolors=$(convert "$img" -scale 50x50! -depth 8 \
         \( -clone 0 -colorspace HSB -channel gb -separate +channel -threshold $thresh% \
         -compose multiply -composite \) \
         -alpha off -compose copy_opacity -composite sparse-color:- |\
         convert -size 50x50 xc: -sparse-color voronoi '@-' \
         +dither -colors $numcol -depth 8 -format "%c" histogram:info: |\
         sed -n 's/^[ ]*\(.*\):.*[#]\([0-9a-fA-F]*\) .*$/\1,#\2/p' | sort -r -n -k 1 -t ",")
         hex=`echo "$sortedfinalcolors" | head -n 1 | cut -d, -f2`
         ((fuzz+=10))
      done
      if [[ "$linktype" != "file" ]]
      then
         rm "$img"
      fi
   fi
   [[ `playerctl status` != "Playing" ]] && hex="#FFFFFF"
   [[ "%{F$hex}" != `cat ~/.ricing/cavacolors` ]] && echo -n "%{F$hex}"  > ~/.ricing/cavacolors
   img_url=$new_img_url
   last_status=$new_status
   sleep 1
done
