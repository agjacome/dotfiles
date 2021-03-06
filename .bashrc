[ -z "$PS1" ] && return

# binary executables
export PATH=$HOME/bin:$PATH

# bash history control
export HISTCONTROL=erasedups
export HISTIGNORE="&:pwd:cd:~:[bf]g:history *:l:l[sla]:exit:\:q:su:clear:genpwd *"

# common stuff
export EDITOR=vim
export BROWSER=palemoon
export GREP_COLOR="1;31"
export LESS="-R -X"
export QUOTING_STYLE=literal

# shell options
shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dirspell
shopt -s histappend
shopt -s hostcomplete
shopt -s no_empty_cmd_completion
shopt -s nocaseglob

# fasd
eval "$(fasd --init auto)"

# source bash files
source "$HOME/.bash_alias"
source "$HOME/.bash_functions"

source /usr/share/doc/pkgfile/command-not-found.bash

# set the prompt (defined in .bash_functions)
PROMPT_COMMAND=__prompt

# extra autocompletions
complete -F __completemux tmuxinator mux
complete -F _fasd_bash_hook_cmd_complete v m

# direnv
eval "$(direnv hook bash)"
