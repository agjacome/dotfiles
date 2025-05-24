{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gl = {
      url = "github:nix-community/nixgl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      stable,
      home-manager,
      nix-gl,
      darwin,
      ...
    }:
    let
      inherit (builtins) attrValues;
      inherit (darwin.lib) darwinSystem;
      inherit (home-manager.lib) homeManagerConfiguration;

      homes = attrValues (import ./home/modules);
      systems = attrValues (import ./system/modules);

      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
    in
    rec {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        import ./shell.nix { inherit pkgs; }
      );

      overlays = {
        additions = final: _: import ./pkgs { pkgs = final; };
        stable = final: _: {
          stablepkgs = import stable { system = final.system; };
        };
      };

      darwinConfigurations = {
        "frontify" = darwinSystem {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          system = "aarch64-darwin";
          modules = systems ++ [ ./system/profiles/frontify.nix ];
        };
      };

      homeConfigurations = {
        "caronte" = homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs nix-gl overlays; };
          modules = homes ++ [ ./home/profiles/caronte.nix ];
        };
        "frontify" = homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs overlays; };
          modules = homes ++ [ ./home/profiles/frontify.nix ];
        };
      };
    };
}
