#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# source xinitrc.d scripts
for file in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$file" ] && . "$file"
done
unset file

# add font paths
xset +fp $HOME/.fonts
xset fp rehash

# disable dpms
xset -dpms
xset s off

# load .Xresources
xrdb -load $HOME/.Xresources

# Java workaround
wmname LG3D

# set background and statusbar
$HOME/bin/wallpaper &
$HOME/bin/dwm-statusbar 10 &

# start daemons
[[ -z $(pgrep -af urxvtd)    ]] && urxvtd -q -o -f
[[ -z $(pgrep -af syndaemon) ]] && /usr/bin/syndaemon -R -K -t -i 1 -d
[[ -z $(pgrep -af mpd)       ]] && mpd > /dev/null 2> /dev/null
[[ -z $(pgrep -af mpdas)     ]] && mpdas -c $HOME/.config/mpdasrc > /dev/null 2> /dev/null &
[[ -z $(pgrep -af devmon)    ]] && devmon > /dev/null 2> /dev/null &

# start DWM
dwm 2> $HOME/var/log/dwm.log
