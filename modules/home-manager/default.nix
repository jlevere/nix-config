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
      (builtins.filter (p: myUtils.fileNameOf p != "default") (myUtils.filesIn ./.))
      {
        inherit
          pkgs
          inputs
          displayServer
          ;
      };
in
{
  imports = features;

  # Common desktop tools for both GNOME and Hyprland sessions
  home.packages = with pkgs; [
    wl-clipboard
    grim
    slurp
    swappy
    firefox
    nixfmt-rfc-style
    nil
  ];
}
