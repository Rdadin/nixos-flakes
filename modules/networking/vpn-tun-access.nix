{ ... }:
{
  # Trust TUN/TAP interfaces so traffic from VPNs isn’t blocked by the firewall.
  networking.firewall.trustedInterfaces = [ "tun0" ];
  # Reverse path filtering: "loose" is friendlier for split‑tunnel VPNs.
  networking.firewall.checkReversePath = "loose";
}


