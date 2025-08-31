_:

{
  programs.waybar.settings = {
    "top_bar" = {
      layer = "top";
      position = "top";
      height = 36;
      spacing = 4;
      "modules-left" = [
        "hyprland/workspaces"
        "hyprland/submap"
      ];
      "modules-center" = [
        "clock#time"
        "custom/separator"
        "clock#week"
        "custom/separator_dot"
        "clock#month"
        "custom/separator"
        "clock#calendar"
      ];
      "modules-right" = [
        "tray"
        "network"
        "pulseaudio"
      ];

      "hyprland/workspaces" = {
        "on-click" = "activate";
        format = "{icon}";
        "format-icons" = {
          "1" = "󰲠";
          "2" = "󰲢";
          "3" = "󰲤";
          "4" = "󰲦";
          "5" = "󰲨";
          "6" = "󰲪";
          "7" = "󰲬";
          "8" = "󰲮";
          "9" = "󰲰";
          "10" = "󰿬";
          "special" = "";
        };
        "show-special" = true;
        "all-outputs" = true;
        "persistent-workspaces" = {
          "*" = [
            1
            2
            3
            4
            5
            6
            7
            8
            9
            10
          ];
        };
      };

      "tray" = {
        icon-size = 16;
        spacing = 8;
      };

      "network" = {
        format = "{ifname}";
        format-wifi = "  {essid}";
        format-ethernet = " {ifname}";
        format-disconnected = "󰌙";
        tooltip = true;
      };

      "pulseaudio" = {
        format = "  {volume}%";
        format-muted = "  {volume}%";
        on-click = "pavucontrol";
        tooltip = true;
      };

      "hyprland/submap" = {
        format = "<span color='#a6e3a1'>Mode:</span> {}";
        tooltip = false;
      };

      "clock#time" = {
        format = "{:%H:%M}";
      };

      "custom/separator" = {
        format = "|";
        tooltip = false;
      };

      "custom/separator_dot" = {
        format = "•";
        tooltip = false;
      };

      "clock#week" = {
        format = "{:%a}";
      };

      "clock#month" = {
        format = "{:%h}";
      };

      "clock#calendar" = {
        format = "{:%F}";
        "tooltip-format" = "<tt><small>{calendar}</small></tt>";
        actions = {
          "on-click-right" = "mode";
        };
        calendar = {
          mode = "month";
          "mode-mon-col" = 3;
          "weeks-pos" = "right";
          "on-scroll" = 1;
          "on-click-right" = "mode";
          format = {
            months = "<span color='#f5e0dc'><b>{}</b></span>";
            days = "<span color='#cdd6f4'><b>{}</b></span>";
            weeks = "<span color='#cba6f7'><b>W{}</b></span>";
            weekdays = "<span color='#a6e3a1'><b>{}</b></span>";
            today = "<span color='#94e2d5'><b><u>{}</u></b></span>";
          };
        };
      };

      "clock" = {
        format = "{:%H:%M | %a • %h | %F}";
        "format-alt" = "{:%I:%M %p}";
        "tooltip-format" = "<tt><small>{calendar}</small></tt>";
        actions = {
          "on-click-right" = "mode";
        };
        calendar = {
          mode = "month";
          "mode-mon-col" = 3;
          "weeks-pos" = "right";
          "on-scroll" = 1;
          "on-click-right" = "mode";
          format = {
            months = "<span color='#f5e0dc'><b>{}</b></span>";
            days = "<span color='#cdd6f4'><b>{}</b></span>";
            weeks = "<span color='#cba6f7'><b>W{}</b></span>";
            weekdays = "<span color='#a6e3a1'><b>{}</b></span>";
            today = "<span color='#94e2d5'><b><u>{}</u></b></span>";
          };
        };
      };
    };
  };
}
