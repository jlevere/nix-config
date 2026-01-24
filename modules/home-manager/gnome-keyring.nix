{ pkgs, ... }:

{
  # Start gnome-keyring-daemon in the user session
  # The "secrets" component provides the D-Bus secret service API (libsecret)
  systemd.user.services."gnome-keyring-secrets" = {
    Unit = {
      Description = "GNOME Keyring (secrets component)";
      PartOf = [ "graphical-session.target" ];
      # Start before other services that might need secrets
      Before = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      # Create control directory before starting
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %t/keyring";
      ExecStart = "${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --start --foreground --components=secrets";
      Restart = "on-failure";
      RestartSec = 2;
      # Ensure control directory exists
      RuntimeDirectory = "keyring";
      RuntimeDirectoryMode = "0700";
      # Environment variables for keyring
      Environment = [
        "GNOME_KEYRING_CONTROL=%t/keyring"
      ];
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
    # Ensure secret service is available to applications
    # This helps MCP OAuth flows work properly
    DBUS_SESSION_BUS_ADDRESS = "unix:path=$XDG_RUNTIME_DIR/bus";
  };
}

