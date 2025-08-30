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
      system.enable = true;
      users.enable = true;
      gpu-nvidia-ampere.enable = true;
    };

    gdm.enable = true;
    hyprland.enable = true;

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