{ pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };
    initrd = {
      enable = true;
      systemd.enable = true;
    };
    consoleLogLevel = 3;
    # Disable sp5100_tco watchdog that causes shutdown warnings on AMD
    blacklistedKernelModules = [ "sp5100_tco" ];
    plymouth = {
      enable = true;
      themePackages = [ (pkgs.catppuccin-plymouth.override { variant = "mocha"; }) ];
      theme = "catppuccin-mocha";
    };
  };
}
