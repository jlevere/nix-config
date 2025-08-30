{ config, lib, ... }:
let
  cfg = config.myUser.git;
  types = lib.types;
in
{
  options.myUser.git = {
    allowedSigners = {
      url = lib.mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "URL to fetch allowed SSH signing keys from (e.g., GitHub keys URL).";
      };
      sha256 = lib.mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "SHA256 hash for the fetched allowed signers file.";
      };
      email = lib.mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Email label to use in allowed_signers entries (defaults to programs.git.userEmail if unset).";
      };
      filePath = lib.mkOption {
        type = types.str;
        default = "${config.home.homeDirectory}/.ssh/allowed_signers";
        description = "Path to write the allowed_signers file.";
      };
      signingKeyPublicPath = lib.mkOption {
        type = types.str;
        default = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        description = "Path to the public key used for SSH commit signing.";
      };
      identities = lib.mkOption {
        type = types.listOf types.str;
        default = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
        description = "SSH identities to load into agent.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      ignores = [ ".direnv" ".envrc" ];
      extraConfig = {
        commit.gpgsign = true;
        gpg.format = "ssh";
        gpg.ssh.allowedSignersFile = cfg.allowedSigners.filePath;
        user.signingkey = cfg.allowedSigners.signingKeyPublicPath;
      };
    };

    services.ssh-agent.enable = true;

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks."*" = {
        addKeysToAgent = "yes";
        identityFile = cfg.allowedSigners.identities;
        identitiesOnly = true;
      };
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    # Write allowed_signers only when url+sha256 provided
    home.file = lib.mkIf (cfg.allowedSigners.url != null && cfg.allowedSigners.sha256 != null) {
      "${cfg.allowedSigners.filePath}".text = let
        raw = builtins.readFile (builtins.fetchurl {
          url = cfg.allowedSigners.url;
          sha256 = cfg.allowedSigners.sha256;
        });
        lines = lib.filter (l: l != "") (lib.splitString "\n" raw);
        label = if cfg.allowedSigners.email != null then cfg.allowedSigners.email else (config.programs.git.userEmail or "git@localhost");
      in (lib.concatMapStringsSep "\n" (k: "${label} ${k}") lines) + "\n";
    };
  };
}

