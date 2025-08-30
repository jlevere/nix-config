{ pkgs, inputs, ... }:

{
  programs.hyprland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  programs.hyprland.xwayland.enable = true;

  # Allow hyprlock PAM module for session locking
  security.pam.services.hyprlock = { };
}
