#!/bin/sh
export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"

if [ -f "$HOME/.Xresources" ]; then
    xrdb $HOME/.Xresources
fi

eval "$(dbus-launch --sh-syntax --exit-with-session)"

fcitx -d &

awesome 
