{
  description = "A Nix-flake-based Kotlin development environment";

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
          jdk = pkgs."jdk${toString javaVersion}";
          gradle = super.gradle.override {
            java = jdk;
          };
          kotlin = super.kotlin.override {
            jre = jdk;
          };
        })
      ];

      pkgs = import nixpkgs { inherit overlays system; };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [ kotlin gradle gcc ncurses patchelf zlib ];

        shellHook = ''
          ${pkgs.kotlin}/bin/kotlin -version
        '';
      };
    });
}
