{ config, pkgs, lib, inputs, ... }:

with lib; {
  imports = [
    inputs.nix-index-database.hmModules.nix-index
  ];

  options = {
    modules.base.enable = mkEnableOption "base module";

    user.name = mkOption {
      type = types.str;
      default = "agjacome";
    };
  };

  config = mkIf config.modules.base.enable {
    home.username = config.user.name;
    home.homeDirectory = "/home/${config.user.name}";

    programs.home-manager.enable = true;
    programs.nix-index-database.comma.enable = true;

    nix.package = mkDefault pkgs.nix;
    nix.settings = {
      experimental-features = "nix-command flakes repl-flake";
      keep-outputs          = true;
      keep-derivations      = true;
    };

    home.packages = with pkgs; [
      bash
      bat
      bc
      chezmoi
      direnv
      fd
      fish
      fzf
      git
      git-annex
      git-privacy
      gnupg
      htop
      less
      moreutils
      mr
      neofetch
      neovim
      nodejs_20
      openssh
      pass
      pinentry
      rclone
      reptyr
      ripgrep
      ripgrep-all
      rsync
      screenkey
      streamlink
      tmux
      tree
      yt-dlp
      zoxide
    ];

    home.stateVersion = "23.05";
  };
}
