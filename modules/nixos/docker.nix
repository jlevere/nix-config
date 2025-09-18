{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    liveRestore = true;
    # enableNvidia = true;

    daemon.settings = {
      log-driver = "journald";
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

  systemd.services.docker.wantedBy = [ "multi-user.target" ];
}
