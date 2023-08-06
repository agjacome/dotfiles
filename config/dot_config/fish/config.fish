status is-interactive; or return

if test -z $DISPLAY; and ! test -z $XDG_VTNR; and test $XDG_VTNR -le 2
    if type -q tbsm
        exec tbsm
    end
end

set -f theme_title_display_process yes
set -f theme_title_display_path yes
set -f theme_title_display_user no
set -f theme_title_use_abbreviated_path yes

bind \ct $HOME/.local/bin/tmux-session
