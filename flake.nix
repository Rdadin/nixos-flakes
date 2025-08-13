{
  description = "NixOS flake with Home Manager (user: rober)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, plasma-manager, ... }:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;

    mkHost = hostPath:
      lib.nixosSystem {
        inherit system;
        specialArgs = { inherit self nixpkgs home-manager sops-nix; }; # handy if modules need inputs
        modules = [
          (import hostPath)
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = null;
            home-manager.sharedModules = [
              sops-nix.homeManagerModules.sops 
              plasma-manager.homeManagerModules.plasma-manager
            ];
            home-manager.users.rober = import ./users/rober/home.nix;
          }
        ];
      };
  in {
    nixosConfigurations = {
      nixos-desktop       = mkHost ./hosts/desktop/default.nix;
      nixos-dell   = mkHost ./hosts/laptop-dell/default.nix;
      nixos-exo = mkHost ./hosts/laptop-exo/default.nix;
    };
  };
}

