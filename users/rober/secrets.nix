{ config, ... }:

let
  homeDir     = config.home.homeDirectory;
  secretsBase = "${homeDir}/.local/share/secrets";
  vpnSecrets  = "${secretsBase}/vpn";
in
{
  sops.age.keyFile = "${homeDir}/.config/sops/age/keys.txt";

  # niceties
  home.file."${vpnSecrets}/espacio/.keep".text = "";
  home.file."${vpnSecrets}/arsat/.keep".text = "";
  home.file."${vpnSecrets}/opn_infra/.keep".text = "";

  sops.secrets = {
    # ESPACIO
    "vpn/espacio/auth.txt" = {
      sopsFile = ../../secrets/vpn/espacio-auth.txt;
      path = "${vpnSecrets}/espacio/auth.txt"; mode = "0600";
    };
    "vpn/espacio/rdadin.p12" = {
      sopsFile = ../../secrets/vpn/espacio/rdadin.p12;
      path = "${vpnSecrets}/espacio/rdadin.p12"; mode = "0600";
    };
    "vpn/espacio/rdadin.key" = {
      sopsFile = ../../secrets/vpn/espacio/rdadin.key;
      path = "${vpnSecrets}/espacio/rdadin.key"; mode = "0600";
    };

    # ARSAT
    "vpn/arsat/auth.txt" = {
      sopsFile = ../../secrets/vpn/arsat-auth.txt;
      path = "${vpnSecrets}/arsat/auth.txt"; mode = "0600";
    };
    "vpn/arsat/rdadin_ar.p12" = {
      sopsFile = ../../secrets/vpn/arsat/rdadin_ar.p12;
      path = "${vpnSecrets}/arsat/rdadin_ar.p12"; mode = "0600";
    };
    "vpn/arsat/rdadin_ar.key" = {
      sopsFile = ../../secrets/vpn/arsat/rdadin_ar.key;
      path = "${vpnSecrets}/arsat/rdadin_ar.key"; mode = "0600";
    };

    # OPN_INFRA
    "vpn/opn_infra/ca.crt" = {
      sopsFile = ../../secrets/vpn/opn_infra/ca.crt;
      path = "${vpnSecrets}/opn_infra/ca.crt"; mode = "0600";
    };
    "vpn/opn_infra/client.crt" = {
      sopsFile = ../../secrets/vpn/opn_infra/client.crt;
      path = "${vpnSecrets}/opn_infra/client.crt"; mode = "0600";
    };
    "vpn/opn_infra/client.key" = {
      sopsFile = ../../secrets/vpn/opn_infra/client.key;
      path = "${vpnSecrets}/opn_infra/client.key"; mode = "0600";
    };
    "vpn/opn_infra/ta.key" = {
      sopsFile = ../../secrets/vpn/opn_infra/ta.key;
      path = "${vpnSecrets}/opn_infra/ta.key"; mode = "0600";
    };
    "vpn/opn_infra/auth.txt" = {
      sopsFile = ../../secrets/vpn/opn_infra-auth.txt;
      path = "${vpnSecrets}/opn_infra/auth.txt"; mode = "0600";
    };
  };
}
