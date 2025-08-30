{ pkgs, lib, ... }:

{
  services.swaync = {
    enable = true;
  };

  # Only start under a Hyprland session
  systemd.user.services.swaync = {
    Service = {
      ExecCondition = ''${pkgs.bash}/bin/bash -lc 'test -n "$HYPRLAND_INSTANCE_SIGNATURE"' '';
    };
  };
  home.packages = [ pkgs.libnotify ];
}
