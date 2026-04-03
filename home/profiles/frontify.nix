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
  homes.darwin.enable = true;

  user.name = "albertojacome";
  user.home = "/Users/albertojacome";
}
