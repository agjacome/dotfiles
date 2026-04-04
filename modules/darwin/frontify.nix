{ config, lib, ... }:

{
  options = {
    systems.frontify.enable = lib.mkEnableOption "frontify system";
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
