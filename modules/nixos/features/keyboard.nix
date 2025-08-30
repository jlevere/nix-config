{ ... }:

{
  # System-wide keyboard layout and options; applied to GNOME/Wayland and TTY
  services.xserver.xkb = {
    layout = "us";
    options = "caps:ctrl_modifier";
  };

  # Apply XKB settings to virtual consoles as well
  console.useXkbConfig = true;
}


