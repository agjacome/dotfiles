{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = {
    homes.dev.enable = lib.mkEnableOption "dev home";
  };

  config = lib.mkIf config.homes.dev.enable {
    home.packages = with pkgs; [
      claude-code
      delta
      opencode
      direnv
      fnm
      gh
      gh-markdown-preview
      git
      git-annex
      git-machete
      gnumake
      gron
      jq
      lua-language-server
      mr
      neovim
      parallel
      tree-sitter
      vimv
    ];
  };
}
