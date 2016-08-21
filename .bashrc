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

# cabal
[[ -d $HOME/.cabal-sandbox/bin ]] && export PATH=$PATH:$HOME/.cabal-sandbox/bin
[[ -d $HOME/.cabal/bin         ]] && export PATH=$PATH:$HOME/.cabal/bin

# nix
[[ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]] && . $HOME/.nix-profile/etc/profile.d/nix.sh
# quickfix for glibc 2.21 vs 2.22 locale issues (see https://github.com/NixOS/nix/issues/599).
export LOCALE_ARCHIVE="/nix/store/2mbqc6p36xlyl21d4mf1zhmprmqijwkk-glibc-locales-2.21/lib/locale/locale-archive"

# npm
export PATH=$PATH:$HOME/.node_modules/bin
export npm_config_prefix=$HOME/.node_modules

# path for marks (see .bash_functions)
export MARKPATH=$HOME/etc/marks

# source bash files
source "$HOME/.bash_alias"
source "$HOME/.bash_functions"

# set the prompt (defined in .bash_functions)
PROMPT_COMMAND=prompt

