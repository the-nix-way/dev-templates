{
  description = "A Nix-flake-based Protobuf development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) mkShell nickel;
      in {
        devShells = {
          default = mkShell {
            buildInputs = [ nickel ];

            shellHook = ''
              ${nickel}/bin/nickel --version
            '';
          };
        };
      });
}
