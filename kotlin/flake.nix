{
  description = "A Nix-flake-based Kotlin development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        jdk = pkgs.jdk17;

        config = {
          packageOverrides = p: {
            gradle = (p.gradle.override { java = jdk; });

            kotlin = (p.kotlin.override { jre = jdk; });
          };
        };

        pkgs = import nixpkgs { inherit config system; };
        inherit (pkgs) mkShell;

        kotlin = pkgs.kotlin;
        buildTools = with pkgs; [ gradle ];
        otherTools = with pkgs; [ gcc ncurses patchelf zlib ];
      in
      {
        devShells = {
          default = mkShell {
            buildInputs = [ kotlin ] ++ buildTools ++ otherTools;

            shellHook = ''
              ${kotlin}/bin/kotlin -version
            '';
          };
        };
      });
}
