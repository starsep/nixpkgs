{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "stu";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "lusingander";
    repo = "stu";
    rev = "v${version}";
    hash = "sha256-VETEcRuJk0cCWB5y8IRdycKcKb3uiAWOyjeZWCJykG4=";
  };

  cargoHash = "sha256-s2QvRberSz4egVO8A2h3cx8oUlZM1bV5qZ0U4EiuPRs=";

  meta = with lib; {
    description = "TUI (Terminal/Text UI) application for AWS S3";
    homepage = "https://lusingander.github.io/stu/";
    license = licenses.mit;
    maintainers = with maintainers; [ starsep ];
    mainProgram = "stu";
  };
}
