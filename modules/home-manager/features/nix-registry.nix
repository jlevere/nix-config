{ inputs, ... }:

{
  nix.channels.nixpkgs = inputs.nixpkgs;

  nix.registry = {
    np = {
      from = {
        type = "indirect";
        id = "np";
      };
      flake = inputs.nixpkgs;
    };
    nixpkgs = {
      from = {
        type = "indirect";
        id = "nixpkgs";
      };
      flake = inputs.nixpkgs;
    };
  };
}
