ArchLinux dotfiles
==================

These are my config files for Linux's $HOME. There are designed to use with
Arch Linux, but are probably suitable for any other distro (after installing
all required packages).

Installation:

    git clone --recursive git@github.com:agjacome/dotfiles.git
    cd dotfiles
    for file in $(ls -a | grep -v "^.\{1,2\}$\|^.git$\|^README.md$"); do \
        ln -sf $(pwd)/$file ~/$file; \
    done

