$HOME files
===========

My config files for Linux's ```$HOME```. I've only tested them under ArchLinux,
but they are probably suitable to any distro, given that all the required
packages are installed.

My home directory is usually structured as follows:

```
/home/agjacome
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
```

All configuration files assume that directory structure.

This git repository is kept under ```~/etc/dotfiles```, and all dotfiles are
just symlinked (```ln -s```) to their expected destination, except those that
hold passwords or sensitive information, which are just copied and modified in
place (e.g.: ```~/.msmtprc```). Aside from dotfiles, ```~/bin``` holds scripts
and programs that will be available from ```$PATH```, and the directory is also
symlinked in the same way.

The usual way to install everything:

```bash
mkdir -p $HOME/{doc,etc,media,share,src,tmp,var}
mkdir -p $HOME/var/{log,mail}
mkdir -p $HOME/etc/marks

git clone https://github.com/agjacome/dotfiles.git $HOME/etc/dotfiles

for file in $(ls -a $HOME/etc/dotfiles | grep -v "^.\{1,2\}$\|^.git$\|^.gitmodules$\|^README.md$"); do
    ln -sf $HOME/etc/dotfiles/$file $HOME/$file
done
```

There are things that will probably require some tweaking after that linking is
executed, and they should be solved case by case.



### TODO

* Migrate plain symlinks of dotfiles to [GNU Stow](https://www.gnu.org/software/stow/)
or [rcm](https://github.com/thoughtbot/rcm) or anything similar.

