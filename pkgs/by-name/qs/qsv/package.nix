{ lib, rustPackages, rustPlatform, fetchFromGitHub, libclang, python3 }:

let
  inherit (rustPackages.rustc) llvmPackages;
in
rustPlatform.buildRustPackage rec {
  pname = "qsv";
  version = "0.128.0";

  src = fetchFromGitHub {
    owner = "jqnatividad";
    repo = "qsv";
    rev = "${version}";
    hash = "sha256-DoCiBERnFWCxJuTLJV3gWMzaukpgqI82L9GTnF/UZyI=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "calamine-0.25.0" = "sha256-31fJ6wS0s9lyHqf/D4Po6upkOk2IIG3gXjV/FropwlI=";
      "dynfmt-0.1.5" = "sha256-/SrNOOQJW3XFZOPL/mzdOBppVCaJNNyGBuJumQGx6sA=";
      "grex-1.4.5" = "sha256-cGO40UFjm7/mjOqxBPZG5N8h9/BmQXSu5aHnNrezfXE=";
      "polars-0.40.0" = "sha256-znAavcdg4OM5wa0OpagEysSZCAZcuhMZ1RpLghkm9nU=";
    };
  };

  nativeBuildInputs = [ python3 ];
  buildInputs = [ libclang ];

  cargoBuildFlags = [
    "--features all_features"
  ];

  cargoTestFlags = [
    "--features all_features"
  ];

  postFixup = ''
    wrapProgram $out/bin/qsv \
      --prefix LIBCLANG_PATH : ${llvmPackages.libclang.lib}/lib \
      --prefix PATH : ${lib.makeBinPath (with llvmPackages; [clang bintools-unwrapped])}
  '';

  meta = with lib; {
    description = "CSVs sliced, diced & analyzed";
    homepage = "https://github.com/jqnatividad/qsv";
    license = with lib.licenses; [ mit unlicense ]; # dual licensed
    maintainers = with maintainers; [ starsep ];
    mainProgram = "qsv";
  };
}
