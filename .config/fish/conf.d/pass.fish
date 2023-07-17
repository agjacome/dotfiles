status is-interactive || exit

if which pass > /dev/null
    set -gx PASSWORD_STORE_DIR $HOME/etc/passwords
end

