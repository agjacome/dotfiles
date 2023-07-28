status is-interactive || exit

if type -q mcfly
    set -gx MCFLY_DELETE_WITHOUT_CONFIRM true
    set -gx MCFLY_DISABLE_MENU true
    set -gx MCFLY_FUZZY 2
    set -gx MCFLY_KEY_SCHEME vim
    set -gx MCFLY_PROMPT ''
    set -gx MCFLY_RESULTS 30
    mcfly init fish | source
end
