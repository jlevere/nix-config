{ pkgs, lib, ... }:

{
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      "g" = "git";
      "gs" = "git status";
      "ga" = "git add";
      "gd" = "git diff";
      "gf" = "git fetch";
      "gp" = "git push";
      "gt" = "git ls-files | tree --fromfile --charset=ascii";
    };
    plugins = [
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
    ];
    functions = {
      fish_greeting = { body = ""; };
    };
  };

  home.activation.configure-tide = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${pkgs.fish}/bin/fish -c "tide configure --auto --style=Lean \
     --prompt_colors='True color' --show_time=No \
      --lean_prompt_height='Two lines' \
      --prompt_connection=Disconnected \
      --prompt_connection_andor_frame_color=Dark \
      --prompt_spacing=Compact --icons='Many icons' \
      --transient=No"
  '';
}


