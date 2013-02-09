if [[ $(tty) = /dev/tty1 && -z "$DISPLAY" ]]; then
    if [[ -z "$(pgrep -x dwm)" ]]; then
        setsid /usr/bin/xinit $HOME/.bin/dwm_run -- :0 -nolisten tcp &> /dev/null &
        sleep 3
        exit
    elif [[ -z "$(pgrep -x xbmc)" ]]; then
        setsid /usr/bin/xinit $HOME/.bin/xbmc_run -- :1 -nolisten tcp -layout xbmc &> /dev/null &
        sleep 3
        exit
    fi
fi

source $HOME/.bashrc
