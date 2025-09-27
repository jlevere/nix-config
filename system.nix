{
  pkgs,
  inputs,
  myUtils,
  lib,
  ...
}:

{

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/nixos
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    kernelParams = [ "quiet" ];
    kernelModules = [
      "cpuid"
    ];
  };

  # Replace missing disk swap with zram swap to avoid boot timeout
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  # Force-disable old swapDevices defined by hardware-configuration.nix (UUID no longer exists)
  swapDevices = lib.mkForce [ ];

  # Home Manager users (co-located with system root)
  home-manager.users.pop =
    { ... }:
    {
      imports = [
        ./home.nix
        ./modules/home-manager
      ];
    };

  # System users (simple inline style)
  users.users.pop = {
    isNormalUser = true;
    description = "pop";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "i2c"
      "bluetooth"
      "libvirtd"
      "kvm"
      "input"
    ];
  };

  users.groups.docker.members = [ "pop" ];
  users.groups.i2c.members = [ "pop" ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";
  networking.networkmanager.unmanaged = [ "interface-name:tailscale0" ];

  time.timeZone = "America/Chicago";

  services = {
    libinput.enable = true;
    printing.enable = true;
    openssh.enable = true;
    resolved.enable = true;
    tailscale.extraUpFlags = [ "--accept-dns=false" ];
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
    desktopManager.plasma6.enable = true;
  };

  programs.azureVpnClient.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs.zsh.enable = true;
  programs.zsh.ohMyZsh = {
    enable = true;
    theme = "powerlevel10k";
    custom = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
    plugins = [
      "git" "vi-mode" "z" "sudo" "colored-man-pages"
      "history-substring-search" "fzf" "extract"
    ];
  };
  programs.zsh.autosuggestions.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.promptInit = ''
    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
  '';
  programs.zsh.interactiveShellInit = ''
    alias ls='eza --icons --group-directories-first'
    alias cat='bat --paging=never --style=plain'
  '';

  system.stateVersion = "25.05";
}
