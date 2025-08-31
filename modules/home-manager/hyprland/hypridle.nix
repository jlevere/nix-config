{ pkgs, ... }:

{
  # Hypridle: idle manager (desktop-friendly; lock, then DPMS off)
  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
      lock_cmd = "pidof hyprlock || hyprlock"
      before_sleep_cmd = "loginctl lock-session"
      after_sleep_cmd = "hyprctl dispatch dpms on"
      inhibit_sleep = 3
      ignore_dbus_inhibit = false
    }

    # Lock after 5 minutes
    listener {
      timeout = 300
      on-timeout = "loginctl lock-session"
      on-resume = "hyprctl dispatch dpms on"
    }

    # Turn displays off after 7 minutes
    listener {
      timeout = 420
      on-timeout = "hyprctl dispatch dpms off"
      on-resume = "hyprctl dispatch dpms on"
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
