#!/bin/sh
export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"

eval "$(dbus-launch --sh-syntax --exit-with-session)"
fcitx -d &
