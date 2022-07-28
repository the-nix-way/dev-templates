{
  description = "A Nix-flake-based Kotlin development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        kotlin = pkgs.kotlin;
        buildTools = with pkgs; [ gradle ];

        inherit (pkgs) mkShell;
      in {
        devShells = {
          default = mkShell {
            buildInputs = [ kotlin ] ++ buildTools;

            shellHook = ''
              ${kotlin}/bin/kotlin -version
            '';
          };
        };
      });
}
