{ config, pkgs, lib, inputs, ... }:

with lib;
{
  options = {
    modules.darwin.enable = mkEnableOption "darwin module";
  };

  config = mkIf config.modules.darwin.enable {
    home.packages = with pkgs; [
      alacritty
      (nerdfonts.override { fonts = ["Monofur"]; })
    ];
  };
}
