{ pkgs, ... }:

{
  # Install system-wide fonts; defaults are set in Home Manager
  fonts.packages = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-color-emoji
    gyre-fonts
    nerd-fonts.caskaydia-cove
    doulos-sil
  ];
}
