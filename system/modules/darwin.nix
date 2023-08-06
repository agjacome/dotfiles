{ config, pkgs, lib, ... }:

with lib;
{
  options = {
    systems.darwin.enable = mkEnableOption "darwin system";
  };

  config = mkIf config.systems.darwin.enable {
    services.nix-daemon.enable = true;

    environment = {
      systemPath = [ "/opt/homebrew/bin" ];
    };

    system = {
      defaults = {
        dock = {
          autohide = true;
          mru-spaces = false;
        };

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

    homebrew = {
      enable = true;

      global = {
        autoUpdate = false;
        brewfile = true;
      };

      caskArgs.no_quarantine = true;

      casks = [ "amethyst" ];
    };
  };
}
