if ! set -q __fish_profile_sourced; and test -f /etc/profile
  fenv source /etc/profile
  set -gx __fish_profile_sourced 1
end

fish_add_path -gmp $HOME/.local/bin $HOME/.nix-profile/bin

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
