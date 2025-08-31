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
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}