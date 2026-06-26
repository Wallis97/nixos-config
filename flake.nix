{
  description = "A simple NixOS flake";

  inputs = {
    # Use unstable NixOS channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nixops4 = {
      url = "github:nixops4/nixops4";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixops4, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
	home-manager.nixosModules.home-manager
	{
	  home-manager = {
	    useGlobalPkgs = true;
	    useUserPackages = true;
	    extraSpecialArgs = { inherit inputs; };
	    users.vallii = ./home.nix;
	  };
	}
      ];
    };
  };
}
