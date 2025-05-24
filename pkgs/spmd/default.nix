{
  runCommand,
  fetchFromGitHub,
  lib,
  bash,
  coreutils,
}:

runCommand "spmd"
  {
    src = fetchFromGitHub {
      owner = "micahco";
      repo = "spmd";
      rev = "013aa1d9a60909f746120aa0fc52e49e6b2e0c17";
      sha256 = "j4lq+s88JH2ChJJDGApWd10jcyUi9zkDN0TqLNZfPAY=";
    };

    meta = {
      description = "Utility that pulls metadata from the propietary Spotify client using the dbus interface";
      homepage = "https://github.com/micahco/spmd";
      license = lib.licenses.bsd2;
      platforms = lib.platforms.unix;
    };

    buildInputs = [ coreutils ];
  }
  ''
    cd $src

    install -pDm755 -t $out/bin spmd
    install -pDm644 -t $out/share/man/man1 spmd.1

    patchShebangs $out/bin
  ''
