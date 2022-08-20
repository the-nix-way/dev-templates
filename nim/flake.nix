{
  description = "A Nix-flake-based Nim development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) mkShell nim;
      in
      {
        devShells = {
          default = mkShell {
            buildInputs = [ nim ];

            shellHook = ''
              ${nim}/bin/nim --version
            '';
          };
        };
      });
}
