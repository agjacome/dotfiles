{ config, lib, pkgs, ... }:

with lib;
{
  options = {
    homes.desktop.enable = mkEnableOption "desktop home";
  };

  config = mkIf config.homes.desktop.enable {
    home.packages = with pkgs; [
      aria2
      clipmenu
      dunst
      feh
      ffmpeg
      gimp
      screenkey
      spmd
      spotify
      streamlink
      tbsm
      ventoy
      vivaldi-ffmpeg-codecs
      xclip
      xdg-utils
      yt-dlp
      zathura

      # gpu-accelerated packages
      (config.lib.nixGL.wrap alacritty)
      (config.lib.nixGL.wrap ghostty)
      (config.lib.nixGL.wrap mpv)
      (config.lib.nixGL.wrap vivaldi)

      # fonts
      (stablepkgs.nerdfonts.override { fonts = [ "DroidSansMono" "Monofur" ]; })
      noto-fonts
      noto-fonts-emoji
    ];

    fonts.fontconfig.enable = true;

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Vanilla-DMZ";
      size = 64;
      package = pkgs.vanilla-dmz;
    };
  };
}
