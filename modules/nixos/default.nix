{
  pkgs,
  config,
  lib,
  inputs,
  myUtils,
  ...
}:
let
  cfg = config.mySystem;
  utils = myUtils;

  features = utils.extendModules (name: {
    extraOptions = {
      mySystem.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";
    };

    configExtension = config: (lib.mkIf cfg.${name}.enable config);
  }) (utils.filesIn ./features) { inherit pkgs; };

  bundles = utils.extendModules (name: {
    extraOptions = {
      mySystem.bundles.${name}.enable = lib.mkEnableOption "enable ${name} module bundle";
    };

    configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
  }) (utils.filesIn ./bundles) { inherit pkgs; };
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ]
  ++ features
  ++ bundles;

  config = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    nixpkgs.config.allowUnfree = true;
    programs.nix-ld.enable = true;

    # Allow unfree packages for interactive nix shell usage
    environment.sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
    };
  };
}
