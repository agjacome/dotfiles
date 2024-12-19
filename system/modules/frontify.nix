{ config, lib, ... }:

with lib;
{
  options = {
    systems.frontify.enable = mkEnableOption "frontify system";
  };

  config = mkIf config.systems.frontify.enable {
    homebrew.casks = [
      "deskpad"
      "orbstack"
      "tableplus"
      "tunnelblick"
      "tuple"
    ];
  };
}
