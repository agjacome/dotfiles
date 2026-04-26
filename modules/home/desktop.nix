{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    homes.desktop.enable = lib.mkEnableOption "desktop home";
  };

  config = lib.mkIf config.homes.desktop.enable {

    nixpkgs.config.permittedInsecurePackages = [ "ventoy-1.1.10" ];

    home.packages = with pkgs; [
      aria2
      clipmenu
      detox
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
      (config.lib.nixGL.wrap alacritty)
      (config.lib.nixGL.wrap mpv)
      (config.lib.nixGL.wrap niri)
      (config.lib.nixGL.wrap vivaldi)

      # niri launcher with nix mesa for EGL_EXT_device_query
      (writeShellScriptBin "niri-launch" ''
        export __EGL_VENDOR_LIBRARY_FILENAMES="${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json"
        export LD_LIBRARY_PATH="${pkgs.mesa}/lib"
        exec niri --session 2>>/tmp/niri.log
      '')

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
