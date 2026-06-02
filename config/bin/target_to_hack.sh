#!/bin/bash
 
ip_address=$(/bin/cat ~/.config/bin/target | awk '{print $1}')
machine_name=$(/bin/cat ~/.config/bin/target | awk '{print $2}')
 
if [ $ip_address ] && [ $machine_name ]; then
    echo "%{F#0077B6}ﲅ %{F#ffffff}$ip_address%{u-} - $machine_name"
else
    echo "%{F#0077B6}ﲅ %{u-}%{F#ffffff} No target"
fi
