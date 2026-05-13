#!/bin/bash
 
ip_address=$(/bin/cat ~/.config/bin/target | awk '{print $1}')
machine_name=$(/bin/cat ~/.config/bin/target | awk '{print $2}')
 
if [ $ip_address ] && [ $machine_name ]; then
    echo "%{F#A182FF}ﲅ %{F#ffffff}$ip_address%{u-} - $machine_name"
else
    echo "%{F#A182FF}ﲅ %{u-}%{F#ffffff} No target"
fi
