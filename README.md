# \$HOME config files for ArchLinux

My home directory is usually structured as follows:

```
/home/agjacome
├── bin
├── doc
├── etc
│   ├── dotfiles
│   └── ...
├── media
├── share
├── src
├── tmp
└── var
    ├── log
    ├── mail
    └── ...
```

All configuration files assume that directory structure.

This git repository is kept under `~/etc/dotfiles`, and all dotfiles are
just symlinked to their expected destination, except those that hold passwords
or sensitive information, which are just copied and modified in place (e.g.:
`~/.msmtprc`).

`~/bin` holds scripts and programs that will be available from `$PATH`,
and the directory is also symlinked in the same way.

The manual way to install everything (until migrated to a proper dotfile tool
or something similar):

```bash
mkdir -p $HOME/{doc,etc,media,share,src,tmp,var}
mkdir -p $HOME/var/{log,mail}

git clone https://github.com/agjacome/dotfiles.git $HOME/etc/dotfiles

for file in $(ls -a $HOME/etc/dotfiles | grep -v "^.\{1,2\}$\|^.git$\|^.gitmodules$\|^README.md$"); do
    ln -sf $HOME/etc/dotfiles/$file $HOME/$file
done
```

### TODO

- Migrate to a proper tool for managing dotfiles:
  https://wiki.archlinux.org/index.php/Dotfiles#Tools
