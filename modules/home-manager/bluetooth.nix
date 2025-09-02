{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    blueman
    bluez
    bluez-tools
  ];

  systemd.user.services.blueman-applet = {
    Unit = {
      Description = "Blueman applet";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecCondition = ''${pkgs.bash}/bin/bash -lc 'test -n "$HYPRLAND_INSTANCE_SIGNATURE"' '';
      ExecStart = "${pkgs.blueman}/bin/blueman-applet";
      Restart = "on-failure";
      RestartSec = 1;
      Environment = [
        "XDG_CURRENT_DESKTOP=Hyprland"
        "XDG_SESSION_TYPE=wayland"
      ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
