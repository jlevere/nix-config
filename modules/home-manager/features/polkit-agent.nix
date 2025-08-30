{ pkgs, ... }:

{
  systemd.user.services.hyprpolkitagent = {
    Unit = {
      Description = "Hyprland Polkit Agent";
      After = [ "graphical-session.target" ];
    };
    Service = {
      # Only start when running a Hyprland session
      ExecCondition = "${pkgs.bash}/bin/bash -c 'test -n \"$HYPRLAND_INSTANCE_SIGNATURE\"'";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
