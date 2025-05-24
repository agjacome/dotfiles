{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

with lib;
{
  imports = [ inputs.nix-index-database.hmModules.nix-index ];

  options = {
    homes.base.enable = mkEnableOption "base home";

    user.name = mkOption {
      type = types.str;
      default = "agjacome";
    };

    user.home = mkOption {
      type = types.str;
      default = "/home/${config.user.name}";
    };
  };

  config = mkIf config.homes.base.enable {
    home.username = config.user.name;
    home.homeDirectory = config.user.home;

    nix.package = mkDefault pkgs.nix;
    nix.settings = {
      experimental-features = "nix-command flakes";
    };

    home.packages = with pkgs; [
      bash
      bc
      cargo
      chezmoi
      comma
      curl
      delta
      diceware
      direnv
      fd
      fish
      fnm
      fzf
      gh
      git
      git-annex
      git-machete
      git-privacy
      gnumake
      gnupg
      gron
      home-manager
      htop
      imagemagick
      jq
      kalker
      less
      mr
      neovim
      nodejs_20
      openssh
      parallel
      pass
      pinentry-tty
      rclone
      ripgrep
      rsync
      speedtest-cli
      tldr
      tmux
      tor
      tree
      tree-sitter
      vimv
      zoxide
    ];

    home.stateVersion = "23.05";
  };
}
