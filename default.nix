{ pkgs, stdenv, lib, ... }:

let deps = [pkgs.perl pkgs.curl]; in

stdenv.mkDerivation rec {
  name = "wd-${version}";
  version = "0.9";
  meta = {
    description = "Command-line tool for WebDriver API";
    homepage = https://github.com/mbrock/wd;
    license = lib.licenses.mit;
  };

  src = ./.;
  buildInputs = [pkgs.makeWrapper];
  buildPhase = "true";
  installPhase =
    let path = lib.makeBinPath deps; in ''
      mkdir -p $out/bin && cp $src/wd $out/bin;
      wrapProgram "$out/bin/wd" --prefix PATH : "${path}"
    '';
}
