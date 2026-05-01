{
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nixpkgs-unfree.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    stable.url = "github:nixos/nixpkgs/release-25.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gl = {
      # url = "github:nix-community/nixgl";
      url = "github:KeeTraxx/nixgl/fix-nvidia-kernel-param"; # https://github.com/nix-community/nixGL/pull/221
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
      inherit (darwin.lib) darwinSystem;
      inherit (home-manager.lib) homeManagerConfiguration;

      homeModules = import ./modules/home;
      darwinModules = import ./modules/darwin;

    in
    rec {
      formatter = {
        x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
        aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt;
      };

      overlays = {
        additions = final: _: {
          tbsm = final.callPackage ./pkgs/tbsm { };
          spmd = final.callPackage ./pkgs/spmd { };
        };
        stable = final: _: {
          stablepkgs = import stable {
            system = final.system;
            config = final.config;
          };
        };
      };

      darwinConfigurations = {
        "frontify" = darwinSystem {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          system = "aarch64-darwin";
          modules = darwinModules ++ [ ./hosts/frontify/system.nix ];
        };
      };

      homeConfigurations = {
        "caronte" = homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs nix-gl overlays; };
          modules = homeModules ++ [ ./hosts/caronte.nix ];
        };
        "frontify" = homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs overlays; };
          modules = homeModules ++ [ ./hosts/frontify/home.nix ];
        };
      };
    };
}
