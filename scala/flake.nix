{
  description = "A Nix-flake-based Scala development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        jdk = "jdk17";

        config = {
          packageOverrides = p: {
            sbt = p.sbt.override { jre = p.${jdk}; };
            scala_3 = p.scala_3.override { jre = p.${jdk}; };
          };
        };

        pkgs = import nixpkgs { inherit config jdk system; };

        inherit (pkgs) mkShell;

        scala = pkgs.scala_3;

        buildTools = with pkgs; [ sbt ];
      in
      {
        devShells = {
          default = mkShell {
            buildInputs = [ scala ] ++ buildTools;

            shellHook = ''
              ${scala}/bin/scala -version
            '';
          };
        };
      });
}
