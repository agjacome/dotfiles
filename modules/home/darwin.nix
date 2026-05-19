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
    targets.darwin.copyApps.enable = false;
    targets.darwin.linkApps.enable = true;

    home.packages = with pkgs; [
      alacritty
      coreutils-full
      gnused
      helium
      nerd-fonts.monofur
      pinentry_mac
      raycast
      spotify
      unixtools.watch

      (tableplus.overrideAttrs (oldAttrs: {
        version = "704";
        src = fetchurl {
          url = "https://files.tableplus.com/macos/704/TablePlus.dmg";
          hash = "sha256-u+vxksWZBUVtQRiR707S993rnuj3ofZaPvBglJlq1T8=";
        };
      }))
    ];
  };
}
