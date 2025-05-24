{ config, lib, ... }:

with lib;
{
  options = {
    systems.frontify.enable = mkEnableOption "frontify system";
  };

  config = mkIf config.systems.frontify.enable {
    ids.gids.nixbld = 30000;
    system.primaryUser = "albertojacome";

    homebrew.casks = [
      "orbstack"
      "tunnelblick"
      "tuple"
    ];
  };
}
