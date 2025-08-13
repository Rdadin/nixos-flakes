{ config, pkgs, ... }:
{
  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";  # Breeze Dark global theme
      colorScheme = "BreezeDark";                  # matching color scheme
      iconTheme   = "breeze-dark";                 # optional: dark icon theme
      wallpaperSlideShow = {
        path = ../../../wallpapers;  # directory
        interval = 60;                    # seconds
      };
      # nice-to-haves:
      wallpaperFillMode = "stretch";
      wallpaperBackground.blur = false;
    };

    input = {
      mice = [
        {
          accelerationProfile = "none";
          acceleration = -0.5;
          name = "Logitech G703 LS";
          productId = "4086";
          vendorId = "046d";
        }
      ];
    };
  };
}
