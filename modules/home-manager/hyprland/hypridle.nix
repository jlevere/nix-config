{ pkgs, ... }:

{
  # Hypridle: idle manager (desktop-friendly; lock, then DPMS off)
  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
      lock_cmd = "${pkgs.procps}/bin/pgrep -x hyprlock >/dev/null || ${pkgs.hyprlock}/bin/hyprlock"
      before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session"
      after_sleep_cmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on"
      inhibit_sleep = 3
      ignore_dbus_inhibit = false
    }

    # Lock after 5 minutes
    listener {
      timeout = 300
      on-timeout = "${pkgs.systemd}/bin/loginctl lock-session"
      on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on"
    }

    # Turn displays off after 7 minutes
    listener {
      timeout = 420
      on-timeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off"
      on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on"
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
