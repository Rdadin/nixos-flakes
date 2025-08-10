{ lib, pkgs, ... }:
with lib; {
  options.networking.core.enable = mkEnableOption "basic networking stack";

  config = mkIf (config.networking.core.enable or true) {
    networking.networkmanager = {
      enable = true;
      plugins = with pkgs; [ networkmanager-openvpn ];
    };
    # Firewall defaults are OK; vpn-tun-access module will tweak for TUNs.
  };
}

