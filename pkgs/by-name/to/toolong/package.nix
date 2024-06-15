{ lib, python3Packages, fetchFromGitHub }:

python3Packages.buildPythonPackage rec {
  pname = "toolong";
  version = "1.4.0";

  src = fetchFromGitHub {
    owner = "Textualize";
    repo = "toolong";
    rev = "v${version}";
    sha256 = "sha256-Zd6j1BIrsLJqptg7BXb67qY3DaeHRHieWJoYYCDHaoc=";
  };

  propagatedBuildInputs = with python3Packages; [ numpy wand ];

  meta = with lib; {
    description = "A terminal application to view, tail, merge, and search log files (plus JSONL)";
    homepage = "https://github.com/Textualize/toolong";
    changelog = "https://github.com/Textualize/toolong/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ starsep ];
  };
}
