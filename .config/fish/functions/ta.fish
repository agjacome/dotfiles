function ta --wraps='tmux attach-session'
    systemd-run --scope --user tmux attach-session $argv
end
