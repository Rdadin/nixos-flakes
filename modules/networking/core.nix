{ pkgs, ... }:
{
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [ networkmanager-openvpn ];
  };

  # Firewall defaults are OK; vpn-tun-access.nix will tweak for TUNs.
}

