{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stable.url = "github:NixOS/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    rec {
      lib = import ./lib { inherit inputs; };
      homes = import ./home/modules;

      formatter = forAllSystems (system:
        legacyPackages.${system}.nixpkgs-fmt
      );

      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.callPackage ./shell.nix { };
      });

      legacyPackages = forAllSystems (system:
        import nixpkgs {
          inherit system;
          overlays = [ ];
          config.allowUnfree = true;
          config.allowBroken = false;
        }
      );

      packages = forAllSystems (system:
        lib.filterSupported system (
          import ./pkgs {
            pkgs = import nixpkgs {
              inherit system;
              overlays = [ ];
              config.allowUnfree = true;
              config.allowBroken = false;
            };
          }
        )
      );

      homeConfigurations = {
        agjacome = lib.makeHomeConfig {
          pkgs = legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = (builtins.attrValues homes) ++ [
            ./home/profiles/home.nix
          ];
        };
      };

      checks = forAllSystems (system:
        let
          inherit (nixpkgs.lib.attrsets) filterAttrs mapAttrs;
          checkPackages = packages.${system};
          checkHomes = mapAttrs (name: user: user.activationPackage)
            (filterAttrs (name: user: user.pkgs.system == system) homeConfigurations);
        in
        checkPackages // checkHomes
      );
    };
}
