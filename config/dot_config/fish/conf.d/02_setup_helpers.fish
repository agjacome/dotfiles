set -q __fish_setup_helpers; and return
set -gx __fish_setup_helpers 1

if type -q direnv
    direnv hook fish | source
end

if type -q fzf
    set -gx FZF_DEFAULT_OPTS '--layout=reverse --cycle --ansi --height=100%'
    set -gx FZF_TMUX 1
end

if type -q zoxide
    zoxide init fish | source
end
