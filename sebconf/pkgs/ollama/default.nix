{ pkgs ? import <nixpkgs> {} }:

pkgs.buildGoModule {
  pname = "ollama";
  version = "0.11.4";

  src = pkgs.fetchFromGitHub {
    owner = "ollama";
    repo = "ollama";
    rev = "v0.11.4";
    sha256 = null; # à remplacer
  };

  vendorHash  = null; # à remplacer

  subPackages = [ "." ];

  meta = with pkgs.lib; {
    description = "Run large language models locally";
    homepage = "https://ollama.com";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux;
  };
}
