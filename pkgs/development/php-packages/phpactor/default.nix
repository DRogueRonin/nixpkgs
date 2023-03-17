{ mkDerivation, fetchGit, makeWrapper, lib, php, phpPackages }:
let
  pname = "phpactor";
  version = "2023.01.21";
  composer = phpPackages.composer;
in
mkDerivation {
  inherit pname version composer;

  src = fetchGit {
		url = "https://github.com/phpactor/phpactor.git";
    ref = "refs/tags/${version}";
  };

  dontUnpack = true;

  nativeBuildInputs = [
    makeWrapper
    php
    composer
  ];

  buildPhase = ''
    mkdir -p $out/libexec/phpactor
    cp -r $src/* $out/libexec/phpactor
    cd $out/libexec/phpactor
    composer install
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    makeWrapper ${php}/bin/php $out/bin/phpactor \
      --add-flags "$out/libexec/phpactor/bin/phpactor"
    runHook postInstall
  '';

  meta = with lib; {
    description = "PHP Language Server";
    license = licenses.mit;
    homepage = "https://github.com/phpactor/phpactor";
    maintainers = with maintainers; teams.php.members;
  };
}
