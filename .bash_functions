#!/usr/bin/env bash

function __prompt()
{
    local -r status_color=$( (( $? )) && echo "\[\e[0;31m\]" || echo "" )
    local -r prompt=$( [[ $EUID -eq 0 ]] && echo -e "\uF12A\uF12A" || echo -e "\uF054\uF054")

    export PS1="${status_color}${prompt}\[\e[0m\] "
    export PS2="${prompt}\[\e[0m\] "
}

function jump()
{
    cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
}

function mark()
{
    mkdir -p $MARKPATH; ln -s "$(pwd)" $MARKPATH/$1
}

function unmark()
{
    rm -if $MARKPATH/$1
}

function marks() {
    ls -l $MARKPATH | sed 's/  / /g' | cut -d' ' -f9- | sed 's/->/\>/' | column -t -s ">"
}

function __completemarks()
{
    local curw=${COMP_WORDS[COMP_CWORD]}
    local wordlist=$(find $MARKPATH -type l -printf "%f\n")
    COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
    return 0
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

ipif() {
    if grep -P "(([1-9]\d{0,2})\.){3}(?2)" <<< "$1"; then
	 curl ipinfo.io/"$1"
    else
	ipawk=($(host "$1" | awk '/address/ { print $NF }'))
	curl ipinfo.io/${ipawk[1]}
    fi
    echo
}
