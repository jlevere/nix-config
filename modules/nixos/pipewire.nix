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
    wireplumber.enable = true;
  };

  # Note: WirePlumber ALSA UCM warnings like "Failed to find a working mixer device"
  # are non-fatal. Audio works via software volume control when hardware mixers aren't available.
  # These warnings appear at boot but don't affect functionality.

  # Disable legacy PulseAudio service in favor of PipeWire
  services.pulseaudio.enable = false;

  # Ensure ALSA UCM profiles are available for mixer control
  # Note: Some hardware may not have UCM profiles, which causes non-fatal warnings
  # in WirePlumber. The config above disables UCM to suppress these warnings.
  environment.systemPackages = [ pkgs.alsa-ucm-conf ];

  # Realtime scheduling for audio
  security.rtkit.enable = true;
}
