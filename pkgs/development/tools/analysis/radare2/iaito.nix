{ fetchFromGitHub , lib , mkDerivation
  # nativeBuildInputs
  , cmake, pkg-config, zip
  # Qt
  , qtbase, qtsvg, qtwebengine, qttools
  # buildInputs
  , radare2, python3, graphviz, wrapQtAppsHook
}:

mkDerivation rec {
  pname = "iaito";
  version = "5.5.0-beta";

  src = fetchFromGitHub {
    owner = "radareorg";
    repo = "iaito";
    rev = "d55b59fecfa1ab3e0c0ac6312f4259e9cf32e8df";
    sha256 = "wwusQMx9N8+4KNavW+bpUtqZ4c/G70b1xtgToFzOrfw=";
    fetchSubmodules = true;
  };

  sourceRoot = "source/src";

  nativeBuildInputs = [ cmake pkg-config zip python3 wrapQtAppsHook ];
  propagatedBuildInputs = [ python3.pkgs.pyside2 ];
  buildInputs = [ qtbase qttools qtsvg qtwebengine radare2 python3 graphviz ];

  cmakeFlags = [
    "-DIAITO_ENABLE_PYTHON=on"
    "-DIAITO_ENABLE_PYTHON_BINDINGS=on"
    "-DIAITO_ENABLE_CRASH_REPORTS=off" # requires breakpad
    "-DIAITO_ENABLE_KSYNTAXHIGHLIGHTING=off" # requires KF5SyntaxHighlighting
    "-DIAITO_ENABLE_GRAPHVIZ=on"
  ];

  meta = with lib; {
    description = "Official graphical interface for radare2, a libre reverse engineering framework";
    homepage = src.meta.homepage;
    license = licenses.gpl3;
    maintainers = with maintainers; [ noonien ];
  };
}
