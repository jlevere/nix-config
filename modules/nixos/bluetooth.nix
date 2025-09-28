{ pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
      FastConnectable = true;
      ControllerMode = "dual";
    };
    Policy = {
      AutoEnable = true;
    };
  };

  # Let BlueZ manage power via AutoEnable and leave post-commands out

  # A2DP codecs for PipeWire
  services.pipewire.wireplumber.extraConfig.bluetooth-policy = {
    "monitor.bluez.rules" = [
      { matches = [ { "device.name" = "bluez_card.*"; } ];
        actions = { update-props = { "bluez5.enable-msbc" = true; "bluez5.enable-hw-volume" = true; "bluez5.enable-a2dp-codec-switching" = true; }; };
      }
    ];
  };
}
