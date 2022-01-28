#!/bin/bash
source "${HOME}/.cache/wal/colors.sh"

used=`free -h | grep Mem | awk '{printf ($3)}'`
pused=`echo $used | sed 's/Gi//g' | sed 's/\.//g'`
all=`free -h | grep Mem | awk '{printf ($2)}'`
pall= `echo $pall | sed 's/Gi//g' | sed 's/\.//g'`
fg="$foreground"

[[ `echo $pused | grep -i -c "M"` -ne 0 ]] && echo "$used/$all %{T4}%{T-}%{F-}" && exit

[[ $pused -ge 65 ]] && fg="#FFC139"

[[ $pused -ge 75 ]] && fg="#FF3939"

echo "%{F$fg}$used/$all %{T4}%{T-}%{F-}"
 
