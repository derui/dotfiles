#!/bin/bash

if [[ ! -x $(which jack_control) ]]; then
    exit 1
fi

TARGET_CARD=0
DEFAULT_PROFILE="output:analog-stereo+input:analog-stereo"
DEFAULT_CARD=alsa_card.usb-Yamaha_Corporation_Steinberg_UR22C-00

# turn off target device in pulseaudio
pactl set-card-profile $DEFAULT_CARD off

jack_control start
if [[ $? != 0 ]]; then
    echo "Jack startup failed"
    pactl set-card-profile $DEFAULT_CARD $DEFAULT_PROFILE
    exit 1
fi

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

pacmd set-default-sink alsa_output.usb-Yamaha_Corporation_Steinberg_UR22C-00.analog-stereo
pacmd set-default-source alsa_input.usb-Yamaha_Corporation_Steinberg_UR22C-00.analog-stereo
