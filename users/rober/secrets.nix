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
      format = "binary";
      path = "${vpnSecrets}/espacio/auth.txt";
      mode = "0600";
    };
    "vpn/espacio/client.crt" = {
      sopsFile = ../../secrets/vpn/espacio/client.crt;
      format = "binary";
      path = "${vpnSecrets}/espacio/client.crt";
      mode = "0600";
    };
    "vpn/espacio/client.key" = {
      sopsFile = ../../secrets/vpn/espacio/client.key;
      format = "binary";
      path = "${vpnSecrets}/espacio/client.key";
      mode = "0600";
    };
    "vpn/espacio/ca.crt" = {
      sopsFile = ../../secrets/vpn/espacio/ca.crt;
      format = "binary";
      path = "${vpnSecrets}/espacio/ca.crt";
      mode = "0600";
    };
    "vpn/espacio/rdadin.key" = {
      sopsFile = ../../secrets/vpn/espacio/rdadin.key;
      format = "binary";
      path = "${vpnSecrets}/espacio/rdadin.key";
      mode = "0600";
    };


    # ARSAT
    "vpn/arsat/auth.txt" = {
      sopsFile = ../../secrets/vpn/arsat-auth.txt;
      format = "binary";
      path = "${vpnSecrets}/arsat/auth.txt";
      mode = "0600";
    };
    "vpn/arsat/client.crt" = {
      sopsFile = ../../secrets/vpn/arsat/client.crt;
      format = "binary";
      path = "${vpnSecrets}/arsat/client.crt";
      mode = "0600";
    };
    "vpn/arsat/client.key" = {
      sopsFile = ../../secrets/vpn/arsat/client.key;
      format = "binary";
      path = "${vpnSecrets}/arsat/client.key"; 
      mode = "0600";
    };
    "vpn/arsat/ca.crt" = {
      sopsFile = ../../secrets/vpn/arsat/ca.crt;
      format = "binary";
      path = "${vpnSecrets}/arsat/ca.crt";
      mode = "0600";
    };
    "vpn/arsat/rdadin_ar.key" = {
      sopsFile = ../../secrets/vpn/arsat/rdadin_ar.key;
      format = "binary";
      path = "${vpnSecrets}/arsat/rdadin_ar.key";
      mode = "0600";
    };

    # OPN_INFRA
    "vpn/opn_infra/ca.crt" = {
      sopsFile = ../../secrets/vpn/opn_infra/ca.crt;
      format = "binary";
      path = "${vpnSecrets}/opn_infra/ca.crt"; 
      mode = "0600";
    };
    "vpn/opn_infra/client.crt" = {
      sopsFile = ../../secrets/vpn/opn_infra/client.crt;
      format = "binary";
      path = "${vpnSecrets}/opn_infra/client.crt"; 
      mode = "0600";
    };
    "vpn/opn_infra/client.key" = {
      sopsFile = ../../secrets/vpn/opn_infra/client.key;
      format = "binary";
      path = "${vpnSecrets}/opn_infra/client.key"; 
      mode = "0600";
    };
    "vpn/opn_infra/ta.key" = {
      sopsFile = ../../secrets/vpn/opn_infra/ta.key;
      format = "binary";
      path = "${vpnSecrets}/opn_infra/ta.key"; 
      mode = "0600";
    };
    "vpn/opn_infra/auth.txt" = {
      sopsFile = ../../secrets/vpn/opn_infra-auth.txt;
      format = "binary";
      path = "${vpnSecrets}/opn_infra/auth.txt"; 
      mode = "0600";
    };
  };
}
