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
  homes.desktop.enable = true;
  homes.gtk.enable = true;

  user.name = "agjacome";
  user.home = "/home/agjacome";

  nixGL = {
    packages = import nix-gl { inherit pkgs; };
    defaultWrapper = "nvidia";
  };
}
