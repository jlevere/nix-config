{
  lib,
  config,
  pkgs,
  ...
}:

{

  # Generic graphics stack
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # replaces hardware.opengl.driSupport32Bit
  };

  # NVIDIA driver selection for X/Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Ampere supports the open kernel module
    open = true;

    # Choose a stable packaged branch
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    modesetting.enable = true;
    nvidiaSettings = true;

    powerManagement = {
      enable = false;
      finegrained = false;
    };
  };

  # Ensure nouveau doesn't grab the device
  boot.blacklistedKernelModules = [ "nouveau" ];

  # Wayland + NVIDIA niceties (GNOME / Hyprland)
  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    WLR_NO_HARDWARE_CURSORS = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  # Often helps Wayland session stability on NVIDIA
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
}
