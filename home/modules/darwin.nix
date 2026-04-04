{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = {
    homes.darwin.enable = lib.mkEnableOption "darwin home";
  };

  config = lib.mkIf config.homes.darwin.enable {

    home.packages = with pkgs; [
      alacritty
      coreutils-full
      gnused
      httptoolkit
      mpv
      nerd-fonts.monofur
      pinentry_mac
      raycast
      spotify
      (tableplus.overrideAttrs (oldAttrs: {
        version = "662";
        src = fetchurl {
          url = "https://files.tableplus.com/macos/662/TablePlus.dmg";
          hash = "sha256-VR0sSTZfRjjv+p4DcYciKBJG5DHIwj4KLhTHPGRsSX0=";
        };
      }))
      unixtools.watch
      xclip
      yt-dlp
    ];
  };
}
