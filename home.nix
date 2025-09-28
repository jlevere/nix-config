{
  outputs,
  lib,
  ...
}:

{
  programs.git = {
    userName = "stackviolator";
    userEmail = "59704399+stackviolator@users.noreply.github.com";
  };

  myUser = {
    fonts.enable = true;
    git.enable = true;
    fish.enable = false;
    direnv.enable = true;
    nix-registry.enable = true;
    man.enable = true;
    keyboard.enable = true;

    hyprland.enable = true;
    vesktop.enable = true;
    typst.enable = true;
    notifications.enable = true;
    polkit-agent.enable = true;
    wezterm.enable = true;
    dev-packages.enable = true;
    zellij.enable = false;
    bluetooth.enable = false;

    git.allowedSigners = {
      url = null;
      sha256 = null;
      email = null;
    };
  };

  home = {
    username = "pop";
    homeDirectory = lib.mkDefault "/home/pop";
    stateVersion = "25.05";
  };
}
