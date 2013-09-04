[ -z "$PS1" ] && return

# binary executables (add .bin/ and rvm binaries)
export PATH=$PATH:$HOME/.bin:$HOME/.rvm/bin

# bash history control
export HISTCONTROL=erasedups
export HISTIGNORE="&:pwd:cd:~:[bf]g:history *:l:l[sla]:exit:\:q:su:clear:genpwd *"

# common stuff
export EDITOR=vim
export BROWSER=firefox
export GREP_COLOR="1;31"
export LESS="-R"

# python virtualenv
export WORKON_HOME=$HOME/.virtualenvs

# java workarounds
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true -Dsun.java2d.xrender=true'

# path for marks (see .bash_functions)
export MARKPATH=$HOME/.marks

# vaapi backend for vdpau (libvdpau-va-gl)
export VDPAU_DRIVER=va_gl

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
source "$HOME/.rvm/scripts/rvm"
source "$HOME/.rvm/scripts/completion"
source "/usr/bin/virtualenvwrapper.sh"

# set the prompt (defined in .bash_functions)
PROMPT_COMMAND=prompt
