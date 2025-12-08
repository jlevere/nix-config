{
  pkgs,
  inputs,
  myUtils,
  lib,
  ...
}:

{

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/nixos
  ];

  # Allow unfree packages (needed for cursor and other proprietary software)
  nixpkgs.config.allowUnfree = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    kernelParams = [ "quiet" ];
    kernelModules = [
      "cpuid"
    ];

    # Allow unlocking LUKS via TPM2 to avoid needing a keyboard at boot
    initrd.luks.devices."luks-2cbe7a7a-182f-4827-8ae7-726207d3c60f" = {
      bypassWorkqueues = true;
      allowDiscards = true;
      crypttabExtraOpts = [ "tpm2-device=auto" ];
    };
  };

  # Replace missing disk swap with zram swap to avoid boot timeout
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  # Force-disable old swapDevices defined by hardware-configuration.nix (UUID no longer exists)
  swapDevices = lib.mkForce [ ];

  # Home Manager users (co-located with system root)
  home-manager.users.admin =
    { ... }:
    {
      imports = [
        ./home.nix
        ./modules/home-manager
      ];
    };

  # System users (simple inline style)
  users.users.admin = {
    isNormalUser = true;
    initialPassword = "password";
    description = "admin";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "i2c"
      "bluetooth"
      "libvirtd"
      "kvm"
    ];
  };

  users.groups.docker.members = [ "admin" ];
  users.groups.i2c.members = [ "admin" ];

  networking.hostName = "p620";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";

  services = {
    libinput.enable = true;
    printing.enable = true;
    openssh.enable = false;

    # Microsoft Azure VPN Client
    microsoft-azurevpnclient.enable = true;
  };

  # Silence systemd warning about legacy /var/run/cups socket path
  systemd.sockets.cups.listenStreams = [ "/run/cups/cups.sock" ];

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  system.stateVersion = "25.05";
}
