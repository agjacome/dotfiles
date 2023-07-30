{ pkgs ? let
    lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
    system = builtins.currentSystem;
    overlays = [];
  in
  import nixpkgs { inherit system overlays; }
, ...
}: pkgs.mkShell {
  NIX_CONFIG = "experimental-features = nix-command flakes repl-flake";
  nativeBuildInputs = [ pkgs.nix pkgs.home-manager pkgs.git ];
}
