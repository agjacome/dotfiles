#!/usr/bin/env bash

if [[ -f /etc/profile ]]; then
    source /etc/profile
fi

if [[ -z $DISPLAY && -n $XDG_VTNR && $XDG_VTNR -le 2 ]]; then
    if command -v tbsm >/dev/null 2>&1; then
        exec tbsm
    fi
fi
