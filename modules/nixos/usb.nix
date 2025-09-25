{ pkgs, ... }:

{
  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    usbutils
  ];

  # Disable autosuspend for TP-Link Bluetooth USB Adapter (2357:0604)
  services.udev.extraRules = ''
    ACTION=="add|change", SUBSYSTEM=="usb", ATTR{idVendor}=="2357", ATTR{idProduct}=="0604", ATTR{power/autosuspend}="-1", ATTR{power/control}="on"
  '';
}
