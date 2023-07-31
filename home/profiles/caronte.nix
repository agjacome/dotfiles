{ lib, pkgs, ... }:
{
  modules.base.enable = true;
  modules.gui.enable = true;

  user.name = "agjacome";

  nixgl = pkgs.nixgl.auto.nixGLNvidia;
}
