{ pkgs }: {

  allowBroken = true;
  allowUnfree = true;

  packageOverrides = super: let self = super.pkgs; in
  {

    haskellEnv = super.haskellngPackages.ghcWithPackages (self: [
      self.cabal2nix
      self.cabal-install
      self.ghc-mod
      self.hoogle
      self.hlint
      self.pandoc
      self.mtl
      self.text
      self.QuickCheck
    ]);

  };

}
