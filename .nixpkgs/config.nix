{ pkgs }: {

  allowBroken = true;
  allowUnfree = true;

  packageOverrides = super: let self = super.pkgs; in
    let inherit (self)   stdenv callPackage fetchFromGitHub;
        inherit (stdenv) lib;
        inherit (lib)    overrideDerivation concatMapStringsSep;
    in rec {

      exposePkgs = names: ghcPackages: ghcPackages.overrideDerivation (drv: {
        postBuild = ''
        ${drv.postBuild}
        ${concatMapStringsSep "\n" (name: "$out/bin/ghc-pkg expose ${name}") names}
        '';
      });

      haskellNGPackage s= with self.haskell-ng.lib; self.haskell-ng.packages.ghc7101.override {
        overrides = self: super: {
          ghc-mod = overrideCabal super.ghc-mod (drv: {
            broken = false;
            src = pkgs.fetchFromGitHub {
              owner  = "kazu-yamamoto";
              repo   = "ghc-mod";
              rev    = "f023d939e2edfc7e6874be76b5ad8f5de51e4124";
              sha256 = "022ivz85xrbsxf3bls5cr8421a1va57fdcl7cgzskrkf3qgc5ji5";
            };
            buildDepends = drv.buildDepends ++ [ self.cabal-helper self.cereal ];
            postInstall = "";
          });
        };
      };

      haskellEnv = haskellNGPackages.ghcWithPackages (self: [
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
