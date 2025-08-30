{ pkgs, ... }:

{
  home.packages = with pkgs; let
    pythonWithPackages = python3.withPackages (ps: with ps; [ requests pwntools ]);
  in [
    act
    alejandra
    awscli2
    code-cursor
    bat
    binutils
    dig
    file
    gdb
    ghidra
    gnumake
    jq
    just
    ltrace
    nil
    netcat
    pythonWithPackages
    ripgrep
    rustscan
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


