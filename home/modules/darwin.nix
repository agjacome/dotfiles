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
      (nerdfonts.override { fonts = [ "Monofur" ]; })
      pinentry_mac
      raycast
    ];
  };
}
