{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  dmsPluginRegistry = pkgs.fetchFromGitHub {
    owner = "AvengeMedia";
    repo = "dms-plugin-registry";
    rev = "91f5a9998db5b2810f7ee5623e1f2142b89de2ea";
    hash = "sha256-firHOQ20re/4yzut4lJyNp3QE5nFCtjF5vS475vJJ9A=";
  };

  dmsPassPlugin = pkgs.fetchFromGitHub {
    owner = "LouisKottmann";
    repo = "dms-pass";
    rev = "be247a2029efc0df07d57236bad09754384cfb2f";
    hash = "sha256-40U/OTGTFf3lc4Q01/DYLw9xmRHvALq3GHyTytqcNlY=";
  };
in
{
  options = {
    homes.desktop.enable = lib.mkEnableOption "desktop home";
  };

  config = lib.mkIf config.homes.desktop.enable {

    nixpkgs.config.permittedInsecurePackages = [ "ventoy-1.1.12" ];

    home.packages = with pkgs; [
      aria2
      cava
      clipmenu
      detox
      dunst
      inputs.dank-pinentry.packages.${pkgs.stdenv.hostPlatform.system}.pinentry-dms
      ffmpeg
      fuzzel
      gimp
      nirius
      ripgrep-all
      screenkey
      scrot
      spmd
      spotify
      streamlink
      swayimg
      tbsm
      ventoy
      wl-clipboard
      xclip
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
      xdg-utils
      xwayland-satellite
      yt-dlp
      zathura

      egl-gbm
      egl-wayland
      egl-x11

      # gpu-accelerated packages
      (config.lib.nixGL.wrap alacritty)
      (config.lib.nixGL.wrap dms-shell)
      (config.lib.nixGL.wrap helium)
      (config.lib.nixGL.wrap mpv)
      (config.lib.nixGL.wrap obs-studio)
      (config.lib.nixGL.wrap quickshell)
      (config.lib.nixGL.wrap vivaldi)

      # fonts
      fontconfig
      nerd-fonts.droid-sans-mono
      nerd-fonts.monofur
      noto-fonts
      noto-fonts-color-emoji

      # gtk theming
      numix-gtk-theme
      numix-icon-theme
      vanilla-dmz
    ];

    fonts.fontconfig.enable = true;

    # dms plugins
    home.file.".config/DankMaterialShell/themes/gruvboxMulti" = {
      source = "${dmsPluginRegistry}/themes/gruvbox-multi";
      force = true;
    };

    home.file.".config/DankMaterialShell/plugins/dankPinentry".source =
      inputs.dank-pinentry.packages.${pkgs.stdenv.hostPlatform.system}.dms-plugin;

    home.file.".config/DankMaterialShell/plugins/dmsPass".source = dmsPassPlugin;
  };
}
