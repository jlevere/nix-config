{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    liveRestore = true;
    # enableNvidia = true;
    
    daemon.settings = {
      log-driver = "journald";
    };
  };

  environment.systemPackages = with pkgs; [
    docker-compose
    docker-buildx
  ];

  systemd.services.docker.wantedBy = [ "multi-user.target" ];
}
