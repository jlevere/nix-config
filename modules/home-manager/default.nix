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
    code-cursor
    nixfmt-rfc-style
    nil
    ghostty
    fuzzel
    tmux
    wdisplays
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".zshrc".text = ''
    # Managed by Home Manager. Intentionally minimal to suppress zsh-newuser-install.
  '';

  xdg.configFile."ghostty/config".text = ''
    font-family = "JetBrainsMono Nerd Font"
    font-size   = 12
    theme       = Srcery
    background-opacity = 0.90
  '';
}
