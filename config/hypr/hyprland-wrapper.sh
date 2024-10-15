#!/bin/sh

export EDITOR=/usr/bin/vim
export XDG_CACHE_HOME=/var/tmp/share/$USER
export XDG_RUNTIME_HOME=/tmp/$(id -u)-runtime-dir

exec dbus-run-session Hyprland
