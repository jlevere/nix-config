{
  lib,
  pkgs,
  config,
  ...
}:

{
  xdg.portal = {
    enable = true;
    # Hyprland module typically wires in the hyprland portal; keep only GTK
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
