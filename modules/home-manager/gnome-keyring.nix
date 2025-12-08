{ pkgs, ... }:

{
  # Start gnome-keyring-daemon in the user session
  # The "secrets" component provides the D-Bus secret service API (libsecret)
  systemd.user.services."gnome-keyring-secrets" = {
    Unit = {
      Description = "GNOME Keyring (secrets component)";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --start --foreground --components=secrets";
      Restart = "on-failure";
      RestartSec = 2;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # Ensure SSH_AUTH_SOCK and other keyring env vars are set
  # This helps apps find the keyring socket
  home.sessionVariables = {
    # Point to the standard keyring socket location
    GNOME_KEYRING_CONTROL = "$XDG_RUNTIME_DIR/keyring";
  };
}

