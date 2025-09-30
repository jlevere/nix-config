{ pkgs, ... }:

{
  imports = [
    ./keymap.nix
    ./waybar
    ./theme
    ./screenshot.nix
  ];

  config = {
    home.packages = with pkgs; [
      hyprlock
      hypridle
      hyprpaper
      pavucontrol
      rofi
      playerctl
      helvum
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      systemd.variables = [ "--all" ];

      plugins = [ ];

      settings = {
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = "rgba(94e2d5ee) rgba(94e2d5ee) 45deg";
        };

        debug = {
          disable_logs = false;
        };

        input = {
          kb_layout = "us";
          kb_options = "caps:ctrl_modifier";
        };

        cursor = {
          no_hardware_cursors = true;
        };

        exec-once = [ ];

        monitor = [
          ", preferred, auto, 1"
        ];

        decoration = {
          rounding = 8;
        };

        env = [
          "NIXOS_OZONE_WL,1"
          "MOZ_ENABLE_WAYLAND,1"
        ];
      };
    };

    # Autostart Waybar under Hyprland session
    systemd.user.services.waybar = {
      Unit = {
        Description = "Waybar";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecCondition = ''${pkgs.bash}/bin/bash -lc 'test -n "$HYPRLAND_INSTANCE_SIGNATURE"' '';
        ExecStart = "${pkgs.waybar}/bin/waybar";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    systemd.user.services.hyprpaper = {
      Unit = {
        Description = "Hyprpaper Wallpaper Daemon";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecCondition = ''${pkgs.bash}/bin/bash -lc 'test -n "$HYPRLAND_INSTANCE_SIGNATURE"' '';
        ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
