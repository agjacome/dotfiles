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

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ { nixpkgs, home-manager, darwin, ... }:
    let
      inherit (builtins) attrValues;
      inherit (darwin.lib) darwinSystem;
      inherit (home-manager.lib) homeManagerConfiguration;

      homes = let ms = import ./home/modules; in attrValues ms;
      systems = let ms = import ./system/modules; in attrValues ms;

      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

    in
    rec {
      formatter = forAllSystems (system:
        nixpkgs.legacyPackages.${system}.nixpkgs-fmt
      );

      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in import ./pkgs { inherit pkgs; }
      );

      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in import ./shell.nix { inherit pkgs; }
      );

      overlays = {
        additions = final: _: import ./pkgs { pkgs = final; };
        stable = final: _: {
          stablepkgs = import inputs.stable {
            system = final.system;
          };
        };
        nix-gl = inputs.nix-gl.overlay;
      };

      darwinConfigurations = {
        "frontify" = darwinSystem {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          system = "aarch64-darwin";
          modules = systems ++ [
            ./system/profiles/frontify.nix
          ];
        };
      };

      homeConfigurations = {
        "agjacome@Caronte" = homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs overlays; };
          modules = homes ++ [
            ./home/profiles/caronte.nix
          ];
        };
        "albertojacome@frontify" = homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs overlays; };
          modules = homes ++ [
            ./home/profiles/frontify.nix
          ];
        };
      };
    };
}
