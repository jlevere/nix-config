{ lib, pkgs, ... }:

{
  mySystem = {
    bootloader.enable = lib.mkDefault true;
    firmware.enable = lib.mkDefault true;
    polkit.enable = lib.mkDefault true;
    usb.enable = lib.mkDefault true;
    fish.enable = lib.mkDefault true;
    lmsensors.enable = lib.mkDefault true;
    openssh.enable = lib.mkDefault false;
    rtkit.enable = lib.mkDefault true;
  };

  time.timeZone = lib.mkDefault "America/Chicago";
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  environment.systemPackages = [ pkgs.home-manager ];

  # Network time and weekly SSD trim for stability
  services.timesyncd.enable = lib.mkDefault true;
  services.fstrim.enable = lib.mkDefault true;

  # Sensible firewall defaults; can be overridden per-host
  networking.firewall.enable = lib.mkDefault true;
}


