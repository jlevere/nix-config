{ pkgs, ... }:

{
  hardware.bluetooth.enable = false;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = true;

  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
      FastConnectable = true;
      ControllerMode = "bredr";
    };
    Policy = {
      AutoEnable = true;
    };
  };

  # Ensure adapter is powered after daemon starts/resume
  systemd.services.bluetooth.serviceConfig.ExecStartPost = [
    "${pkgs.bluez}/bin/bluetoothctl power on"
    "${pkgs.bluez}/bin/btmgmt --index 0 power on"
  ];
}
