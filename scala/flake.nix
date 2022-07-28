{
  description = "A Nix-flake-based Java development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        jdk = "jdk17";
        jdkPkg = pkgs.${jdk};

        config = {
          packageOverrides = p: {
            sbt = p.sbt.override {
              jre = p.${jdk};
            };
            scala_3 = p.scala_3.override {
              jre = p.${jdk};
            };
          };
        };

        pkgs = import nixpkgs { inherit config jdk system; };

        inherit (pkgs) mkShell;

        scala = pkgs.scala_3;

        buildTools = with pkgs; [ sbt ];
      in {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = [
              scala
              jdkPkg
            ] ++ buildTools;

            shellHook = ''
              ${scala}/bin/scala -version
            '';
          };
        };
      }
    );
}
