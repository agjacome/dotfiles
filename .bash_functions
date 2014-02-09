color_off='\[\e[0m\]'
red='\[\e[0;31m\]'
green='\[\e[0;32m\]'
yellow='\[\e[0;33m\]'
cyan='\[\e[0;36m\]'
white='\[\e[0;37m\]'

## PROMPT

function prompt_git()
{
    git branch &> /dev/null || return 1

    local HEAD="$(git symbolic-ref HEAD 2> /dev/null)"
    local BRANCH="${HEAD##*/}"

    if [[ -z "$(git status 2> /dev/null | grep 'directory clean')" ]]; then
        local STATUS="!"
    fi

    local git="${red}${BRANCH-unknown}${STATUS}"
    echo "${white}─[${git}${white}]"
}

function prompt_pwd()
{
    local path="${PWD/#$HOME/~}"
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
    [[ $EUID -eq 0 ]] && local root=${red} || local root=${yellow}

    PS1="${white}┌─[${root}\u${white}]─[${cyan}\h${white}]─"
    PS1="${PS1}[${green}${path}${white}]${git}${white}\n"
    PS1="${PS1}└─[${status}${white}]─╼${color_off} "

    PS2="${white}╾─────╼${color_off} "
}

## MARKPATH

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

complete -F _completemarks jump unmark

# vim: ft=sh
