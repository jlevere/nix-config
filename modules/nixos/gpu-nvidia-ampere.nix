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
    extraPackages = [ pkgs.nvidia-vaapi-driver ];
  };

  # NVIDIA driver selection for X/Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Match current setup: proprietary kernel module
    open = false;

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
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_RENDERER = "vulkan";
    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct"; # for nvidia-vaapi-driver
    __GL_VRR_ALLOWED = "1";
    __GL_GSYNC_ALLOWED = "1";
  };

  # Often helps Wayland session stability on NVIDIA
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
}
