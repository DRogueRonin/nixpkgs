{ mkDerivation, fetchurl, makeWrapper, lib, php }:
let
  pname = "phpDocumentor";
  version = "3.3.1";
in
mkDerivation {
  inherit pname version;

  src = fetchurl {
		url = "https://phpdoc.org/phpDocumentor.phar";
    sha256 = "SpPSeP1FgfF3YJAxNNhfzePUDZP3OcjGSPPtAsnD57s=";
  };

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    install -D $src $out/libexec/phpDocumentor/phpDocumentor.phar
    makeWrapper ${php}/bin/php $out/bin/phpdoc \
      --add-flags "$out/libexec/phpDocumentor/phpDocumentor.phar"
  '';

  meta = with lib; {
    description = "PHP documentation generator";
    license = licenses.mit;
    homepage = "https://phpdoc.org";
    maintainers = with maintainers; teams.php.members;
  };
}
