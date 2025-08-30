{ pkgs, ... }:

{
  # Use PipeWire (configured elsewhere) and disable legacy PulseAudio
  services.pulseaudio.enable = false;

  # Ensure ALSA UCM profiles are available for mixer control
  environment.systemPackages = [ pkgs.alsa-ucm-conf ];
}


