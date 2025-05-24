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
      mpv
      nerd-fonts.monofur
      pinentry_mac
      raycast
      spotify
      (tableplus.overrideAttrs (oldAttrs: {
        version = "608";
        src = fetchurl {
          url = "https://files.tableplus.com/macos/608/TablePlus.dmg";
          hash = "sha256-wb5ac82u+DJ7hJ+htnW6aipYjzfjW70lISFZtOOxsy0=";
        };
      }))
      unixtools.watch
      xclip
      yt-dlp
    ];
  };
}
