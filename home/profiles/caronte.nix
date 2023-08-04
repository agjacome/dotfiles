{ pkgs, inputs, ... }:
{
  modules.base.enable = true;
  modules.desktop.enable = true;

  user.name = "agjacome";

  nixgl = pkgs.nixgl.auto.nixGLNvidia;
}
