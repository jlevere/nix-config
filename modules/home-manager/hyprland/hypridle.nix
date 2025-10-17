{ pkgs, ... }:

{
  # Hypridle: minimal config (only lock after timeout)
  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
      lock_cmd = "${pkgs.procps}/bin/pgrep -x hyprlock >/dev/null || ${pkgs.hyprlock}/bin/hyprlock"
    }

    listener {
      timeout = 300
      on-timeout = "${pkgs.systemd}/bin/loginctl lock-session"
    }
  '';

  # Autostart hypridle in Hyprland session
  systemd.user.services.hypridle = {
    Unit = {
      Description = "Hypridle daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecCondition = ''${pkgs.bash}/bin/bash -lc 'test -n "$HYPRLAND_INSTANCE_SIGNATURE"' '';
      ExecStart = "${pkgs.hypridle}/bin/hypridle";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
