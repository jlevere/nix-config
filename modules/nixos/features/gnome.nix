{ pkgs, lib, ... }:

{
  services = {
    xserver.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Trim default apps; keep minimal GNOME shell bits
  environment.gnome.excludePackages = with pkgs; [
    gnome-console
    gnome-text-editor
    gnome-tour
    gnome-characters
    gnome-font-viewer
    gnome-contacts
    gnome-calculator
    gnome-maps
    gnome-weather
    gnome-clocks
    gnome-music
    gnome-disk-utility
    gnome-system-monitor
    gnome-logs
    gnome-software
    totem
    orca
    yelp
    xterm
  ];

  # Ensure portals exist for GNOME too
  xdg.portal.enable = true;
}


