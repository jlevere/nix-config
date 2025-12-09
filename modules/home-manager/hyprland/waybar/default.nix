{ pkgs, config, ... }:

{
  imports = [
    ./settings.nix
    ./style.nix
  ];

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      # Tie Waybar to the Hyprland session target so it starts once per session.
      target = "hyprland-session.target";
    };
  };

  # Install weather script
  home.file.".config/waybar/weather.sh" = {
    source = ./weather.sh;
    executable = true;
  };

  # Install Tailscale status script
  home.file.".config/waybar/tailscale-status.sh" = {
    source = ./tailscale-status.sh;
    executable = true;
  };
}
