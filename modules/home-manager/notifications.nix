{ pkgs, ... }:

{
  home.packages = with pkgs; [
    libnotify
    swaynotificationcenter
  ];

  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      timeout = 5;
      timeout-critical = 0;
    };
  };
}