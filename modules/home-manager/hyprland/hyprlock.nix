{ ... }:

{
  # Hyprlock: simple lock screen using current wallpaper
  xdg.configFile."hypr/hyprlock.conf".text = ''
    general {
      hide_cursor = true
      grace = 2
      no_fade_on_vt_switch = true
    }

    background {
      monitor = ""
      path = "~/.wallpapers/wallpaper.png"
      blur_passes = 3
      blur_size = 8
    }

    input-field {
      monitor = ""
      size = 300, 50
      position = 0, 0
      halign = "center"
      valign = "center"
      rounding = 8
      inner_color = rgba(30,30,46,0.7)
      outer_color = rgba(69,71,90,0.7)
      font_color = rgb(205,214,244)
      outline_thickness = 2
      fail_color = rgb(243,139,168)
      placeholder_text = "Password"
      dots_center = true
    }
  '';
}
