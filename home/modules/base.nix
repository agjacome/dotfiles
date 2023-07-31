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

    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      bash
      bat
      bc
      chezmoi
      diceware
      direnv
      fd
      fish
      fzf
      git
      git-annex
      git-privacy
      gnupg
      htop
      jq
      less
      mr
      neofetch
      neovim
      (nerdfonts.override { fonts = ["DroidSansMono" "Monofur" ]; })
      nodejs_20
      openssh
      parallel
      pass
      pinentry
      rclone
      reptyr
      ripgrep
      ripgrep-all
      rsync
      tmux
      tor
      tree
      zoxide
    ];

    home.stateVersion = "23.05";
  };
}
