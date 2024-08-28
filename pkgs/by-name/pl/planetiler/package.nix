{ lib, maven, fetchFromGitHub, makeWrapper, jre }:

maven.buildMavenPackage rec {
  pname = "planetiler";
  version = "0.8.2";

  src = fetchFromGitHub {
    owner = "onthegomap";
    repo = "planetiler";
    rev = "v${version}";
    hash = "sha256-VrNH5l1qX5sMwI6fI0m533KBH8bKvldzVu5ON+oMm6Q=";
  };

  mvnHash = "sha256-b0nkp23gv4kejac/xrvm3xWo3Z8if7zveNUHBg7ZBm4=";
  mvnParameters = "compile assembly:single -Dmaven.test.skip=true";

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    ./scripts/set-versions.sh ${version}

    runHook preInstall

    mkdir -p $out/{bin,lib}
    cp target/gol-tool-${version}-jar-with-dependencies.jar $out/lib/gol-tool.jar

    makeWrapper ${jre}/bin/java $out/bin/gol \
      --add-flags "-cp $out/lib/gol-tool.jar" \
      --add-flags "com.geodesk.gol.GolTool"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Flexible tool to build planet-scale vector tilesets from OpenStreetMap data fast";
    homepage = "https://github.com/onthegomap/planetiler";
    license = licenses.asl20;
    maintainers = [ maintainers.starsep ];
    platforms = platforms.all;
  };
}
