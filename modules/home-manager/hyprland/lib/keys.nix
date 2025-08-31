{
  pkgs,
  lib,
  config,
  ...
}:

{
  wayland.windowManager.hyprland = {
    settings = {
      "$mainMod" = "SUPER";

      bind =
        let
          toWSNumber = n: (toString (if n == 0 then 10 else n));

          moveworkspaces = map (n: "$mainMod SHIFT, ${toString n}, movetoworkspace, ${toWSNumber n}") [ 1 2 3 4 5 6 7 8 9 0 ];
          woworkspaces  = map (n: "$mainMod, ${toString n}, workspace, ${toWSNumber n}")          [ 1 2 3 4 5 6 7 8 9 0 ];
        in
        [
          # Launch terminal and app launcher
          "$mainMod, return, exec, wezterm"
          "$mainMod, SPACE, exec, rofi -show drun"

          # Window management
          "$mainMod, Q, killactive"
          "$mainMod, F, fullscreen"
          "$mainMod SHIFT, F, togglefloating"
          "$mainMod, P, pseudo"
          "$mainMod, S, layoutmsg, togglesplit"

          # Workspace navigation
          "$mainMod, bracketleft, workspace, -1"
          "$mainMod, bracketright, workspace, +1"

          # Directional focus (vim-style) and arrows
          "SUPER, H, movefocus, l"
          "SUPER, J, movefocus, d"
          "SUPER, K, movefocus, u"
          "SUPER, L, movefocus, r"
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Audio controls
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
        ]
        ++ woworkspaces
        ++ moveworkspaces;

      binde = [
        "$mainMod SHIFT, h, moveactive, -20 0"
        "$mainMod SHIFT, l, moveactive, 20 0"
        "$mainMod SHIFT, k, moveactive, 0 -20"
        "$mainMod SHIFT, j, moveactive, 0 20"

        "$mainMod CTRL, h, resizeactive, -30 0"
        "$mainMod CTRL, l, resizeactive, 30 0"
        "$mainMod CTRL, k, resizeactive, 0 -10"
        "$mainMod CTRL, j, resizeactive, 0 10"
      ];

      bindm = [
        # Move and resize windows with mod + mouse drag
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };

    extraConfig = "";
  };
}
