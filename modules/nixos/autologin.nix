{ lib, config, ... }:
let
  cfg = config.mySystem.autologin;
in
{
  options.mySystem.autologin = {
    user = lib.mkOption {
      default = null;
      description = ''
        username to autologin
      '';
    };
  };

  config = lib.mkIf (cfg.user != null) {
  };
}
