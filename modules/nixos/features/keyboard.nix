{ ... }:

{
  # System-wide keyboard layout and options; applied to Wayland and TTY
  services.xserver.xkb = {
    layout = "us";
    options = "caps:ctrl_modifier";
  };

  # Apply XKB settings to virtual consoles as well
  console.useXkbConfig = true;
}


