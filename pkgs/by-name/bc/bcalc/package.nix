{
  fetchurl,
  installShellFiles,
  lib,
  lua,
  qt5,
  stdenv,
}:

stdenv.mkDerivation {
  pname = "bcalc";
  version = "19.08.0";

  src = fetchurl {
    url = "http://bcalc.w8.pl/download/bcalc19080_linux_x86-64.tar.gz";
    hash = "sha256-BVd9dZ7w3qGeImju9Ra9yB4zb+iQsPk1TGUmWReAGpI=";
  };
  sourceRoot = ".";

  buildInputs = [
    (lua.overrideAttrs (old: {
      installPhase = ''
        installPhase
        ln -s $out/lib/liblua.so.5.2 $out/lib/liblua5.2.so.0
      '';
    }))
    qt5.qtbase
    qt5.full
  ];
  dontPatchELF = false;

  nativeBuildInputs = [
    # qt5.wrapQtAppsHook
    installShellFiles
    qt5.qtbase
    qt5.full
  ];

  propagatedBuildInputs = [
    qt5.qtbase
    qt5.full
  ];

  dontWrapQtApps = true;

  postInstall = ''
    installBin bcalconsole bdeal bcalcgui
  '';

  # preFixup = ''
  #   wrapQtApp "$out/bin/bcalcgui" --prefix PATH / bcalcgui
  # '';

  meta = with lib; {
    description = "Bridge Calculator, set of programs for Bridge card game";
    longDescription = ''
      Bridge Calculator is set of freeware/donationware programs written by Piotr Beling which solve problems in the Bridge card game
      - double dummy problem solver
      - single dummy solver
      - deals generator
      - API to double dummy solver for programmers
    '';
    homepage = "http://bcalc.w8.pl/index.php?lang=en&topic=about";
    license = licenses.unfreeRedistributable;
    maintainers = [ maintainers.starsep ];
    platforms = platforms.linux;
  };
}
