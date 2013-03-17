#!/bin/sh
# $Xorg: xinitrc.cpp,v 1.3 2000/08/17 19:54:30 cpqbld Exp $

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/usr/X11/lib/X11/xinit/.Xresources
sysmodmap=/usr/X11/lib/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then

    if [ -x /usr/bin/cpp ] ; then
        xrdb -merge $sysresources
    else
        xrdb -nocpp -merge $sysresources
    fi

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    if [ -x /usr/bin/cpp ] ; then
        xrdb -merge "$userresources"
    else
        xrdb -nocpp -merge "$userresources"
    fi

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
# for use skk-uim setting
export XMODIFIERS="@im=ibus"
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="ibus"
# uim-xim &
ibus-daemon -d -x

# for gnome/kde like task tray
#trayer-srg --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --tint 0x191970 --heighttype pixel --height 16 --monitor primary &

export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

if [ -d /usr/X11/lib/X11/xinit/xinitrc.d ] ; then
	for f in /usr/X11/lib/X11/xinit/xinitrc.d/*.sh ; do
 		[ -x "$f" ] && . "$f"
 	done
 	unset f
fi

# modify xset's values
xset s off
xset s noblank
xset -dpms

# for transparents
xcompmgr -n &
nitrogen --restore

# running dropbox
$HOME/.dropbox-dist/dropboxd &

# running growthforecast
$HOME/perl/bin/growthforecast.pl --data-dir $HOME/growthforecast &

# running local fluentd
$HOME/.gem/ruby/1.9.1/bin/fluentd -c $HOME/conf/fluentd.conf &

#exec /home/derui/bin/xmonad
exec /usr/bin/awesome

# xclock -geometry 50x50-1+1 &
# xterm -geometry 80x50+494+51 &
# xterm -geometry 80x20+494-0 &
# exec xterm -geometry 80x66+0+0 -name login
