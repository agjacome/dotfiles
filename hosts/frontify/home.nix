{ overlays, ... }:
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
  homes.darwin.enable = true;

  user.name = "alberto.jacome";
  user.home = "/Users/alberto.jacome";
}
