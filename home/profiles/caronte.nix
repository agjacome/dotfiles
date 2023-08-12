{ pkgs, inputs, overlays, ... }:
{
  nixpkgs = {
    overlays = [
      overlays.additions
      overlays.nix-gl
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  homes.base.enable = true;
  homes.desktop.enable = true;

  user.name = "agjacome";

  nixgl = pkgs.nixgl.auto.nixGLNvidia;
}
