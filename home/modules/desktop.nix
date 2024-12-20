{ config, pkgs, lib, ... }:

with lib;
let
  # https://github.com/guibou/nixGL/issues/114
  withNixGL = pkg:
    if config.nixgl == null then
      pkg
    else
      (pkg.overrideAttrs (old: {
        name = "nixGL-${pkg.name}";
        buildCommand = ''
          set -eo pipefail

          ${
          # Heavily inspired by https://stackoverflow.com/a/68523368/6259505
          pkgs.lib.concatStringsSep "\n" (map (outputName: ''
            echo "Copying output ${outputName}"
            set -x
            cp -rs --no-preserve=mode "${pkg.${outputName}}" "''$${outputName}"
            set +x
          '') (old.outputs or [ "out" ]))}

          rm -rf $out/bin/*
          shopt -s nullglob # Prevent loop from running if no files
          for file in ${pkg.out}/bin/*; do
            echo "#!${pkgs.bash}/bin/bash" > "$out/bin/$(basename $file)"
            echo "exec -a \"\$0\" ${lib.getExe config.nixgl} $file \"\$@\"" >> "$out/bin/$(basename $file)"
            chmod +x "$out/bin/$(basename $file)"
          done
          shopt -u nullglob # Revert nullglob back to its normal default state
        '';
      }));

  nixGLPkg = if config.nixgl == null then [ ] else [ config.nixgl ];
in
{
  options = {
    homes.desktop.enable = mkEnableOption "desktop home";

    nixgl = mkOption {
      type = types.nullOr types.package;
      default = null;
    };
  };

  config =
    let
      packages = with pkgs; [
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
      ];

      glPackages = with pkgs; map withNixGL [
        alacritty
        firefox-devedition
        mpv
        vivaldi
      ];

      fonts = with pkgs; [
        nerd-fonts.droid-sans-mono
        (stablepkgs.nerdfonts.override { fonts = [ "Monofur" ]; }) # something seems broken in unstable monofur
        noto-fonts
        noto-fonts-emoji
      ];
    in

    mkIf config.homes.desktop.enable {
      fonts.fontconfig.enable = true;

      home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        name = "Vanilla-DMZ";
        size = 64;
        package = pkgs.vanilla-dmz;
      };

      home.packages = packages ++ glPackages ++ nixGLPkg ++ fonts;
    };
}
