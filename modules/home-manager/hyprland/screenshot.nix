{ pkgs, ... }:

{
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    sway-contrib.grimshot
  ];

  home.file.".local/bin/screenshot" = {
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
      mkdir -p "$SCREENSHOT_DIR"

      timestamp="$(date +'%Y-%m-%d_%H-%M-%S')"

      case ''${1:-} in
        screen)
          grimshot --notify save screen "$SCREENSHOT_DIR/''${timestamp}.png"
          ;;
        area)
          grimshot --notify save area "$SCREENSHOT_DIR/''${timestamp}.png"
          ;;
        active|window)
          grimshot --notify save active "$SCREENSHOT_DIR/''${timestamp}.png"
          ;;
        copy-screen)
          grimshot --notify copy screen
          ;;
        copy-area)
          grimshot --notify copy area
          ;;
        copy-active|copy-window)
          grimshot --notify copy active
          ;;
        *)
          echo "Usage: screenshot {screen|area|active|window|copy-screen|copy-area|copy-active|copy-window}" >&2
          exit 1
          ;;
      esac
    '';
    executable = true;
  };
}
