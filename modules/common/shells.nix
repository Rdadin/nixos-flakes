{ config, lib, pkgs, ... }:
with lib; {
  options.common.shells.enable = mkEnableOption "shells and prompt";

  config = mkIf (config.common.shells.enable or true) {
    programs.fish.enable = true;

    # Primary group for the user
    users.groups.rober = {};

    users.users.rober = {
      # Make sure only ONE of these is true
      isNormalUser = lib.mkForce true;
      isSystemUser = lib.mkForce false;

      description = "Roberto Dadin";
      home = "/home/rober";
      group = "rober";
      extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
      shell = pkgs.fish;
    };
  };
}

