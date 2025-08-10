{ pkgs, lib, ... }:
{
  services.power-profiles-daemon.enable = true;  # simple and works great
  services.logind.lidSwitch = "suspend";
  services.logind.lidSwitchExternalPower = "ignore";

  # Optional extras:
  # services.tlp.enable = true;  # if you prefer TLP over power-profiles-daemon
  # programs.auto-cpufreq.enable = true;

  hardware.bluetooth.enable = lib.mkDefault true;
}

