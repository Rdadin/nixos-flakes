{ pkgs, ... }:
{
  services.desktopManager.plasma6.enable = true;

  # Plasma helpers you actually use
  environment.systemPackages = with pkgs; [
    pkgs.kdePackages.plasma-nm
    pkgs.kdePackages.kdeconnect-kde
    pavucontrol
  ];
}
