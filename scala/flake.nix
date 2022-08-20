{
  description = "A Nix-flake-based Scala development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs =
    { self
    , flake-utils
    , nixpkgs
    }:
    flake-utils.lib.eachDefaultSystem (system:

    let
      javaVersion = 17;

      overlays = [
        (self: super: rec {
          jdk = super."jdk${toString javaVersion}";
          sbt = super.sbt.override {
            jre = jdk;
          };
          scala = super.scala_3.override {
            jre = jdk;
          };
        })
      ];

      pkgs = import nixpkgs { inherit overlays system; };
    in
    {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [ scala sbt coursier ];

        shellHook = ''
          ${pkgs.scala}/bin/scala -version
        '';
      };
    });
}
