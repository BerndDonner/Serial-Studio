{
  lib,
  stdenv,
  qt6,
  openssl,
  cmake,
  pkg-config,
} :

stdenv.mkDerivation {
  pname = "Serial-Studio";
  version = "3.0.6"; #TODO can we automatically set the version from github?

  meta = with lib; {
    description = "Serial Studio is a multi-platform, versatile data visualization tool designed for embedded engineers, students, hackers, and teachers.";
    homepage    = "https://github.com/BerndDonner/Serial-Studio";
    license     = licenses.mit;
    platforms   = platforms.linux;
    maintainers = [ ]; #TODO
  };

  # src = fetchgit {
  #   url = "https://github.com/BerndDonner/Serial-Studio";
  #   branchName = "nixos";
  #   rev = "1bb9cd3d544eaf5ada8a8cb08a6e1308e839680f";
  #   hash = "sha256-hyYrJkbicsj3jaEytKH7sRIXNT5SxNb3UE75GSzGCBM=";
  # };

  src = ./.;

  buildInputs = [
    qt6.qtbase
    qt6.qtsvg
    qt6.qtgraphs
    qt6.qtlocation
    qt6.qtconnectivity
    openssl
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
    qt6.qttools
    qt6.wrapQtAppsHook
  ];

  preConfigure = ''
    export LC_ALL=C.UTF-8
  '';
  
  cmakeFlags = [
    "-DPRODUCTION_OPTIMIZATION=ON"
    "-DCMAKE_BUILD_TYPE=Release"
    "-DQT_DEPLOY_USE_PATCHELF=ON"
  ];
}

