with import <nixpkgs> {};
stdenv.mkDerivation rec {
  version = "1.0.0";
  name = "nix-presentation-${version}";
  src = ./src;
  buildInputs = [
    pandoc
    python27Packages.pygments
  ];
  buildPhase = ''
    pandoc -t revealjs slides.md -s --highlight-style pygments -V theme=sky -o slides.html
  '';
  installPhase = ''
    mkdir -p $out/share
    cp -v slides.html $out/share/
    cp -rv reveal.js $out/share/
  '';
}
