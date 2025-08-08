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
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  fonts.packages = with pkgs; [
  pkgs.nerd-fonts.fira-code
  pkgs.nerd-fonts.jetbrains-mono
  pkgs.nerd-fonts.hack
  ];



  environment.systemPackages = with pkgs; [ 
    vim 
    wget 
    git 
    curl 
    htop 
    xclip
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
    gcc
    wl-clipboard     # Wayland clipboard utilities
    bat
    ipcalc
    tealdeer
    plasma5Packages.kdeconnect-kde
  ];

  hardware.bluetooth.enable = true;

  hardware.bluetooth.powerOnBoot = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };

  services.pulseaudio.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
