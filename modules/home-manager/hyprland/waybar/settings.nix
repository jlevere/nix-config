_:

{
  programs.waybar.settings = {
    "top_bar" = {
      layer = "top";
      position = "top";
      height = 34;
      spacing = 0;
      
      "modules-left" = [
        "hyprland/workspaces"
        "hyprland/window"
      ];
      
      "modules-center" = [
        "clock"
      ];
      
      "modules-right" = [
        "custom/weather"
        "cpu"
        "memory"
        "disk"
        "tray"
        "custom/notifications"
        "network"
        "wireplumber"
      ];

      "hyprland/workspaces" = {
        format = "{icon} {windows}";
        "format-window-separator" = " ";
        "window-rewrite-default" = "";
        "window-rewrite" = {
          # Browser
          "class<firefox>" = "󰈹";
          "class<Firefox>" = "󰈹";
          
          # Development
          "class<cursor>" = "󰨞";
          "class<Cursor>" = "󰨞";
          "class<ghidra>" = "󱘎";
          
          # Terminal
          "class<org.wezfurlong.wezterm>" = "󰆍";
          "class<zellij>" = "󰆍";
          
          # Communication
          "class<vesktop>" = "󰙯";
          "class<Vesktop>" = "󰙯";
          "class<signal>" = "󰭹";
          "class<Signal>" = "󰭹";
          
          # Productivity
          "class<obsidian>" = "󱓷";
          "class<Obsidian>" = "󱓷";
          
          # System Tools
          "class<pavucontrol>" = "󰕾";
          "class<rofi>" = "󰕘";
          "class<Rofi>" = "󰕘";
          "class<remmina>" = "󰢹";
          "class<org.remmina.Remmina>" = "󰢹";
        };
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
          "special" = "";
        };
        "on-scroll-up" = "hyprctl dispatch workspace e+1";
        "on-scroll-down" = "hyprctl dispatch workspace e-1";
        "show-special" = true;
        "all-outputs" = true;
        "persistent-workspaces" = {
          "*" = [ 1 2 3 4 5 6 7 8 9 10 ];
        };
      };

      "hyprland/window" = {
        format = "{}";
        "max-length" = 60;
        "separate-outputs" = true;
        rewrite = {
          "(.*) — Mozilla Firefox" = "󰈹 $1";
          "(.*) - Cursor" = "󰨞 $1";
          "(.*) - WezTerm" = "󰆍 $1";
        };
      };

      "clock" = {
        format = " {:%H:%M}";
        "format-alt" = " {:%A, %B %d, %Y}";
        "tooltip-format" = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "month";
          "mode-mon-col" = 3;
          "weeks-pos" = "right";
          "on-scroll" = 1;
          format = {
            months = "<span color='#f5e0dc'><b>{}</b></span>";
            days = "<span color='#cdd6f4'><b>{}</b></span>";
            weeks = "<span color='#cba6f7'><b>W{}</b></span>";
            weekdays = "<span color='#a6e3a1'><b>{}</b></span>";
            today = "<span color='#f38ba8'><b><u>{}</u></b></span>";
          };
        };
      };

      "custom/weather" = {
        format = "{}";
        interval = 600;
        exec = "~/.config/waybar/weather.sh";
        "return-type" = "json";
        "on-click" = "firefox 'https://wttr.in'";
      };

      "cpu" = {
        interval = 2;
        format = "󰻠 {usage}%";
        "on-click" = "flatpak run io.missioncenter.MissionCenter || wezterm start --class btm -- btm";
      };

      "memory" = {
        interval = 2;
        format = "󰍛 {percentage}%";
        "tooltip-format" = "RAM: {used:0.1f}G / {total:0.1f}G\nSwap: {swapUsed:0.1f}G / {swapTotal:0.1f}G";
        "on-click" = "flatpak run io.missioncenter.MissionCenter || wezterm start --class btm -- btm";
      };

      "disk" = {
        interval = 30;
        format = "󰋊 {percentage_used}%";
        path = "/";
        "tooltip-format" = "Used: {used} / {total}";
      };

      "network" = {
        interval = 2;
        "format-wifi" = "󰖨 {essid}";
        "format-ethernet" = "󰈀 {bandwidthDownBytes}";
        "format-linked" = "󰈀 {ifname}";
        "format-disconnected" = "󰖪";
        "tooltip-format" = "{ifname}: {ipaddr}/{cidr}\n󰕒 {bandwidthUpBytes} 󰇚 {bandwidthDownBytes}\n\nClick: copy IP | Right-click: settings";
        "on-click" = "bash -c 'ip addr show | grep \"inet \" | grep -v 127.0.0.1 | head -1 | awk \"{print \\$2}\" | cut -d/ -f1 | wl-copy && notify-send \"IP Copied\" \"$(wl-paste)\"'";
        "on-click-right" = "nm-connection-editor";
      };

      "wireplumber" = {
        format = "{icon} {volume}%";
        "format-muted" = "󰝟";
        "format-icons" = {
          default = [ "󰕿" "󰖀" "󰕾" ];
        };
        "on-click" = "pavucontrol";
        "on-click-right" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "on-scroll-up" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
        "on-scroll-down" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
        "tooltip-format" = "{node_name}\nVolume: {volume}%\n\nScroll: adjust volume\nRight-click: mute";
        "max-volume" = 150;
      };

      "custom/notifications" = {
        tooltip = false;
        format = "{icon}";
        "format-icons" = {
          notification = "󱅫";
          none = "󰂚";
          "dnd-notification" = "󰂛";
          "dnd-none" = "󰂛";
          "inhibited-notification" = "󰂠";
          "inhibited-none" = "󰂠";
          "dnd-inhibited-notification" = "󰂠";
          "dnd-inhibited-none" = "󰂠";
        };
        "return-type" = "json";
        "exec-if" = "which swaync-client";
        exec = "swaync-client -swb";
        "on-click" = "swaync-client -t -sw";
        "on-click-right" = "swaync-client -d -sw";
        escape = true;
      };

      "tray" = {
        "icon-size" = 16;
        spacing = 8;
      };
    };
  };
}
