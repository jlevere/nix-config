NixOS configuration for my personal machine. Uses flakes and home-manager, tailored to current hardware.

## Layout
- `nixos/` system modules by area (boot, gpu, network, etc.)
- `modules/home-manager/` user modules (desktop, shell, apps)
- `flake.nix` entry point for system and home profiles

## Usage
- Build and switch system: `sudo nixos-rebuild switch --flake .#<hostname>`
- Update inputs: `nix flake update`

## Notes
- Assumes hardware in `hardware-configuration.nix`
- Tweaks are opinionated; review modules before reuse
