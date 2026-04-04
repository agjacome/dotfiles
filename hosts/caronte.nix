{
  pkgs,
  nix-gl,
  overlays,
  ...
}:

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
  homes.dev.enable = true;
  homes.desktop.enable = true;

  user.name = "agjacome";
  user.home = "/home/agjacome";

  targets.genericLinux.nixGL = {
    packages = import nix-gl { inherit pkgs; };
    defaultWrapper = "nvidia";
  };
}
