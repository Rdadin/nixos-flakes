{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    openvpn
    networkmanager
    networkmanager-openvpn
  ];

  networking.networkmanager.enable = true;

  services.openvpn.servers = {
    espacio = {
      autoStart = true;
      config = ''
        client
        dev tun
        proto udp
        remote espacio.example.com 1194
        resolv-retry infinite
        nobind
        persist-key
        persist-tun
        auth-user-pass /etc/openvpn/espacio/auth.txt
        remote-cert-tls server
        cipher AES-256-CBC
        verb 3
      '';
    };

    arsat = {
      autoStart = false;
      config = ''
        client
        dev tun
        proto udp
        remote arsat.example.com 443
        resolv-retry infinite
        nobind
        persist-key
        persist-tun
        auth-user-pass /etc/openvpn/arsat/auth.txt
        remote-cert-tls server
        cipher AES-256-CBC
        verb 3
      '';
    };

    opn_infra = {
      autoStart = false;
      config = ''
        client
        dev tun
        proto udp
        remote opn_infra.example.com 1194
        resolv-retry infinite
        nobind
        persist-key
        persist-tun
        auth-user-pass /etc/openvpn/opn_infra/auth.txt
        remote-cert-tls server
        cipher AES-256-CBC
        verb 3
      '';
    };
  };

  environment.etc = {
    "openvpn/espacio/auth.txt".source = ./../../secrets/openvpn/espacio-auth.txt;
    "openvpn/arsat/auth.txt".source = ./../../secrets/openvpn/arsat-auth.txt;
    "openvpn/opn_infra/auth.txt".source = ./../../secrets/openvpn/opn_infra-auth.txt;
  };
}

