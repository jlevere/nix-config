{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    inputs:
    let
      utils = import ./utils { inherit inputs; };
    in
    with utils;
    {
      nixosConfigurations = {
        p620 = mkSystem ./system.nix;
      };

      homeManagerModules.default = ./modules/home-manager;
      nixosModules.default = ./modules/nixos;

      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);
    };
}
