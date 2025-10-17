{ lib, config, pkgs, ... }:

{
  # Create /etc/pam.d/hyprlock so Hyprlock doesn't fall back to su
  security.pam.services.hyprlock = {
    text = ''
      auth     include login
      account  include login
      password include login
      session  include login
    '';
  };
}


