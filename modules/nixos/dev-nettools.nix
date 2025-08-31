{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    inetutils
    tcpdump
  ];
}
