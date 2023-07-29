{ config, pkgs, ... }:

{
  home.username = "agjacome";
  home.homeDirectory = "/home/agjacome";

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    bat
    chezmoi
    direnv
    fd
    fish
    fzf
    git
    gnupg
    htop
    less
    neofetch
    neovim
    pass
    ripgrep
    ripgrep-all
    tmux
    tree
    zoxide
  ];

  programs.home-manager.enable = true;
}
