{ lib, pkgs, ... }:

{
  mySystem = {
    dconf.enable = lib.mkDefault true;
    pipewire.enable = lib.mkDefault true;
    fonts.enable = lib.mkDefault true;
    xdg-utils.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    ly.enable = lib.mkDefault true;
    upower.enable = lib.mkDefault true;
    bluetooth.enable = lib.mkDefault true;
    bolt.enable = lib.mkDefault true;
    sound.enable = lib.mkDefault true;
    rtkit.enable = lib.mkDefault true;
    keyboard.enable = lib.mkDefault true;
  };

  # Support color management and location portals needed by modern Wayland apps
  services.colord.enable = lib.mkDefault true;
  services.geoclue2.enable = lib.mkDefault true;

  # Backlight via DDC/CI for external monitors on Wayland systems
  hardware.i2c.enable = lib.mkDefault true;
  services.udev.packages = [ pkgs.ddcutil ];
  environment.systemPackages = [ pkgs.ddcutil ];

  # Docker setup and user access per https://wiki.nixos.org/wiki/Docker
  virtualisation.docker.enable = lib.mkDefault true;
}


