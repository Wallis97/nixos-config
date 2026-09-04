{
  description = "A simple NixOS flake";

  inputs = {
    # Use unstable NixOS channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
          url = "github:youwen5/zen-browser-flake";
          inputs.nixpkgs.follows = "nixpkgs";
    };

    reaper-flake.url = "github:9Prestidigitator/reaper-flake";

    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-wire.url = "github:semi710/nix-wire";
  };

  outputs =
    inputs:
    inputs.nix-wire.mkFlake {
      inherit inputs;
    };
}
