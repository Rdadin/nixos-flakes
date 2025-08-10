{ lib, ... }:
with lib; {
  options.services.audio.pipewire.enable = mkEnableOption "PipeWire audio stack";

  config = mkIf config.services.audio.pipewire.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
    services.pulseaudio.enable = false;
  };
}
