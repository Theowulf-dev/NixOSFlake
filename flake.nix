{
  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
    
    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, winapps, ... } @ inputs: 
  {
    packages = {
      x86_64-linux = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            unstable = import nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
          modules = [
            home-manager.nixosModules.home-manager
            ./configuration.nix
          ];
        };
      };
    };
    
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { 
        inherit inputs;
        unstable = import nixpkgs-unstable {
          system = "x86_64-linux"; # or whatever your system is
          config.allowUnfree = true;
        };
      };
      modules = [ 
        home-manager.nixosModules.home-manager
        ./configuration.nix
      ];
    };
  };
}
