{ runCommand, fetchFromGitHub, lib, bash, coreutils }:

runCommand "tbsm"
{
  src = fetchFromGitHub {
    owner = "loh-tar";
    repo = "tbsm";
    rev = "v0.7";
    sha256 = "wGw/+mZhtB9Z8xYgiH9593aIS8Xg49+yGPinKv3SEnQ=";
  };

  meta = {
    description = "A pure bash session or application launcher. Inspired by cdm, tdm and krunner.";
    homepage = "https://loh-tar.github.io/tbsm/";
    license = lib.licenses.gpl2;
    platforms = lib.platforms.unix;
  };

  buildInputs = [ bash coreutils ];
} ''
  cd $src

  install -pDm755 -t $out/bin src/tbsm
  install -pDm644 -t $out/etc/xdg/tbsm/themes themes/*
  install -pDm644 -t $out/share/doc/tbsm doc/*
  ln -srf -T $out/bin/tbsm $out/share/doc/tbsm/"70_SourceCode"

  substituteInPlace $out/bin/tbsm \
    --replace "/etc/xdg" "$out/etc/xdg" \
    --replace "/usr/share/doc" "$out/share/doc"

  patchShebangs $out/bin
''
