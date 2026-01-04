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
        # Set desktop environment for proper portal registration
        "XDG_CURRENT_DESKTOP=Hyprland"
        # Suppress portal registration warnings - agent works without it
        "QT_LOGGING_RULES=*.debug=false;qt.qpa.*.warning=false"
      ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
