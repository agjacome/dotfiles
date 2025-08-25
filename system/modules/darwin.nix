{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
{
  options = {
    systems.darwin.enable = mkEnableOption "darwin system";

    user.name = mkOption { type = types.str; };
  };

  config = mkIf config.systems.darwin.enable {
    nix.settings = {
      trusted-users = [ config.user.name ];
    };

    system = {
      stateVersion = 5;

      defaults = {
        dock = {
          autohide = true;
          autohide-delay = 0.0;
          autohide-time-modifier = 0.0;
          expose-animation-duration = 0.0;
          launchanim = false;
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
          NSAutomaticWindowAnimationsEnabled = false;
          NSWindowResizeTime = 0.001;
          NSScrollAnimationEnabled = false;
          NSUseAnimatedFocusRing = false;
        };

        CustomUserPreferences = {
          "com.apple.finder" = {
            ShowExternalHardDrivesOnDesktop = true;
            ShowHardDrivesOnDesktop = false;
            ShowRemovableMediaOnDesktop = true;
            _FXSortFoldersFirst = true;
            DisableAllAnimations = true;
          };

          "com.apple.spaces" = {
            "spans-displays" = false;
          };

          "com.apple.dock" = {
            expose-animation-duration = 0.0;
            missioncontrol-animation-duration = 0.0;
            workspaces-swoosh-animation-off = true;
            workspaces-edge-delay = 0.0;
            workspace-auto-swoosh = false;
            springboard-show-duration = 0.0;
            springboard-hide-duration = 0.0;
            springboard-page-duration = 0.0;
          };

          "com.apple.Accessibility" = {
            ReduceMotionEnabled = 1;
            DifferentiateWithoutColor = 1;
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
        "steermouse"
      ];
    };
  };
}
