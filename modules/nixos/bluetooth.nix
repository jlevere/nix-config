{ pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
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

  # power adapter and reconnect Keychron on resume
  powerManagement.resumeCommands = ''
    MAC=$(${pkgs.bluez}/bin/bluetoothctl devices | ${pkgs.gnugrep}/bin/grep -i 'Keychron' | ${pkgs.coreutils}/bin/head -n1 | ${pkgs.gawk}/bin/awk '{print $2}')
    if [ -n ""$MAC"" ]; then
      ${pkgs.bluez}/bin/btmgmt --index 0 power on || true
      ${pkgs.bluez}/bin/bluetoothctl connect "$MAC" || true
    fi
  '';
}
