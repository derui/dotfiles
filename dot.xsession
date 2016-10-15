#!/bin/sh
# $Xorg: xinitrc.cpp,v 1.3 2000/08/17 19:54:30 cpqbld Exp $

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/usr/X11/lib/X11/xinit/.Xresources
sysmodmap=/usr/X11/lib/X11/xinit/.Xmodmap

# merge in defaults and keymaps

#if [ -f $sysresources ]; then
#
#    if [ -x /usr/bin/cpp ] ; then
#        xrdb -merge $sysresources
#    else
#        xrdb -nocpp -merge $sysresources
#    fi
#
#fi

#if [ -f $sysmodmap ]; then
#    xmodmap $sysmodmap
#fi

#if [ -f "$userresources" ]; then
#    if [ -x /usr/bin/cpp ] ; then
#        xrdb -merge "$userresources"
#    else
#        xrdb -nocpp -merge "$userresources"
#    fi
#
#fi
#
#if [ -f "$usermodmap" ]; then
#    xmodmap "$usermodmap"
#
#    # Enable SandS with using xcape.
#    if [ -x `which xcape` ]; then
#        xmodmap -e 'keycode 255=space'; xmodmap -e 'keycode 65=Shift_L'; xcape -e '#65=space'
#    fi
#fi
if [ -f "$HOME/.xprofile" ]; then
    source $HOME/.xprofile
fi

eval "$(dbus-launch --sh-syntax --exit-with-session)"
fcitx -d &

export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

#if [ -d /usr/X11/lib/X11/xinit/xinitrc.d ] ; then
#	for f in /usr/X11/lib/X11/xinit/xinitrc.d/*.sh ; do
# 		[ -x "$f" ] && . "$f"
# 	done
# 	unset f
#fi

# modify xset's values
xset s off
xset s noblank
xset -dpms

# for transparents
xcompmgr -n &
nitrogen --restore

# running dropbox
$HOME/.dropbox-dist/dropboxd &

exec /usr/bin/awesome

# xclock -geometry 50x50-1+1 &
# xterm -geometry 80x50+494+51 &
# xterm -geometry 80x20+494-0 &
