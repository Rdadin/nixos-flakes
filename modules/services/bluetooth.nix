{ config, lib, ... }:
with lib; {
  options.services.bluetooth.enable = mkEnableOption "Bluetooth";

  config = mkIf config.services.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
  };
}
