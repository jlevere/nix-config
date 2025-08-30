{ ... }:

{
  services = {
    xserver.enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true; # GNOME Wayland session; Hyprland provided separately
    };
    desktopManager.gnome.enable = true;
  };
}
