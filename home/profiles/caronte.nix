{ pkgs, inputs, ... }:
{
  homes.base.enable = true;
  homes.desktop.enable = true;

  user.name = "agjacome";

  nixgl = pkgs.nixgl.auto.nixGLNvidia;
}
