#!/usr/bin/env bash

function __prompt()
{
    local -r status_color=$( (( $? )) && echo "\[\e[0;31m\]" || echo "" )
    local -r prompt=$( [[ $EUID -eq 0 ]] && echo -e "\uF12A\uF12A" || echo -e "\uF054\uF054")

    export PS1="${status_color}${prompt}\[\e[0m\] "
    export PS2="${prompt}\[\e[0m\] "
    export PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${LOGNAME}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
}

function __completemux()
{
    COMPREPLY=()
    local word="${COMP_WORDS[COMP_CWORD]}"

    if [ "$COMP_CWORD" -eq 1 ]; then
        local commands="$(compgen -W "$(tmuxinator commands)" -- "$word")"
        local projects="$(compgen -W "$(tmuxinator completions start)" -- "$word")"

        COMPREPLY=( $commands $projects )
    elif [ "$COMP_CWORD" -eq 2 ]; then
        local words=("${COMP_WORDS[@]}")

        unset words[0]
        unset words[$COMP_CWORD]

        local completions=$(tmuxinator completions "${words[@]}")
        COMPREPLY=( $(compgen -W "$completions" -- "$word") )
    fi
}
