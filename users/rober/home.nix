{ config, pkgs, lib, ... }:
{
  home.username = "rober";
  home.homeDirectory = "/home/rober";
  home.stateVersion = "25.05";

  imports = [
    ./secrets.nix

    # user modules
    ./modules/misc/packages.nix
 
    ./modules/terminal/shell.nix
    ./modules/terminal/starship.nix
    ./modules/terminal/alacritty.nix
#    ./modules/terminal/kitty.nix

    ./modules/editors/neovim.nix

    ./modules/vcs/git.nix

#    ./modules/desktop/hyprland
    ./modules/desktop/plasma

    ./modules/vpn/openvpn.nix
  ];
}
