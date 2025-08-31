{ lib, pkgs, ... }:

{
  # Enable Ly display manager and default to the Hyprland session
  services.displayManager.ly = {
   enable = true;
   package = pkgs.ly;
   settings = {};
  };
}


