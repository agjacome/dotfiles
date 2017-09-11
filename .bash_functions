declare -r color_off='\[\e[0m\]'
declare -r red='\[\e[0;31m\]'
declare -r green='\[\e[0;32m\]'
declare -r yellow='\[\e[0;33m\]'
declare -r cyan='\[\e[0;36m\]'
declare -r white='\[\e[0;37m\]'

function prompt_git()
{
    git branch &> /dev/null || return 1

    local HEAD="$(git symbolic-ref HEAD 2> /dev/null)"
    local BRANCH="${HEAD##*/}"

    if [[ -z "$(git status 2> /dev/null | grep 'working tree clean')" ]]; then
        local STATUS="!"
    fi

    local git="${red}${BRANCH-unknown}${STATUS}"
    echo "${color_off}─[${git}${color_off}]"
}

function prompt_pwd()
{
    local path="${PWD/#$HOME/\~}"
    local git="$(prompt_git)"
    local maxlen="$(($(tput cols) - ${#USER} - ${#HOSTNAME} - ${#git} - 14))"

    if [[ ${#path} -gt ${maxlen} ]]; then
        local path="...${path:$((${#path} - ${maxlen}))}"
    fi

    echo $path
}

function prompt()
{
    (( $? )) && local status="${red}✗" || local status="${green}✓"

    local git=$(prompt_git)
    local path=$(prompt_pwd)
    [[ $EUID -eq 0 ]] && local user=${red} || local user=${yellow}

    PS1="${color_off}┌─[${user}\u${color_off}]─[${cyan}\h${color_off}]─"
    PS1="${PS1}[${green}${path}${color_off}]${git}${color_off}\n"
    PS1="${PS1}└─[${status}${color_off}]─╼${color_off} "

    PS2="${color_off}╾─────╼${color_off} "
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

function marks()
{
    ls -l $MARKPATH | sed 's/  / /g' | cut -d' ' -f9- | sed 's/->/\>/' | column -t -s ">"
}

_completemarks()
{
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

_completemux() {
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

complete -F _completemarks jump unmark
complete -F _completemux tmuxinator mux

# vim: ft=sh
