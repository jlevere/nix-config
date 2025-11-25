{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprpolkitagent
  ];

  systemd.user.services."hyprpolkitagent" = {
    Unit = {
      Description = "HyprPolkitAgent";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecCondition = ''${pkgs.bash}/bin/bash -lc 'test -n "$HYPRLAND_INSTANCE_SIGNATURE"' '';
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
      RestartSec = 2;
      Environment = [
        "QT_QPA_PLATFORM=wayland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION=1"
      ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
