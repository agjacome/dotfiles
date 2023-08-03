{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gl = {
      url = "github:guibou/nixgl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # darwin = {
    #   url = "github:lnl7/nix-darwin";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, nix-gl, ... }:
    let
      inherit (builtins) attrValues;
      # inherit (darwin.lib) darwinSystem;
      inherit (home-manager.lib) homeManagerConfiguration;
      inherit (nixpkgs.lib) filterAttrs genAttrs platforms;
      inherit (nixpkgs.lib.lists) elem;

      homeModules = import ./home/modules;

      supportedSystems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = genAttrs supportedSystems;

      filterSupported = system: pkgs:
        let
          isUnsupportedSystem = attrs: (
            !elem system (attrs.meta.platforms or platforms.all) ||
            elem system (attrs.meta.badPlatforms or [ ])
          );
        in
        filterAttrs (name: value: !isUnsupportedSystem value) pkgs;
    in
    rec {
      formatter = forAllSystems (system:
        legacyPackages.${system}.nixpkgs-fmt
      );

      devShells = forAllSystems (system: {
        default = legacyPackages.${system}.callPackage ./shell.nix { };
      });

      legacyPackages = forAllSystems (system:
        import nixpkgs {
          inherit system;
          overlays = [ nix-gl.overlay ];
          config.allowUnfree = true;
          config.allowBroken = false;
        }
      );

      packages = forAllSystems (system:
        filterSupported system (
          import ./pkgs {
            pkgs = import nixpkgs {
              inherit system;
              overlays = [ nix-gl.overlay ];
              config.allowUnfree = true;
              config.allowBroken = false;
            };
          }
        )
      );

      # darwinConfigurations = {
      #   "frontify" = darwin.lib.darwinSystem {
      #       system = "aarch64-darwin";
      #       pkgs = legacyPackages.aarch64-darwin;
      #       modules = (attrValues.homeModules) ++ [
      #       ];
      #   };
      # };

      homeConfigurations = {
        "agjacome@Caronte" = homeManagerConfiguration {
          check = true;
          pkgs = legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = (attrValues homeModules) ++ [
            ./home/profiles/caronte.nix
          ];
        };
        "albertojacome@frontify" = homeManagerConfiguration {
          check = true;
          pkgs = legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs; };
          modules = (attrValues homeModules) ++ [
            ./home/profiles/frontify.nix
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
