{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xdg-utils
  ];

  xdg.portal = {
    enable = true;
    # Let Hyprland's module provide its own portal; keep GTK for legacy apps
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
