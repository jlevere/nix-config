{ pkgs, ... }:

{
  programs.neovim = {
    extraConfig = ''
      set number
      set relativenumber
      set termguicolors
      colorscheme gruvbox
    '';
  };
}
