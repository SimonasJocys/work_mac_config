{
  description = "Limoncello (Beelink Mini S) nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    home-manager.url = "github:nix-community/home-manager";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, ... } @ inputs:
    let
      system = "aarch64-darwin";
    in {
      darwinConfigurations."simons-MacBook-Air" = nix-darwin.lib.darwinSystem {
        system = system;
        modules = [
          ./system/configuration.nix
        ];
      };

      homeConfigurations = {
        "simon@simons-MacBook-Air" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = system;
          };
          extraSpecialArgs = { inherit inputs self; };
          modules = [
            ./home-manager/home.nix
          ];
        };
      };
    };
}
