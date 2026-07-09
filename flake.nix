{
  description = "A simple NixOS flake";

  inputs = {
    # Use unstable NixOS channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-wire.url = "github:semi710/nix-wire";
  };

  outputs =
    inputs:
    inputs.nix-wire.mkFlake {
      inherit inputs;
    };
}
