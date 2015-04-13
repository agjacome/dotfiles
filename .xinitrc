#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# source xinitrc.d scripts
for file in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$file" ] && . "$file"
done
unset file

# set output to active monitor
$HOME/.bin/hotplug-mon

# add font paths
xset +fp $HOME/.fonts
xset fp rehash

# disable dpms
xset -dpms
xset s off

# load .Xresources
xrdb -merge $HOME/.Xresources

# Java workaround
wmname LG3D

# set background and statusbar
$HOME/.bin/background &
$HOME/.bin/dwm_status 10 &

# start daemons
[[ -z $(pgrep -af urxvtd)     ]] && /usr/bin/urxvtd -q -o -f
[[ -z $(pgrep -af syndaemon)  ]] && /usr/bin/syndaemon -R -K -t -i 1 -d
[[ -z $(pgrep -af pulseaudio) ]] && /usr/bin/start-pulseaudio-x11
[[ -z $(pgrep -af mpd)        ]] && /usr/bin/mpd > /dev/null 2> /dev/null
[[ -z $(pgrep -af mpdas)      ]] && /usr/bin/mpdas -c $HOME/.config/mpdasrc > /dev/null 2> /dev/null &
[[ -z $(pgrep -af devmon)     ]] && /usr/bin/devmon > /dev/null 2> /dev/null &

# start DWM
/usr/bin/dwm 2> /tmp/dwm.log
