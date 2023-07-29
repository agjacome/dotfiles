status is-interactive || exit

if type -q fasd
    set -gx _FASD_DATA "$HOME/.cache/fasd"
end
