{
  description = "Comic Code Ligatures Nerd Font";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      comic-code-ligatures-nerd-font = pkgs.stdenv.mkDerivation {
        pname = "comic-code-ligatures-nerd-font";
        version = "1";

        src = nixpkgs.lib.sourceFilesBySuffices ./. [".otf"];

        installPhase = ''
          runHook preInstall

          mkdir -p $out/share/fonts/opentype/NerdFonts
          mv *.otf $out/share/fonts/opentype/NerdFonts

          runHook postInstall
        '';
      };
    in {
      packages.default = comic-code-ligatures-nerd-font;
      packages.comic-code-ligatures-nerd-font = comic-code-ligatures-nerd-font;
    });
}
