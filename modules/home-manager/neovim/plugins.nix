{ pkgs, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
      vim-nix
      telescope-nvim
      nvim-treesitter
      lualine-nvim
      gruvbox
    ];
  };
}


