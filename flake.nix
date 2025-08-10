{
  description = "NixOS flake with Home Manager (user: rober)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";

    # JaKooLit dotfiles (pin to a tag/commit you like)
    hyprdots.url = "github:JaKooLit/Hyprland-Dots?ref=v2.3.16";
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, ... }: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nixos/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ sops-nix.homeManagerModules.sops ];
            home-manager.users.rober = import ./users/rober/home.nix;

            home-manager.extraSpecialArgs = { inherit hyprdots; };
          }
        ];
      };
    };
  };
}

