{ pkgs, ... }:

{
  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    usbutils
  ];
}
