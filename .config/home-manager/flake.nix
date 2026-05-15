{
  description = "Home Manager configuration of ambrose";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util = {
      url = "github:hraban/mac-app-util";
    };
  };

  outputs =
    {
      nixpkgs,
	  nixpkgs-master,
      home-manager,
      nur,
      mac-app-util,
      ...
    }:
    {
      homeConfigurations."ambrose@framework" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
		pkgs-master = import nixpkgs-master {
          system = "x86_64-linux";
        };
        modules = [
          nur.modules.homeManager.default
          ./machines/framework.nix
        ];
      };
      homeConfigurations."ambrose@goldenbarrel" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
		pkgs-master = import nixpkgs-master {
          system = "x86_64-linux";
        };
        modules = [
          nur.modules.homeManager.default
          ./machines/goldenbarrel.nix
        ];
      };
      homeConfigurations."ambrose@ambrose-workmacbookpro" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
        };
		pkgs-master = import nixpkgs-master {
          system = "x86_64-linux";
        };
        modules = [
          nur.modules.homeManager.default
          mac-app-util.homeManagerModules.default
          ./machines/workmacbookpro.nix
        ];
      };
    };
}
