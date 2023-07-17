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

set -l histignore_commands \
    history pwd cd l l1 ls ll la exit su clear type cal date pass

for cmd in $histignore_commands
    function $cmd-histignore --on-event fish_postexec --inherit-variable cmd
        string match -qr "^$cmd" -- $argv
        and history delete --exact --case-sensitive -- (string trim -r $argv)
    end
end

if which pass > /dev/null
    set -gx PASSWORD_STORE_DIR $HOME/etc/passwords
end

if which direnv > /dev/null;
    direnv hook fish | source;
end

if which mcfly > /dev/null;
    set -gx MCFLY_DISABLE_MENU true
    set -gx MCFLY_FUZZY 2
    set -gx MCFLY_KEY_SCHEME vim
    mcfly init fish | source;
end

