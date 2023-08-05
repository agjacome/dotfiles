#!/usr/bin/env bash

if [[ $__PROFILE_SOURCED -eq 1 ]]; then
    return
fi

if [[ -f /etc/profile ]]; then
    source /etc/profile
fi

if [[ -z $DISPLAY && -n $XDG_VTNR && $XDG_VTNR -le 2 ]]; then
    if command -v tbsm >/dev/null 2>&1; then
        exec tbsm
    fi
fi

export __PROFILE_SOURCED=1
