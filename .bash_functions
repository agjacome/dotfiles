color_off='\[\e[0m\]'
red='\[\e[0;31m\]'
green='\[\e[0;32m\]'
yellow='\[\e[0;33m\]'
cyan='\[\e[0;36m\]'
white='\[\e[0;37m\]'

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

function extract()
{
    if [ -f "${1}" ] ; then
        case "${1}" in
            *.tar.bz2)   tar xvjf "${1}";;
            *.tar.gz)    tar xvzf "${1}";;
            *.bz2)       bunzip2 "${1}";;
            *.rar)       unrar x "${1}";;
            *.gz)        gunzip "${1}";;
            *.tar)       tar xvf "${1}";;
            *.tbz2)      tar xvjf "${1}";;
            *.tgz)       tar xvzf "${1}";;
            *.zip)       unzip "${1}";;
            *.Z)         uncompress "${1}"  ;;
            *.7z)        7z x "${1}";;
            *)           echo "unable to extract '$1'";;
        esac
    fi
}

function man()
{
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

# vim: ft=sh
