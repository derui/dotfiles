#!/usr/bin/env bash

killall -q polybar

while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

export MONITOR=$(polybar -m | head -1 | sed -e 's/:.*$//g')
polybar monitor1 &

if [[ -x `which xrandr` && `xrandr -q | grep " connected" | wc -l` -eq "2" ]]; then
    MONITOR=$(polybar -m | tail -1 | sed -e 's/:.*$//g')
    polybar monitor2 &
fi

echo "Bars launched"
