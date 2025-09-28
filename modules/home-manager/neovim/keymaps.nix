{ ... }:

{
  programs.neovim = {
    extraConfig = ''
      nnoremap <leader>f <cmd>Telescope find_files<cr>
    '';
  };
}


