{ config, lib, ... }:

with lib;
{
  options = {
    modules.darwin.enable = mkEnableOption "darwin module";
  };

  config = mkIf config.modules.darwin.enable { };
}
