{ config, lib, pkgs, ... }:

with lib;
{
  options = {
    homes.desktop.enable = mkEnableOption "desktop home";
  };

  config = mkIf config.homes.desktop.enable {

    nixpkgs.config.permittedInsecurePackages = [ "ventoy-1.1.05" ];

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
      (config.lib.nixGL.wrap mpv)
      (config.lib.nixGL.wrap vivaldi)

      # fonts
      fontconfig
      nerd-fonts.droid-sans-mono
      nerd-fonts.monofur
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
