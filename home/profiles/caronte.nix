{ pkgs, nix-gl, overlays, ... }:

{
  nixpkgs = {
    overlays = [
      overlays.additions
      overlays.stable
    ];
    config = {
      allowUnfree = true;
    };
  };

  homes.base.enable = true;
  homes.desktop.enable = true;

  user.name = "agjacome";

  nixGL = {
    packages = import nix-gl { inherit pkgs; };
    defaultWrapper = "nvidia";
  };
}
