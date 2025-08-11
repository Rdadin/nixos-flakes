{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    lutris
    protonup-qt
    goverlay
    vulkan-tools
    mangohud
    # Uncomment if you use Wine outside Proton:
    # wineWowPackages.stable
    # winetricks
    # dxvk
    # vkd3d
    # vkbasalt
  ];

  # Defaults (you can still set per-game launch options)
  home.sessionVariables = {
    MANGOHUD = lib.mkDefault "0";
    # WINEESYNC = "1";
    # WINEFSYNC = "1";
  };
}

