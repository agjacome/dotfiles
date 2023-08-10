if type -q caffeinate; and type -q tmux
  function caff --wraps='caffeinate'
    set -l pid (pgrep $argv | head -1)
    tmux new-session -d -s caffeinate -n 'caffeinate' "caffeinate -diu -w$pid"
  end
end
