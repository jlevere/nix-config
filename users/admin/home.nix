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
    bundles = {
      general.enable = true;
      desktop.enable = true;

    };

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