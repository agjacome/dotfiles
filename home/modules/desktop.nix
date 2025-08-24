{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
{
  options = {
    homes.desktop.enable = mkEnableOption "desktop home";
  };

  config = mkIf config.homes.desktop.enable {

    nixpkgs.config.permittedInsecurePackages = [ "ventoy-1.1.05" ];

    # downgraded vivaldi to nix 24.11 version
    nixpkgs.overlays = [
      (
        final: prev:
        let
          oldpkgs = (
            import
              (builtins.fetchTarball {
                url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/24.11.tar.gz";
                sha256 = "1gx0hihb7kcddv5h0k7dysp2xhf1ny0aalxhjbpj2lmvj7h9g80a";
              })
              {
                inherit (prev) system;
                config = {
                  allowUnfree = true;
                };
              }
          );
        in
        {
          vivaldi = oldpkgs.vivaldi;
          vivaldi-ffmpeg-codecs = oldpkgs.vivaldi-ffmpeg-codecs;
        }
      )
    ];

    home.packages = with pkgs; [
      aria2
      clipmenu
      dunst
      feh
      ffmpeg
      gimp
      httptoolkit
      ripgrep-all
      screenkey
      spmd
      spotify
      streamlink
      tbsm
      ventoy
      xclip
      xdg-utils
      yt-dlp
      zathura

      # gpu-accelerated packages
      (config.lib.nixGL.wrap alacritty)
      (config.lib.nixGL.wrap mpv)
      (config.lib.nixGL.wrap vivaldi)
      (config.lib.nixGL.wrap vivaldi-ffmpeg-codecs)

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
