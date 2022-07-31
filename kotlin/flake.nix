{
  description = "A Nix-flake-based Kotlin development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        jdk = "jdk17";

        config = {
          packageOverrides = p: {
            gradle = (p.gradle.override { java = p.${jdk}; });

            kotlin = (p.kotlin.override { jre = p.${jdk}; });
          };
        };

        pkgs = import nixpkgs { inherit config system; };
        kotlin = pkgs.kotlin;
        buildTools = with pkgs; [ gradle ];
        otherTools = with pkgs; [ gcc ncurses patchelf zlib ];

        inherit (pkgs) mkShell;
      in {
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
