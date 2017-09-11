[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec /usr/bin/xinit -- vt1 :0 -nolisten tcp

source $HOME/.bashrc
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
    . $HOME/.nix-profile/etc/profile.d/nix.sh;
fi
