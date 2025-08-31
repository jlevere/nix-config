{ pkgs, ... }:

{
  # Use PipeWire for audio
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  # Disable legacy PulseAudio service in favor of PipeWire
  services.pulseaudio.enable = false;

  # Ensure ALSA UCM profiles are available for mixer control
  environment.systemPackages = [ pkgs.alsa-ucm-conf ];

  # Realtime scheduling for audio
  security.rtkit.enable = true;
}
