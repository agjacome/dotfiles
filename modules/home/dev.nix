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
      delta
      direnv
      fd
      fnm
      fzf
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
      ripgrep
      tldr
      tree-sitter
      vimv
    ];
  };
}
