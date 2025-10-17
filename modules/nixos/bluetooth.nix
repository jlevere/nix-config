{ ... }:

{
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  hardware.bluetooth.settings = {
    General = {
      # Enable experimental features for better compatibility
      Experimental = true;
    };
    Policy = {
      AutoEnable = true;
    };
  };
}
