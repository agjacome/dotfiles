#!/usr/bin/env bash

if [[ -f /etc/profile ]]; then
    source /etc/profile
fi

if [[ -z $DISPLAY && $XDG_VTNR -le 2 ]]; then
    exec tbsm
fi
