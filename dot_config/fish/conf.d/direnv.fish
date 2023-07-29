status is-interactive || exit

if type -q direnv
    direnv hook fish | source
end

