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
      m-cli
      mpv
      (nerdfonts.override { fonts = [ "Monofur" ]; })
      pinentry_mac
      raycast
      spotify
      unixtools.watch
      xclip
      yt-dlp
    ];
  };
}
