$HOME files
===========

My config files for Linux's ```$HOME```. I've only tested them under ArchLinux,
but they are probably suitable to any distro, given that all the required
packages are installed.

My home directory is usually structured as follows:

    $HOME
    ├── bin
    ├── doc
    │   ├── books
    │   ├── papers
    │   └── ...
    ├── etc
    │   ├── dotfiles
    │   ├── dwm
    │   ├── marks
    │   ├── vimfiles
    │   └── ...
    ├── media
    │   ├── films
    │   ├── music
    │   └── ...
    ├── share
    │   ├── college
    │   ├── courses
    │   ├── torrents
    │   └── ...
    ├── src
    │   ├── arch
    │   │   ├── build
    │   │   ├── packages
    │   │   ├── sources
    │   │   ├── srcpackages
    │   │   └── yaourt
    │   └── ...
    ├── tmp
    └── var
        ├── log
        ├── mail
        └── ...

All configuration files assume that directory structure.

This git repository is kept under ```~/etc/dotfiles```, and all dotfiles are
just symlinked (```ln -s```) to their expected destination, except those that
hold passwords or sensitive information, which are just copied and modified in
place (e.g.: ```~/.msmtprc```). Aside from dotfiles, ```~/bin``` holds scripts
and programs that will be available from ```$PATH```, and the directory is also
symlinked in the same way.

The usual way to install everything:

    mkdir -p $HOME/{doc,etc,media,share,src,tmp,var} $HOME/etc/marks $HOME/var/{log,mail}
    git clone https://github.com/agjacome/dotfiles.git $HOME/etc/dotfiles
    pushd $HOME/etc/dotfiles
    for file in $(ls -a | grep -v "^.\{1,2\}$\|^.git$\|^.gitmodules$\|^README.md$"); do
        ln -sf $(pwd)/$file ~/$file;
    done
    popd

There are things that will probably require some tweaking after that linking is
executed, and they should be solved case by case.
