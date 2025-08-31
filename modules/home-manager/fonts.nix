{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  fonts.fontconfig.defaultFonts = {
    sansSerif = [ "Noto Sans" ];
    monospace = [ "CaskaydiaCove Nerd Font" ];
    serif = [ "Noto Serif" ];
  };
}
