{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  waylandGlWrap =
    pkg:
    let
      wrapped = config.lib.nixGL.wrap pkg;
    in
    pkgs.runCommand "${pkg.name}-nixgl-wayland" { nativeBuildInputs = [ pkgs.makeWrapper ]; } ''
      mkdir -p $out
      cp -rs --no-preserve=mode ${wrapped}/* $out/

      rm -rf $out/bin
      mkdir -p $out/bin

      for bin in ${wrapped}/bin/*; do
        makeWrapper "$bin" "$out/bin/$(basename "$bin")" \
          --prefix LD_LIBRARY_PATH : "${pkgs.egl-wayland}/lib" \
          --suffix __EGL_EXTERNAL_PLATFORM_CONFIG_DIRS : "/etc/egl/egl_external_platform.d:/usr/share/egl/egl_external_platform.d:${pkgs.egl-wayland}/share/egl/egl_external_platform.d"
      done
    '';

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
      clipmenu
      detox
      discord
      dunst
      inputs.dank-pinentry.packages.${pkgs.stdenv.hostPlatform.system}.pinentry-dms
      feh
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
      tbsm
      ventoy
      wl-clipboard
      xclip
      xdg-utils
      xwayland-satellite
      yt-dlp
      zathura

      # gpu-accelerated packages
      (waylandGlWrap alacritty)
      (waylandGlWrap dms-shell)
      (waylandGlWrap quickshell)

      (config.lib.nixGL.wrap mpv)
      (config.lib.nixGL.wrap helium)
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
