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
      fuzzel
      playerctl
      helvum
      wl-clipboard
      xclip
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
          no_hardware_cursors = false;
        };

        exec-once = [ ];

        monitor = [
          "HDMI-A-3, preferred, 0x0, 1.5, transform, 3"
          "DP-4, 3440x1440@144, 1440x240, 1"
        ];

        workspace = [
          "1, monitor:DP-4, persistent:true, default:true"
          "2, monitor:DP-4, persistent:true"
          "3, monitor:HDMI-A-3, persistent:true, default:true"
          "4, monitor:HDMI-A-3, persistent:true"
          "5, monitor:DP-4, persistent:true"
          "6, monitor:DP-4, persistent:true"
          "7, monitor:HDMI-A-3, persistent:true"
          "8, monitor:HDMI-A-3, persistent:true"
          "9, monitor:DP-4, persistent:true"
          "10, monitor:DP-4, persistent:true"
        ];

        decoration = {
          rounding = 8;
        };

        env = [
          "NIXOS_OZONE_WL,1"
          "MOZ_ENABLE_WAYLAND,1"
          "WGPU_BACKEND,gl"
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
