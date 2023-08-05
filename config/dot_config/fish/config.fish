! status is-interactive; or set -q __fish_config_sourced; and return

set -f theme_title_display_process yes
set -f theme_title_display_path yes
set -f theme_title_display_user no
set -f theme_title_use_abbreviated_path yes

bind \ct $HOME/.local/bin/tmux-session

set -gx __fish_config_sourced 1
