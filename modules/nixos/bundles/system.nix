{ lib, ... }:

{
  mySystem = {
    bootloader.enable = lib.mkDefault true;
    firmware.enable = lib.mkDefault true;
    dconf.enable = lib.mkDefault true;
    pipewire.enable = lib.mkDefault true;
    polkit.enable = lib.mkDefault true;
    fonts.enable = lib.mkDefault true;
    xdg-utils.enable = lib.mkDefault true;
    usb.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    fish.enable = lib.mkDefault true;
    lmsensors.enable = lib.mkDefault true;
    openssh.enable = lib.mkDefault false;
  };

  time.timeZone = lib.mkDefault "America/Chicago";
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
}