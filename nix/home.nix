{ config, pkgs, ... }:

{
  home.username = "agjacome";
  home.homeDirectory = "/home/agjacome";

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    bat
    chezmoi
    direnv
    fish
    fzf
    git
    gnupg
    htop
    less
    mcfly
    neofetch
    neovim
    pass
    ripgrep
    ripgrep-all
    tmux
    tree
  ];

  programs.home-manager.enable = true;
}
