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
      # editor
      neovim
      tree-sitter

      # language servers
      bash-language-server
      dockerfile-language-server
      lua-language-server
      marksman
      nixd
      taplo
      vscode-langservers-extracted
      yaml-language-server

      # git
      delta
      gh
      gh-markdown-preview
      git
      git-annex
      git-machete
      jujutsu
      mr

      # ai
      claude-code
      opencode
      pi-coding-agent

      # tools
      direnv
      fnm
      gnumake
      gron
      jq
      parallel
      sqlit-tui
      vimv
    ];
  };
}
