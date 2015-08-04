{
  packageOverrides = pkgs : rec {

    haskellEnv = pkgs.haskellngPackages.ghcWithPackages (self : [
      self.cabal2nix
      self.cabal-install
      self.hoogle
      self.pandoc
      self.mtl
      self.text
      self.QuickCheck
    ]);

  };
}
