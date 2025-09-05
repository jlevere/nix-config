{ inputs, myUtils, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager

    # NixOS module set
    ./autologin.nix
    ./backlight.nix
    ./bluetooth.nix
    ./bolt.nix
    ./bootloader.nix
    ./cuda.nix
    ./dconf.nix
    ./dev-nettools.nix
    ./docker.nix
    ./azure-vpn-client.nix
    ./firmware.nix
    ./fish.nix
    ./fonts.nix
    ./gpu-nvidia-ampere.nix
    ./hyprland.nix
    ./keyboard.nix
    ./lmsensors.nix
    ./openssh.nix
    ./pipewire.nix
    ./polkit.nix
    ./qt-wayland.nix
    ./tailscale.nix
    ./upower.nix
    ./usb.nix
    ./xdg-utils.nix
  ];

  # Home Manager globals
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bkp";
    extraSpecialArgs = { inherit inputs myUtils; };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
  programs.nix-ld.enable = true;

  # Allow unfree packages for interactive nix shell usage
  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
}
