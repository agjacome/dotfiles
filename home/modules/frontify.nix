{ config, pkgs, lib, ... }:

with lib;
{
  options = {
    homes.frontify.enable = mkEnableOption "frontify home";
  };

  config = mkIf config.homes.frontify.enable {
    home.packages = with pkgs; [
      awscli2
      colima
      docker
      docker-compose
      ffmpeg
      vips
    ];
  };
}
