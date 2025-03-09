{ config, pkgs, lib, ... }:

with lib;
{
  options = {
    systems.darwin.enable = mkEnableOption "darwin system";
  };

  config = mkIf config.systems.darwin.enable {
    environment = {
      systemPath = [ "/opt/homebrew/bin" ];
    };

    system = {
      stateVersion = 5;

      defaults = {
        dock = {
          autohide = true;
          autohide-delay = 0.0;
          autohide-time-modifier = 0.2;
          expose-animation-duration = 0.2;
          mru-spaces = false;
          orientation = "bottom";
          show-process-indicators = true;
          show-recents = false;
          showhidden = true;
          tilesize = 42;
          wvous-bl-corner = 1;
          wvous-br-corner = 1;
          wvous-tl-corner = 1;
          wvous-tr-corner = 1;
        };

        finder = {
          AppleShowAllExtensions = true;
          AppleShowAllFiles = true;
          CreateDesktop = true;
          FXDefaultSearchScope = "SCcf";
          FXPreferredViewStyle = "Nlsv";
          QuitMenuItem = true;
          ShowPathbar = true;
          ShowStatusBar = false;
          _FXShowPosixPathInTitle = false;
        };

        NSGlobalDomain = {
          KeyRepeat = 1;
          InitialKeyRepeat = 10;
        };

        CustomUserPreferences = {
          "com.apple.finder" = {
            ShowExternalHardDrivesOnDesktop = true;
            ShowHardDrivesOnDesktop = false;
            ShowRemovableMediaOnDesktop = true;
            _FXSortFoldersFirst = true;
          };
        };
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

      onActivation = {
        autoUpdate = false;
        cleanup = "zap";
        upgrade = false;
      };

      caskArgs.no_quarantine = true;

      casks = [
        "amethyst"
        "keycastr"
        "steermouse"
      ];
    };
  };
}
