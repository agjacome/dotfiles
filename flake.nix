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

  outputs = inputs @ { nixpkgs, home-manager, nix-gl, darwin, ... }:
    let
      inherit (builtins) attrValues;
      inherit (darwin.lib) darwinSystem;
      inherit (home-manager.lib) homeManagerConfiguration;

      homeModules = let ms = import ./home/modules; in attrValues ms;
      systemModules = let ms = import ./system/modules; in attrValues ms;

      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
    in
    rec {
      packages = forAllSystems (system:
        import nixpkgs {
          inherit system;

          overlays = [ nix-gl.overlay ];
          config = {
            allowBroken = false;
            allowUnfree = true;
            allowUnsupportedSystem = true;
          };
        }
      );

      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        import ./shell.nix { inherit pkgs; }
      );

      formatter = forAllSystems (system:
        nixpkgs.legacyPackages.${system}.nixpkgs-fmt
      );

      darwinConfigurations = {
        "frontify" = darwinSystem {
          pkgs = packages.aarch64-darwin;
          system = "aarch64-darwin";
          modules = systemModules ++ [
            ./system/profiles/frontify.nix
          ];
        };
      };

      homeConfigurations = {
        "agjacome@Caronte" = homeManagerConfiguration {
          pkgs = packages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = homeModules ++ [
            ./home/profiles/caronte.nix
          ];
        };
        "albertojacome@frontify" = homeManagerConfiguration {
          pkgs = packages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs; };
          modules = homeModules ++ [
            ./home/profiles/frontify.nix
          ];
        };
      };
    };
}
