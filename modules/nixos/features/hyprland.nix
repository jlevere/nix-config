{ pkgs, ... }:

{
  programs.hyprland.enable = true;
  # Use packaged hyprland from nixpkgs for stability
  programs.hyprland.package = pkgs.hyprland;
  programs.hyprland.xwayland.enable = true;

  # Prefer logind backend for libseat to avoid seatd requirements
  environment.variables.LIBSEAT_BACKEND = "logind";

  # Allow hyprlock PAM module for session locking
  security.pam.services.hyprlock = { };
}
