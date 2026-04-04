{ config, lib, ... }:

{
  options = {
    systems.frontify.enable = lib.mkEnableOption "frontify system";

    user.name = lib.mkOption { type = lib.types.str; };
  };

  config = lib.mkIf config.systems.frontify.enable {
    ids.gids.nixbld = 30000;
    system.primaryUser = config.user.name;

    homebrew.casks = [
      "orbstack"
      "tunnelblick"
      "tuple"
    ];
  };
}
