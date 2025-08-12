{ pkgs, lib, ... }:
{
  # Replace the old broken unit with a correct one
  systemd.services.input-retrigger-after-dm = {
    description = "Retrigger input devices after display manager starts";
    after = [ "display-manager.service" "systemd-udevd.service" ];
    wants = [ "display-manager.service" ];
    wantedBy = [ "display-manager.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = lib.mkForce [
        "${pkgs.systemd}/bin/udevadm control --reload"
        "${pkgs.systemd}/bin/udevadm trigger --subsystem-match=input --action=add"
      ];
    };
  };
}
