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
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
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
    waybar           # Status bar for Hyprland
    rofi-wayland     # App launcher (or wofi if you prefer)
    hyprpaper        # Wallpaper daemon
    kitty            # Terminal (or alacritty/wezterm)
    brightnessctl    # Brightness control
    pavucontrol      # Audio control GUI
    wl-clipboard     # Wayland clipboard utilities
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
