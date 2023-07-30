{ inputs, ... }:

let
  inherit (inputs.nixpkgs.lib) filterAttrs platforms;
  inherit (inputs.nixpkgs.lib.lists) elem;
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in {
    makeHomeConfig = {
        modules ? []
      , pkgs
      , system ? pkgs.system
      , username ? "agjacome"
      , homeDirectory ? "/home/${username}"
      , stateVersion ? 23.05
      , lib ? pkgs.lib
      , extraSpecialArgs ? {}
      , check ? true
    }:
      { inherit modules; } // homeManagerConfiguration {
        inherit modules pkgs lib extraSpecialArgs check;
      };

    filterSupported = system: pkgs:
      let
        isUnsupportedSystem = attrs: (
          !elem system (attrs.meta.platforms or platforms.all) ||
          elem system (attrs.meta.badPlatforms or [])
        );
      in
        filterAttrs (name: value: !isUnsupportedSystem value) pkgs;
}
