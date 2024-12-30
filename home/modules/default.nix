{
  base = import ./base.nix;
  desktop = import ./desktop.nix;
  gtk = import ./gtk.nix;

  darwin = import ./darwin.nix;
}
