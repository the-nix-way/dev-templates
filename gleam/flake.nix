{
  description = "A Nix-flake-based Gleam development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        gleamPkg = pkgs.gleam;

        inherit (pkgs) mkShell;
      in {
        devShells = {
          default = mkShell {
            buildInputs = [ gleamPkg ];

            shellHook = ''
              ${gleamPkg}/bin/gleam --version
            '';
          };
        };
      });
}
