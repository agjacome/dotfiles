function tn --wraps='tmux new-session'
    systemd-run --scope --user tmux new-session $argv
end
