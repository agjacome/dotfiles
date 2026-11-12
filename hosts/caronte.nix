{
  pkgs,
  nix-gl,
  overlays,
  ...
}:

{
  nixpkgs = {
    overlays = [
      overlays.additions
      overlays.stable
    ];
    config = {
      allowUnfree = true;
    };
  };

  homes.base.enable = true;
  homes.dev.enable = true;
  homes.desktop.enable = true;

  user.name = "agjacome";
  user.home = "/home/agjacome";

  targets.genericLinux.nixGL = {
    packages =
      let
        # Backport the upstream PCRE2 migration while retaining the NVIDIA fixes.
        src = pkgs.applyPatches {
          name = "nixgl-source";
          src = nix-gl;
          patches = [
            (pkgs.fetchpatch {
              url = "https://github.com/nix-community/nixGL/commit/320297bd99179701d63e3670e64e636d6165afe2.patch";
              hash = "sha256-WXuqzULt5sXe0LKgYYP7Vqbu87BHlKQfFthl/29/MlA=";
            })
          ];
        };
      in
      import src { inherit pkgs; };
    defaultWrapper = "nvidia";
  };
}
