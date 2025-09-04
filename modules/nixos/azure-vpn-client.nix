{
  lib,
  pkgs,
  config,
  ...
}:

let
  cfg = config.programs.azureVpnClient;

  runtimeLibs = with pkgs; [
    gtk3
    glib
    pango
    cairo
    gdk-pixbuf
    atk
    wayland
    libxkbcommon
    xorg.libX11
    xorg.libXi
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXext
    xorg.libXfixes
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libxcb
    xorg.xcbutil
    xorg.xcbutilimage
    xorg.xcbutilrenderutil
    xorg.xcbutilwm
    xorg.xcbutilkeysyms
    alsa-lib
    libdrm
    mesa
    libglvnd
    libgbm
    libepoxy
    fontconfig
    freetype
    expat
    sqlite
    icu
    libunwind
    at-spi2-core
    libayatana-appindicator-gtk3
    nss
    nspr
    libsecret
    stdenv.cc.cc.lib
  ];

  defaultPackage = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "microsoft-azurevpnclient";
    version = "3.0.0";

    src = pkgs.fetchurl {
      url = "https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-azurevpnclient/microsoft-azurevpnclient_${version}_amd64.deb";
      hash = "sha256-nl02BDPR03TZoQUbspplED6BynTr6qNRVdHw6fyUV3s=";
    };

    nativeBuildInputs = with pkgs; [
      dpkg
      makeWrapper
    ];
    buildInputs = runtimeLibs;

    unpackPhase = ''
      dpkg-deb -x "$src" .
    '';

    installPhase =
      let
        outOpt = "$out/opt/microsoft/microsoft-azurevpnclient";
        outApps = "$out/share/applications";
        outIcons = "$out/share/icons";
        libPath = lib.makeLibraryPath runtimeLibs;
      in
      ''
              runHook preInstall

              mkdir -p ${outOpt}
              cp -r opt/microsoft/microsoft-azurevpnclient/* ${outOpt}/

              mkdir -p ${outApps} ${outIcons}
              sed -e "s|^Exec=.*|Exec=$out/bin/azure-vpn-client|" \
                  -e "s|^TryExec=.*|TryExec=$out/bin/azure-vpn-client|" \
                  -e "s|^Icon=.*|Icon=${outIcons}/microsoft-azurevpnclient.png|" \
                  usr/share/applications/microsoft-azurevpnclient.desktop > ${outApps}/microsoft-azurevpnclient.desktop
              install -Dm644 usr/share/icons/microsoft-azurevpnclient.png ${outIcons}/microsoft-azurevpnclient.png

              mkdir -p $out/bin
              cat > $out/bin/azure-vpn-client <<EOF
        #!/usr/bin/env bash
        set -eo pipefail

        # Ensure libraries are found
        export LD_LIBRARY_PATH="${outOpt}/lib:${libPath}:$LD_LIBRARY_PATH"

        # Run from the program directory so Flutter can locate its snapshots/assets
        cd "${outOpt}"

        # Execute with argv0 set to the real binary path
        exec -a "${outOpt}/microsoft-azurevpnclient" "${outOpt}/microsoft-azurevpnclient" "$@"
        EOF
              chmod 0755 $out/bin/azure-vpn-client

              runHook postInstall
      '';

    dontBuild = true;

    # Avoid patchelf on Flutter libs; rely on nix-ld and LD_LIBRARY_PATH instead
    postFixup = "";

    meta = with lib; {
      description = "Microsoft Azure VPN Client packaged from the official Ubuntu .deb";
      homepage = "https://learn.microsoft.com/azure/vpn-gateway/";
      license = licenses.unfree;
      platforms = [ "x86_64-linux" ];
      mainProgram = "azure-vpn-client";
    };
  };

  azurePackage = if cfg.package != null then cfg.package else defaultPackage;

  programPath = "${azurePackage}/opt/microsoft/microsoft-azurevpnclient/microsoft-azurevpnclient";
  wrapperPath = "${azurePackage}/bin/azure-vpn-client";
  programDir = "${azurePackage}/opt/microsoft/microsoft-azurevpnclient";
  polkitRuleText = ''
    polkit.addRule(function (action, subject) {
      if ((action.id == "org.freedesktop.resolve1.set-dns-servers" || action.id == "org.freedesktop.resolve1.set-domains")) {
        var prog = action.lookup("program");
        if (prog == "${programPath}" || prog == "${wrapperPath}" || prog == "${programDir}") {
          return polkit.Result.YES;
        }
      }
    });
  '';
in
{
  options.programs.azureVpnClient = {
    enable = lib.mkEnableOption "Azure VPN Client (Microsoft)";
    package = lib.mkOption {
      type = lib.types.nullOr lib.types.package;
      default = null;
      description = "Optional override package for Azure VPN Client.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ azurePackage ];
    security.polkit.enable = true;
    environment.etc."polkit-1/rules.d/microsoft-azurevpnclient.rules".text = polkitRuleText;
    services.resolved.enable = lib.mkDefault true;
    systemd.tmpfiles.rules = [
      "d /var/log/azurevpnclient 0755 root root -"
    ];
  };
}
