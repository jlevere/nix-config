{ pkgs, inputs, ... }:

{
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = false;
  programs.hyprland.package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  programs.hyprland.portalPackage =
    inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

  services = {
    displayManager.defaultSession = "hyprland";
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-mocha-mauve";
      package = pkgs.kdePackages.sddm;
      settings = {
        Theme = {
          CursorTheme = "Bibata-Modern-Ice";
        };
      };
    };
    # Enable AccountsService for user avatar support
    accounts-daemon.enable = true;
  };

  # Create symlink for user avatar in AccountsService directory
  systemd.tmpfiles.rules = [
    "L+ /var/lib/AccountsService/icons/admin - - - - ${../../assets/avatar.png}"
  ];

  services.xserver.enable = true;

  # Install Catppuccin SDDM theme
  environment.systemPackages = with pkgs; [
    (catppuccin-sddm.override {
      flavor = "mocha";
      font = "Noto Sans";
      fontSize = "9";
      background = "${../../assets/wallpapers/die.jpg}";
      loginBackground = true;
    })
    bibata-cursors
  ];
}
