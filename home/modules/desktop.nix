{ config, pkgs, lib, ... }:

# nixgl management adapted (copied) from responses and suggestions in
# https://github.com/guibou/nixGL/issues/114

with lib;
let
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
    modules.desktop.enable = mkEnableOption "desktop module";

    nixgl = mkOption {
      type = types.nullOr types.package;
      default = null;
    };
  };

  config =
    let
      packages = with pkgs; [
        clipmenu
        dunst
        feh
        ffmpeg
        gimp
        screenkey
        spotify
        streamlink
        vivaldi-ffmpeg-codecs
        xclip
        xdg-utils
        yt-dlp
        zathura
      ];

      glPackages = with pkgs; map withNixGL [
        alacritty
        discord
        firefox-devedition
        mpv
        slack
        vivaldi
      ];

      fonts = with pkgs; [
        (nerdfonts.override { fonts = [ "DroidSansMono" "Monofur" ]; })
        noto-fonts
        noto-fonts-emoji
      ];
    in
    mkIf config.modules.desktop.enable {
      fonts.fontconfig.enable = true;
      home.packages = packages ++ glPackages ++ nixGLPkg ++ fonts;
    };
}
