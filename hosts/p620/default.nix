{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    kernelParams = [ "quiet" ];
    kernelModules = [
      "coretemp"
      "cpuid"
    ];
  };

  mySystem = {
    bundles = {
      base.enable = true;
      desktop.enable = true;
      users.enable = true;
      gpu-nvidia-ampere.enable = true;
    };

    # Explicitly choose GDM as the display manager
    gdm.enable = true;
    # Keep GNOME optional via mySystem.gnome.enable if desired

    users = {
      "admin" = import ../../users/admin;
    };
    dev-nettools.enable = true;
  };

  networking.hostName = "p620";
  networking.networkmanager.enable = true;

  services = {
    libinput.enable = true;
    printing.enable = true;
  };

  system.stateVersion = "25.05";
}
