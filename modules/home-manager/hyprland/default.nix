{ pkgs, ... }:

{
  imports = [
    ./keymap.nix
    ./waybar
    ./theme
  ];

  config = {
    home.packages = with pkgs; [
      pyprland
      hyprpicker
      hyprlock
      hypridle
      hyprcursor
      hyprpaper
      pavucontrol
      rofi-wayland
      playerctl
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      systemd.variables = [ "--all" ];

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

        gestures = {
          workspace_swipe = true;
        };

        env = [
          "NIXOS_OZONE_WL,1"
          "MOZ_ENABLE_WAYLAND,1"
          "XCURSOR_THEME,catppuccin-mocha-teal-cursors"
          "XCURSOR_SIZE,24"
        ];
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
