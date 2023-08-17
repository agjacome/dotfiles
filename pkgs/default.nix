{ pkgs }:
{
  tbsm = pkgs.callPackage ./tbsm { };
  spmd = pkgs.callPackage ./spmd { };
}
