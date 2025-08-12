{
  description = "Limoncello (Beelink Mini S) nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    home-manager.url = "github:nix-community/home-manager";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    nixvim = {
    # url = "github:nix-community/nixvim/update/nixos-24.05";
    # url = "github:nix-community/nixvim/update/main";
    url = "github:nix-community/nixvim";
    inputs.nixpkgs.follows = "nixpkgs";
    # inputs.nixpkgs.follows = "nixpkgs-unstable";
  };
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, nixvim, catppuccin, ... } @ inputs:
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
            nixvim.homeManagerModules.nixvim
            catppuccin.homeModules.catppuccin
          ];
        };
      };
    };
}
