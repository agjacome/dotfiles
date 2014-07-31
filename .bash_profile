# dwm in vt1, xbmc in vt2
if [[ -z $DISPLAY ]]; then
    if   [[ $XDG_VTNR -eq 1 && -z $(pgrep -x dwm)  ]]; then
        exec /usr/bin/xinit $HOME/.bin/dwm_run  -- vt1 :0 -nolisten tcp
    elif [[ $XDG_VTNR -eq 2 && -z $(pgrep -x xbmc) ]]; then
        exec /usr/bin/xinit $HOME/.bin/xbmc_run -- vt2 :1 -nolisten tcp
    fi
fi

source $HOME/.bashrc
