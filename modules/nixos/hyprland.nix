{ pkgs, inputs,... }:

{
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = false;
  programs.hyprland.package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  programs.hyprland.portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

  services = {
    displayManager.defaultSession = "hyprland";
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "breeze";
    };
  };

  services.xserver.enable = true;
}
