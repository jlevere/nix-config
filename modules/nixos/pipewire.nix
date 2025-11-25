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
    
    # WirePlumber configuration
    wireplumber.configPackages = [
      (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/51-alsa-disable-ucm.conf" ''
        # Disable UCM for devices that don't have proper mixer controls
        # This suppresses "Failed to find a working mixer device" warnings
        # Audio will use software volume control instead
        monitor.alsa.rules = [
          {
            matches = [
              {
                node.name = "~alsa_.*"
              }
            ]
            actions = {
              update-props = {
                api.alsa.use-ucm = false
              }
            }
          }
        ]
      '')
    ];
  };

  # Disable legacy PulseAudio service in favor of PipeWire
  services.pulseaudio.enable = false;

  # Ensure ALSA UCM profiles are available for mixer control
  # Note: Some hardware may not have UCM profiles, which causes non-fatal warnings
  # in WirePlumber. The config above disables UCM to suppress these warnings.
  environment.systemPackages = [ pkgs.alsa-ucm-conf ];

  # Realtime scheduling for audio
  security.rtkit.enable = true;
}
