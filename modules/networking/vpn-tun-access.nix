{ lib, config, ... }:

let
  cfg = config.my.vpn.tunAccess;
in
{
  options.my.vpn.tunAccess = {
    enable = lib.mkEnableOption "relax firewall for VPN TUN interfaces";
    interfaces = lib.mkOption {
      type = with lib.types; listOf str;
      default = [ "tun0" ];
      description = ''
        TUN/TAP interfaces to mark as trusted (e.g. "tun0", "tun1").
      '';
    };
    rpFilterMode = lib.mkOption {
      type = lib.types.enum [ "loose" "strict" "no" ];
      default = "loose";
      description = ''
        Reverse path filtering mode. "loose" is recommended for split-tunnel VPNs.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.trustedInterfaces = cfg.interfaces;
    networking.firewall.checkReversePath = cfg.rpFilterMode;
  };
}

