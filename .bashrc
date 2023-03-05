[ -z "$PS1" ] && return

# binary executables
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

# bash history control
export HISTCONTROL=erasedups
export HISTIGNORE="&:pwd:cd:~:[bf]g:history *:l:l[sla]:exit:\:q:su:clear:genpwd *"

# common stuff
export EDITOR=nvim
export BROWSER=vivaldi
export GREP_COLOR="1;31"
export LESS="-R -X"
export QUOTING_STYLE=literal
export GPG_TTY=$(tty)

# shell options
shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dirspell
shopt -s histappend
shopt -s hostcomplete
shopt -s no_empty_cmd_completion
shopt -s nocaseglob

# source bash files
source "$HOME/.bash_alias"
source "$HOME/.bash_functions"

# set the prompt (defined in .bash_functions)
__prompt

# extra autocompletions
complete -F __completemux tmuxinator mux
complete -F _fasd_bash_hook_cmd_complete v m

# pacman helper for not found commands
source /usr/share/doc/pkgfile/command-not-found.bash

# nix
export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

# fasd
eval "$(fasd --init auto)"

# direnv
eval "$(direnv hook bash)"
