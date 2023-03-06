{
  description = "A Nix-flake-based Scala development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
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
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [ scala sbt coursier ];

        shellHook = ''
          ${pkgs.scala}/bin/scala -version
        '';
      };
    });
}
