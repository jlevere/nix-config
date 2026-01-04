{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  config = {
    home.packages = with pkgs; [
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
    ];

    home.file.".background".source = builtins.path { path = ../../../../assets/wallpapers/die.jpg; };

    home.file.".face".source = builtins.path { path = ../../../../assets/avatar.png; };

    qt = {
      enable = true;
      platformTheme.name = "kvantum";
      style.name = "kvantum";
    };

    catppuccin = {
      enable = true;
      flavor = "mocha";
      cursors.enable = false; # dont build tons of cursor variants
    };

    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Mocha-Standard-Teal-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "teal" ];
          size = "standard";
          variant = "mocha";
        };
      };

      gtk4.extraConfig = {
        # Fallback to Adwaita-dark for GTK-4 since Catppuccin doesn't support it yet
        gtk-application-prefer-dark-theme = 1;
      };
    };

    # Ensure pointer cursor theme is set for Wayland and X11 apps
    home.pointerCursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 24;
      gtk.enable = true;
    };

    xdg.configFile = {
      "hypr/hyprpaper.conf".text = ''
        preload = ~/.background
        wallpaper = , ~/.background
      '';
      "rofi/catppuccin-mocha.rasi" = lib.mkIf (pkgs ? rofi) {
        source = ./rofi/catppuccin-mocha.rasi;
      };
      "rofi/config.rasi" = lib.mkIf (pkgs ? rofi) { source = ./rofi/config.rasi; };
      
      # Create a minimal GTK-4.0 CSS to prevent import errors
      "gtk-4.0/gtk.css".text = ''
        /* Fallback GTK-4.0 theme - Catppuccin doesn't support GTK-4 yet */
        @import url("resource:///org/gtk/libgtk/theme/Adwaita/gtk-contained-dark.css");
      '';
    };
  };
}
