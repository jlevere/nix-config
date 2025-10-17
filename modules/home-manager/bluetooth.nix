{ pkgs, ... }:
{
  # Blueman applet for GUI Bluetooth management
  home.packages = with pkgs; [
    blueman
  ];

  # Simple auto-start for blueman applet in Hyprland
  wayland.windowManager.hyprland.settings.exec-once = [
    "blueman-applet"
  ];
}
