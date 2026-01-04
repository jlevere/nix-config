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

  # Suppress harmless udev errors about device node creation
  # The nodes are created by the kernel/systemd before udev rules run
  services.udev.extraRules = ''
    # Skip nvidia device node creation if they already exist
    KERNEL=="nvidia*", TEST=="/dev/$name", GOTO="nvidia_end"
    LABEL="nvidia_end"
  '';

  # Ensure nouveau doesn't grab the device
  boot.blacklistedKernelModules = [ "nouveau" ];

  # Wayland + NVIDIA niceties (GNOME / Hyprland)
  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    WLR_NO_HARDWARE_CURSORS = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_RENDERER = "vulkan";
    LIBVA_DRIVER_NAME = "nvidia";
    # Force EGL platform to be Wayland for better compatibility
    EGL_PLATFORM = "wayland";
    # Helps with screencopy on NVIDIA
    WLR_DRM_NO_ATOMIC = "1";
  };

  # Often helps Wayland session stability on NVIDIA
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
}
