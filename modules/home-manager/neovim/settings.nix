{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    extraConfig = ''
      set number
      set relativenumber
      set termguicolors
      colorscheme gruvbox
    '';
  };
}


