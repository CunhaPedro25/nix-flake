{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = { 
        nixos-desktop = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/nixos-desktop/configuration.nix
            inputs.home-manager.nixosModules.default
            inputs.nix-ld.nixosModules.nix-ld
          ];
        };
      };
      
      homeConfigurations = {
        mint-desktop = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/mint-desktop/home.nix
	    inputs.home-manager.nixosModules.default
	  ];
	};
      };
    };
}
