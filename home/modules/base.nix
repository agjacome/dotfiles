{ config, pkgs, lib, inputs, overlays, ... }:

with lib;
{
  imports = [
    inputs.nix-index-database.hmModules.nix-index
  ];

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
    nixpkgs = {
      overlays = [ overlays.stable ];
    };

    home.username = config.user.name;
    home.homeDirectory = config.user.home;

    nix.package = mkDefault pkgs.nix;
    nix.settings = {
      auto-optimise-store = true;
      experimental-features = "nix-command flakes repl-flake";
      keep-derivations = true;
      keep-outputs = true;
    };

    home.packages = with pkgs; [
      bash
      bat
      bc
      cargo
      chafa
      chezmoi
      comma
      curl
      diceware
      direnv
      fd
      fish
      fzf
      gcc13
      git
      git-annex
      git-privacy
      gnumake
      gnupg
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
      pinentry
      rclone
      ripgrep
      (stablepkgs.ripgrep-all) # unstable failing to build @ 2023-08-26
      rsync
      speedtest-cli
      tldr
      tmux
      tor
      tree
      vimv
      zoxide
    ];

    home.stateVersion = "23.05";
  };
}
