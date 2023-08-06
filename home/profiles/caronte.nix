{ pkgs, inputs, overlays, ... }:
{
  nixpkgs = {
    overlays = [
      overlays.additions
      overlays.nix-gl
    ];
    config = {
      allowBroken = false;
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      allowUnsupportedSystem = false;
    };
  };

  homes.base.enable = true;
  homes.desktop.enable = true;

  user.name = "agjacome";

  nixgl = pkgs.nixgl.auto.nixGLNvidia;
}
