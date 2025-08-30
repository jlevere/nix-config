{ lib, ... }:

{
  mySystem = {
    dconf.enable = lib.mkDefault true;
    pipewire.enable = lib.mkDefault true;
    fonts.enable = lib.mkDefault true;
    xdg-utils.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
  };
}


