{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
{
  options = {
    homes.gtk.enable = mkEnableOption "gtk home";
  };

  config = mkIf config.homes.gtk.enable {
    gtk = {
      enable = true;
      gtk2 = {
        configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      };
      font = {
        name = "Noto Sans";
        size = 10;
        package = pkgs.noto-fonts;
      };
      iconTheme = {
        name = "Numix";
        package = pkgs.numix-icon-theme;
      };
      theme = {
        name = "Numix";
        package = pkgs.numix-gtk-theme;
      };
    };
  };
}
