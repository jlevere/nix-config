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
    };
    Policy = {
      AutoEnable = true;
    };
  };
}
