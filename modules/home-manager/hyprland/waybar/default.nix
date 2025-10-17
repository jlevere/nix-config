{ pkgs, config, ... }:

{
  imports = [
    ./settings.nix
    ./style.nix
  ];

  programs.waybar.enable = true;

  # Install weather script
  home.file.".config/waybar/weather.sh" = {
    source = ./weather.sh;
    executable = true;
  };
}
