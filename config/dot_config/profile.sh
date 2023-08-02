#!/usr/bin/env bash

if [[ -f /etc/profile ]]; then
    source /etc/profile
fi

# FIXME: this is breaking stuff
# if [[ -d $HOME/.nix-profile/share ]]; then
#     export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"
# fi

if [[ -z $DISPLAY && -n $XDG_VTNR && $XDG_VTNR -le 2 ]]; then
    if command -v tbsm >/dev/null 2>&1; then
        exec tbsm
    fi
fi
