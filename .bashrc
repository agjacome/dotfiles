[ -z "$PS1" ] && return

# binary executables
export PATH=$HOME/bin:$PATH

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

# cabal
[[ -d $HOME/.cabal-sandbox/bin ]] && export PATH=$PATH:$HOME/.cabal-sandbox/bin
[[ -d $HOME/.cabal/bin         ]] && export PATH=$PATH:$HOME/.cabal/bin

# nix
[[ -e $HOME/.nix-profile/etc/profile.d/nix.hs ]] && $HOME/.nix-profile/etc/profile.d/nix.sh

# path for marks (see .bash_functions)
export MARKPATH=$HOME/etc/marks

# java workarounds
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true -Dsun.java2d.xrender=true'

# source bash files
source "$HOME/.bash_alias"
source "$HOME/.bash_functions"

# set the prompt (defined in .bash_functions)
PROMPT_COMMAND=prompt
