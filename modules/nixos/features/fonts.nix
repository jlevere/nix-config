{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    corefonts

    nerd-fonts.caskaydia-cove
  ];
}