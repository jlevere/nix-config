{ pkgs, ... }:

{
  # Enable ALSA + PipeWire sound stack niceties
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  # Make sure UCM2 profiles are available for ALSA
  environment.systemPackages = [ pkgs.alsa-ucm-conf ];
}


