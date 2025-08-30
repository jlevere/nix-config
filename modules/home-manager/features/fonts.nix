{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    gyre-fonts
    nerd-fonts.caskaydia-cove
    doulos-sil
  ];

  fonts.fontconfig.defaultFonts = {
    sansSerif = [ "Noto Sans" ];
    monospace = [ "CaskaydiaCove Nerd Font" ];
    serif = [ "Noto Serif" ];
  };
}


