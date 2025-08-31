{
  pkgs,
  config,
  lib,
  myUtils,
  inputs,
  displayServer ? "wayland",
  ...
}:
let
  cfg = config.myUser;

  features =
    myUtils.extendModules
      (name: {
        extraOptions = {
          myUser.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";
        };

        configExtension = config: (lib.mkIf cfg.${name}.enable config);
      })
      (myUtils.filesIn ./features)
      {
        inherit
          pkgs
          inputs
          displayServer
          ;
      };

  bundles =
    myUtils.extendModules
      (name: {
        extraOptions = {
          myUser.bundles.${name}.enable = lib.mkEnableOption "enable ${name} module bundle";
        };

        configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
      })
      (myUtils.filesIn ./bundles)
      {
        inherit
          pkgs
          inputs
          displayServer
          ;
      };
in
{
  imports = features ++ bundles;

  # Common desktop tools for both GNOME and Hyprland sessions
  home.packages = with pkgs; [
    wl-clipboard
    grim
    slurp
    swappy
    firefox
    code-cursor
    nixfmt-rfc-style
    nil
  ];

  # Allow unfree packages for Home Manager as well
  nixpkgs.config.allowUnfree = true;
}
