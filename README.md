# ~/.*

#### I use BTW

[![I use Arch btw](https://i.kym-cdn.com/photos/images/original/002/243/369/466.png)](https://knowyourmeme.com/memes/btw-i-use-arch)

- [ArchLinux](https://archlinux.org) **obviously**.
- Nix [home-manager](https://nix-community.github.io/home-manager/) to manage
  user-centric programs (see `flake.nix`).
- [Chezmoi](https://www.chezmoi.io) to manage dotfiles (see `config/` dir).
- Window Manager: [dwm](https://dwm.suckless.org) - see
  [agjacome/dwm](https://github.com/agjacome/dwm)
- Shell: [fish](https://fishshell.com)
- Terminal: [alacritty](https://alacritty.org)
- Multiplexer: [tmux](https://github.com/tmux/tmux/wiki)
- Editor: [neovim](https://neovim.io) - see
  [agjacome/nvimfiles](https://github.com/agjacome/nvimfiles)
- Password manager: [pass](https://www.passwordstore.org)


#### YOLO

```
$ curl -fsLS https://raw.githubusercontent.com/agjacome/dotfiles/master/bin/setup | bash
```

It ~~may~~ will not work for you. Read the code and figure out your own setup.
The main steps are:

```
$ git clone https://github.com/agjacome/dotfiles.git dotfiles
$ cd dotfiles
$ nix-shell --run "home-manager switch --impure --flake ."
$ chezmoi init --apply -S .
```

#### TODO

- Migrate from [dmenu](https://github.com/agjacome/dmenu) to
  [rofi](https://davatorium.github.io/rofi/).
- Fully migrate from dwm to [xmonad](https://xmonad.org).
- Play with and fully migrate to [NixOS](https://nixos.org) at some point **btw**.
- Become rich and retire early to have infinite time to spend in unproductive
  migrations.

#### Nobody Asked Questions

##### How often do you update your environment?
Damn bro, very smart question, no way anyone can tell with this being a git
repository and shit.

You can see it yourself at
[github's code-frequency](https://github.com/agjacome/dotfiles/graphs/code-frequency).
In general every few years I tend to do a big overhaul of all the things that I
grew disgusted with over time, and there are very small changes in between
those periods.

I agree with this article: [Stop perfecting your
config](https://arkadiuszchmura.com/posts/stop-perfecting-your-config/)

##### Why `--impure`?
Because propietary Nvidia [NixGL](https://github.com/guibou/nixGL) wrapper.

##### Why don't you use home-manager to also setup your dotfiles?
I may at some point, just started using home-manager recently. I am mostly ok
for the dual setup of home-manager + chezmoi at the moment. It may become a new
todo point in the future.

