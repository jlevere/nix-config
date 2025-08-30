{ lib, ... }:

{
  services = {
    xserver.enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = lib.mkDefault true;
    };
    # Default to not enabling full GNOME; provide separate feature
    desktopManager.gnome.enable = lib.mkDefault false;
  };
}
