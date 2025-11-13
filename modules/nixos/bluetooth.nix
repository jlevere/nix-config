{ ... }:

{
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  hardware.bluetooth.settings = {
    General = {
      # Enable experimental features for better compatibility
      Experimental = true;
      # Enable LE Audio (ISO sockets) for Bluetooth 5.2+ devices
      KernelExperimental = true;
      # Speed up reconnection after device sleep
      FastConnectable = true;
      # Allow devices to reconnect quickly without re-pairing
      JustWorksRepairing = "always";
      # Increase reconnection attempts and intervals for better reliability
      ReconnectAttempts = 7;
      ReconnectIntervals = "1, 2, 4, 8, 16, 32, 64";
    };
    Policy = {
      AutoEnable = true;
      # Reconnect to devices automatically when they come back
      ReconnectOnResume = true;
    };
  };
  
  # Disable USB autosuspend for Bluetooth adapter to prevent connection issues
  services.udev.extraRules = ''
    # Disable autosuspend for Bluetooth USB devices
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="*", ATTR{idProduct}=="*", TEST=="power/control", ATTR{power/control}="on"
    ACTION=="add", SUBSYSTEM=="usb", DRIVER=="btusb", ATTR{power/control}="on"
  '';
}
