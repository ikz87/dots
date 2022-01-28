#!/bin/bash

killall rofi


rofi -show drun -color-normal "#272a34,#FFFFFF,#404040,#555555,#ff3061" -color-window "#404040,#ff3061,#ff3061" -font "CartographCF 14" -show-icons -location 0 -lines 1 -width $2 -yoffset -307 -bw 5 -padding 10 -line-margin 5 -hide-scrollbar true -fixed-num-lines false 
