{
  pkgs,
  inputs,
  config,
  ...
}:

{
  # Hyprlock: simple lock screen using current wallpaper
  xdg.configFile."hypr/hyprlock.conf".text = ''
    # Catppuccin Mocha colors
    $base = rgba(24,24,37,1.0)
    $surface0 = rgba(49,50,68,1.0)
    $text = rgba(205,214,244,1.0)
    $textAlpha = rgba(205,214,244,0.8)
    $mauve = rgba(203,166,247,1.0)
    $mauveAlpha = rgba(203,166,247,0.8)
    $red = rgba(243,139,168,1.0)
    $yellow = rgba(250,179,135,1.0)
    $accent = $mauve
    $accentAlpha = $mauveAlpha
    $font = "CaskaydiaCove Nerd Font"

    # GENERAL
    general {
      hide_cursor = true
      immediate_render = true
      fail_timeout = 2000
    }

    # AUTH
    auth {
      pam:enabled = true
      pam:module = hyprlock
    }

    # BACKGROUND
    background {
      monitor = ""
      path = $HOME/.background
      blur_passes = 0
      color = $base
    }

    # LAYOUT
    label {
      monitor = ""
      text = Layout: $LAYOUT
      color = $text
      font_size = 25
      font_family = $font
      position = 30, -30
      halign = "left"
      valign = "top"
    }

    # TIME
    label {
      monitor = ""
      text = $TIME
      color = $text
      font_size = 90
      font_family = $font
      position = -30, 0
      halign = "right"
      valign = "top"
    }

    # DATE
    label {
      monitor = ""
      text = cmd[update:43200000] date +"%A, %d %B %Y"
      color = $text
      font_size = 25
      font_family = $font
      position = -30, -150
      halign = "right"
      valign = "top"
    }

    # USER AVATAR
    image {
      monitor = ""
      path = $HOME/.face
      size = 100
      border_color = $accent
      position = 0, 75
      halign = "center"
      valign = "center"
    }

    # INPUT FIELD
    input-field {
      monitor = ""
      size = 300, 60
      outline_thickness = 4
      dots_size = 0.2
      dots_spacing = 0.2
      dots_center = true
      outer_color = $accent
      inner_color = $surface0
      font_color = $text
      fade_on_empty = false
      placeholder_text = <span foreground="##$textAlpha"><i>󰌾 Logged in as </i><span foreground="##$accentAlpha">$USER</span></span>
      hide_input = false
      check_color = $accent
      fail_color = $red
      fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
      capslock_color = $yellow
      position = 0, -47
      halign = "center"
      valign = "center"
    }
  '';
}
