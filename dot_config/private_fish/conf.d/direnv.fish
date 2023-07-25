status is-interactive || exit

if which direnv > /dev/null;
    direnv hook fish | source;
end

