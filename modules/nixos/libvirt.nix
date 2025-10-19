{ pkgs, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
      };
    };

    spiceUSBRedirection.enable = true;
  };

  programs.virt-manager.enable = true;

  # Disable auto-resume of VMs on boot (prevents errors on missing VMs)
  systemd.services.libvirt-guests.enable = false;
}
