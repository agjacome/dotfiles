{
  config,
  lib,
  pkgs,
  ...
}:

let
  wrapWaylandGL =
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
          --set __EGL_EXTERNAL_PLATFORM_CONFIG_DIRS "${pkgs.egl-wayland}/share/egl/egl_external_platform.d"
      done
    '';
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
      feh
      ffmpeg
      fuzzel
      gimp
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
      (wrapWaylandGL alacritty)
      (wrapWaylandGL dms-shell)
      (config.lib.nixGL.wrap mpv)
      (wrapWaylandGL quickshell)
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
  };
}
