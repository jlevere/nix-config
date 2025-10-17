{ ... }:

{
  programs.waybar.style = ''
    /* Catppuccin Mocha - Minimal Technical Theme */
    @define-color base   #1e1e2e;
    @define-color surface0 #313244;
    @define-color surface1 #45475a;
    @define-color surface2 #585b70;
    
    @define-color text     #cdd6f4;
    @define-color subtext0 #a6adc8;
    @define-color overlay0 #6c7086;
    
    @define-color blue      #89b4fa;
    @define-color sapphire  #74c7ec;
    @define-color sky       #89dceb;
    @define-color teal      #94e2d5;
    @define-color green     #a6e3a1;
    @define-color peach     #fab387;
    @define-color red       #f38ba8;
    @define-color mauve     #cba6f7;
    @define-color pink      #f5c2e7;

    * {
      font-family: "CaskaydiaCove Nerd Font", monospace;
      font-size: 14px;
      font-weight: 500;
      border: none;
      border-radius: 0;
      min-height: 0;
      padding: 0;
      margin: 0;
    }

    window#waybar {
      background-color: alpha(@base, 0.75);
      border-bottom: 1px solid alpha(@surface2, 0.3);
      color: @text;
    }

    /* Left modules */
    #workspaces {
      margin: 0;
      padding: 0 6px;
    }

    #workspaces button {
      padding: 0 7px;
      margin: 0 1px;
      color: @overlay0;
      background: transparent;
      border-bottom: 1px solid transparent;
      transition: all 0.15s cubic-bezier(0.4, 0, 0.2, 1);
      font-size: 16px;
    }

    #workspaces button:hover {
      color: @subtext0;
      background: alpha(@surface0, 0.5);
    }

    #workspaces button.empty {
      color: alpha(@overlay0, 0.5);
    }

    #workspaces button.active {
      color: @mauve;
      border-bottom: 1px solid @mauve;
    }

    #workspaces button.special {
      color: @pink;
      border-bottom: 1px solid @pink;
    }

    #workspaces button.urgent {
      color: @red;
      border-bottom: 1px solid @red;
    }

    #window {
      margin: 0 12px;
      padding: 0 8px;
      color: @subtext0;
      font-weight: 400;
      border-left: 1px solid alpha(@surface2, 0.2);
    }

    #window.empty {
      border: none;
      margin: 0;
      padding: 0;
    }

    /* Center */
    #clock {
      padding: 0 20px;
      color: @text;
      font-weight: 600;
      letter-spacing: 0.5px;
      border-left: 1px solid alpha(@surface2, 0.2);
      border-right: 1px solid alpha(@surface2, 0.2);
    }

    /* Right modules */
    #custom-weather,
    #cpu,
    #memory,
    #disk,
    #network,
    #wireplumber,
    #custom-notifications {
      padding: 0 10px;
      margin: 0 1px;
    }

    #custom-weather {
      color: @sky;
      border-right: 1px solid alpha(@surface2, 0.2);
    }

    #cpu {
      color: @blue;
    }

    #memory {
      color: @sapphire;
    }

    #disk {
      color: @teal;
      padding-right: 12px;
      border-right: 1px solid alpha(@surface2, 0.2);
    }

    #network {
      color: @green;
      padding-left: 12px;
    }

    #network.disconnected {
      color: @overlay0;
    }

    #wireplumber {
      color: @mauve;
    }

    #wireplumber.muted {
      color: @overlay0;
    }

    #custom-notifications {
      color: @peach;
      padding-right: 12px;
      border-right: 1px solid alpha(@surface2, 0.2);
    }

    #tray {
      padding: 0 10px;
    }

    #tray > .passive {
      -gtk-icon-effect: dim;
    }

    #tray > .needs-attention {
      -gtk-icon-effect: highlight;
    }

    /* Tooltips */
    tooltip {
      background: alpha(@base, 0.95);
      border: 1px solid alpha(@surface2, 0.5);
      border-radius: 4px;
      padding: 8px 12px;
    }

    tooltip label {
      color: @text;
      font-size: 11px;
    }
  '';
}
