{
  lib,
  config,
  inputs,
  myUtils,
  pkgs,
  ...
}:
{
  options.mySystem.users = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          userConfig = lib.mkOption {
            default = { };
            example = "DP-1";
          };
          userSettings = lib.mkOption {
            default = { };
            example = "{}";
          };
        };
      }
    );
    default = { };
  };

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "bkp";

      extraSpecialArgs = {
        inherit inputs;
        inherit myUtils;
      };

      users = builtins.mapAttrs (
        name: user:
        { ... }:
        {
          imports = [
            (import user.userConfig)
            # home-manager module set is already imported at nixos level;
            # import only project HM module tree
            ../../home-manager
          ];
        }
      ) (config.mySystem.users);
    };

    users.users = builtins.mapAttrs (
      name: user:
      {
        isNormalUser = true;
        initialPassword = "password";
        description = name;
        shell = pkgs.fish;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      }
      // user.userSettings
    ) (config.mySystem.users);
  };
}
