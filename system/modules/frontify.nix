{ config, lib, ... }:

with lib;
{
  options = {
    systems.frontify.enable = mkEnableOption "frontify system";

    user.name = mkOption { type = types.str; };
  };

  config = mkIf config.systems.frontify.enable {
    ids.gids.nixbld = 30000;
    system.primaryUser = config.user.name;

    homebrew.casks = [
      "orbstack"
      "tunnelblick"
      "tuple"
    ];
  };
}
