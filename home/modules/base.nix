{ config, pkgs, lib, inputs, ... }:

with lib;
{
  imports = [
    inputs.nix-index-database.hmModules.nix-index
  ];

  options = {
    modules.base.enable = mkEnableOption "base module";

    user.name = mkOption {
      type = types.str;
      default = "agjacome";
    };

    user.home = mkOption {
      type = types.str;
      default = "/home/${config.user.name}";
    };
  };

  config = mkIf config.modules.base.enable {
    home.username = config.user.name;
    home.homeDirectory = config.user.home;

    programs.home-manager.enable = true;
    programs.nix-index-database.comma.enable = true;

    nix.package = mkDefault pkgs.nix;
    nix.settings = {
      auto-optimise-store = true;
      experimental-features = "nix-command flakes repl-flake";
      keep-outputs = true;
      keep-derivations = true;
    };

    home.packages = with pkgs; [
      bash
      bat
      bc
      cargo
      chafa
      chezmoi
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
      htop
      imagemagick
      jq
      less
      mr
      neofetch
      neovim
      nodejs_20
      openssh
      parallel
      pass
      pinentry
      rclone
      ripgrep
      ripgrep-all
      rsync
      speedtest-cli
      tldr
      tmux
      tor
      tree
      zoxide
    ];

    home.stateVersion = "23.05";
  };
}
