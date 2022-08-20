{
  description = "A Nix-flake-based Java development environment";

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
          };
        };

        pkgs = import nixpkgs { inherit config jdk system; };
        java = jdk;
        buildTools = with pkgs; [ ant gradle maven ];
        inherit (pkgs) mkShell;
      in {
        devShells = {
          default = mkShell {
            buildInputs = [ java ] ++ buildTools;

            shellHook = ''
              ${java}/bin/java -version
            '';
          };
        };
      });
}
