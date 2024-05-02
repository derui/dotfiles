#!/bin/sh

export EDITOR=/usr/bin/vim
export XDG_CACHE_HOME=/var/tmp/share/$USER

exec dbus-run-session Hyprland
