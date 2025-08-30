{ lib, ... }:

{
  myUser = {
    dev-packages.enable = lib.mkDefault true;
    zellij.enable = lib.mkDefault true;
  };
}
