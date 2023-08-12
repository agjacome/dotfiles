{ ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  homes.base.enable = true;
  homes.darwin.enable = true;
  homes.frontify.enable = true;

  user.name = "albertojacome";
  user.home = "/Users/albertojacome";
}
