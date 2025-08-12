{ pkgs, ... }:
{
  # Time & locale
  time.timeZone = "America/Argentina/Buenos_Aires";
  i18n.defaultLocale = "en_US.UTF-8";

  # Nix config
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # QoL
  services.envfs.enable = true;
  services.fstrim.enable = true;
  zramSwap.enable = true;
  security.polkit.enable = true;

  # Shells
  programs.fish.enable = true;

  # System-wide CLI
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
    wl-clipboard
    bat
    ipcalc
    tealdeer
    ghostscript
    tectonic
    mermaid-cli
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";     # Electron/Chromium apps prefer Wayland
    MOZ_ENABLE_WAYLAND = "1"; # Firefox prefers Wayland
  };
}

