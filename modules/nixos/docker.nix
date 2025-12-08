{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    # Allow daemon stop to tear down containers cleanly during shutdown
    liveRestore = false;
    # enableNvidia = true;

    daemon.settings = {
      log-driver = "journald";
      "exec-opts" = [ "native.cgroupdriver=systemd" ];
      runtimes = {
        runsc = {
          path = "${pkgs.gvisor}/bin/runsc";
        };
      };
    };

    extraPackages = with pkgs; [
      docker-buildx
      docker-compose
    ];
  };

  environment.variables = {
    DOCKER_BUILDKIT = "1";
    COMPOSE_DOCKER_CLI_BUILD = "1";
  };

  systemd.services.docker = {
    wantedBy = [ "multi-user.target" ];
    # Give Docker more time to gracefully shutdown containers
    serviceConfig = {
      TimeoutStopSec = 90;
      KillMode = "mixed";
    };
  };
}
