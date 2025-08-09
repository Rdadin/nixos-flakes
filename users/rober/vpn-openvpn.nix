{ config, ... }:

let
  homeDir     = config.home.homeDirectory;
  secretsBase = "${homeDir}/.local/share/secrets";
  vpnSecrets  = "${secretsBase}/vpn";
  profilesDir = "${homeDir}/.config/openvpn-profiles";
in
{
  # keep a dir placeholder
  home.file."${profilesDir}/.keep".text = "";

  # ESPACIO: pkcs12 + tls-auth + user/pass
  home.file."${profilesDir}/espacio.ovpn".text = ''
    client
    dev tun
    proto udp4
    remote 186.153.174.203 10000
    resolv-retry infinite
    nobind
    persist-key
    persist-tun

    data-ciphers AES-128-GCM:AES-256-GCM:AES-128-CBC
    data-ciphers-fallback AES-128-CBC
    auth SHA256
    remote-cert-tls server

    auth-user-pass ${vpnSecrets}/espacio/auth.txt
    pkcs12        ${vpnSecrets}/espacio/rdadin.p12
    tls-auth      ${vpnSecrets}/espacio/rdadin.key 1
    verify-x509-name "OpenVPN" name
    explicit-exit-notify
    verb 3
  '';

  # ARSAT: pkcs12 + tls-auth + user/pass
  home.file."${profilesDir}/arsat.ovpn".text = ''
    client
    dev tun
    proto udp4
    remote 186.33.208.138 1194
    resolv-retry infinite
    nobind
    persist-key
    persist-tun

    data-ciphers AES-256-GCM:AES-128-GCM:AES-128-CBC
    data-ciphers-fallback AES-128-CBC
    auth SHA256
    remote-cert-tls server

    auth-user-pass ${vpnSecrets}/arsat/auth.txt
    pkcs12        ${vpnSecrets}/arsat/rdadin_ar.p12
    tls-auth      ${vpnSecrets}/arsat/rdadin_ar.key 1
    verify-x509-name "openvpn-sv" name
    explicit-exit-notify
    verb 3
  '';

  # OPN_INFRA: split certs/keys from inline + user/pass
  home.file."${profilesDir}/opn_infra.ovpn".text = ''
    client
    dev tun
    proto udp4
    remote vpn.educar.net.ar 1194
    lport 0
    resolv-retry infinite
    nobind
    persist-key
    persist-tun

    ca           ${vpnSecrets}/opn_infra/ca.crt
    cert         ${vpnSecrets}/opn_infra/client.crt
    key          ${vpnSecrets}/opn_infra/client.key
    tls-auth     ${vpnSecrets}/opn_infra/ta.key 1
    auth-user-pass ${vpnSecrets}/opn_infra/auth.txt

    remote-cert-tls server
    verify-x509-name "C=AR, ST=Buenos Aires, L=Nuñez, O=Educar, CN=vpn.educar.net.ar" subject
    verb 3
  '';
}
