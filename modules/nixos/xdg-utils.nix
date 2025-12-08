{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    xdg-utils
  ];

  xdg.portal = {
    enable = true;
    # Prefer Hyprland portal, fall back to GTK for legacy apps
    extraPortals = [
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common.default = [ "hyprland" "gtk" ];
      hyprland.default = [ "hyprland" "gtk" ];
    };
  };
}
