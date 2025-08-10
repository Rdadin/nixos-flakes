{ config, lib, pkgs, ... }:
with lib; {
  options.common.base.enable = mkEnableOption "core system baseline";

  config = mkIf (config.common.base.enable or true) {
    time.timeZone = "America/Argentina/Buenos_Aires";

    i18n.defaultLocale = "en_US.UTF-8";

    # Nix / nixpkgs
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    # Quality-of-life
    services.fstrim.enable = true;
    zramSwap.enable = true;
    security.polkit.enable = true;

    # CLI must-haves
    environment.systemPackages = with pkgs; [
      vim wget git curl htop tmux neovim unzip killall pciutils usbutils
      wl-clipboard bat ipcalc tealdeer
    ];

    # Fonts
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.hack
    ];
  };
}

