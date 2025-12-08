{ lib, config, pkgs, ... }:

{
  # GNOME Keyring - provides secret storage service for libsecret consumers
  # Required by apps like Azure VPN Client, VS Code, browsers, etc.
  services.gnome.gnome-keyring.enable = true;

  # Unlock the keyring automatically on login via PAM
  # This integrates with SDDM so the keyring is unlocked when you log in
  security.pam.services.sddm.enableGnomeKeyring = true;

  # Also enable for login (covers TTY login, su, etc.)
  security.pam.services.login.enableGnomeKeyring = true;

  environment.systemPackages = [ pkgs.gnome-keyring pkgs.seahorse ];
}

