{
  pkgs,
  inputs,
  config,
  ...
}:

{
  # Hyprlock configuration with visible elements
  xdg.configFile."hypr/hyprlock.conf".text = ''
    general {
      hide_cursor = true
    }

    # Background - blurred screenshot with fallback color
    background {
      monitor =
      color = rgb(30, 30, 46)
      path = screenshot
      blur_passes = 3
      blur_size = 7
    }

    # Input field for password
    input-field {
      monitor =
      size = 300, 60
      outline_thickness = 2
      dots_size = 0.2
      dots_spacing = 0.2
      dots_center = true
      outer_color = rgba(0, 0, 0, 0)
      inner_color = rgba(0, 0, 0, 0.5)
      font_color = rgb(200, 200, 200)
      fade_on_empty = false
      placeholder_text = <span foreground="##cdd6f4">Password...</span>
      hide_input = false
      position = 0, -120
      halign = center
      valign = center
    }

    # Time label
    label {
      monitor =
      text = cmd[update:1000] echo "$(date +"%H:%M")"
      color = rgba(200, 200, 200, 1.0)
      font_size = 90
      font_family = Noto Sans
      position = 0, -300
      halign = center
      valign = top
    }

    # User label
    label {
      monitor =
      text = Hi $USER
      color = rgba(200, 200, 200, 1.0)
      font_size = 25
      font_family = Noto Sans
      position = 0, -40
      halign = center
      valign = center
    }
  '';
}
