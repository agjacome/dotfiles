if not status is-interactive; return; end

if test -f ~/.profile
    fenv source ~/.profile
end

set -x PATH $HOME/bin $HOME/.local/bin $PATH

set -gx BROWSER vivaldi
set -gx COLORTERM truecolor
set -gx DIFFPROG nvim -d -c 'set diffopt+=vertical' -c 'set diffopt+=foldcolumn:0'
set -gx EDITOR nvim
set -gx GPG_TTY (tty)
set -gx LANG en_GB.UTF-8
set -gx LC_ALL en_GB.UTF-8
set -gx LESS -R -X
set -gx PAGER less
set -gx QUOTING_STYLE literal
set -fx LOCALE_ARCHIVE /usr/lib/locale/locale-archive

set -f theme_title_display_process yes
set -f theme_title_display_path yes
set -f theme_title_display_user no
set -f theme_title_use_abbreviated_path yes

