{ pkgs, ... }:

{
  imports = [
    ./plugins.nix
    ./settings.nix
    ./keymaps.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
  };
}
