{ pkgs, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
      telescope-nvim
      nvim-treesitter
      lualine-nvim
      gruvbox
      vim-nix
    ];
  };
}
