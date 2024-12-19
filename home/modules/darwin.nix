{ config, pkgs, lib, ... }:

with lib;
{
  options = {
    homes.darwin.enable = mkEnableOption "darwin home";
  };

  config = mkIf config.homes.darwin.enable {
    home.packages = with pkgs; [
      alacritty
      coreutils-full
      gnused
      mpv
      nerd-fonts.monofur
      pinentry_mac
      raycast
      spotify
      unixtools.watch
      xclip
      yt-dlp
    ];
  };
}
