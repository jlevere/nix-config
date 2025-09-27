{ pkgs, ... }:

{
  programs.neovim = {
    extraConfig = ''
      let mapleader = " "
      nnoremap <leader>f <cmd>Telescope find_files<cr>
    '';
  };
}
