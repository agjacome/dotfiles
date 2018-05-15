[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec /usr/bin/xinit -- vt1 :0 -nolisten tcp

source $HOME/.bashrc
