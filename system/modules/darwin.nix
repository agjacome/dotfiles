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
      activationScripts.postUserActivation.text = ''
        /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
      '';

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
          tilesize = 24;
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
          InitialKeyRepeat = 20;
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

      caskArgs.no_quarantine = true;

      casks = [ "amethyst" ];
    };
  };
}
