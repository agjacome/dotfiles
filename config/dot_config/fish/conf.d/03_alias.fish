abbr cp    "cp -ir"
abbr cowp  "cp -ir --reflink=always"
abbr df    "df -hT"
abbr grep  "grep --color=auto -Ii"
abbr l     "ls"
abbr l1    "ls -1"
abbr mkdir "mkdir -pv"
abbr mv    "mv -i"
abbr rm    "rm -Ivf"
abbr rr    "rm -Irvf"

if type -q tmux
    abbr ta "tmux attach -t"
    abbr tl "tmux list-sessions"
    abbr tn "tmux new -s (basename (pwd) | sed 's/[^a-zA-Z0-9]//g')"
end

if type -q nvim
    abbr v   "nvim"
    abbr vi  "nvim"
    abbr vim "nvim"
else if type -q vim
    abbr v   "vim"
    abbr vi  "vim"
    abbr vim "vim"
end

if type -q yay
    abbr i   "yay -S"
    abbr qdt "yay -Qdtq"
    abbr ss  "yay -Ss"
    abbr syu "yay -Syu"
else if test -f /usr/bin/pacman
    abbr i   "sudo pacman -S"
    abbr qdt "pacman -Qdtq"
    abbr ss  "pacman -Ss"
    abbr syu "sudo pacman -Syu"
end

if test -d $HOME/.dotfiles
    abbr dotup "pushd $HOME/.dotfiles && git pull && home-manager switch --impure && chezmoi apply && popd"
end

if type -q docker
    abbr dcu "docker compose up --build -d --remove-orphans --pull always --renew-anon-volumes --wait"
    abbr dcp "docker compose ps -a --format='table {{.Name}}\t{{.Image}}\t{{.Status}}'"
    abbr dcd "docker compose down"
end
