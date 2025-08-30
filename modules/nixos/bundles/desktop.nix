{ lib, ... }:

{
  mySystem = {
    dconf.enable = lib.mkDefault true;
    pipewire.enable = lib.mkDefault true;
    fonts.enable = lib.mkDefault true;
    xdg-utils.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    upower.enable = lib.mkDefault true;
    bluetooth.enable = lib.mkDefault true;
    bolt.enable = lib.mkDefault true;
    sound.enable = lib.mkDefault true;
    rtkit.enable = lib.mkDefault true;
  };
}


