#!/usr/bin/env bash

killall -q polybar

while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

polybar monitor1 &
polybar monitor2 &

echo "Bars launched"
