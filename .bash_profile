# dwm in vt1, kodi in vt2
if [[ -z $DISPLAY ]]; then
    if   [[ $XDG_VTNR -eq 1 && -z $(pgrep -x dwm)  ]]; then
        exec /usr/bin/xinit $HOME/.bin/dwm_run  -- vt1 :0 -nolisten tcp
    elif [[ $XDG_VTNR -eq 2 && -z $(pgrep -x kodi) ]]; then
        exec /usr/bin/xinit $HOME/.bin/kodi_run -- vt2 :1 -nolisten tcp
    fi
fi

source $HOME/.bashrc
