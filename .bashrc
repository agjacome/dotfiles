[ -z "$PS1" ] && return

export PATH=$PATH:$HOME/.bin:$HOME/.rvm/bin

export HISTCONTROL=erasedups
export HISTIGNORE="&:pwd:cd:~:[bf]g:history *:l:l[sla]:exit:\:q:su:clear:genpwd *"

export EDITOR=vim
export BROWSER=firefox
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

export GREP_COLOR="1;31"
export LESS="-R"

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dirspell
shopt -s histappend
shopt -s hostcomplete
shopt -s no_empty_cmd_completion
shopt -s nocaseglob

source "$HOME/.bash_alias"
source "$HOME/.bash_functions"
source "$HOME/.rvm/scripts/rvm"
source "$HOME/.rvm/scripts/completion"

PROMPT_COMMAND=prompt
