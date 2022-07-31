{
  description = "A Nix-flake-based Scala development environment";

  inputs = { dev.url = "github:the-nix-way/dev-templates"; };

  outputs = { self, dev }:
    let inherit (dev.lib) flake-utils nixpkgs;
    in flake-utils.lib.eachDefaultSystem (system:
      let
        jdk = "jdk17";
        jdkPkg = pkgs.${jdk};

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
      in {
        devShells = {
          default = mkShell {
            buildInputs = [ scala jdkPkg ] ++ buildTools;

            shellHook = ''
              ${scala}/bin/scala -version
            '';
          };
        };
      });
}
