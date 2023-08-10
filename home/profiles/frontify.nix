{ ... }:
{
  nixpkgs = {
    config = {
      allowBroken = false;
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      allowUnsupportedSystem = false;
    };
  };

  homes.base.enable = true;
  homes.darwin.enable = true;
  homes.frontify.enable = true;

  user.name = "albertojacome";
  user.home = "/Users/albertojacome";
}
