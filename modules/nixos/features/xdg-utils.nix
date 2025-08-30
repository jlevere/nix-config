{
  lib,
  pkgs,
  config,
  ...
}:

{
  xdg.portal = {
    enable = true;
    # Provide only GTK portal; let upstream Hyprland module add its own
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
