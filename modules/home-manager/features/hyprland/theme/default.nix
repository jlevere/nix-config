{ pkgs, inputs, ... }:

{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  config = {
    home.packages = with pkgs; [
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
    ];

    home.file.".wallpapers/wallpaper.png".source =
      ../../../../../assets/wallpapers/nixos-wallpaper-catppuccin-mocha.png;

    qt = {
      enable = true;
      platformTheme.name = "kvantum";
      style.name = "kvantum";
    };

    catppuccin = {
      enable = true;
      flavor = "mocha";
      cursors = {
        enable = true;
        flavor = "mocha";
        accent = "teal";
      };
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
      cursorTheme = {
        name = "catppuccin-mocha-teal-cursors";
        package = pkgs.catppuccin-cursors.mochaTeal;
      };
    };

    xdg.configFile = {
      "hypr/hyprpaper.conf".text = ''
        preload = ~/.wallpapers/wallpaper.png
        wallpaper = , ~/.wallpapers/wallpaper.png
      '';
      "rofi/catppuccin-mocha.rasi".source = ./rofi/catppuccin-mocha.rasi;
      "rofi/config.rasi".source = ./rofi/config.rasi;
    };
  };
}