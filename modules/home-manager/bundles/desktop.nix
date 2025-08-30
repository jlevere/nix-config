{
  lib,
  #displayServer,
  myUtils,
  ...
}:

{
  config = {
    myUser = {
      vesktop.enable = lib.mkDefault true;
      typst.enable = lib.mkDefault true;
      notifications.enable = lib.mkDefault true;
      polkit-agent.enable = lib.mkDefault true;
      wezterm.enable = lib.mkDefault true;
    };
  };
}