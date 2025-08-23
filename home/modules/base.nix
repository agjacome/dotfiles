{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

with lib;
{
  imports = [ inputs.nix-index-database.homeModules.nix-index ];

  options = {
    homes.base.enable = mkEnableOption "base home";

    user.name = mkOption { type = types.str; };
    user.home = mkOption { type = types.str; };
  };

  config = mkIf config.homes.base.enable {
    home.username = config.user.name;
    home.homeDirectory = config.user.home;

    nix.package = mkDefault pkgs.nix;
    nix.settings = {
      experimental-features = "nix-command flakes";

      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://nixpkgs-unfree.cachix.org"
      ];

      trusted-substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://nixpkgs-unfree.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
      ];
    };

    home.packages = with pkgs; [
      bash
      bc
      cachix
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
