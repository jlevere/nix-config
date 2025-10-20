{ pkgs, ... }:

{
  home.packages =
    with pkgs;
    let
      pythonWithPackages = python3.withPackages (
        ps: with ps; [
          requests
          pwntools
        ]
      );
    in
    [
      act
      alejandra
      awscli2
      cursor  # From overlay - tracks latest releases
      bat
      binutils
      dig
      file
      gdb
      ghidra
      gnumake
      google-chrome
      jq
      just
      ltrace
      nil
      netcat
      obsidian
      pythonWithPackages
      remmina
      ripgrep
      rustscan
      signal-desktop
      socat
      strace
      go-task
      tree
      unzip
      uv
      wget
      zellij
      zip
    ];
}
