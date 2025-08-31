{
  outputs,
  lib,
  ...
}:

{

  programs.git = {
    userName = "jLevere";
    userEmail = "71566629+jLevere@users.noreply.github.com";
  };

  myUser = {
    # Explicit feature toggles (bundles removed)
    fonts.enable = true;
    git.enable = true;
    fish.enable = true;
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
    zellij.enable = true;

    git.allowedSigners = {
      url = "https://github.com/jLevere.keys";
      sha256 = "1g87mxaaizyn8y5l0mdkxh14gywp4xjxlhxx2327m1q528bzn7gp";
    };
  };

  home = {
    username = "admin";
    homeDirectory = lib.mkDefault "/home/admin";
    stateVersion = "25.05";
  };
}
