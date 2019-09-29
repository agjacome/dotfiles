[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec /usr/bin/xinit /home/agjacome/.xinitrc-dwm  -- :0 vt1 -nolisten tcp
[[ -z $DISPLAY && $XDG_VTNR -eq 2 ]] && exec /usr/bin/xinit /home/agjacome/.xinitrc-kodi -- :1 vt2 -nolisten tcp

source $HOME/.bashrc
