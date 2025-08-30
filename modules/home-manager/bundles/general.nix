{ lib, ... }:

{

  myUser = {
    fonts.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    fish.enable = lib.mkDefault true;
    direnv.enable = lib.mkDefault true;
    nix-registry.enable = lib.mkDefault true;
    man.enable = lib.mkDefault true;
    keyboard.enable = lib.mkDefault true;
  };

  programs.home-manager.enable = true;
}