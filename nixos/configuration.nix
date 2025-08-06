{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Argentina/Buenos_Aires";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  users.users.rober = {
    isNormalUser = true;
    description = "Roberto Dadin";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "";  # Use 'passwd' later
  };

  environment.systemPackages = with pkgs; [ 
    vim 
    wget 
    git 
    curl 
    htop 
    tmux 
    neovim 
    unzip 
    killall 
    pciutils 
    usbutils 
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
