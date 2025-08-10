# modules/gaming/default.nix
{ lib, pkgs, config, ... }:
let
  cfg = config.modules.gaming.enable;
in
{
  options.modules.gaming.enable = lib.mkEnableOption "Gaming stack (Steam, Gamemode, MangoHud, etc.)";

  config = lib.mkIf cfg {
    ###########################################################################
    # GPU / Vulkan / 32-bit userspace
    ###########################################################################
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      # VA-API helpers for Intel/AMD. En NVIDIA esto no rompe nada (usa NVDEC aparte).
      extraPackages = with pkgs; [ vaapiVdpau libvdpau-va-gl ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiVdpau libvdpau-va-gl ];
    };

    ###########################################################################
    # Steam + Gamescope + Gamemode + MangoHud
    ###########################################################################
    programs.steam = {
      enable = true;
      # Útil si hacés Remote Play o servidores dedicados
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true; # permite sesión Gamescope desde el display manager
    };

    programs.gamemode.enable = true;
    programs.mangohud.enable = true;

    ###########################################################################
    # Herramientas comunes de gaming
    ###########################################################################
    environment.systemPackages = with pkgs; [
      lutris
      protonup-qt        # para gestionar Proton-GE fácilmente
      goverlay           # GUI para MangoHud/vkBasalt
      wineWowPackages.stable
      winetricks
      vulkan-tools       # vkcube, vulkaninfo
      vkbasalt           # post-processing (shaders)
      dxvk               # D3D9/10/11 → Vulkan
      vkd3d              # D3D12 → Vulkan
    ];

    ###########################################################################
    # Gamepads y udev rules
    ###########################################################################
    services.udev.packages = [ pkgs.game-devices-udev-rules ];

    ###########################################################################
    # Variables por defecto (no fuerzan nada globalmente)
    ###########################################################################
    environment.variables = {
      # MangoHud se puede activar por juego con el launch option:
      #   MANGOHUD=1 %command%
      MANGOHUD = lib.mkDefault "0";

      # Si usás Wine/Proton y tu kernel soporta esync/fsync, podés dejarlas en 1.
      # Te las dejo comentadas para que decidas por juego o globalmente.
      # WINEESYNC = "1";
      # WINEFSYNC = "1";
    };
  };
}

