{ lib, config, pkgs, ... }:

{
  # GNOME Keyring - provides secret storage service for libsecret consumers
  # Required by apps like Azure VPN Client, VS Code, browsers, etc.
  services.gnome.gnome-keyring.enable = true;

  # Note: PAM integration disabled because we're starting keyring via user session
  # This avoids the "unable to locate daemon control file" error at login
  # The keyring is started by the graphical session instead
  # Using mkForce to override the automatic PAM integration from gnome-keyring service
  security.pam.services.sddm.enableGnomeKeyring = lib.mkForce false;
  security.pam.services.login.enableGnomeKeyring = lib.mkForce false;

  environment.systemPackages = [ pkgs.gnome-keyring pkgs.seahorse ];
}

