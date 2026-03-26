{
  stdenv,
  lib,
  undmg,
  fetchurl,
}:
stdenv.mkDerivation rec {
  pname = "TunnelblickInstaller";
  version = "8.0";
  build = "6300";

  src = fetchurl {
    name = "Tunnelblick_${version}_build_${build}.dmg";
    url = "https://tunnelblick.net/iprelease/Tunnelblick_${version}_build_${build}.dmg";
    hash = "sha256-4Ikl1ViVm2fDOgnRmyKLAE073AANPRmByYO/L5tp2cs=";
  };

  nativeBuildInputs = [ undmg ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R Tunnelblick.app $out/Applications/TunnelblickInstaller.app
    runHook postInstall
  '';

  meta = with lib; {
    description = "Tunnelblick helps you control OpenVPN® VPNs on macOS";
    homepage = "https://tunnelblick.net/";
    license = licenses.gpl2Only;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    mainProgram = "TunnelblickInstaller.app";
    maintainers = with maintainers; [ Ambrose ];
    platforms = platforms.darwin;
  };
}
