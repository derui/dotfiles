#!/usr/bin/env python3

import time
import subprocess

target_card = 0
default_profile = "output:analog-stereo+input:analog-stereo"
card_name = "usb-Yamaha_Corporation_Steinberg_UR22C-00"
default_card = "alsa_card.{}".format(card_name)
default_output = "alsa_output.{}.analog-stereo".format(card_name)
default_input = "alsa_input.{}.analog-stereo".format(card_name)

def turn_off_target_device():
    subprocess.run(['pactl', 'set-card-profile', default_card, 'off'], check=True)

def start_jack():
    print("Starting jack...")
    ret = subprocess.run(['jack_control','start'], check=True)

def exit_jack():
    print("Exiting jack...")
    ret = subprocess.run(['jack_control','exit'], check=True)

def find_sink(name):
    ret = subprocess.run(['pactl', 'list', 'short', 'sinks'], capture_output=True)
    output = list(filter(lambda v: v >= 0, map(lambda x: x.find(name), str(ret.stdout, 'utf-8').splitlines())))

    if len(output) > 0:
        return True
    return False

def wait_sink_enabled(name):
    while True:
        print("Waiting to finish registration sink '{}' to pulseaudio...".format(name))
        v = find_sink(name)
        if v:
            break
        time.sleep(1)

def set_jack_as_default():
    print( "Use jack sink as default sink in Pulseaudio")
    subprocess.run(['pacmd', 'set-default-sink', 'jack_out'])
    subprocess.run(['pacmd', 'set-default-source', 'jack_in'])

def restore_default():
    print( "Use default sink as default sink in Pulseaudio")
    subprocess.run(['pacmd', 'set-default-sink', default_output])
    subprocess.run(['pacmd', 'set-default-source',default_input])

def restore_target_device():
    subprocess.run(["pactl", 'set-card-profile', default_card, default_profile])

    wait_sink_enabled(default_output)

def reset_all_stream_sinks(output):
    all_sinks = subprocess.run(['pactl', 'list','short','sinks'], capture_output=True)
    all_sinks = [str(v, 'utf-8').split('\t') for v in all_sinks.stdout.splitlines()]
    default_sinks = list(filter(lambda v: v[1].find(output) != -1,
                          map(lambda v: (v[0], v[1]), all_sinks)))

    if len(default_sinks) < 1:
        print("Can not get sink information for default")
        exit(1)

    default_sink = default_sinks[0]
    all_sink_inputs = subprocess.run(['pactl', 'list','short','sink-inputs'], capture_output=True)
    all_sink_inputs = [str(v, 'utf-8').split('\t')[0] for v in all_sink_inputs.stdout.splitlines()]

    for sink_input in all_sink_inputs:
        print("Move sink of {} to {}".format(sink_input, default_sink[0]))
        subprocess.run(['pactl', 'move-sink-input', sink_input, default_sink[0]])


def main():
    turn_off_target_device()
    start_jack()
    set_jack_as_default()

    wait_sink_enabled("jack_out")
    reset_all_stream_sinks("jack_out")

    input("Jack startred successfully, waiting hit any key to quit jack...")

    exit_jack()

    restore_target_device()
    restore_default()
    reset_all_stream_sinks(default_output)


main()
