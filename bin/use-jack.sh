#!/bin/bash

if [[ ! -x $(which jack_control) ]]; then
    exit 1
fi

TARGET_CARD=0
DEFAULT_PROFILE="output:analog-stereo+input:analog-stereo"
CARD_NAME=usb-Yamaha_Corporation_Steinberg_UR22C-00
DEFAULT_CARD=alsa_card.$CARD_NAME

# turn off target device in pulseaudio
pactl set-card-profile $DEFAULT_CARD off

jack_control start
if [[ $? != 0 ]]; then
    echo "Jack startup failed"
    pactl set-card-profile $DEFAULT_CARD $DEFAULT_PROFILE
    exit 1
fi

echo "Waiting to finish registration jack to pulseaudio..."
sleep 2

echo "Use jack sink as default sink in Pulseaudio"
pacmd set-default-sink jack_out
pacmd set-default-source jack_in

echo "Jack started successfully, waiting hit any key to quit jack..."

while read -r v; do
    break
done

jack_control exit
echo "Jack exited"

# restore default profile
pactl set-card-profile $DEFAULT_CARD $DEFAULT_PROFILE

while true; do
    echo "Waiting to finish activation on pulseaudio..."
    local sinks=$(pacmd list-sinks | rg "name:" | rg -n "$CARD_NAME")
    if [[ sinks >= 1 ]]; then
        break
    fi

    sleep 1
done

pacmd set-default-sink alsa_output.$CARD_NAME.analog-stereo
pacmd set-default-source alsa_input.$CARD_NAME.analog-stereo
