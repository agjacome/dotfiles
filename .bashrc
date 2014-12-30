[ -z "$PS1" ] && return

# binary executables
export PATH=$PATH:$HOME/.bin

# bash history control
export HISTCONTROL=erasedups
export HISTIGNORE="&:pwd:cd:~:[bf]g:history *:l:l[sla]:exit:\:q:su:clear:genpwd *"

# common stuff
export EDITOR=vim
export BROWSER=firefox
export GREP_COLOR="1;31"
export LESS="-R -X"

# shell options
shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dirspell
shopt -s histappend
shopt -s hostcomplete
shopt -s no_empty_cmd_completion
shopt -s nocaseglob

# source bash files, rvm files and virtualenvwrapper
source "$HOME/.bash_alias"
source "$HOME/.bash_functions"

# set the prompt (defined in .bash_functions)
PROMPT_COMMAND=prompt

# path for marks (see .bash_functions)
export MARKPATH=$HOME/.marks

# tmuxinator completion
source "$HOME/.bin/tmuxinator_completion"

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -r "$HOME/.rvm/scripts/completion" ]] && source "$HOME/.rvm/scripts/completion"

# Virtualenv
export WORKON_HOME="$HOME/.virtualenvs"
source /usr/bin/virtualenvwrapper.sh

# Cabal
export PATH=$PATH:$HOME/.cabal/bin:$HOME/.cabal-sandbox/bin

# java workarounds
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true -Dsun.java2d.xrender=true'

# vaapi backend for vdpau (libvdpau-va-gl)
export VDPAU_DRIVER=va_gl
