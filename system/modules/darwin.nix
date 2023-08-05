{ config, lib, ... }:

with lib;
{
  options = {
    systems.darwin.enable = mkEnableOption "darwin system";
  };

  config = mkIf config.systems.darwin.enable {
    services.nix-daemon.enable = true;

    system = {
      defaults = {
        finder = {
          AppleShowAllExtensions = true;
          CreateDesktop = false;
          FXPreferredViewStyle = "Nlsv";
          ShowPathbar = true;
          ShowStatusBar = true;
        };

        NSGlobalDomain.KeyRepeat = 1;
        NSGlobalDomain.InitialKeyRepeat = 20;
      };

      keyboard = {
        enableKeyMapping = true;
        remapCapsLockToEscape = true;
      };
    };
  };
}
